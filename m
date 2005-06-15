Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVFOGad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVFOGad (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 02:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVFOGad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 02:30:33 -0400
Received: from mail1.kontent.de ([81.88.34.36]:55189 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261508AbVFOGaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 02:30:00 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Wakko Warner <wakko@animx.eu.org>
Subject: Re: Problem found: kaweth fails to work on 2.6.12-rc[456]
Date: Wed, 15 Jun 2005 08:29:52 +0200
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050612004136.GA8107@animx.eu.org> <200506121722.09813.oliver@neukum.org> <20050615010238.GA9215@animx.eu.org>
In-Reply-To: <20050615010238.GA9215@animx.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506150829.52765.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 15. Juni 2005 03:02 schrieb Wakko Warner:
> Here's my modified int_callback:
> static void int_callback(struct urb *u, struct pt_regs *regs)
> {
>         struct kaweth_device *kaweth = u->context;
>         int act_state;
> 
> printk(KERN_INFO "kaweth: begin callback\n");
> printk(KERN_INFO "kaweth: u->status: %d\n", u->status);
>         switch (u->status) {
>         case 0:                 /* success */
>                 break;
>         case -ECONNRESET:       /* unlink */
>         case -ENOENT:   
>         case -ESHUTDOWN:
>                 return;
>         /* -EPIPE:  should clear the halt */
>         default:                /* error */
>                 goto resubmit;
>         }
> 
>         /* we check the link state to report changes */
>         if (kaweth->linkstate != (act_state = ( kaweth->intbuffer[STATE_OFFSET]
> printk(KERN_INFO "kaweth: Link state change.  kaweth->linkstate: %d act_state:
>         kaweth->linkstate, act_state);
>                 if (!act_state) {
> printk(KERN_INFO "kaweth: netif_carrier_on\n");
>                         netif_carrier_on(kaweth->net);
>                 } else {
> printk(KERN_INFO "kaweth: netif_carrier_off\n");
>                         netif_carrier_off(kaweth->net);
>                 }
> 
>                 kaweth->linkstate = act_state;
> printk(KERN_INFO "kaweth: new link state: %d\n", act_state);
>         }
> resubmit:
>         kaweth_resubmit_int_urb(kaweth, GFP_ATOMIC);
> printk(KERN_INFO "kaweth: end callback\n");
> }

Very well.

> Results (after ifconfig up, ethernet cable was plugged in at the time):
> Jun 14 20:50:25 gonzales kernel: [80756.691742] kaweth: begin callback
> Jun 14 20:50:25 gonzales kernel: [80756.691754] kaweth: u->status: 0
> Jun 14 20:50:25 gonzales kernel: [80756.691759] kaweth: Link state change.  kaweth->linkstate: 0 act_state: 2
> Jun 14 20:50:25 gonzales kernel: [80756.691764] kaweth: netif_carrier_off

OK, that should not happen.

Could you remove the "!" at 'if (!act_state) {' and retest?
The documentation I got says that it should be there, but who knows
how accurate it is for all devices.

> Jun 14 20:50:25 gonzales kernel: [80756.691769] kaweth: new link state: 2
> Jun 14 20:50:25 gonzales kernel: [80756.691776] kaweth: end callback
> 
> the next thing was:
> Jun 14 20:50:25 gonzales kernel: [80756.819793] kaweth: begin callback
> Jun 14 20:50:25 gonzales kernel: [80756.819800] kaweth: u->status: 0
> Jun 14 20:50:25 gonzales kernel: [80756.819807] kaweth: end callback
> many times, last occurence:
> Jun 14 20:50:36 gonzales kernel: [80767.576134] kaweth: begin callback
> Jun 14 20:50:36 gonzales kernel: [80767.576143] kaweth: u->status: 0
> Jun 14 20:50:36 gonzales kernel: [80767.576157] kaweth: end callback
> 
> then I ifconfig down since it was spewing that information:
> Jun 14 20:50:36 gonzales kernel: [80767.618157] kaweth: begin callback
> Jun 14 20:50:36 gonzales kernel: [80767.618172] kaweth: u->status: -2
> 
> I assume it didn't print the end since the status was -2 (not sure what -2 is)

Killing the URB due to ifconfig.

	Thank you
		Oliver
