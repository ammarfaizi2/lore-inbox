Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWGDKDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWGDKDj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 06:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWGDKDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 06:03:38 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:11423 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S932200AbWGDKDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 06:03:37 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch] fix AB-BA deadlock inversion at cs46xx_dsp_remove_scb
Date: Tue, 4 Jul 2006 12:03:14 +0200
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       Ingo Molnar <mingo@elte.hu>
References: <200607041115.35997.duncan.sands@math.u-psud.fr> <1152005720.3109.30.camel@laptopd505.fenrus.org>
In-Reply-To: <1152005720.3109.30.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607041203.15106.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, that fixes it.  However

> +	unsignded long flags;

should be "unsigned":

Index: Linux/sound/pci/cs46xx/dsp_spos_scb_lib.c
===================================================================
--- Linux.orig/sound/pci/cs46xx/dsp_spos_scb_lib.c	2006-07-04 10:09:05.778370000 +0200
+++ Linux/sound/pci/cs46xx/dsp_spos_scb_lib.c	2006-07-04 11:53:18.353662891 +0200
@@ -180,6 +180,7 @@
 void cs46xx_dsp_remove_scb (struct snd_cs46xx *chip, struct dsp_scb_descriptor * scb)
 {
 	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	unsigned long flags;
 
 	/* check integrety */
 	snd_assert ( (scb->index >= 0 && 
@@ -194,9 +195,9 @@
 		     goto _end);
 #endif
 
-	spin_lock(&scb->lock);
+	spin_lock_irqsave(&scb->lock, flags);
 	_dsp_unlink_scb (chip,scb);
-	spin_unlock(&scb->lock);
+	spin_unlock_irqrestore(&scb->lock, flags);
 
 	cs46xx_dsp_proc_free_scb_desc(scb);
 	snd_assert (scb->scb_symbol != NULL, return );
