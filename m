Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275856AbRJBIc0>; Tue, 2 Oct 2001 04:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275862AbRJBIcR>; Tue, 2 Oct 2001 04:32:17 -0400
Received: from balabit.bakats.tvnet.hu ([195.38.106.66]:4882 "EHLO
	kuka.balabit") by vger.kernel.org with ESMTP id <S275856AbRJBIcC>;
	Tue, 2 Oct 2001 04:32:02 -0400
Date: Tue, 2 Oct 2001 10:31:12 +0200
From: Balazs Scheidler <bazsi@balabit.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: reproducible bug in 2.2.19 & 2.4.x
Message-ID: <20011002103112.A13638@balabit.hu>
In-Reply-To: <20010928130138.A19532@balabit.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010928130138.A19532@balabit.hu>; from bazsi@balabit.hu on Fri, Sep 28, 2001 at 01:01:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 28, 2001 at 01:01:38PM +0200, Balazs Scheidler wrote:
> I added a backtrace function to my test program to show where it
> aborts, and here's the result:
> 
> Signal (11) received, stackdump follows; eax='ffffffe0', ebx='0000000c', ecx='be5ff96c', edx='00000400', eip='00000001'
> retaddr=0x1, ebp=0xbe5ff944
> retaddr=0x804892a, ebp=0xbe5ffd74
> retaddr=0x4001bc9f, ebp=0xbe5ffe34
> 
> The program _always_ aborted at eip=0x1.
> 
> the program didn't abort if I removed the syslog() function call from the
> thread.

I received an idea, suggesting that syslog() is not reentrant and this
causes problems.

I added mutexes around my syslog call and the problem still occurs, although
slower.

I'm trying to remove syslog() and add some sigaction calls instead (which I
think is the culprit) I attach my modified stressthreads.c

-- 
Bazsi
PGP info: KeyID 9AF8D0A9 Fingerprint CD27 CFB0 802C 0944 9CFD 804E C82C 8EB1

--Q68bSM7Ycu6FN28Q
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="stressthreads.c"

#include <pthread.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <signal.h>
#include <syslog.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

#define BACKTRACE 0


#if BACKTRACE
void inline 
z_dump_backtrace(unsigned long eip, unsigned long first_ebp)
{
  /* NOTE: this is i386 specific */
  unsigned long *ebp;
  
  fprintf(stderr, "retaddr=0x%lx, ebp=0x%lx\n", eip, first_ebp);
  
  ebp = (unsigned long *) first_ebp;
  while (ebp > (unsigned long *) &ebp && *ebp) 
    {
      fprintf(stderr, "retaddr=0x%lx, ebp=0x%lx\n", *(ebp+1), *ebp);
      ebp = (unsigned long *) *ebp;
    }
}

void
z_fatal_signal_handler(int signo)
{
  struct sigcontext *p = (struct sigcontext *) (((char *) &p) + 16);

  fprintf(stderr, "Signal (%d) received, stackdump follows; eax='%08lx', ebx='%08lx', ecx='%08lx', edx='%08lx', eip='%08lx'\n",
        signo, p->eax, p->ebx, p->ecx, p->edx, p->eip);
  z_dump_backtrace(p->eip, p->ebp);
  exit(1);
}
#endif

pthread_mutex_t syslog_mutex = PTHREAD_MUTEX_INITIALIZER;

void *thread_func(void *arg)
{
  int fd = *(int *) arg;
  int i;
  char buf[1024];

  pthread_mutex_lock(&syslog_mutex);
  syslog(LOG_DEBUG, "thread started...%p\n", pthread_self());
  pthread_mutex_unlock(&syslog_mutex);
  memset(buf, 'a', sizeof(buf));
  for (i = 0; i < 1024; i++)
    {
      write(fd, buf, sizeof(buf));
    }
  close(fd);
  //syslog(LOG_DEBUG, "thread stopped...%p\n", pthread_self());
  free(arg);
  return NULL;
}

int main()
{
  int fd;
  struct sockaddr_in sin;
  int tmp = 1;
  
#if BACKTRACE
  signal(SIGSEGV, z_fatal_signal_handler);
#endif
  signal(SIGPIPE, SIG_IGN);
  
  fd = socket(AF_INET, SOCK_STREAM, 0);
  
  sin.sin_family = AF_INET;
  sin.sin_port = htons(10000);
  sin.sin_addr.s_addr = INADDR_ANY;
  
  setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &tmp, sizeof(tmp));
  
  if (bind(fd, (struct sockaddr *) &sin, sizeof(sin)) < 0)
    {
      perror("bind");
      return 0;
    }
  
  listen(fd, 255);
  
  while (1)
    {
      int newfd;
      int tmplen;
      pthread_t t;
      
      tmplen = sizeof(sin);
      newfd = accept(fd, (struct sockaddr *) &sin, &tmplen);
      if (newfd == -1)
        {
          perror("accept");
        }
      else
        {
          int *state = (int *) malloc(sizeof(int));
          
          *state = newfd;
          pthread_create(&t, NULL, thread_func, state);
        }
    }
}

--Q68bSM7Ycu6FN28Q--
