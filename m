Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274976AbTHAWsN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 18:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274978AbTHAWsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 18:48:13 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:54288 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S274976AbTHAWsG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 18:48:06 -0400
Date: Sat, 2 Aug 2003 00:47:53 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre10
Message-ID: <20030801224753.GA912@alpha.home.local>
References: <Pine.LNX.4.44.0308011316490.3656-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308011316490.3656-100000@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01, 2003 at 01:19:11PM -0300, Marcelo Tosatti wrote:
> 
> Hello,
> 
> Here goes -pre10, hopefully the last -pre of 2.4.22. 
> 
> It contains a bunch of important fixes, detailed below.
> 
> Please help testing.

Hi Marcelo,

First, one word : Congratulations !

This is the _first_ vanilla 2.4 kernel which I can run _unpatched_ on my
customer's firewalls. This one was stressed all the day at 4000 hits/s.
Subsystems and drivers include aic7xxx, cpqarray, bonding, tulip, eepro100,
sunhme, PIII / PPro SMP, netfilter. Everything looks fine and smooth even at a
sustained write rate of 900 kB/s (logs). I only loose and corrupt significant
number of firewall logs above 3000 lines/s if I don't extend the log buffer
size. I've been using the fairly simple attached patch for a few months now
with success (no loss up to 5600 lines/s). I believe Randy Dunlap has already
got nearly the same one included in 2.5/2.6, so may want to include it too
since it's not really intrusive, although my customer can survive with one
patch :-)

Second, I'm writing this mail from my alpha :

bash-2.03$ uname -a
Linux alpha 2.4.22-pre10 #1 Fri Aug 1 23:20:31 CEST 2003 alpha unknown

It compiled without a glitch and I've got no error in the logs yet. The
previous stable version on this machine was 2.4.21-rc3 + aic7xxx from Justin.
For the record, this one is an NFS server on reiserfs on soft raid5 on aic7xxx.

Third, my VAIO likes it a lot since I can now power it off without holding the
button during 4 seconds !

So for me, it looks like the cleanest 2.4 to date. I will only tell you in 450
days if it's as much reliable as have been my old ones for the last 450 days of
interrupted service :-)

I hope we'll get other positive records so that we can quickly get 2.4.22.

Thanks to you and all others in $ChangeLog for this good version !
Willy
 
============
patch : make LOG_BUF_LEN configurable at config time
============

diff -urN wt10-pre3/Documentation/Configure.help wt10-pre3-log-buf-len/Documentation/Configure.help
--- wt10-pre3/Documentation/Configure.help	Wed Mar 19 09:58:25 2003
+++ wt10-pre3-log-buf-len/Documentation/Configure.help	Tue Mar 25 08:20:35 2003
@@ -25231,6 +25231,19 @@
   output to the second serial port on these devices.  Saying N will
   cause the debug messages to appear on the first serial port.
 
+Kernel log buffer length shift
+CONFIG_LOG_BUF_SHIFT
+  The kernel log buffer has a fixed size of :
+      64 kB (2^16) on MULTIQUAD and IA64,
+     128 kB (2^17) on S390
+      32 kB (2^15) on SMP systems
+      16 kB (2^14) on UP systems
+
+  You have the ability to change this size with this parameter which
+  fixes the bit shift used to get the buffer length (which must be a
+  power of 2). Eg: a value of 16 sets the buffer to 64 kB (2^16).
+  The default value of 0 uses standard values above.
+
 Disable pgtable cache
 CONFIG_NO_PGT_CACHE
   Normally the kernel maintains a `quicklist' of preallocated
diff -urN wt10-pre3/arch/i386/config.in wt10-pre3-log-buf-len/arch/i386/config.in
--- wt10-pre3/arch/i386/config.in	Wed Mar 19 09:58:25 2003
+++ wt10-pre3-log-buf-len/arch/i386/config.in	Tue Mar 25 08:25:12 2003
@@ -508,6 +508,8 @@
     string '   Initial kernel command line' CONFIG_CMDLINE "root=301 ro"
 fi
 
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 endmenu
 
 source lib/Config.in
diff -urN wt10-pre3/kernel/printk.c wt10-pre3-log-buf-len/kernel/printk.c
--- wt10-pre3/kernel/printk.c	Wed Mar 19 09:58:20 2003
+++ wt10-pre3-log-buf-len/kernel/printk.c	Tue Mar 25 08:14:55 2003
@@ -29,6 +29,7 @@
 
 #include <asm/uaccess.h>
 
+#if !defined(CONFIG_LOG_BUF_SHIFT) || (CONFIG_LOG_BUF_SHIFT - 0 == 0)
 #if defined(CONFIG_MULTIQUAD) || defined(CONFIG_IA64)
 #define LOG_BUF_LEN	(65536)
 #elif defined(CONFIG_ARCH_S390)
@@ -37,6 +38,9 @@
 #define LOG_BUF_LEN	(32768)
 #else	
 #define LOG_BUF_LEN	(16384)			/* This must be a power of two */
+#endif
+#else /* CONFIG_LOG_BUF_SHIFT */
+#define LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
 #endif
 
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)


