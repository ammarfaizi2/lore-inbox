Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269504AbUI3Vda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269504AbUI3Vda (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269506AbUI3Vda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:33:30 -0400
Received: from pop.gmx.de ([213.165.64.20]:24043 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269504AbUI3Vd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 17:33:28 -0400
X-Authenticated: #20450766
Date: Thu, 30 Sep 2004 23:21:39 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Jeremy Higdon <jeremy@sgi.com>
cc: Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, gnb@sgi.com
Subject: Re: [PATCH] I/O space write barrier
In-Reply-To: <20040930071541.GA201816@sgi.com>
Message-ID: <Pine.LNX.4.60.0409302317590.3449@poirot.grange>
References: <200409271103.39913.jbarnes@engr.sgi.com> <200409291555.29138.jbarnes@engr.sgi.com>
 <20040930071541.GA201816@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2004, Jeremy Higdon wrote:

> Here's the qla1280 patch to go with Jesse's mmiowb patch.
> Comments are verbose to satisfy a request from Mr. Bottomley.
>
> signed-off-by: Jeremy Higdon  <jeremy@sgi.com>
>
> ===== drivers/scsi/qla1280.c 1.65 vs edited =====
> --- 1.65/drivers/scsi/qla1280.c	2004-07-28 20:59:10 -07:00
> +++ edited/drivers/scsi/qla1280.c	2004-09-29 23:43:30 -07:00
> @@ -3397,8 +3397,22 @@
> 		"qla1280_64bit_start_scsi: Wakeup RISC for pending command\n");
> 	sp->flags |= SRB_SENT;
> 	ha->actthreads++;
> +
> +	/*
> +	 * Update request index to mailbox4 (Request Queue In).
> +	 * The mmiowb() ensures that this write is ordered with writes by other
> +	 * CPUs.  Without the mmiowb(), it is possible for the following:
> +	 *    CPUA posts write of index 5 to mailbox4
> +	 *    CPUA releases host lock
> +	 *    CPUB acquires host lock
> +	 *    CPUB posts write of index 6 to mailbox4
> +	 *    On PCI bus, order reverses and write of 6 posts, then index 5,
> +	 *       causing chip to issue full queue of stale commands
> +	 * The mmiowb() prevents future writes from crossing the barrier.
> +	 * See Documentation/DocBook/deviceiobook.tmpl for more information.
> +	 */

A pretty obvious note: instead of repeating this nice but pretty lengthy 
comment 3 times in the same file, wouldn't it be better to write at 
further locations something like

 	/* Enforce IO-ordering. See comment in <function> for details. */

Also helps if you later have to modify the comment, or move it, or add 
more mmiowb()s, or do some other modifications.

Thanks
Guennadi
---
Guennadi Liakhovetski

