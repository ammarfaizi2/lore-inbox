Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311364AbSCMUrn>; Wed, 13 Mar 2002 15:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311362AbSCMUrd>; Wed, 13 Mar 2002 15:47:33 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:38328 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S311360AbSCMUrT>; Wed, 13 Mar 2002 15:47:19 -0500
Date: Wed, 13 Mar 2002 20:49:15 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Chris Mason <mason@suse.com>
cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        viro@math.psu.edu
Subject: Re: [RFC] write_super is for syncing
In-Reply-To: <212850000.1015973327@tiny>
Message-ID: <Pine.LNX.4.21.0203132041560.1503-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2002, Chris Mason wrote:
> 
> But, the loop in sync_supers(dev == 0) is harder, it expects
> some flag it can check, and it expects the callback to the FS
> will clear that flag.  Adding a new flag seemed like more fun
> than redoing the locking and super walk.  I'm curious to hear what 
> Al thinks of it though.

Sorry if this is irrelevant to your case (wasn't following the thread),
but we noticed that repeatedly-restarting sync_supers() loop some while
back.  Would this patch help?

Hugh

--- 2.4.19-pre3/fs/super.c	Tue Mar 12 02:16:52 2002
+++ linux/fs/super.c	Wed Mar 13 20:27:54 2002
@@ -398,6 +398,7 @@
 	struct file_system_type *fs = s->s_type;
 
 	spin_lock(&sb_lock);
+	s->s_type = NULL;
 	list_del(&s->s_list);
 	list_del(&s->s_instances);
 	spin_unlock(&sb_lock);
@@ -461,19 +462,25 @@
 		}
 		return;
 	}
-restart:
 	spin_lock(&sb_lock);
+restart:
 	sb = sb_entry(super_blocks.next);
-	while (sb != sb_entry(&super_blocks))
+	while (sb != sb_entry(&super_blocks)) {
 		if (sb->s_dirt) {
 			sb->s_count++;
 			spin_unlock(&sb_lock);
 			down_read(&sb->s_umount);
 			write_super(sb);
-			drop_super(sb);
-			goto restart;
-		} else
-			sb = sb_entry(sb->s_list.next);
+			up_read(&sb->s_umount);
+			spin_lock(&sb_lock);
+			if (!--sb->s_count) {
+				destroy_super(sb);
+				goto restart;
+			} else if (!sb->s_type)
+				goto restart;
+		}
+		sb = sb_entry(sb->s_list.next);
+	}
 	spin_unlock(&sb_lock);
 }
 

