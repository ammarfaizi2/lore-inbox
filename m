Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268315AbUIKU70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268315AbUIKU70 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 16:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268322AbUIKU7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 16:59:16 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:34471 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S268321AbUIKU6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 16:58:30 -0400
Date: Sat, 11 Sep 2004 22:58:28 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, James@superbug.demon.co.uk,
       dth@ncc1701.cistron.net, linux-kernel@vger.kernel.org
Subject: Re: Linux serial console patch
Message-ID: <20040911205828.GB31680@MAIL.13thfloor.at>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>, James@superbug.demon.co.uk,
	dth@ncc1701.cistron.net, linux-kernel@vger.kernel.org
References: <20040905175037.O58184@cus.org.uk> <413BA35C.8080705@superbug.demon.co.uk> <chhebr$pta$1@news.cistron.nl> <20040906114321.A26906@flint.arm.linux.org.uk> <413C8612.4010806@superbug.demon.co.uk> <20040906165230.C30400@flint.arm.linux.org.uk> <20040906094622.6816784f.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040906094622.6816784f.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 09:46:22AM -0700, Randy.Dunlap wrote:
> On Mon, 6 Sep 2004 16:52:30 +0100 Russell King wrote:
> 
> | On Mon, Sep 06, 2004 at 04:45:22PM +0100, James Courtier-Dutton wrote:
> | > Russell King wrote:
> | > > On Mon, Sep 06, 2004 at 10:32:27AM +0000, Danny ter Haar wrote:
> | > > 
> | > >>James Courtier-Dutton  <James@superbug.demon.co.uk> wrote:
> | > >>
> | > >>>>I have read your posts to lkml containing your serial console flow control
> | > >>>>patches firstly for 2.4.x and then for 2.6.x kernels.
> | > >>>
> | > >>>Does this fix junk being output from the serial console?
> | > >>>If one is using Pentium 4 HT, it seems that both CPU cores try to send 
> | > >>>characters to the serial port at the same time, resulting in lost 
> | > >>>characters as one CPU over writes the output from the other.
> | > >>
> | > >>We have multiple P4-HT enabled servers with debian installed & serial
> | > >>console enabled (RPB++ ;-) and _i_ have never seen this behaviour.
> | > > 
> | > > 
> | > > I don't think this is a serial problem as such, but a problem with the
> | > > kernel console subsystem (printk) itself.  Maybe James can provide an
> | > > example output to confirm exactly what he's seeing.
> | > > 
> | > 
> | > http://www.superbug.demon.co.uk/latency/
> | > 
> | > There are 2 oops traces there. At about line 176, the corruption starts.
> | 
> | They both look like a two printk's overlapping each other, which isn't
> | unreasonable since one is an oops.  We try real hard to get oopses
> | out, which means "busting" the printk spinlocks.  The side effect of
> | busting those spinlocks is of course no console locking.
> | 
> | It may be annoying, but unless some SMP person wants to fix the spinlock
> | busting to be a little more inteligent, you can expect this situation
> | to continue.
> 
> I've seen it enough times that I would like to see it fixed,
> and David Howells (RH) has posted a patch for it several times.
> 
> I'm woondering if this:
> http://linux.bkbits.net:8080/linux-2.5/diffs/kernel/printk.c@1.38?nav=index.html|src/|src/kernel|hist/kernel/printk.c
> is supposed to be a patch for the problem in the 'latency' log above.
> If so, it's not as good a solution as David Howells's patch is.
> His latest (AFAIK) is:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=105730993512692&w=2

here is an updated version:

--- ./kernel/printk.c.orig	2004-09-10 23:56:11.000000000 +0200
+++ ./kernel/printk.c	2004-09-11 22:56:33.000000000 +0200
@@ -521,6 +521,8 @@ asmlinkage int printk(const char *fmt, .
 	return r;
 }
 
+static volatile int printk_cpu = -1;
+
 asmlinkage int vprintk(const char *fmt, va_list args)
 {
 	unsigned long flags;
@@ -529,11 +531,12 @@ asmlinkage int vprintk(const char *fmt, 
 	static char printk_buf[1024];
 	static int log_level_unknown = 1;
 
-	if (unlikely(oops_in_progress))
+	if (unlikely(oops_in_progress && printk_cpu == smp_processor_id()))
 		zap_locks();
 
 	/* This stops the holder of console_sem just where we want him */
 	spin_lock_irqsave(&logbuf_lock, flags);
+	printk_cpu = smp_processor_id();
 
 	/* Emit the output into the temporary buffer */
 	printed_len = vscnprintf(printk_buf, sizeof(printk_buf), fmt, args);


HTH,
Herbert

> --
> ~Randy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
