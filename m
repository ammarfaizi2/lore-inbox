Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317363AbSHBXzK>; Fri, 2 Aug 2002 19:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317404AbSHBXym>; Fri, 2 Aug 2002 19:54:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46347 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317363AbSHBXxB>; Fri, 2 Aug 2002 19:53:01 -0400
Date: Sat, 3 Aug 2002 00:56:26 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: tytso@mit.edu, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
       axel@hh59.org
Subject: Re: Linux 2.5.30: [SERIAL] build fails at 8250.c
Message-ID: <20020803005626.D16963@flint.arm.linux.org.uk>
References: <20020802154924.A5505@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020802154924.A5505@baldur.yggdrasil.com>; from adam@yggdrasil.com on Fri, Aug 02, 2002 at 03:49:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 03:49:24PM -0700, Adam J. Richter wrote:
> 	linux-2.5.30/include/linux/serialP.h needs struct async_icount,
> which is defined in <linux/serial.h>, causing
> linux-2.5.30/drivers/serial/8250.c not to compile, among other problems.
> In linux-2.5.30, you cannot compile a file that includes <linux/serialP.h>
> without including <linux/serial.h>.  So, I think the solution is for
> serialP.h to #include serial.h.  I have attached a patch that does this.

Ack.  I've just found why I and many other people can build it, and
other people can't.  I can tell you that you're building 8250.c as a
module.

Why?

When I build 8250.c into the kernel, linux/module.h doesn't include
linux/version.h, so when we include linux/serialP.h, the compiler
assumes that LINUX_VERSION_CODE is zero.  So we end up including
linux/serial.h.

However, when building as a module, linux/module.h does include
linux/version.h, so when we don't include linux/serial.h.

Oh, the problems of trying to reduce the includes...  I think we should
re-include linux/serial.h and eliminate linux/serialP.h.

Hmm, I wonder how many other oddities like this are in the tree today.
It sounds like we want to create a rule similar to the one for using
CONFIG_* symbols.  Does this sound reasonable: if you use
LINUX_VERSION_CODE, you must include linux/version.h into that very
same file to guarantee that it is defined.

Well, I took checkconfig.pl and created checkversion.pl (attached).
Oh god, can I please put the worms back in the can?  Now?  I think
there's lots of work to do here; lots of stuff including linux/version.h
for the hell of it, and a comparitively small number not including it
when they use LINUX_VERSION_CODE.

(No, I'm just off to zzz, so this must be a nightmare, maybe it'll go
away by the time I wake up later today.) 8/

> 	Ted (or whowever gathers drivers/serial patches for Linus), do
> you want to shepherd this change to Linus, do you want me to submit it
> directly, or do you want to do something else?

It's more a thing for me than Ted.  One of the things I'd like to
do is to eventually kill off serialP.h

Ok, here's a fix for the 8250.c build problem (please don't send it
to Linus; I've other changes that'll be going via BK and patch to
lkml pending):

--- orig/drivers/serial/8250.c	Fri Aug  2 21:13:31 2002
+++ linux/drivers/serial/8250.c	Sat Aug  3 00:28:47 2002
@@ -31,7 +31,8 @@
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/serial_reg.h>
-#include <linux/serialP.h>
+#include <linux/circ_buf.h>
+#include <linux/serial.h>
 #include <linux/delay.h>
 
 #include <asm/io.h>
--- orig/drivers/serial/8250.h	Sat Jul 27 13:55:21 2002
+++ linux/drivers/serial/8250.h	Sat Aug  3 00:28:21 2002
@@ -59,3 +59,15 @@
 #else
 #define SERIAL8250_SHARE_IRQS 0
 #endif
+
+#if defined(__alpha__) && !defined(CONFIG_PCI)
+/*
+ * Digital did something really horribly wrong with the OUT1 and OUT2
+ * lines on at least some ALPHA's.  The failure mode is that if either
+ * is cleared, the machine locks up with endless interrupts.
+ */
+#define ALPHA_KLUDGE_MCR  (UART_MCR_OUT2 | UART_MCR_OUT1)
+#else
+#define ALPHA_KLUDGE_MCR 0
+#endif
+


And here's the (hacked up) checkversion.pl script - its used in the same
way as checkconfig.pl in the makefile, so use like this:

$ cd linux
$ find * -name SCCS -prune -o -name BitKeeper -prune -o -name '*.[chS]' \
 -type f -print | sort | xargs perl -w ../checkversion.pl

I'll clean it up _after_ sleep, unless someone doesn't get there first.

#! /usr/bin/perl
#
# checkconfig: find uses of CONFIG_* names without matching definitions.
# Copyright abandoned, 1998, Michael Elizabeth Chastain <mailto:mec@shout.net>.

use integer;

$| = 1;

foreach $file (@ARGV)
{
    # Open this file.
    open(FILE, $file) || die "Can't open $file: $!\n";

    # Initialize variables.
    my $fInComment    = 0;
    my $fInString     = 0;
    my $fUseKernCode  = 0;
    my $iLinuxVersion = 0;

    LINE: while ( <FILE> )
    {
	# Strip comments.
	$fInComment && (s+^.*?\*/+ +o ? ($fInComment = 0) : next);
	m+/\*+o && (s+/\*.*?\*/+ +go, (s+/\*.*$+ +o && ($fInComment = 1)));

	# Pick up definitions.
	if ( m/^\s*#/o )
	{
	    $iLinuxVersion     = $. if m/^\s*#\s*include\s*"linux\/version\.h"/o;
	}

	# Strip strings.
	$fInString && (s+^.*?"+ +o ? ($fInString = 0) : next);
	m+"+o && (s+".*?"+ +go, (s+".*$+ +o && ($fInString = 1)));

	# Pick up definitions.
	if ( m/^\s*#/o )
	{
	    $iLinuxVersion     = $. if m/^\s*#\s*include\s*<linux\/version\.h>/o;
	}

	# Look for usages.
	next unless m/LINUX_VERSION_CODE/o;
	$fUseKernCode = 1;
	last LINE if $iLinuxVersion;
	print "$file: $.: need linux/version.h\n";
	last LINE
    }

    # Report superfluous includes.
    if ( $iLinuxVersion && ! $fUseKernCode )
	{ print "$file: $iLinuxVersion: linux/version.h not needed.\n"; }

    close(FILE);
}


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

