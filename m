Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269938AbUJGXrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269938AbUJGXrI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269947AbUJGXqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:46:45 -0400
Received: from peabody.ximian.com ([130.57.169.10]:29059 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269932AbUJGXjK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:39:10 -0400
Subject: Re: [RFC][PATCH] inotify 0.13.1
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1097097180.12126.2.camel@vertex>
References: <1097097180.12126.2.camel@vertex>
Content-Type: text/plain
Date: Thu, 07 Oct 2004 19:37:36 -0400
Message-Id: <1097192256.3960.71.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK.

I am working on redoing the inotify locking wrt inodes.

Most of the time that we grab inode->i_lock, we don't need it.  We do
need it when allocating or freeing inode->inotify_data.  We also need it
when first obtaining the inotify_data reference count (see below).

So we need an inotify_data reference count to track its lifetime.  We
already have ->watcher_count, which functions pretty well as this ref
count, but we need to formalize it, make it atomic_t, and always grab it
under ->i_lock.  Freeing the structure is then a consequence of the ref
count dropping to zero via atomic_dec_and_test().

Then we can add inotify_data->lock to protect the contents of
inotify_data from concurrent access and not use i_lock.

Anyone dereferencing inotify_data (or setting/freeing it for the first
time) needs to hold a ref count.  This is an existing bug.

We can hopefully end up only taking inode->i_lock when grabbing this ref
count, and no other time.  We won't have to nest it with dev->lock any
more.

That is the plan, anyhow.  Patch later tonight or tomorrow, with luck.

	Robert Love


