Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267500AbRGUBG2>; Fri, 20 Jul 2001 21:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267506AbRGUBGR>; Fri, 20 Jul 2001 21:06:17 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:63678 "EHLO snfc21.pbi.net")
	by vger.kernel.org with ESMTP id <S267503AbRGUBGK>;
	Fri, 20 Jul 2001 21:06:10 -0400
Date: Fri, 20 Jul 2001 18:08:37 -0700
From: Bruce Korb <bkorb@pacbell.net>
Subject: Re: Strange fixinclude behavior for GCC 3.0
To: GCC-Bugs <gcc-bugs@gcc.gnu.org>, Raul Nunez <dervishd@jazzfree.com>
Cc: bkorb@pacbell.net, linux-kernel@vger.kernel.org
Message-id: <3B58D615.11E727EF@pacbell.net>
Organization: Home
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-4GB i586)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
In-Reply-To: <3B5731FC.76653135@veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


>     Hello everybody at GCC :)

Hello,

> 2.- Fixincludes fixes [several] includes from the linux kernel [...]

I ran fixincl against today's 2.4.7:

> ....
> Applying machine_name             to linux/a.out.h
> Fixed:  linux/a.out.h
> ....
> Applying avoid_wchar_t_type       to linux/nls.h
> Fixed:  linux/nls.h
> ....
> Applying io_quotes_def            to linux/i2c.h
> Fixed:  linux/i2c.h
> ....
> Applying io_quotes_use            to net/irda/irtty.h
> Fixed:  net/irda/irtty.h
> Applying io_quotes_use            to net/irda/irmod.h
> Fixed:  net/irda/irmod.h
> Applying machine_name             to net/dsfield.h
> Fixed:  net/dsfield.h
> ....
> Cleaning up unneeded directories:

It looks like six headers got fixed.  "linux/a.out.h" and "linux/nls.h"
were properly fixed, "net/dsfield.h" is an unavoidable dumb fix,
and there are *three* files that were unchanged and appear in
the fixed directory:  linux/i2c.h net/irda/irtty.h net/irda/irmod.h
All three were "fixed" by io_quotes_def or _use.  Since there
is supposed to be code that does a byte-by-byte comparison of
the results before the output file gets created, it is curious
indeed.  Something is tripping something up.  Thanks for your report!

 - Bruce

$ for f in `find * -type f` ; do diff -u $SDIR/$f $f ; done
--- /work/kernel/linux-2.4.7/include/linux/a.out.h
+++ linux/a.out.h       Fri Jul 20 17:44:23 2001
@@ -127,7 +136,7 @@
 #define SEGMENT_SIZE PAGE_SIZE
 #endif

-#ifdef linux
+#ifdef __linux__
 #include <asm/page.h>
 #if defined(__i386__) || defined(__mc68000__)
 #define SEGMENT_SIZE   1024
--- /work/kernel/linux-2.4.7/include/linux/nls.h
+++ linux/nls.h Fri Jul 20 17:44:23 2001
@@ -1,10 +1,21 @@
 #ifndef _LINUX_NLS_H
 #define _LINUX_NLS_H

 #include <linux/init.h>

 /* unicode character */
+#ifndef __cplusplus
 typedef __u16 wchar_t;
+#endif
 
 struct nls_table {
        char *charset;
--- /work/kernel/linux-2.4.7/include/linux/i2c.h
+++ linux/i2c.h Fri Jul 20 17:44:26 2001
<<NO CHANGES>>

--- /work/kernel/linux-2.4.7/include/net/irda/irtty.h
+++ net/irda/irtty.h    Fri Jul 20 17:44:29 2001
<<NO CHANGES>>

--- /work/kernel/linux-2.4.7/include/net/irda/irmod.h
+++ net/irda/irmod.h    Fri Jul 20 17:44:29 2001
<<NO CHANGES>>

--- /work/kernel/linux-2.4.7/include/net/dsfield.h
+++ net/dsfield.h       Fri Jul 20 17:44:29 2001
@@ -51,7 +60,7 @@
 }
 
 
-#if 0 /* put this later into asm-i386 or such ... */
+#if 0 /* put this later into asm-__i386__ or such ... */
 
 static inline void ip_change_dsfield(struct iphdr *iph,__u16 dsfield)
 {
