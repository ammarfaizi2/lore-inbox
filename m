Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbULXNVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbULXNVA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 08:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbULXNU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 08:20:59 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:31519 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261400AbULXNUv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 08:20:51 -0500
Date: Fri, 24 Dec 2004 14:20:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: kblockd/1: page allocation failure in 2.6.9
Message-ID: <20041224132006.GC2528@suse.de>
References: <41C7D32D.2010809@bio.ifi.lmu.de> <41CAAB61.3030704@bio.ifi.lmu.de> <200412231551.15767.vda@port.imtp.ilyichevsk.odessa.ua> <41CAEA62.4060903@bio.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41CAEA62.4060903@bio.ifi.lmu.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23 2004, Frank Steiner wrote:
> >Dec 20 13:17:21 turing kernel: kblockd/1: page allocation failure. 
> >order:0, mode:0x21

This looks fishy - this is GFP_ATOMIC | GFP_DMA, where it should only be
GFP_ATOMIC. gdth should not have shost->cmd_pool->gfp_mask ==
GFP_ATOMIC, that looks like a bug in the driver.

Apart from that, the trace looks sane and the SCSI mid layer should
recover from this condition and not cause a hung io subsystem. The only
way I can see this fail is if the scsi host free_list is not filled for
some reason during init, or if the commands allocated from there are
lost or never finished by the hardware.

-- 
Jens Axboe

