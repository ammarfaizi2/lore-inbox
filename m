Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274984AbTHLBtR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 21:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274985AbTHLBtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 21:49:16 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:12755 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S274984AbTHLBtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 21:49:13 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Christoph Hellwig <hch@infradead.org>
Date: Tue, 12 Aug 2003 11:48:28 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16184.18284.969212.342794@gargle.gargle.HOWL>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2 of 2 - Allow O_EXCL on a block device to claim exclusive use.
In-Reply-To: message from Christoph Hellwig on Monday August 11
References: <E19m2XN-0002BU-00@notabene>
	<20030811082231.A20077@infradead.org>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday August 11, hch@infradead.org wrote:
> On Mon, Aug 11, 2003 at 12:35:57PM +1000, NeilBrown wrote:
> > diff ./fs/block_dev.c~current~ ./fs/block_dev.c
> > -	return do_open(bdev, inode, filp);
> > +	res = do_open(bdev, inode, filp);
> > +	if (res)
> > +		return res;
> > +
> > +	if (!(filp->f_flags & O_EXCL) )
> > +		return 0;
> > +
> > +	if (!(res = bd_claim(bdev, filp)))
> > +		return 0;
> > +
> > +	blkdev_put(bdev, BDEV_FILE);
> > +	return res;
> 
> Shouldn't you claim it before opening.  Also what is the desired
> behaviour when opening partitions vs whole device with O_EXCL?

Good question.
My first attempt at this did claim before openning.
However that didn't work.
Some aspects of the bdev that are needed for claiming are not
initialised before it is first opened.  In particular, bd_contains,
gets set up by do_open.

Also, other code uses this order.
e.g. open_bdev_excl called blkdev_get (which calls do_open) before
bd_claim.

NeilBrown
