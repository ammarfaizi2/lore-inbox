Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <970949-23842>; Thu, 19 Mar 1998 18:56:44 -0500
Received: from mail.fluke.com ([206.138.179.7]:1839 "EHLO fluke.com" ident: "TIMEDOUT") by vger.rutgers.edu with ESMTP id <970945-23842>; Thu, 19 Mar 1998 18:56:26 -0500
Date: Thu, 19 Mar 1998 16:07:58 -0800
From: David Dyck <dcd@TC.FLUKE.COM>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: linux-kernel@vger.rutgers.edu
Subject: Re: signal names
In-Reply-To: <Pine.LNX.3.95.980319175550.104A-100000@chaos.analogic.com>
Message-Id: <98Mar19.160802pst.27803@gateway2.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

Thanks for the quick reply, and I hope you 
don't mind another follow up to linux-kernel

On Thu, 19 Mar 1998, Richard B. Johnson wrote:

> On Thu, 19 Mar 1998, David Dyck wrote:
> 
> > Thanks Richard,
> [SNIPPED]
> > 
> > The problem is still with the linux 2.1.x headers.

> The problem is that nobody has taken the time to sort it all out.

  I'd like to help, as I've already suggested adding #ifdef __KERNEL__
around them 

> No user program is supposed to "know" about <asm/...> they should
> only include <signal.h> and <sys/signal.h>. 

> The latest glibc includes <signum.h> into <signal.h> and never
> looks at /usr/include/asm|linux since it is not supposed to "know"
> that such exists.

    I just looked at glibc-2.0.6/sysdeps/unix/sysv/linux/signum.h
and they don't have SIGRTMAX in it.  I only have access to
Solaris and linux header files, but Solaris pretents to support
sysv as well as POSIX.  I noticed that the glibc headers
for solaris2 (sysdeps/unix/sysv/sysv4/solaris2/signum.h)
does include the new Solaris signals including
_SIGRTMIN and _SIGRTMAX.

    If I was runing with glibc, then I probably wouldn't
have noticed this problem, but I'm still using libc 5.4.44
which is what is mentioned in linux Documented/Changes.

> To find the "real" signals, a program, script, or person has to
> follow the trail from /usr/include/signal.h to find any text
> that has SIGHUP and SIGINT on adjacent lines with white-space allowed.
> 
> Then, if the text doesn't start with "#define" "enum" or "typedef",
> you have to continue the search. Eventually a list of signals will
> be found. SIGHUP will always be 1 and SIGINT will always be 2. They
> come from the appropriate control-character - 64. Others could be
> anything.
> 
> To do this on any Unix system would not be too hard.

You've descripte what Perl does pretty well,  it uses
the preprocessor output to determine all the files that
are included into a program that #includes <signal.h>
It then looks at the file names that the preprocessor
puts in, and greps through those files (with awk if I remember right)

What perl's configuration script comes up with after
it chases through something like 
  echo "#include <signal.h>" | gcc -E - | \
	awk '/#.*"..*"/ {print $3 }'  | sed -e 's/"//g' | \
		sort -u | xargs grep -l SIG

on my computer is

    /usr/include/asm/siginfo.h
    /usr/include/asm/signal.h
    /usr/include/linux/signal.h
    /usr/include/signal.h

and that include the line from /usr/include/asm/signal.h
#define SIGRTMAX      (_NSIG-1)

but since __KERNEL__ is not defined there is no definition
of the value _NSIG

This causes perl's configure to not be able to detect
the correct values for these signals.  (There are some
changes that I've yet to determine that may help
perl throught this problem).

It also causes the following valid C program to not compile
under linux 2.1.x and libc 5.4.44.

#include <signal.h>

#include <stdio.h>
int main() {
#if defined(SIGRTMIN)
        printf("SIGRTMIN=%d\n", SIGRTMIN);
#endif
#if defined(SIGRTMAX)
        printf("SIGRTMAX=%d\n", SIGRTMAX);
#endif
}

I get the following error:

rtmax.c: In function `main':
rtmax.c:9: `_NSIG' undeclared (first use this function)
rtmax.c:9: (Each undeclared identifier is reported only once
rtmax.c:9: for each function it appears in.)

What is surprising is that no one else seems to catch
on that this is a linux 2.1.x header problem

Any other advice would be appreciated.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
