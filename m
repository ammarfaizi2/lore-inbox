Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265030AbUD3CFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbUD3CFl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 22:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265039AbUD3CFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 22:05:41 -0400
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:19719 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S265030AbUD3CFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 22:05:30 -0400
From: "Art Haas" <ahaas@airmail.net>
Date: Thu, 29 Apr 2004 21:05:25 -0500
To: linux-kernel@vger.kernel.org
Subject: Problem with recent changes to fs/dcache.c
Message-ID: <20040430020525.GI27793@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I run linux on a SparcStation SS20 in addition to a PC, and found that
none of the 2.6.6-rc kernels would boot. After trying the latest -rc3
kernel and seeing it fail also, my debugging quest began. Adding a few
printk() statements pointed the problem to be in fs/dcache.c in the
vfs_caches_init() function. The 1.69->1.70 changes to this file added in
a call to nr_free_pages() and used that result to adjust the global
mempages variable. This change caused the boot failures.

The printk() statements I'd added showed that vfs_caches_init() was
being called with 'mempages' set to 46073. The nr_free_pages() call
returned 127661, and this value being subtracted from mempages went
negative, but the value is unsigned, so mempages became enormous. Things
ended up getting stuck in the inode_init() call down a bit, having
seeming survived the dcache_init() call only because of values
wrapping around.

I commented out the 'mempages -= reserve;' line in the file, and the
boot continued along. Unfortunately I encounter a kernel trap when
mounting the hard drives, so there are other problems still needing to
be looked at.

The possiblity of nr_free_pages() being larger than mempages looks like
a silent bug that was tripped. If not, then another bug in the Sparc
port may be responsible for values being used in these functions. The
memory-management gurus can take a peek and see what they find.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
