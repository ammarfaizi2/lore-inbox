Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWEMEkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWEMEkj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 00:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWEMEkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 00:40:39 -0400
Received: from mx1.suse.de ([195.135.220.2]:56799 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932175AbWEMEki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 00:40:38 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Sat, 13 May 2006 13:46:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17509.22160.118149.49714@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       paul.clements@steeleye.com
Subject: Re: [PATCH 008 of 8] md/bitmap: Change md/bitmap file handling to
 use bmap to file blocks.
In-Reply-To: message from Andrew Morton on Friday May 12
References: <20060512160121.7872.patches@notabene>
	<1060512060809.8099@suse.de>
	<20060512104750.0f5cb10a.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday May 12, akpm@osdl.org wrote:
> NeilBrown <neilb@suse.de> wrote:
> >
> > If md is asked to store a bitmap in a file, it tries to hold onto the
> > page cache pages for that file, manipulate them directly, and call a
> > cocktail of operations to write the file out.  I don't believe this is
> > a supportable approach.
> 
> erk.  I think it's better than...
> 
> > This patch changes the approach to use the same approach as swap files.
> > i.e. bmap is used to enumerate all the block address of parts of the file
> > and we write directly to those blocks of the device.
> 
> That's going in at a much lower level.  Even swapfiles don't assume
> buffer_heads.

I'm not "assuming" buffer_heads.  I'm creating buffer heads and using
them for my own purposes.  These are my pages and my buffer heads.
None of them belong to the filesystem.
The buffer_heads are simply a convenient data-structure to record the
several block addresses for each page.  I could have equally created
an array storing all the addresses, and built the required bios by
hand at write time.  But buffer_heads did most of the work for me, so
I used them.

Yes, it is a lower level, but
 1/ I am certain that there will be no kmalloc problems and
 2/ Because it is exactly the level used by swapfile, I know that it
    is sufficiently 'well defined' that no-one is going to break it.

> 
> When playing with bmap() one needs to be careful that nobody has truncated
> the file on you, else you end up writing to disk blocks which aren't part
> of the file any more.

Well we currently play games with i_write_count to ensure that no-one
else has the file open for write.  And if no-one else can get write
access, then it cannot be truncated.
I did think about adding the S_SWAPFILE flag, but decided to leave
that for a separate patch and review different approaches to
preventing write access first (e.g. can I use a lease?).

> 
> All this (and a set_fs(KERNEL_DS), ug) looks like a step backwards to me. 
> Operating at the pagecache a_ops level looked better, and more
> filesystem-independent.

If you really want filesystem independence, you need to use vfs_read
and vfs_write to read/write the file.  I have a patch which did that,
but decided that the possibility of kmalloc failure at awkward times
would make that not suitable.
So I now use vfs_read to read in the file (just like knfsd) and
bmap/submit_bh to write out the file (just like swapfile).

I don't think a_ops really provides an interface that I can use, partly
because, as I said in a previous email, it isn't really a public
interface to a filesystem.

> 
> I haven't looked at this patch at all closely yet.  Do I really need to?

I assume you are asking that because you hope I will retract the
patch.  While I'm always open to being educated, I am not yet
convinced that there is any better way, or even any other usable way,
to do what needs to be done, so I am not inclined to retract the
patch.

I'd like to say that you don't need to read it because it is perfect,
but unfortunately history suggests that is unlikely to be true.

Whether you look more closely is of course up to you, but I'm convinced
that patch is in the right direction, and your review and comments are
always very valuable.

NeilBrown
