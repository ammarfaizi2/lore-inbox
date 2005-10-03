Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVJCGtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVJCGtw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 02:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVJCGtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 02:49:51 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:52116 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932154AbVJCGtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 02:49:51 -0400
Date: Mon, 3 Oct 2005 08:50:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] drivers/ide/pci/alim15x3.c SMP fix
Message-ID: <20051003065032.GA23777@elte.hu>
References: <20050901072430.GA6213@elte.hu> <1125571335.15768.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125571335.15768.21.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Iau, 2005-09-01 at 09:24 +0200, Ingo Molnar wrote:
> > is this the right way to fix the UP assumption below?
> 
> Probably not. The ide_lock may already be held (randomly depending on 
> the code path) at the point we retune a drive on error. Actually you 
> probably crash before this anyway.
> 
> The ALi code in question was written knowing the system would be
> uniprocessor and making various related assumptions. You also have to
> get this locking right just to make it more fun - loading the timings
> for one channel while another is doing I/O corrupts your data silently
> in some cases. Fixing the ide_lock to be consistent in usage when the
> tuning calls are made (ie fix the reset path and other offenders) might
> be possible and would make using ide_lock ok, but it would still be
> wrong with pre-emption and/or SMP.

so perhaps part of the solution would be to do the initialization under 
the IDE lock, via the patch below? It boots fine on my box so the basic 
codepaths seem to be OK. Then the retuning codepaths need to be checked 
to make sure they are holding the IDE lock.

	Ingo

Index: linux/drivers/ide/setup-pci.c
===================================================================
--- linux.orig/drivers/ide/setup-pci.c
+++ linux/drivers/ide/setup-pci.c
@@ -665,8 +665,11 @@ static int do_ide_setup_pci_device(struc
 {
 	static ata_index_t ata_index = { .b = { .low = 0xff, .high = 0xff } };
 	int tried_config = 0;
+	unsigned long flags;
 	int pciirq, ret;
 
+	spin_lock_irqsave(&ide_lock, flags);
+
 	ret = ide_setup_pci_controller(dev, d, noisy, &tried_config);
 	if (ret < 0)
 		goto out;
@@ -721,6 +724,8 @@ static int do_ide_setup_pci_device(struc
 	*index = ata_index;
 	ide_pci_setup_ports(dev, d, pciirq, index);
 out:
+	spin_unlock_irqrestore(&ide_lock, flags);
+
 	return ret;
 }
 
