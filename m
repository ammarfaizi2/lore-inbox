Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbUKFFFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbUKFFFF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 00:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbUKFFFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 00:05:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:65225 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261312AbUKFFEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 00:04:54 -0500
X-Authenticated: #5039886
Date: Sat, 6 Nov 2004 06:04:55 +0100
From: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Mounting on floating mounts is possible
Message-ID: <20041106060455.0100e3ec@doener>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this[1] patch changed check_mnt() so that mounting on a floating mount
(i.e. one that was unmounted using MNT_DETACH and was still in use) is
possible, since we no longer check if the mountpoint is actually
reachable. The problem is that we may lose any reference to the floating
mount, but the mount on it will keep it alive, thus it will never go
away. The following patch removes the reference from the mount to its
namespace when it is unmounted lazily, so that check_mnt protects from
such mounts.

Please CC me as I'm not subscribed to the list.

Bjoern

[1] http://lwn.net/Articles/91946/

diff -uNr --minimal a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c    2004-10-31 00:41:02.000000000 +0200
+++ b/fs/namespace.c    2004-11-06 04:38:37.299013810 +0100
@@ -358,6 +358,7 @@
                } else {
                        struct nameidata old_nd;
                        detach_mnt(mnt, &old_nd);
+                       mnt->mnt_namespace = NULL;
                        spin_unlock(&vfsmount_lock);
                        path_release(&old_nd);
                }
