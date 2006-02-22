Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751541AbWBVWef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbWBVWef (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWBVWef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:34:35 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:3209 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751541AbWBVWee convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:34:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RoPt4ly3HJT5cXGWxLlT2WhAGzj5fUekWMXG16Jc3AL4KsYG4a+SxWC/l99DAELchJR7b3M32Phkm+mH1PFvBYWy6VI9VgRlxGr42oudez3dw85ZXIZ5dSZDk3mrZKGGB+z5+2QYbKO7eOIBlb4xupFtibfiKW7NCBBOIQrw3No=
Message-ID: <4ae3c140602221434v6ec583a7yf04df5fa7a4948fc@mail.gmail.com>
Date: Wed, 22 Feb 2006 17:34:33 -0500
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: question about possibility of data loss in Ext2/3 file system
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <1140645651.2979.79.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c140602221356x15015171h5aa4a3d7bb6034e0@mail.gmail.com>
	 <1140645651.2979.79.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently the scheme you described helps improve the file integrity.
But still not good enough. For example, if all data blocks are
flushed, then you will update the metadata. But right after you update
the block bitmap and before you update the inode, you lose power. You
will get some dead blocks.  Right? Do you know how ext2/3 deal with
this situation?

Also, the scheme you mentioned is just for new file creation. What
will happen if I want to update an existing file? Say, I open file A,
seek to offset 5000, write 4096 bytes, and then close. Do you know how
ext2/3 handle this situation?

Many thanks for your kind help!

Xin

On 2/22/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Wed, 2006-02-22 at 16:56 -0500, Xin Zhao wrote:
> > As far as I know, in Ext2/3 file system, data blocks to be flushed to
> > disk are usually marked as dirty and wait for kernel thread to flush
> > them lazily. So data blocks of a file could be flushed even after this
> > file is closed.
> >
> > Now consider this scenario: suppose data block 2,3 and 4 of file A are
> > marked to be flushed out. At time T1, block 2 and 3 are flushed, and
> > file A is closed. However, at time T2, system experiences power outage
> > and failed to flushed block 4. Does that mean we will end up with
> > getting a partially flushed file?  Is there any way to provide better
> > guarantee on file integrity?
>
> on ext3 in default mode it works a bit different
>
> if you write a NEW file that is
>
> then first the data gets written (within like 5 seconds, and not waiting
> for the lazy flush daemon). Only when that is done is the metadata (eg
> filesize on disk) updated. So after the power comes back you don't see a
> mixed thing; you see a file of a certain size, and all the data upto
> that size is there.
>
> If you need more guarantees you need to use fsync/fdata_sync from the
> application.
>
>
>
