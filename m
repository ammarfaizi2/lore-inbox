Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317049AbSFAUL2>; Sat, 1 Jun 2002 16:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317048AbSFAUL1>; Sat, 1 Jun 2002 16:11:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27398 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317049AbSFAULX>;
	Sat, 1 Jun 2002 16:11:23 -0400
Message-ID: <3CF92B1D.E466B743@zip.com.au>
Date: Sat, 01 Jun 2002 13:14:21 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 9/16] direct-to-BIO writeback for writeback-mode ext3
In-Reply-To: <3CF88903.E253A075@zip.com.au> <20020601191514.GA7905@turbolinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Jun 01, 2002  01:42 -0700, Andrew Morton wrote:
> > Turn on direct-to-BIO writeback for ext3 in data=writeback mode.
> 
> A minor note on this (especially minor since I believe data=journal
> doesn't even work in 2.5), but you should probably also change the
> address ops in ext3/ioctl.c if you enable/disable per-inode data
> journaling.

hrm.  Actually, changing journalling mode against a file while
modifications are happening against it is almost certain to explode
if the timing is right.  ISTR that we have seen bug reports against
this on ext3-users.  This is just waaaay too hard to do.

But we can fix it by doing the opposite: create three separate
a_ops instances, one for each journalling mode.  Assign it at
new_inode/read_inode time.

This way, we don't have to do the `ext3_should_journal_data()'
tests all over the place and we just don't care if someone diddles
the journalling mode while the file is otherwise in use.

Another one for my todo list..

-
