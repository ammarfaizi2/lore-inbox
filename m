Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUEQXK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUEQXK7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbUEQXK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:10:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:15051 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263101AbUEQXKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:10:40 -0400
Date: Mon, 17 May 2004 16:12:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert.Picco@hp.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] HPET driver
Message-Id: <20040517161212.659746db.akpm@osdl.org>
In-Reply-To: <20040517160508.63e1ddf0.akpm@osdl.org>
References: <40A3F805.5090804@hp.com>
	<40A40204.1060509@pobox.com>
	<40A93DA5.4020701@hp.com>
	<20040517160508.63e1ddf0.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Robert Picco <Robert.Picco@hp.com> wrote:
> >
> > O.K.  Did this but had to add a writeq and readq for i386.
> 
> You implementation of these is private to hpet.c.  From what Jeff is
> saying, it looks like it should be in include/asm-i386/io.h?

This look OK?

readq()/writeq() are supposed to be defined in terms of u64's.




---

 25-akpm/drivers/char/hpet.c   |   15 ---------------
 25-akpm/include/asm-i386/io.h |   11 +++++++++++
 2 files changed, 11 insertions(+), 15 deletions(-)

diff -puN drivers/char/hpet.c~hpet-driver-updates-move-readq drivers/char/hpet.c
--- 25/drivers/char/hpet.c~hpet-driver-updates-move-readq	Mon May 17 16:06:34 2004
+++ 25-akpm/drivers/char/hpet.c	Mon May 17 16:06:47 2004
@@ -90,21 +90,6 @@ static struct hpets *hpets;
 #define	read_counter(MC)	readl(MC)
 #endif
 
-#ifndef readq
-static unsigned long long __inline readq(void *addr)
-{
-	return readl(addr) | (((unsigned long long)readl(addr + 4)) << 32LL);
-}
-#endif
-
-#ifndef writeq
-static void __inline writeq(unsigned long long v, void *addr)
-{
-	writel(v & 0xffffffff, addr);
-	writel(v >> 32, addr + 4);
-}
-#endif
-
 static irqreturn_t hpet_interrupt(int irq, void *data, struct pt_regs *regs)
 {
 	struct hpet_dev *devp;
diff -puN include/asm-i386/io.h~hpet-driver-updates-move-readq include/asm-i386/io.h
--- 25/include/asm-i386/io.h~hpet-driver-updates-move-readq	Mon May 17 16:06:34 2004
+++ 25-akpm/include/asm-i386/io.h	Mon May 17 16:11:11 2004
@@ -364,4 +364,15 @@ BUILDIO(b,b,char)
 BUILDIO(w,w,short)
 BUILDIO(l,,int)
 
+static inline u64 readq(void *addr)
+{
+	return readl(addr) | (((u64)readl(addr + 4)) << 32);
+}
+
+static inline void writeq(u64 v, void *addr)
+{
+	writel(v & 0xffffffff, addr);
+	writel(v >> 32, addr + 4);
+}
+
 #endif

_

