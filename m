Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbTD2TsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 15:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbTD2TsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 15:48:13 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48412 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261603AbTD2TsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 15:48:12 -0400
Date: Tue, 29 Apr 2003 15:58:42 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-usb-devel@lists.sourceforge.net, fisaksen@bewan.com
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>,
       Arjan Van de Ven <arjanv@redhat.com>
Subject: Re: PATCH: usb-uhci: interrupt out with urb->interval 0  [linux-usb-devel]
Message-ID: <20030429155842.A9215@devserv.devel.redhat.com>
References: <20030416160035.GA13488@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030416160035.GA13488@gtf.org>; from jgarzik@pobox.com on Wed, Apr 16, 2003 at 12:00:36PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Frode Isaksen <fisaksen@bewan.com>
> Date: Wed, 16 Apr 2003 17:44:55 +0200

> A recent change (2.4.21) in the usb-uhci driver calls 
> "uhci_clean_iso_step2" after the completion of one-shot (urb->interval 
> 0) interrupt out transfers. This call clears the list of descriptors. 
> However, it crashes when trying to get the next desciptor in the "for" 
> loop in the "process_interrupt" function,

> --- drivers/usb/usb-uhci.c.orig	2003-04-16 15:39:04.000000000 +0200
> @@ -2628,6 +2628,7 @@
>  				// correct toggle after unlink
>  				usb_dotoggle (urb->dev, usb_pipeendpoint 
>  				(urb->pipe), usb_pipeout (urb->pipe));
>  				clr_td_ioc(desc); // inactivate TD
> +				break;
>  			}

Pretty obvious, but I'd rather see something like the attached
patch instead. The original code was obviously a case of a rash
copy-paste, complete with an unused "int i".

Is there a more interesting/popular/widespread device than
Lego Tower which uses these oneshots?

-- Pete

diff -urN -X dontdiff linux-2.4.21-rc1/drivers/usb/host/usb-uhci.c linux-2.4.21-rc1-nip/drivers/usb/host/usb-uhci.c
--- linux-2.4.21-rc1/drivers/usb/host/usb-uhci.c	2003-04-24 10:52:56.000000000 -0700
+++ linux-2.4.21-rc1-nip/drivers/usb/host/usb-uhci.c	2003-04-29 12:43:28.000000000 -0700
@@ -2430,9 +2430,9 @@
 
 _static int process_interrupt (uhci_t *s, struct urb *urb)
 {
-	int i, ret = -EINPROGRESS;
+	int ret = -EINPROGRESS;
 	urb_priv_t *urb_priv = urb->hcpriv;
-	struct list_head *p = urb_priv->desc_list.next;
+	struct list_head *p;
 	uhci_desc_t *desc = list_entry (urb_priv->desc_list.prev, uhci_desc_t, desc_list);
 
 	int actual_length;
@@ -2440,8 +2440,8 @@
 
 	//dbg("urb contains interrupt request");
 
-	for (i = 0; p != &urb_priv->desc_list; p = p->next, i++)	// Maybe we allow more than one TD later ;-)
-	{
+	// Maybe we allow more than one TD later ;-)
+	while ((p = urb_priv->desc_list.next) != &urb_priv->desc_list) {
 		desc = list_entry (p, uhci_desc_t, desc_list);
 
 		if (is_td_active(desc)) {
