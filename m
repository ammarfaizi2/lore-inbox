Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276010AbRI1LCU>; Fri, 28 Sep 2001 07:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276011AbRI1LCA>; Fri, 28 Sep 2001 07:02:00 -0400
Received: from balabit.bakats.tvnet.hu ([195.38.106.66]:36872 "EHLO
	kuka.balabit") by vger.kernel.org with ESMTP id <S276010AbRI1LBl>;
	Fri, 28 Sep 2001 07:01:41 -0400
Date: Fri, 28 Sep 2001 13:01:38 +0200
From: Balazs Scheidler <bazsi@balabit.hu>
To: linux-kernel@vger.kernel.org
Subject: reproducible bug in 2.2.19 & 2.4.x
Message-ID: <20010928130138.A19532@balabit.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We encountered SIGSEGV problems in our massively multithreaded application,
which we tracked down to a kernel issue. At least it seems to be a kernel
issue. I wrote a simple test program attached to this mail, which can be
used to reproduce this SIGSEGV.

How to reproduce it:
  - each new session starts a new thread (TCP sessions)
  - sometimes sessions break up causing a SIGPIPE to be delivered
  - each thread logs messages using syslog (libc changes SIGPIPE settings
    before really sending the message to avoid SIGPIPE terminating the
    application)
  - SIGPIPE is SIG_IGNed (it doesn't seem to matter whether I use SIG_IGN or
    an empty signal handler function)

The test program attached (stressthreads.c) opens a socket, binds to a port,
and starts listening for new connections. In each new thread, it sends a
syslog message, writes 1MB in 1024 byte chunks to the connection, closes the
connection and exits.

Also attached a python script starting up 100 threads, and connecting to the
given ip/port, reading 1024 bytes of data, then closing the connection. So
effectively we cause SIGPIPE in each thread in stresstest during their write
call. To run the test, compile stressthreads.c on one computer and run it,
it'll start listening on 0.0.0.0:10000. Modify the end of test-zorp.py, and
set the correct IP address of your first host in the script.

Start the script, and the other end will crash.

The program SEGFAULTs within a second when run on our PIII 800 SMP
test system. The SEGFAULT did not occur on any of our non-SMP systems. (even
with the same PIII with a non-SMP kernel)

I added a backtrace function to my test program to show where it
aborts, and here's the result:

Signal (11) received, stackdump follows; eax='ffffffe0', ebx='0000000c', ecx='be5ff96c', edx='00000400', eip='00000001'
retaddr=0x1, ebp=0xbe5ff944
retaddr=0x804892a, ebp=0xbe5ffd74
retaddr=0x4001bc9f, ebp=0xbe5ffe34

The program _always_ aborted at eip=0x1.

the program didn't abort if I removed the syslog() function call from the
thread.

The results are same for a 2.4.5 kernel (so I assume it affects later kernel
versions as well). 

Ideas, solutions, any help welcome.

PS: I'm not subscribed, so please CC me the replies.

-- 
Bazsi
PGP info: KeyID 9AF8D0A9 Fingerprint CD27 CFB0 802C 0944 9CFD 804E C82C 8EB1

--mP3DRpeJDSE+ciuQ
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="stressthreads.c"

#include <pthread.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <signal.h>
#include <syslog.h>
#include <stdio.h>

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
}

int main()
{
  int fd;
  struct sockaddr_in sin;
  int tmp = 1;
  
  signal(SIGSEGV, z_fatal_signal_handler);
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
          pthread_create(&t, NULL, thread_func, &newfd);
        }
    }
}

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test-zorp.py"

#!/usr/bin/python

from socket import *
from time import time, sleep


from thread import start_new_thread, get_ident
from os import system
import sys

def httptest(name,url):
        id = get_ident()
        j=0
        while 1:
                j=j+1
                i="%u,%u"%(id,j)
                print "%s,%s,started"%(name,i)
                t1=time()
                try:
                        f=socket(AF_INET, SOCK_STREAM)
			f.connect(url)
			f.read(1024)
	                f.close()
                except:
                        print "%s,%s,failed,%s"%(name,i,sys.exc_value)
                t2=time()
                print "%s,%s,elapsed,%f"%(name,i,(t2-t1))

def test(name,url,count):
        for i in range(1,count):
                print "starting %s thread(%u,%u)"%(name,i,count)
                start_new_thread(httptest,(name,url))

test("rovid", ("10.0.0.2", 10000), 100)
system("ping 10.0.0.2")

--mP3DRpeJDSE+ciuQ--
