Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbUBXWeK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbUBXWd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:33:26 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:17077 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262505AbUBXWcp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:32:45 -0500
Date: Tue, 24 Feb 2004 23:31:40 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       fritz@isdn4linux.de
Subject: Re: 2.6.3-bk5 isdn oops
Message-ID: <20040224233140.A24461@electric-eye.fr.zoreil.com>
References: <20040224185510.GN11203@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040224185510.GN11203@redhat.com>; from davej@redhat.com on Tue, Feb 24, 2004 at 06:55:10PM +0000
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> :
[...]
> ISDN subsystem Rev: 1.1.2.3/1.1.2.3/1.1.2.2/1.1.2.3/1.1.2.2/1.1.2.2 loaded
> ICN-ISDN-driver Rev 1.65.6.8 mem=0x000d0000
> icn: (line0) ICN-2B, port 0x320 added
> Debug: sleeping function called from invalid context at include/linux/rwsem.h:43in_atomic():0, irqs_disabled():1
> Call Trace:
>  [<c0123214>] __might_sleep+0x80/0x8a
>  [<c011df07>] do_page_fault+0x71/0x46c
>  [<c7b0ffd7>] isdn_status_callback+0x8e0/0x968 [isdn]
>  [<c0121447>] schedule+0x5a6/0x631
>  [<c01213c8>] schedule+0x527/0x631
>  [<c011de96>] do_page_fault+0x0/0x46c
>  [<c010c165>] error_code+0x2d/0x38
>  [<c79aba66>] icn_exit+0xb4/0x155 [icn]

drivers/isdn/i4l/isdn_common.c
    745 isdn_status_callback(isdn_ctrl *c)
[...]
    767                 case ISDN_STAT_UNLOAD:
    768                         rc = fsm_event(&drv->fi, EV_STAT_UNLOAD, c);
[...]
    886         put_drv(drv);
                        ^^^ -> let's name this one "catherine"


drivers/isdn/i4l/isdn_common.c
    630 drv_stat_unload(struct fsm_inst *fi, int pr, void *arg)
[...]
    638         put_drv(drv);
                        ^^^ -> let's name this one "therese"

One has:
therese = catherine->fi->userdata

Given:

drivers/isdn/i4l/isdn_common.c
    896 register_isdn(isdn_if *iif)
[...]
    915         drv->fi.userdata = drv;

One checks that:
catherine = catherine->fi->userdata

So catherine = therese and there is a double put_drv() on the same pointer.
put_drv(drv)
-> drv_destroy(drv)
   -> kfree(drv->slots);

Oops.

--
Ueimor
