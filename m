Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264628AbUESWFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264628AbUESWFl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 18:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbUESWFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 18:05:41 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:54666 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264628AbUESWFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 18:05:30 -0400
Subject: question about ext3_find_goal with reservation
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
In-Reply-To: <20040513195310.5725fa43.akpm@osdl.org>
References: <E1BOQmf-0005cP-4Q@thunk.org> 
	<20040513195310.5725fa43.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 May 2004 15:04:34 -0700
Message-Id: <1085004276.15374.1318.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just wondering, how the goal block being determined in ext3?

If we are doing sequential write, (the new logical block is next to the
last logical block), it's easy. Just increase the last physical block
recorded in i_next_alloc_goal and take that as the goal block for
ext3_new_block() to try to do allocation there.

If the pattern is random write, in the current implementation(with the
goal fix), the ext3_find_near() will find a goal with good locality.( I
have a hard time understand the ext3_find_near(), need some help
here...)

Well I am thinking, with the ext3 reservation changes, would it make
sense that to find the goal in the reservation window, if we are doing
random write on a inode, and we have a reservation window for that
inode? In another words, when we try to find a goal for block allocation
and the write pattern is non-sequential, if the the filesystem has
reservation turned on, before we try to find a goal somewhere else,
shouldn't we try to locate the goal inside the reservation window first?

This will avoid the problem that a reservation window for an inode being
throwed away frequently when a single process open an file doing lseek
and write frequently? (We have discussed this before.)

With reservation, we probably don't need ext3_find_near() to guide us to
find a goal block. But we still need that in the case the filesystem is
mounted without reservation on.

If all above make sense, then the goal should be the start block of the
reservation window. So when ext3_new_block() try to satisfy the goal
block, it will try to do allocation inside the reservation window
directly. This makes the goal outside of reservation almost impossible
in ext3_try_to_allocate_with_rsv(), unless it is doing sequential writes
and the goal is just next to the end of the reservation.

Any thoughts?

Mingming


