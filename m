Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSGVKkP>; Mon, 22 Jul 2002 06:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316668AbSGVKkP>; Mon, 22 Jul 2002 06:40:15 -0400
Received: from rzfoobar.is-asp.com ([217.11.194.155]:39914 "EHLO mail.isg.de")
	by vger.kernel.org with ESMTP id <S316667AbSGVKkL>;
	Mon, 22 Jul 2002 06:40:11 -0400
Message-ID: <3D3BE1C2.CB89D124@isg.de>
Date: Mon, 22 Jul 2002 12:43:14 +0200
From: Peter Niemayer <niemayer@isg.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: read/recv sometimes returns EAGAIN instead of EINTR on SMP machines
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I just noticed that both kernel 2.2.x and 2.4.x return a false code from read or recv
under certain conditions:

If one process tries to read non-blocking from a tcp socket (domain sockets work
fine), and another process sends the reading process signals, then sometimes
select() returns with the indication that the socket is readable, but the subsequent
read returns EAGAIN - instead of EINTR which would have been the correct return
code. This only happenes on SMP machines.

Other "fd"-types or operating systems I tried did not show such a behaviour.

Find below a small sample source that demonstrates the problem - from time to time
you should get messages such as:

"recv returned EAGAIN, after 161365824 bytes and 54 interrupts"

Regards,

Peter Niemayer

---------------------------------------------------------------------------------------

sample source below, compile with
> c++ -o test test.cxx

start with
> ./test

creates 3 processes, one just writing to a socket, one reading from the socket
non-blocking, one sending SIGUSR1 signals to the reading process

---------------------------------------------------------------------------------------
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <sys/time.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>
#include <stdlib.h>

#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <netdb.h>

#include <sys/types.h>

int sigcount = 0;

void mysighandler(int) {
  ++sigcount;
}


void writer(int fd);
void reader(int fd);
void signaller(int pid);

#define testres(name,x) {\
  int rc = x; \
  if (rc < 0) { \
    perror(name); \
    exit(0); \
  } \
} 


int main(int argc, char* argv[]) {
  
  int mypid = getpid();

  int localhost = (127 << 24) + 1; // 127.0.0.1
    
  int s1 = socket(AF_INET, SOCK_STREAM, 0);
  if (s1 < 0) {
    perror("error creating server socket");
    exit(0);
  }
  
  {
    int val = 1;
    testres("reuse",setsockopt(s1, SOL_SOCKET, SO_REUSEADDR,
            (char *) &val, sizeof(val)));
  }

  {
    struct sockaddr_in adr;
    memset ((char *)&adr, 0, sizeof(struct sockaddr_in));
    adr.sin_family = AF_INET;
    adr.sin_addr.s_addr = htonl(localhost); // INADDR_ANY;
    adr.sin_port = htons(9999);
    testres("bind", bind(s1, (sockaddr*) &adr, sizeof(struct sockaddr_in)));
    testres("listen", listen(s1, 5));
  }
  
  if (fork() == 0) {
    
    int s2 = socket(AF_INET, SOCK_STREAM, 0);
    if (s2 < 0) {
      perror("error creating client socket");
      exit(0);
    }
    
    {
      struct sockaddr_in adr;
      memset ((char *)&adr, 0, sizeof(struct sockaddr_in));
      adr.sin_family = AF_INET;
      adr.sin_addr.s_addr = htonl(localhost);
      adr.sin_port = htons(9999);
      testres("connect", connect(s2, (sockaddr *) &adr,
              sizeof(struct sockaddr_in)));
    }
  
  
    writer(s2);
    _exit(0);
  }
  
  int s2 = accept(s1, 0, 0);
  
  {
    struct sigaction action;
    action.sa_handler = mysighandler;
    sigemptyset(&action.sa_mask);
    action.sa_flags = 0;
    testres("sigaction", sigaction(SIGUSR1, &action, 0));
  }
  
  if (fork() == 0) {
    signaller(mypid);
    _exit(0);
  }
  
  reader(s2);

  return 0;
}

void signaller(int pid) {
  for (;;) {
    if (getppid() == 1) {
      puts("parent terminated, terminating signaller");
      break;
    }

    kill(pid, SIGUSR1);
    usleep(1);
  }
}

void writer(int fd) {
  fd_set waitset;
  
  struct timeval tv;
  
  char buf[64000];
  memset(buf, 0, 64000);
  
  int flags = fcntl(fd, F_GETFL);
  flags |= O_NONBLOCK;

  fcntl(fd, F_SETFL, flags);

  for (;;) {
    if (getppid() == 1) {
      puts("parent terminated, terminating writer");
      break;
    }

    FD_ZERO(&waitset);
    FD_SET(fd, &waitset);

    tv.tv_sec = 1;
    tv.tv_usec = 0;

    int rc = select(fd+1, 0, &waitset, 0, &tv);

    if (rc < 0) {
      if (rc == EINTR) {
        break;
      } else {
        perror("writer terminated with select error");
        return;
      }
    } else if (rc == 1) {
      // socket is writeable
      send(fd, buf, 64000, 0);
    }

  }
}

void reader(int fd) {
  fd_set waitset;
  
  struct timeval tv;
  
  char buf[64000];
  memset(buf, 0, 64000);
  
  int flags = fcntl(fd, F_GETFL);
  flags |= O_NONBLOCK;
  fcntl(fd, F_SETFL, flags);
  
  int totalbytes = 0;

  for (;;) {
  
    FD_ZERO(&waitset);
    FD_SET(fd, &waitset);
    
    tv.tv_sec = 1;
    tv.tv_usec = 0;
    
    int rc = select(fd+1, &waitset, 0, 0, &tv);
    
    if (rc < 0) {
      if (errno == EINTR) {
        continue;
      } else if (errno == EAGAIN) {
        puts("select returned EAGAIN");
        continue;
      } else {
        perror("writer terminated with select error");
        return;
      }
    } else if (rc == 1) {
      // socket is readable
      
      for (;;) {
        rc = recv(fd, buf, 64000, 0);

        if (rc < 0) {
          if (errno == EINTR) {
            continue;
          } else if (errno == EAGAIN) {
            printf("recv returned EAGAIN, after %d bytes and %d interrupts\n",
                   totalbytes, sigcount);
            fflush(0);
            sigcount = 0;
            totalbytes = 0;
          }
        } else if (rc == 0) {
          puts("reader read 0 bytes");
          return;
        } else {
          totalbytes += rc;
        }
        break;
      }
    }
  
  }
}
-----------------------------------------------------------------------------------------
