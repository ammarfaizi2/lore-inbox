Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbULXT2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbULXT2v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 14:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbULXT2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 14:28:51 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:19891 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261439AbULXT2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 14:28:49 -0500
Subject: Re: kblockd/1: page allocation failure in 2.6.9
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jens Axboe <axboe@suse.de>
Cc: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041224132006.GC2528@suse.de>
References: <41C7D32D.2010809@bio.ifi.lmu.de>
	 <41CAAB61.3030704@bio.ifi.lmu.de>
	 <200412231551.15767.vda@port.imtp.ilyichevsk.odessa.ua>
	 <41CAEA62.4060903@bio.ifi.lmu.de>  <20041224132006.GC2528@suse.de>
Content-Type: text/plain
Date: Fri, 24 Dec 2004 13:28:12 -0600
Message-Id: <1103916492.5448.27.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-24 at 14:20 +0100, Jens Axboe wrote:
> This looks fishy - this is GFP_ATOMIC | GFP_DMA, where it should only be
> GFP_ATOMIC. gdth should not have shost->cmd_pool->gfp_mask ==
> GFP_ATOMIC, that looks like a bug in the driver.

This may be a fault in the gdth driver (if that's where the trace came
from).  It sets unchecked_isa_dma to 1 in its template and then resets
it at various places in the driver it may have been reset too late to
prevent it from getting the GFP_DMA scsi command pool.

> Apart from that, the trace looks sane and the SCSI mid layer should
> recover from this condition and not cause a hung io subsystem. The only
> way I can see this fail is if the scsi host free_list is not filled for
> some reason during init, or if the commands allocated from there are
> lost or never finished by the hardware.

Yes, I've checked this out in SCSI by artificially simulating a memory
allocation failure in scsi_get_command().  My system behaves nicely even
as I rack up the failures.  Is there anything else unusual in the log
that may indicate what the problem is?

James


