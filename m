Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVLQACq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVLQACq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 19:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVLQACq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 19:02:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:1226 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964845AbVLQACp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 19:02:45 -0500
Subject: Re: [PATCH] UHCI: add missing memory barriers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Linus Torvalds <torvalds@g5.osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <200512161959.jBGJxh05007356@hera.kernel.org>
References: <200512161959.jBGJxh05007356@hera.kernel.org>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 10:58:01 +1100
Message-Id: <1134777482.6102.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 11:59 -0800, Linux Kernel Mailing List wrote:
> tree d094f197975af7ef7b80006dbea0f5d38915f88b
> parent 42f3ab42875a52af7e711803bfb8d8d7cca84c1c
> author Alan Stern <stern@rowland.harvard.edu> Sat, 17 Dec 2005 03:09:01 -0800
> committer Linus Torvalds <torvalds@g5.osdl.org> Sat, 17 Dec 2005 03:25:25 -0800
> 
> [PATCH] UHCI: add missing memory barriers
> 
> This patch (as617) adds a couple of memory barriers that Ben H. forgot in
> his recent suspend/resume fix.

I didn't think they were necessary but they certainly won't hurt and
it's not a hot code path...

>  	pci_write_config_word(to_pci_dev(uhci_dev(uhci)), USBLEGSUP, 0);
> +	mb();

Isn't pci config space access always fully synchronous ?

>  	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
>  	uhci->hc_inaccessible = 1;
>  	hcd->poll_rh = 0;
> @@ -738,6 +739,7 @@ static int uhci_resume(struct usb_hcd *h
>  	 * really don't want to keep a stale HCD_FLAG_HW_ACCESSIBLE=0
>  	 */
>  	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
> +	mb();

I don't think that one matters much but it won't hurt for sure.

>  	if (uhci->rh_state == UHCI_RH_RESET)	/* Dead */
>  		return 0;
> -
> To unsubscribe from this list: send the line "unsubscribe git-commits-head" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

