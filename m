Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWJ0NmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWJ0NmT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 09:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbWJ0NmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 09:42:19 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:54104 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750890AbWJ0NmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 09:42:18 -0400
Message-ID: <45420CAB.3060202@sw.ru>
Date: Fri, 27 Oct 2006 17:42:03 +0400
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: David Howells <dhowells@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: [PATCH 2.6.19-rc3] VFS: missing unused dentry in prune_dcache()
References: <453F6D90.4060106@sw.ru>  <453F58FB.4050407@sw.ru> <20792.1161784264@redhat.com> <21393.1161786209@redhat.com>
In-Reply-To: <21393.1161786209@redhat.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

could you please use this patch instead of
missing-unused-dentry-in-prune_dcache.patch

As far as I understand David Howells have not any objections

Thank you,
	Vasily Averin

---
VFS: missing unused dentry in prune_dcache()

From:	Vasily Averin <vvs@sw.ru>

If we cannot delete dentry we should insert it back to the dentry_unused list.
To prevent cycle and do not blocks prune_dcache() call from
shrink_dcache_memory() we adding this dentry to head of list.

Signed-off-by:	Vasily Averin <vvs@sw.ru>

--- linux-2.6.19-rc3/fs/dcache.c.prdch	2006-10-25 16:09:19.000000000 +0400
+++ linux-2.6.19-rc3/fs/dcache.c	2006-10-26 15:14:51.000000000 +0400
@@ -478,11 +478,9 @@ static void prune_dcache(int count, stru
 			up_read(s_umount);
 		}
 		spin_unlock(&dentry->d_lock);
-		/* Cannot remove the first dentry, and it isn't appropriate
-		 * to move it to the head of the list, so give up, and try
-		 * later
-		 */
-		break;
+		/* Inserting dentry to tail of the list leads to cycle */
+ 		list_add(&dentry->d_lru, &dentry_unused);
+		dentry_stat.nr_unused++;
 	}
 	spin_unlock(&dcache_lock);
 }

