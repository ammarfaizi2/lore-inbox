Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbTLXKvO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 05:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263545AbTLXKvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 05:51:14 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:49899 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263537AbTLXKvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 05:51:12 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jim Lawson <jim+linux-kernel@jimlawson.org>
Date: Wed, 24 Dec 2003 21:51:00 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16361.28564.275984.580859@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0, SiI3112, md raid1 problem: bio too big device (128 > 15)
In-Reply-To: message from Jim Lawson on Tuesday December 23
References: <Pine.LNX.4.58.0312232253140.7841@infocalypse.jimlawson.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday December 23, jim+linux-kernel@jimlawson.org wrote:
> Hi all,
> 
> I am having trouble creating a raid1 array under 2.6.0.  I am able to
> create raid0 and raid5 mds, but raid1s fail with "bio too big device hde3
> (128 > 15)", which doesn't tell me a lot.  I can see it's in
> drivers/block/ll_rw_blk.c, right at the boundary with the device driver,
> but I'm not enough of a kernel wonk to find out a lot more.

This is a raid1 bug.
Some block devices have limits on the sizes of io requests that they
can handle, and advertise these limits with ->max_sectors and
->merge_bvec_fn (and a few others).  Any device MUST be able to accept
a single page IO at any offset.

When raid1 does a 'resync' it does all IO in 64K requests, ignoring
the restrictions.
Getting raid1 resync to handle the restrictions is non-trivial (I have
code, but it is still buggy).

A simple interim fix is to replace

#define RESYNC_BLOCK_SIZE (64*1024)

with

#define RESYNC_BLOCK_SIZE PAGE_SIZE

NeilBrown
