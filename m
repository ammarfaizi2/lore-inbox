Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135343AbRDLVdj>; Thu, 12 Apr 2001 17:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135344AbRDLVdU>; Thu, 12 Apr 2001 17:33:20 -0400
Received: from [204.178.40.224] ([204.178.40.224]:3456 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135343AbRDLVdR>; Thu, 12 Apr 2001 17:33:17 -0400
Date: Thu, 12 Apr 2001 17:27:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Daniel Podlejski <underley@underley.eu.org>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Incorect signal handling ?
In-Reply-To: <20010412223128.A11625@witch.underley.eu.org>
Message-ID: <Pine.LNX.3.95.1010412170827.1515A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001, Daniel Podlejski wrote:

> Hi,
> 
> there is litlle programm:
> 
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <signal.h>
> #include <errno.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> 
> static void empty(int sig)
> {
> 	printf ("hello\n");
> 	return;
> }
> 
> void main()
> {
>         int fd, a;
>         char buf[512];
> 
> 	if (fd = open("/tmp/nic", O_RDONLY) < 0)
> 	{
> 		perror ("open");
> 		exit(1);
> 	}
> 
> 	signal (SIGALRM, empty);
> 	alarm (1);
> 
>         a = read(fd, buf, 511);
> 
>         while (a && a != -1) a = read(fd, buf, 511);
> 
> 	if (a == -1)
> 	{
> 		perror ("read");
> 		exit(1);
> 	}
> 	else printf ("EOF\n");
> 
>         exit(0);
> }
> 
> I open /tmp/nic and run compiled program.
> There should be error EINTR in read, but isn't.
> Why ?
> 

The test program contains several errors. Here is a 'fixed' version.

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <signal.h>
#include <errno.h>
#include <sys/stat.h>
#include <fcntl.h>

static void empty(int sig)
{
	printf ("hello\n");
	return;
}

void main()
{
        int fd, a;
        struct sigaction sa;
        char buf[512];

	if (fd = open("/dev/zero", O_RDONLY) < 0)
	{
		perror ("open");
		exit(1);
	}
        sigaction(SIGALRM, NULL, &sa);
        sa.sa_handler = empty;
        sa.sa_flags   = SA_INTERRUPT;
        sigaction(SIGALRM, &sa, NULL);
	alarm (1);

        while ((a = read(fd, buf, 511)) > 0)
            ;

	if (a == -1)
	{
		perror ("read");
		exit(1);
	}
	else printf ("EOF\n");
        exit(0);
}


First, you need to read something that can be interrupted. A 511 byte
read from a small file will probably never be interrupted. The code
can be spending much more time in the 'while (funny stuff)' loop than
it takes to read that file.

I chose to read from an infinite-size 'file'.

Second, your 'C' runtime library probably defaults to non-BSD signals.
That is to say, the "SA_RESTART" bit is probably set in the flags.
To get the system call interrupted, you need to have that bit clear.
The way to do it is with sigaction(); signal() is just not capable
of doing what you want, now that 'C' runtime libraries default to
POSIX-signal behavior rather than BSD-signals.

FYI, main() can never be void. It must return an 'int'.
  while (a && a != -1) a = read(fd, buf, 511);
doesn't make much sense. (a && a) is either TRUE or FALSE. It
will, therefore NEVER be -1. Maybe you meant (a & a)? If so,
why not just (a != -1) or (a > 0) ?

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


