Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWBXHiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWBXHiu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 02:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWBXHiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 02:38:50 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:1447 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750837AbWBXHit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 02:38:49 -0500
Date: Fri, 24 Feb 2006 02:38:40 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-rt16: possible sound-related side-effect
In-Reply-To: <200602240131.k1O1V7ip013435@auster.physics.adelaide.edu.au>
Message-ID: <Pine.LNX.4.58.0602240230170.20385@gandalf.stny.rr.com>
References: <200602240131.k1O1V7ip013435@auster.physics.adelaide.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Feb 2006, Jonathan Woithe wrote:

>
> I finally got around to doing this and the first two dumps are at the
> end of this message.  Many many more were sent to the logs though - as
> one would expect, since we know that in the fault condition this function
> is called very frequently without any end in site.

Thanks, it didn't find the bug for me, but it did get me a better idea of
what it's doing.  Now that you modified the kernel, I hope you are
comfortable in doing more of that :)

Remove the dump stack, and apply the following patch (should work with
both -rt16 and -rt17).  This is _not_ a bug fix (obviously) but will do
a lot more prints.  I don't know how many interrupts this driver produces
so beware that this can really fill the logs.

Apply the patch and then can you do the same and post the results? This
will give me a good idea at what is happening.  You'll want to remove the
patch afterwards, since it produces a lot of noise.

>
> I've put the *full* dump up at
>
>   http://www.atrad.com.au/~jwoithe/kernel/full_timeout_dump.bz2
>
> if anyone's interested.  Similarly, I moved the dump_stack() call
> outside the while() loop and obtained a dump in the case of things
> working correctly.  You can grab this from
>
>   http://www.atrad.com.au/~jwoithe/kernel/dump_loaded_ok.bz2
>
> Oh yes, the dump_stack() call was put *before* the snd_printk() call
> when I did the tests.  This makes no practical difference except that it
> explains why the output from this came after the dumps.
>
> Over the weekend I'll try to test 2.6.15-rt17 since that's recently come
> out.
>
> What next?
>

Here's the patch.

-- Steve

Index: linux-2.6.15-rt17/sound/pci/hda/hda_intel.c
===================================================================
--- linux-2.6.15-rt17.orig/sound/pci/hda/hda_intel.c	2006-02-08 08:34:07.000000000 -0500
+++ linux-2.6.15-rt17/sound/pci/hda/hda_intel.c	2006-02-24 02:28:24.000000000 -0500
@@ -486,10 +486,14 @@ static void azx_update_rirb(azx_t *chip)
 	u32 res, res_ex;

 	wp = azx_readb(chip, RIRBWP);
-	if (wp == chip->rirb.wp)
+	printk("%s: wp 0x%x\n",__FUNCTION__,wp);
+	if (wp == chip->rirb.wp) {
+		printk("%s: ?? bye bye\n",__FUNCTION__);
 		return;
+	}
 	chip->rirb.wp = wp;

+	printk("%s: rp=0x%x\n",__FUNCTION__,chip->rirb.rp);
 	while (chip->rirb.rp != wp) {
 		chip->rirb.rp++;
 		chip->rirb.rp %= ICH6_MAX_RIRB_ENTRIES;
@@ -497,13 +501,16 @@ static void azx_update_rirb(azx_t *chip)
 		rp = chip->rirb.rp << 1; /* an RIRB entry is 8-bytes */
 		res_ex = le32_to_cpu(chip->rirb.buf[rp + 1]);
 		res = le32_to_cpu(chip->rirb.buf[rp]);
-		if (res_ex & ICH6_RIRB_EX_UNSOL_EV)
+		if (res_ex & ICH6_RIRB_EX_UNSOL_EV) {
+			printk("%s: unsol event\n",__FUNCTION__);
 			snd_hda_queue_unsol_event(chip->bus, res, res_ex);
-		else if (chip->rirb.cmds) {
+		} else if (chip->rirb.cmds) {
 			chip->rirb.cmds--;
+			printk("%s: chip->rirb.cmds=0x%x\n",__FUNCTION__,chip->rirb.cmds);
 			chip->rirb.res = res;
 		}
 	}
+	printk("%s: out\n",__FUNCTION__);
 }

 /* receive a response */
@@ -767,11 +774,14 @@ static irqreturn_t azx_interrupt(int irq
 	u32 status;
 	int i;

+	printk("%s: irq %d\n",__FUNCTION__,irq);
 	spin_lock(&chip->reg_lock);

 	status = azx_readl(chip, INTSTS);
+	printk("%s: status INTSTS 0x%x\n",__FUNCTION__,status);
 	if (status == 0) {
 		spin_unlock(&chip->reg_lock);
+		printk("%s: no irq?\n",__FUNCTION__);
 		return IRQ_NONE;
 	}

@@ -791,6 +801,7 @@ static irqreturn_t azx_interrupt(int irq

 	/* clear rirb int */
 	status = azx_readb(chip, RIRBSTS);
+	printk("%s: status RIRBSTS 0x%x\n",__FUNCTION__,status);
 	if (status & RIRB_INT_MASK) {
 		if (status & RIRB_INT_RESPONSE)
 			azx_update_rirb(chip);
@@ -804,6 +815,7 @@ static irqreturn_t azx_interrupt(int irq
 #endif
 	spin_unlock(&chip->reg_lock);

+	printk("%s: out\n",__FUNCTION__);
 	return IRQ_HANDLED;
 }

