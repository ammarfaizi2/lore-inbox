Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUCBXyR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 18:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUCBXyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 18:54:16 -0500
Received: from adsl-186.flex.com ([206.126.1.185]:15488 "EHLO mail.imodulo.com")
	by vger.kernel.org with ESMTP id S261793AbUCBXx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 18:53:56 -0500
Date: Tue, 2 Mar 2004 23:53:53 +0000
From: Glen Nakamura <glen@imodulo.com>
To: linux-kernel@vger.kernel.org
Cc: jmorris@redhat.com
Subject: Mysterious string truncation in 2.4.25 kernel
Message-ID: <20040302235353.GA4215@modulo.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aloha,

I'm running a patched 2.4.25 kernel and I noticed truncated strings in
various procfs files.  e.g.

# cat /proc/tty/drivers
se                   /dev/cua/%d     5  64-127 serial:callout
se                   /dev/tts/%d     4  64-127 se
pty_slave            /dev/pts/%d   136   0-255 pty:slave
pty_master           /dev/ptm      128   0-255 pty:master
pty_slave            /dev/pty/s%d    3   0-255 pty:slave
pty_master           /dev/pty/m%d    2   0-255 pty:master
/dev/vc/0            /dev/vc/0       4       0 system:vtmaster
/dev/ptmx            /dev/ptmx       5       2 system
/dev/console         /dev/console    5       1 system:console
/dev/tty             /dev/tty        5       0 system:/dev/tty
unknown              /dev/vc/%d      4    1-63 console

Notice that "serial" is output as "se" in the top two lines.
I was able to produce similar results on a vanilla 2.4.25 kernel by
simply changing the length of a few strings in fs/proc/proc_tty.c.
I believe the problem is caused by the following patch:

ChangeSet@1.1290.1.16  2004-01-31 21:16:34-02:00  jmorris@redhat.com

> [PATCH] Zero last byte of mount option page
> 
> Hi Al,
> 
> Here's a patch which zeroes the last byte of the mount option data copied
> from userspace during mount(2).
> 
> For filesystems which parse mount options as strings (the majority), lack
> of a zero terminator could cause the page to be overrun.  The source code
> comments specify that the maximum size of the mount data is PAGE_SIZE-1,
> so this patch will not affect any valid binary-formatted mount data.

--- 1.24/fs/namespace.c	Tue Mar  2 15:50:11 2004
+++ 1.25/fs/namespace.c	Tue Mar  2 15:50:11 2004
@@ -715,6 +715,9 @@
 	if (dev_name && !memchr(dev_name, 0, PAGE_SIZE))
 		return -EINVAL;
 
+	if (data_page)
+		((char *)data_page)[PAGE_SIZE - 1] = 0;
+
 	/* Separate the per-mountpoint flags */
 	if (flags & MS_NOSUID)
 		mnt_flags |= MNT_NOSUID;

Could someone please comment on the correctness of the above patch
especially regarding procfs?

- glen
