Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbTEFUtH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTEFUtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:49:07 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:4228 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S261855AbTEFUtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:49:06 -0400
Subject: Re: [PATCH] Only use MSDOS-Partitions by default on X86
From: David Woodhouse <dwmw2@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: Nicolas Pitre <nico@cam.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk@arm.linux.org.uk>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Marcus Meissner <meissner@suse.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030506184914.GL905@suse.de>
References: <20030506183010.GK905@suse.de>
	 <Pine.LNX.4.44.0305061436510.11648-100000@xanadu.home>
	 <20030506184914.GL905@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1052254888.7532.58.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Tue, 06 May 2003 22:01:28 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Rcpt-To: axboe@suse.de, nico@cam.org, alan@lxorguk.ukuu.org.uk, rmk@arm.linux.org.uk, joern@wohnheim.fh-wedel.de, meissner@suse.de, linux-kernel@vger.kernel.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 19:49, Jens Axboe wrote:
> I see, that would indeed be a bigger job :). Just the block layer would
> not be hard, especially if you make the restriction that the block
> drivers usable would be ones that used a make_request strategy for
> handling requests. That would allow you to kill ll_rw_blk.c,
> deadline-iosched.c, and elevator.c. That's some 21k of text and 2k of
> data on this box.

That's a little short of what I was intending. Ideally we stick 'struct
request', 'struct buffer_head' and 'struct bio' inside #ifdef
CONFIG_BLK_DEV, then kill all the dead code which uses them.

block_dev.c becomes...

int blkdev_open(struct inode * inode, struct file * filp)
{
	return -ENXIO;
}

Don't look at JFFS; that still needs to be able to open a block device
even though it never actually _uses_ it. Look at the non-blkdev mount
path for JFFS2 instead. The _only_ thing we use the mtdblock device for
is to look at its minor number and use it to pick the right MTD device
-- it used to give us the locking on simultaneous mounts for free, a
constant device number for NFS exporting, and a cheap way to work around
the bug that the 'root=' command line option isn't available to
filesystems directly.

mtdblock.c cleanup noted with interest -- I'll play with that shortly;
thanks. Note that you don't actually need flash hardware, you can load
the 'mtdram' device which fakes it with vmalloc-backed storage instead.
Not too useful for powerfail-testing but for mounting something like
ext2 on mtdblock on mtdram it's fine.

-- 
dwmw2


