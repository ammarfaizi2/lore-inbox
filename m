Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVGWUM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVGWUM2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 16:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVGWULl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 16:11:41 -0400
Received: from isilmar.linta.de ([213.239.214.66]:44268 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261581AbVGWULj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 16:11:39 -0400
Date: Sat, 23 Jul 2005 22:11:13 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Noah Misch <noah@cs.caltech.edu>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc3] pcmcia: pcmcia_request_irq for !IRQ_HANDLE_PRESENT
Message-ID: <20050723201113.GA12537@dominikbrodowski.de>
Mail-Followup-To: Noah Misch <noah@cs.caltech.edu>,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20050717035124.GC13529@orchestra.cs.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050717035124.GC13529@orchestra.cs.caltech.edu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> When a driver calls pcmcia_request_irq with IRQ_HANDLE_PRESENT unset, it looks
> for an open IRQ by request_irq()ing with a dummy handler and NULL dev_info.
> free_irq uses dev_info as a key for identifying the handler to free among those
> sharing an IRQ, so request_irq returns -EINVAL if dev_info is NULL and the IRQ
> may be shared.  That unknown error code is the -EINVAL.
> 
> It looks like only pcnet_cs and axnet_cs are affected.  Most other drivers let
> pcmcia_request_irq install their interrupt handlers.  sym53c500_cs requests its
> IRQ manually, but it cannot share an IRQ.
> 
> The appended patch changes pcmcia_request_irq to pass an arbitrary, unique,
> non-NULL dev_info with the dummy handler.

Thanks for the excellent debugging. Your patch seems to work, however it
might be better to do just this:

Index: 2.6.13-rc3-git2/drivers/pcmcia/pcmcia_resource.c
===================================================================
--- 2.6.13-rc3-git2.orig/drivers/pcmcia/pcmcia_resource.c
+++ 2.6.13-rc3-git2/drivers/pcmcia/pcmcia_resource.c
@@ -800,7 +800,7 @@ int pcmcia_request_irq(struct pcmcia_dev
 	} else {
 		int try;
 		u32 mask = s->irq_mask;
-		void *data = NULL;
+		void *data = test_action;
 
 		for (try = 0; try < 64; try++) {
 			irq = try % 32;


Thanks,
	Dominik
