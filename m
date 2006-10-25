Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423385AbWJYMbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423385AbWJYMbI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 08:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423388AbWJYMbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 08:31:07 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:23918 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1423385AbWJYMbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 08:31:03 -0400
Message-ID: <453F58FB.4050407@sw.ru>
Date: Wed, 25 Oct 2006 16:30:51 +0400
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>, Jan Blunck <jblunck@suse.de>,
       Olaf Hering <olh@suse.de>, Balbir Singh <balbir@in.ibm.com>,
       David Howells <dhowells@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>
Subject: [Q] missing unused dentry in prune_dcache()?
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

I would like to ask you clarify me one question in the the following patch:
http://linux.bkbits.net:8080/linux-2.6/gnupatch@449b144ecSF1rYskg3q-SeR2vf88zg
# ChangeSet
#   2006/06/22 15:05:57-07:00 neilb@suse.de
#   [PATCH] Fix dcache race during umount

#   If prune_dcache finds a dentry that it cannot free, it leaves it where it
#   is (at the tail of the list) and exits, on the assumption that some other
#   thread will be removing that dentry soon.

However as far as I see this comment is not correct: when we cannot take
s_umount rw_semaphore (for example because it was taken in do_remount) this
dentry is already extracted from dentry_unused list and we do not add it into
the list again. Therefore dentry will not be found by prune_dcache() and
shrink_dcache_sb() and will leave in memory very long time until the partition
will be unmounted.

Am I probably err?

The patch adds this dentry into tail of the dentry_unused list.

Signed-off-by:	Vasily Averin <vvs@sw.ru>

--- linux-2.6.19-rc3/fs/dcache.c.prdch	2006-10-25 16:09:19.000000000 +0400
+++ linux-2.6.19-rc3/fs/dcache.c	2006-10-25 16:08:20.000000000 +0400
@@ -477,6 +477,8 @@ static void prune_dcache(int count, stru
 			}
 			up_read(s_umount);
 		}
+ 		list_add_tail(&dentry->d_lru, &dentry_unused);
+		dentry_stat.nr_unused++;
 		spin_unlock(&dentry->d_lock);
 		/* Cannot remove the first dentry, and it isn't appropriate
 		 * to move it to the head of the list, so give up, and try
