Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267594AbRGZGi6>; Thu, 26 Jul 2001 02:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267642AbRGZGis>; Thu, 26 Jul 2001 02:38:48 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:25093 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S267594AbRGZGi3>; Thu, 26 Jul 2001 02:38:29 -0400
Date: Thu, 26 Jul 2001 08:40:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Carsten Otte <COTTE@de.ibm.com>
Cc: jfs-discussion@oss.lotus.com, reiserfs-dev@namesys.com, andrea@suse.de,
        sct@dcs.ed.ac.uk, linux-kernel@vger.kernel.org,
        mauelshagen@sistina.com, Holger Smolinski <HSmolinski@de.ibm.com>,
        Horst Hummel <Horst.Hummel@de.ibm.com>
Subject: Re: Design-Question: end_that_request_* and bh->b_end_io hooks
Message-ID: <20010726084004.E648@suse.de>
In-Reply-To: <OF3CC2BFB9.69086721-ONC1256A93.0059C650@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF3CC2BFB9.69086721-ONC1256A93.0059C650@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24 2001, Carsten Otte wrote:
> Hi  Folks,
> 
> as you are deeper into block-devices & filesystems than me,
> here are my two simple questions in short:
> Is it legal for a filesystem (or whatever) to install a hook into
> bh->b_end_io
> which calls generic_make_request?

No, b_end_io might be called from irq context (IDE for instance) which
will break for __make_request (both the _irq spin locks and the schedule
on request slot empty).

You could do bh stacking and defer stuff like this to a thread, that's
probably the way to go.

> Do block drivers need or are they allowed to hold the io_request_lock or
> other (local) locks when calling end_that_request_*?

Yes they may, in fact they _must_ hold it for end_that_request_last.
Look at blkdev_release_request -- it meddles with the queue free and
pending lists and must be protected against reentrancy. 

-- 
Jens Axboe

