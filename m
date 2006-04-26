Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWDZXMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWDZXMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 19:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWDZXMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 19:12:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52394 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932398AbWDZXMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 19:12:16 -0400
Date: Wed, 26 Apr 2006 16:14:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: lkml@rtr.ca, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/scsi/sd.c: fix uninitialized variable in
 handling medium errors
Message-Id: <20060426161444.423a8296.akpm@osdl.org>
In-Reply-To: <1146092161.12914.3.camel@mulgrave.il.steeleye.com>
References: <200604261627.29419.lkml@rtr.ca>
	<1146092161.12914.3.camel@mulgrave.il.steeleye.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> On Wed, 2006-04-26 at 16:27 -0400, Mark Lord wrote:
> > From: Mark Lord <lkml@rtr.ca>
> > 
> > I am looking into how SCSI/SATA handle medium (disk) errors,
> > and the observed behaviour is a little more random than expected,
> > due to a bug in sd.c.
> > 
> > When scsi_get_sense_info_fld() fails (returns 0), it does NOT update the
> > value of first_err_block.  But sd_rw_intr() merrily continues to use that
> > variable regardless, possibly making incorrect decisions about retries and the like.
> > 
> > This patch removes the randomness there, by using the first sector of the
> > request (SCpnt->request->sector) in such cases, instead of first_err_block.
> > 
> > The patch shows more context than usual, to help see what's going on.
> 
> Thanks for finding the bug.  Your solution is a bit, um, convoluted.
> What it should really be doing if we find no valid information field is
> a break so we go out with the default good_sectors of zero (rather than
> arriving at that value via a circuitous route).
> 
> And, of course, I couldn't resist eliminating the superfluous info_valid
> variable and tidying the logic to be programmatic instead of a switch
> case.  How does this work?

It'd be nice to have something simple-and-obvious for the
simple-and-obvious -stable maintainers.  That's if we think -stable needs
this fixed.

> +				int sector_size_div =
> +					512 / SCpnt->device->sector_size;
> +				error_sector /= sector_size_div;

You sure about this bit?
