Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUFUQ6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUFUQ6Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 12:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266321AbUFUQ6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 12:58:25 -0400
Received: from cantor.suse.de ([195.135.220.2]:52655 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266319AbUFUQ6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 12:58:24 -0400
Subject: deadlocks caused by ext3/reiser dirty_inode calls during
	do_mmap_pgoff
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1087837153.1512.176.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 21 Jun 2004 12:59:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

do_mmap_pgoff is called with a write lock on mmap_sem, and can trigger
calls to generic_file_mmap, which calls file_accessed to update the
atime on the file.

For reiserfs, this might start a transaction, which might have to wait
for the currently running transaction to finish.  It looks like ext3 may
do the same thing, but I'm not 100% sure on that.

If the currently running transaction happens to by running
copy_from_user, like we do during write calls, it might be trying to get
a hold of a read lock on the mmap sem while trying to hand page faults.

This is effectively a lock inversion problem, and deadlocks.  There's a
few choices:

1) don't start a transaction during atime updates.
2) don't update the atime until after we drop the mmap_sem.

Anyone have other ideas?

-chris


