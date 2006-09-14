Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751513AbWINJb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWINJb0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 05:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWINJbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 05:31:25 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:45784 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751508AbWINJbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 05:31:24 -0400
Date: Thu, 14 Sep 2006 11:31:23 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] Alignment of fields in struct dentry
Message-ID: <20060914093123.GA10431@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After taking a look at struct dentry, Arnd noted an alignment
problem.  The first four fields currently are:
	atomic_t d_count;
	unsigned int d_flags;		/* protected by d_lock */
	spinlock_t d_lock;		/* per dentry lock */
	struct inode *d_inode;		/* Where the name belongs to - NULL is
					 * negative */
On 64bit architectures, the first three take 12 bytes and d_inode is
not naturally aligned, so it can be aligned to byte 16.  This grows a
struct dentry from 196 to 200 Bytes (assuming no funky config options
like DEBUG_*, PROFILING or PREEMT && SMP are set).

One possible solution would be to exchange d_inode with d_mounted, but
I fear that d_inode would move from a hot cacheline to a cold one,
reducing performance.  Could there be a good solution or would any
rearrangement here only cause regressions?

Also, both 196 and 200 bytes are fairly close to 192 bytes, so I could
imagine performance improvements on 64bit machines with 64 Byte
cachelines.  Might it make sense to trim DNAME_INLINE_LEN_MIN by 4 or
8 bytes for such machines?

Jörn

-- 
The wise man seeks everything in himself; the ignorant man tries to get
everything from somebody else.
-- unknown
