Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbULAP6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbULAP6h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 10:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbULAP6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 10:58:37 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:44707 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261285AbULAP62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 10:58:28 -0500
Subject: Re: Block layer question - indicating EOF on block devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041130184345.47e80323.akpm@osdl.org>
References: <1101829852.25628.47.camel@localhost.localdomain>
	 <20041130184345.47e80323.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101912876.30770.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Dec 2004 14:54:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-12-01 at 02:43, Andrew Morton wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> If the driver simply returns an I/O error, userspace should see a short
> read and be happy?

And the logs fill with I/O error messages. 

> > Nor it turns out is it handleable in user space because a read to the
> > true EOF causes readahead into the fuzzy zone between the actual EOF and
> > the end of media.
> 
> Yup.  You can turn the readahead off with posix_fadvise(POSIX_FADV_RANDOM),

Can't do this during a mount.

> > Currently I see the error, pull the sense data, extract the block number
> > and complete the request to the point it succeeded then fail the rest,
> > but this doesn't end the I/O if someone is using something like cp,
> 
> hm.  Either cp is being silly or we're not propagating the error back
> correctly.  `cp' should see the short read and just handle it.

I'll strace that and see what else I can find. Now I'm partially
completing requests when this problem occurs it does seem somewhat
happier. The original code when I took it to bits was just blindingly
failing the lot.

> > and
> > it also fills the log with "I/O error on" spew from the block layer
> > innards even if REQ_QUIET is magically set.
> 
> We'd need to propagate that quietness back up to the buffer_head layer, at
> least.

Thats what I was assuming looking at the code. Really the block layer is
broken here. It should not be whining about I/O errors on readahead
blocks just letting them go. It has no idea if the readahead is a
badblock a media feature or whatever. (or as James added on irc scsi
reservations).

Alan

