Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269614AbUICLFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269614AbUICLFf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 07:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269622AbUICLFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 07:05:35 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:58381 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S269614AbUICLFZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 07:05:25 -0400
Message-ID: <20040903150521.B1834@castle.nmd.msu.ru>
Date: Fri, 3 Sep 2004 15:05:21 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: EXT3: problem with copy_from_user inside a transaction
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

filemap_copy_from_user() between prepare_write() and commit_write()
appears to be a problem for ext3.

prepare_write() starts a transaction, and if filemap_copy_from_user() causes
a page fault, we'll have
 - order violation with mmap_sem taken inside a transaction (possible
   deadlocks),
 - __GFP_FS memory allocation with all re-entrancy problems (e.g.,
   current->journal_info corruption).

Am I missing something?

If this observation is correct, the possible solution is to call
get_user_pages() or somehow pin the user pages before prepare_write(),
although it will hurt performance...

	Andrey
