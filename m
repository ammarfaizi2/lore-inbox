Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292116AbSB0Tih>; Wed, 27 Feb 2002 14:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292916AbSB0Tgi>; Wed, 27 Feb 2002 14:36:38 -0500
Received: from [80.94.224.242] ([80.94.224.242]:24336 "EHLO babbler.csp.org.by")
	by vger.kernel.org with ESMTP id <S292911AbSB0Tfo>;
	Wed, 27 Feb 2002 14:35:44 -0500
Date: Wed, 27 Feb 2002 21:40:56 +0200
From: Artiom Morozov <artiom@phreaker.net>
To: linux-kernel@vger.kernel.org
Cc: Kiretchko Serguei <spk@csp.org.by>
Subject: select() call corrupts stack
Message-ID: <20020227214056.A6740@cyan.csp.org.by>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_CE+1k2dSO48ffg"
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=_CE+1k2dSO48ffg
Content-Type: text/plain; format=flowed; charset=KOI8-R
Content-Transfer-Encoding: 8bit

Hello,

	Here's a sample program. Try running it and open about 2k of 
connections to port 5222 (you'll need ulimit -n 10000 or like that). It 
will segfault. Simple asm like this
   __asm__(
	"pushl %eax \n\t" 	"movl  0(%ebp), %eax \n\t"
	"cmp   $65535, %eax \n\t"
	"ja isok \n\t"
	"xor  %eax, %eax \n\t"
	"movl  %eax, 0(%eax) \n\t"	 
	"isok: \n\t"
	"popl  %eax \n\t"
   );
after each subroutine call will show you that after select() [ebp] have 
weird value. While this is unlikely to be a security flaw, i think this 
is a bug.

ps: it's okay for 1k of connections or so
pps: kernel 2.4.17 on i686, gcc 3.0.3, glibc 2.2.3.

--=_CE+1k2dSO48ffg
Content-Type: text/x-c++; charset=us-ascii
Content-Disposition: attachment; filename="main.cpp"

#include <deque>
#include <pthread.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <netinet/in.h>

using namespace std;

typedef void* (*DISP_ENTRY_ROUTINE)(void*);

typedef struct
{
  pthread_mutex_t sockLock;
  int sock;
  DISP_ENTRY_ROUTINE disp;
} ReqInfo;

pthread_mutex_t reqsLock = PTHREAD_MUTEX_INITIALIZER;
deque<ReqInfo*> reqs;

void* disp0(void*);

void add_to_queue(int s)
{
  pthread_mutex_lock(&reqsLock);

  ReqInfo * nInfo = new ReqInfo[1];
  nInfo->sock = s;
  pthread_mutex_init(&nInfo->sockLock, NULL);
  nInfo->disp = disp0;
	  
  reqs.push_back(nInfo);
	  
  pthread_mutex_unlock(&reqsLock);
}

void* disp0(void* param)
{
  ReqInfo *p = (ReqInfo *) param;
  char foo[0x10];

  recv(p->sock, foo, 4, 0);
  
  add_to_queue(p->sock);
  return NULL;
}

void* proc_acc(void* param)
{
  int s = socket(PF_INET, SOCK_STREAM, 0);
  
  if (s == -1)
  {
	fprintf(stderr, "proc_acc: socket() failed, %s\n", strerror(errno));
	return NULL;
  }
	
  struct sockaddr_in saL;
  saL.sin_family = AF_INET;
  saL.sin_port = htons(5222);
  saL.sin_addr.s_addr = htonl(INADDR_ANY);
		
  if (bind(s, (sockaddr*)&saL, sizeof(saL)) == -1)
  {
	fprintf(stderr, "proc_acc: bind() failed, %s\n", strerror(errno));
	return NULL;
  }
  
  if (listen(s, SOMAXCONN) == -1)
  {
	fprintf(stderr, "proc_acc: listen() failed, %s\n", strerror(errno));
	return NULL;
  }

  do
  {
	int len;
	struct sockaddr_in addr;
	int ch = accept(s, (struct sockaddr*) &addr, (socklen_t*) &len);
	if (ch == -1)
	{
	  fprintf(stderr, "proc_acc: accept() failed, %s\n", strerror(errno));
	}
	else
	{
	  add_to_queue(ch);
	}
  } while (1);

  return NULL;
}

int try_select(ReqInfo *p)
{
  fd_set set;
  struct timeval tv;
  int out = 0;
  
  do
  {
	tv.tv_sec = tv.tv_usec = 0;
	FD_ZERO(&set);
	FD_SET(p->sock, &set);
  } while ((out = select(p->sock + 1, &set, NULL, NULL, &tv)) == -1 
			&& errno == EINTR);
  
  return out;
}

void* proc_sel(void* param)
{
  do
  {
	ReqInfo *p = NULL;
	pthread_mutex_lock(&reqsLock);
	if (reqs.size())
	{
	  p = reqs.front();
	  reqs.pop_front();
	}
	pthread_mutex_unlock(&reqsLock);
	
	if (p != NULL)
	{
	  int r = try_select(p);
	  switch (r)
	  {
		case 0: 
		{ 
		  pthread_mutex_lock(&reqsLock); 
		  reqs.push_back(p);
		  pthread_mutex_unlock(&reqsLock); 
		}; break;
		case -1:
		{
		  fprintf(stderr, "select(): %s\n", strerror(errno));
		}; 
		default:
		{
		  p->disp(p);
		  delete[] p;
		}; 
	  }
	}
  } while (1);
}

int main()
{
  pthread_t th_acc, th_sel;
  
  pthread_create(&th_acc, NULL, proc_acc, NULL);
  pthread_create(&th_sel, NULL, proc_sel, NULL);

  // should crash here, so don't care about cleanup

  pthread_join(th_acc, NULL);

  return 0;
}

--=_CE+1k2dSO48ffg
Content-Type: text/x-makefile; charset=us-ascii
Content-Disposition: attachment; filename=Makefile

all:
	c++ -pthread -g -Wall -o test-acceptor main.cpp
--=_CE+1k2dSO48ffg--
