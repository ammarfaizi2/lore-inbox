Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbTEUXU5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 19:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTEUXU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 19:20:56 -0400
Received: from ns.suse.de ([213.95.15.193]:22539 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262362AbTEUXUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 19:20:54 -0400
Date: Thu, 22 May 2003 01:33:56 +0200 (CEST)
From: Andreas Gruenbacher <agruen@suse.de>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [Ext2-devel] [RFC] fast EA for ext3
In-Reply-To: <20030518165718.B11651@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.53.0305220050250.17302@Chaos.suse.de>
References: <87n0hkmbiw.fsf@gw.home.net> <20030518165718.B11651@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 May 2003, Andreas Dilger wrote:

> On May 18, 2003  17:04 +0000, Alex Tomas wrote:
> > this patch implements possibility to store EA into inode body
> > which may be larger 128 bytes in 2.5 kernel.
>
> What Alex didn't mention was the reason why we developed this patch in the
> first place - speed.

The patch looks very good. A few issues come to mind:

- What's the status of the other fixed fields in the large inodes? Is
  there agreement on adding exactly the fields in the patch?

- A common operation is to change an attribute's value without changing
  the value's length. The current code does not optimize this case, but
  it should. The patch makes this optimization a little harder.

- struct ext3_xattr_entry makes little sense in an inode. The
  e_value_block and e_hash fields should go away. The e_value_size
  field could be shrunk from 4 to 2 bytes. This would save 10 bytes per
  attribute. The code wouldn't become a lot more messy from that.

- In-inode EA support should be configurable. I would like to choose
  whether I want this feature at compile time, with as few #ifdef's as
  possible.

>  Storing EAs in external blocks is slow, and if you
> have a lot of inodes with external EAs it is fatal, as the EA blocks consume
> so much RAM that they force all of the inode/directory data out of cache.

The current implementation is not suitable for applications which store
unique EAs for very many inodes. Storing the EAs in the inodes is much
better, but increasing the inode size also costs space.

> Some benchmarks (from Alex):
> > environment for  old EA: just mkfs'ed EXT3, inode size 128, 33000 files
> > environment for fast EA: just mkfs'ed EXT3, inode size 256, 33000 files
> >
> >                      old EA       fast EA
> > add attributes       2m35.241s    1m4.151s   (+142%)
> > dump attributes      0m28.716s    0m13.466s  (+113%)
> > change attributes    2m42.108s    1m4.413s   (+153%)
> > remove attributes    1m15.373s    1m3.909s   (+19%)

Nice. That's probably with unique attributes per inode.

> Some minor improvements could be made, such as not storing user EAs inside
> the inode if there are system EAs that could be stored there.

I don't know which strategy will be best here. We don't have to solve this
problem now, though.


By the way, you will likely also need dynamically allocated inodes, right?
What's the status here?


Cheers,
Andreas.

------------------------------------------------------------------
 Andreas Gruenbacher                                SuSE Linux AG
 mailto:agruen@suse.de                     Deutschherrnstr. 15-19
 http://www.suse.de/                   D-90429 Nuernberg, Germany
