Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbULACoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbULACoO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 21:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbULACoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 21:44:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:29668 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261158AbULACoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 21:44:10 -0500
Date: Tue, 30 Nov 2004 18:43:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Block layer question - indicating EOF on block devices
Message-Id: <20041130184345.47e80323.akpm@osdl.org>
In-Reply-To: <1101829852.25628.47.camel@localhost.localdomain>
References: <1101829852.25628.47.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> How is a block device meant to indicate to the block layer that the read
> issued is beyond EOF. For the case where the true EOF is known the
> capacity information is propogated into the inode and that is used. For
> the case where a read exceeds the known EOF the block layer sets BIO_EOF
> which appears nowhere else I can find.
> 
> I'm trying to sort out the case where the block device has only an
> approximate length known in advance. At the low level I've got sense
> data so I know precisely when I hit the real EOF on read. I can pull
> that out, I can partially complete the request neatly up to the EOF but
> I can't find any code anywhere dealing with passing back an EOF.

If the driver simply returns an I/O error, userspace should see a short
read and be happy?

> Nor it turns out is it handleable in user space because a read to the
> true EOF causes readahead into the fuzzy zone between the actual EOF and
> the end of media.

Yup.  You can turn the readahead off with posix_fadvise(POSIX_FADV_RANDOM),
or just read the disk with direct-io.  The latter has the advantage that
you can freely pluck out single 512-byte sectors without pagecache causing
any additional reads.

> Currently I see the error, pull the sense data, extract the block number
> and complete the request to the point it succeeded then fail the rest,
> but this doesn't end the I/O if someone is using something like cp,

hm.  Either cp is being silly or we're not propagating the error back
correctly.  `cp' should see the short read and just handle it.

> and
> it also fills the log with "I/O error on" spew from the block layer
> innards even if REQ_QUIET is magically set.

We'd need to propagate that quietness back up to the buffer_head layer, at
least.
