Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274832AbRJAKDv>; Mon, 1 Oct 2001 06:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274834AbRJAKDb>; Mon, 1 Oct 2001 06:03:31 -0400
Received: from balabit.bakats.tvnet.hu ([195.38.106.66]:46864 "EHLO
	kuka.balabit") by vger.kernel.org with ESMTP id <S274829AbRJAKDX>;
	Mon, 1 Oct 2001 06:03:23 -0400
Date: Mon, 1 Oct 2001 12:03:25 +0200
From: Balazs Scheidler <bazsi@balabit.hu>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reproducible bug in 2.2.19 & 2.4.x
Message-ID: <20011001120325.A7473@balabit.hu>
In-Reply-To: <20010928203019.A24999@balabit.hu> <Pine.LNX.4.10.10109281515050.6506-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10109281515050.6506-100000@coffee.psychology.mcmaster.ca>; from hahn@physics.mcmaster.ca on Fri, Sep 28, 2001 at 03:15:32PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 28, 2001 at 03:15:32PM -0400, Mark Hahn wrote:
> 
> seems like an interaction between your signal code and pthread,
> no obvious reason to blame the kernel:

I've updated my test program to address your issues:

1) I removed the SIGSEGV handler (you know with the fprintf())
2) I modified it to use separate memory for all thread initialization data

The segfault still occurs. (to reenable backtrace #define BACKTRACE to 1 at
the beginning of the program) core is not dumped, because threaded programs
do not drop core.

I still think it's a kernel issue, at least the SMP dependancy tells me so.
(remember SMP kernel on an UP is affected too)

I also attach the strace of the process, which also shows the segfault. (it
is made by strace 4.4 which can follow threads)

PS: again please Cc me, since I'm not subscribed.

-- 
Bazsi
PGP info: KeyID 9AF8D0A9 Fingerprint CD27 CFB0 802C 0944 9CFD 804E C82C 8EB1

--k1lZvvs/B4yU6o8G
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

void *thread_func(void *arg)
{
  int fd = *(int *) arg;
  int i;
  char buf[1024];

  syslog(LOG_DEBUG, "thread started...%p\n", pthread_self());
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

--k1lZvvs/B4yU6o8G--
