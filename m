Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262686AbTCYPvT>; Tue, 25 Mar 2003 10:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262688AbTCYPvT>; Tue, 25 Mar 2003 10:51:19 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:25038 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S262686AbTCYPvS>; Tue, 25 Mar 2003 10:51:18 -0500
Date: Tue, 25 Mar 2003 08:12:32 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] timer hang with current 2.5 BK
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Linux USB <linux-usb-devel@lists.sourceforge.net>
Message-id: <3E807FF0.3050304@pacbell.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_RHgjP6oa79I87GkcP4WNZg)"
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200303251159.26108.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_RHgjP6oa79I87GkcP4WNZg)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Duncan Sands wrote:
> If I remove the uhci_hcd or ehci_hcd module, then I
> systematically get the following:
> 
> (EIP) run_timer_softirq+0xe3/0x400
> timer_interrupt+0x1a3/0x3f0
> do_softirq+0xa1/0xb0
> do_IRQ+0x23f/0x380
> common_interrupt+0x18/0x20
> code: 89 50 04 89 02 C7 41
> 
> kernel/timer.c:302: spin_lock (kernel/timer.c:c02f7b00) already
> locked by kernel/timer.c/398.
> 
> killing interrupt handler etc
> 
> Presumably this is related to the stall_timer.
> This has been happening for ?one week?, and
> still occurs with current BK.  Occurs with and
> without preempt (UP).
> 
> Any ideas?

I'm not getting it any more, but then I'm also running with
this patch too ... the current source prevents drivers from
properly disconnect()ing, which means all kinds of state
doesn't get cleaned up.

What usually gets me lately is that the whole system locks
up when I remove certain modules.  SysRq behaves but little
else (no console).  The common behavior seems to be that
the call_usermode_helper() logic is waiting forever; such
as waiting for network interface "remove" events to finish.

- Dave



--Boundary_(ID_RHgjP6oa79I87GkcP4WNZg)
Content-type: text/plain; name=p5.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=p5.patch

--- 1.15/drivers/usb/core/urb.c	Thu Mar 13 10:45:40 2003
+++ edited/drivers/usb/core/urb.c	Thu Mar 20 11:17:55 2003
@@ -384,11 +384,11 @@
 	/* FIXME
 	 * We should not care about the state here, but the host controllers
 	 * die a horrible death if we unlink a urb for a device that has been
-	 * physically removed.
+	 * physically removed.  (after driver->disconnect returns...)
 	 */
 	if (urb &&
 	    urb->dev &&
-	    (urb->dev->state >= USB_STATE_DEFAULT) &&
+	    // (urb->dev->state >= USB_STATE_DEFAULT) &&
 	    urb->dev->bus &&
 	    urb->dev->bus->op)
 		return urb->dev->bus->op->unlink_urb(urb);

--Boundary_(ID_RHgjP6oa79I87GkcP4WNZg)--
