Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268723AbUI2RRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268723AbUI2RRx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 13:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268722AbUI2RRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 13:17:53 -0400
Received: from scyld.penguincomputing.com ([64.240.166.233]:52865 "EHLO
	bluewest.scyld.com") by vger.kernel.org with ESMTP id S268723AbUI2RQW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 13:16:22 -0400
Date: Wed, 29 Sep 2004 13:16:01 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
To: "John W. Linville" <linville@tuxdriver.com>
cc: akpm@osdl.org, <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.9-rc2] 3c59x: do not mask reset of aism logic at
 rmmod
In-Reply-To: <20040928145455.C12480@tuxdriver.com>
Message-ID: <Pine.LNX.4.44.0409291253510.1746-100000@training.scyld.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2004, John W. Linville wrote:

> Date: Tue, 28 Sep 2004 14:54:55 -0400
> From: John W. Linville <linville@tuxdriver.com>
> To: akpm@osdl.org
> Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
> Subject: [patch 2.6.9-rc2] 3c59x: do not mask reset of aism logic at rmmod
> 
> Some (earlier?) versions of the 3c905(B) card get confused and refuse to
> work again after the 3c59x module is removed (even after reloading the
> module).  Changing vortex_remove_one() to allow the auto-initialize
> state machine logic to be reset when the module is removed alleviates
> this problem.

...and creates a new problem: resetting the link causes operational
problems on many networks.  The most obvious example is spanning tree
detection delays on switches, where the switch does not pass traffic.

This 3c59x.c code was changed in 2001 to mask the transceiver reset and
shut the chip down cleanly.  This occurred in two steps, with a
discussion on the vortex mailing list for each.
3c59x.c:v0.99Uc 12/5/2001
3c59x.c:v0.99T 7/16/2001
The December change was noted as specifically for the 3c905B.

The correct solution is to reset the transceiver (and thus cause
re-autonegotiation) only if a problem is detected, not an unconditional
or proactive reset.

> --- linux-2.6/drivers/net/3c59x.c.orig
> +++ linux-2.6/drivers/net/3c59x.c
> @@ -3162,7 +3162,7 @@ static void __devexit vortex_remove_one 
>  			pci_restore_state(VORTEX_PCI(vp), vp->power_state);
>  	}
>  	/* Should really use issue_and_wait() here */
> -	outw(TotalReset|0x14, dev->base_addr + EL3_CMD);
> +	outw(TotalReset|0x04, dev->base_addr + EL3_CMD);
>  



-- 
Donald Becker				becker@scyld.com
Scyld Software	 			Scyld Beowulf cluster systems
914 Bay Ridge Road, Suite 220		www.scyld.com
Annapolis MD 21403			410-990-9993

