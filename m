Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269433AbUI3TGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269433AbUI3TGI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 15:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269421AbUI3TDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 15:03:10 -0400
Received: from peabody.ximian.com ([130.57.169.10]:3267 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269424AbUI3TCt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:02:49 -0400
Subject: [patch] inotify: locking
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org, iggy@gentoo.org
In-Reply-To: <1096410792.4365.3.camel@vertex>
References: <1096410792.4365.3.camel@vertex>
Content-Type: text/plain
Date: Thu, 30 Sep 2004 15:01:26 -0400
Message-Id: <1096570886.4203.36.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally got around to reviewing the locking in inotify, again, in
response to Andrew's points.

There are still three TODO items:

	- Look into replacing i_lock with i_sem.
	- dev->lock nests inode->i_lock.  Preferably i_lock should
	  remain an outermost lock.  Maybe i_sem can fix this.
	- inotify_inode_is_dead() should always have the inode's
	  i_lock locked when called.  I have not yet reviewed the
	  VFS paths that call it to ensure this is the case.

Anyhow, this patch does the following

	- More locking documentation/comments
	- Respect lock ranking when locking two different
	  inodes' i_lock
	- Don't grab dentry->d_lock and just use dget_parent(). [1]
	- Respect lock ranking with dev->lock vs. inode->i_lock.
	- inotify_release_all_watches() needed dev->lock.
	- misc. cleanup

Patch is on top of 0.11.0.

	Robert Love


