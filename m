Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbULBITL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbULBITL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 03:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbULBITK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 03:19:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7587 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261307AbULBITG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 03:19:06 -0500
Date: Thu, 2 Dec 2004 09:18:28 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Block layer question - indicating EOF on block devices
Message-ID: <20041202081828.GC10454@suse.de>
References: <1101829852.25628.47.camel@localhost.localdomain> <20041130184345.47e80323.akpm@osdl.org> <1101912876.30770.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101912876.30770.14.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01 2004, Alan Cox wrote:
> On Mer, 2004-12-01 at 02:43, Andrew Morton wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > If the driver simply returns an I/O error, userspace should see a short
> > read and be happy?
> 
> And the logs fill with I/O error messages. 

read-ahead should definitely be marked quiet, agree.

> > > and
> > > it also fills the log with "I/O error on" spew from the block layer
> > > innards even if REQ_QUIET is magically set.
> > 
> > We'd need to propagate that quietness back up to the buffer_head layer, at
> > least.
> 
> Thats what I was assuming looking at the code. Really the block layer is
> broken here. It should not be whining about I/O errors on readahead
> blocks just letting them go. It has no idea if the readahead is a
> badblock a media feature or whatever. (or as James added on irc scsi
> reservations).

The upper buffer layer could do something intelligent if EOF is set on
the bio, it really should. The problem is that there's no -EXXX to flag
EOF from the driver, it would be nicest if one could just do:

	end_that_request_chunk(req, 1, good_bytes);
	end_that_request_chunk(req, -EOF, residual);

and be done with it.

-- 
Jens Axboe

