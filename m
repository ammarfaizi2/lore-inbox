Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbUCPXTZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbUCPXTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:19:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:37084 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261816AbUCPXTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:19:05 -0500
Date: Tue, 16 Mar 2004 15:21:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: daniel@osdl.org, linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: 2.6.4-mm2
Message-Id: <20040316152106.22053934.akpm@osdl.org>
In-Reply-To: <1079474312.4186.927.camel@watt.suse.com>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	<1079461971.23783.5.camel@ibm-c.pdx.osdl.net>
	<1079474312.4186.927.camel@watt.suse.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> On Tue, 2004-03-16 at 13:32, Daniel McNeil wrote:
> > Andrew,
> > 
> > I re-ran six copies of the direct_read_under test on an 8-proc
> > machine last night.  All six tests saw uninitialized data.
> 
> It is possible to trigger mpage_writepages twice at the same time,
> right?

Yes.

>   Say once from sync_sb_inodes and once from filemap_fdatawrite? 
> I'm assuming Daniel is hitting the same bug he reported before, a race
> between ll_rw_block from ext3 data=ordered and sychronous writeback from
> fsync or O_DIRECT.

OK, that can happen.  Daniel had a fixlet for that and I assume he's
retrying that.

Not only can it happen with ext3, but also with any random filesystem which
does ll_rw_blk() of a random metadata block.  sync_blockdev() can miss the
associated page.  Conceivably this could leave I/O in flight after umount.

I'm thinking that the right thing to do here is to change submit_bh()
callers and ll_rw_block() to run set_page_writeback(bh->b_page) when they
start the buffer writeout and to do the run-around-the-buffer_heads thing
at I/O completion.  Ho hum, that'll take a bit of work but at least it
kills off some exceptionalities.
