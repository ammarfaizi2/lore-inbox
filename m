Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbTCMSkU>; Thu, 13 Mar 2003 13:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262493AbTCMSkU>; Thu, 13 Mar 2003 13:40:20 -0500
Received: from comtv.ru ([217.10.32.4]:59127 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S262492AbTCMSkP>;
	Thu, 13 Mar 2003 13:40:15 -0500
X-Comment-To: Andreas Dilger
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [Ext2-devel] [PATCH] concurrent block allocation for ext2 against 2.5.64
References: <m3el5bmyrf.fsf@lexa.home.net>
	<20030313103948.Z12806@schatzie.adilger.int>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 13 Mar 2003 21:43:05 +0300
In-Reply-To: <20030313103948.Z12806@schatzie.adilger.int>
Message-ID: <m3d6kvhzuu.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fs/attr.c:
        if (ia_valid & ATTR_SIZE) {
                if (attr->ia_size == inode->i_size) {
                        if (ia_valid == ATTR_SIZE)
                                goto out;       /* we can skip lock_kernel() */
                } else {
                        lock_kernel();
                        error = vmtruncate(inode, attr->ia_size);
                        unlock_kernel();
                        if (error)
                                goto out;
                }
        }

so, all (!) truncates are serialized

>>>>> Andreas Dilger (AD) writes:

 AD> On Mar 13, 2003 11:55 +0300, Alex Tomas wrote:
 >> as Andrew said, concurrent balloc for ext3 is useless because of
 >> BKL.  and I saw it in benchmarks. but it may be useful for ext2.

 AD> Sadly, we are constantly diverging the ext2/ext3 codebases.  Lots
 AD> of features are going into ext3, but lots of fixes/improvements
 AD> are only going into ext2.  Is ext3 holding BKL for doing
 AD> journal_start() still?

 AD> Looking at ext3_prepare_write() we grab the BKL for doing
 AD> journal_start() and for journal_stop(), but I don't _think_ we
 AD> need BKL for journal_stop() do we?  We may or may not need it for
 AD> the journal_data case, but that is not even working right now I
 AD> think.

 AD> It also seems we are getting BKL in ext3_truncate(), which likely
 AD> isn't needed past journal_start(), although we do need to have
 AD> superblock-only lock for ext3_orphan_add/del.



