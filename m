Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUD1VNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUD1VNH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUD1VLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 17:11:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:27824 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262213AbUD1VAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 17:00:55 -0400
Date: Wed, 28 Apr 2004 14:03:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org, jakub@redhat.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] per-user signal pending and message queue limits
Message-Id: <20040428140316.4146b3bd.akpm@osdl.org>
In-Reply-To: <20040428170932.GA14993@logos.cnet>
References: <20040419212810.GB10956@logos.cnet>
	<20040419224940.GY31589@devserv.devel.redhat.com>
	<20040420141319.GB13259@logos.cnet>
	<20040420130439.23fae566.akpm@osdl.org>
	<20040420231351.GB13826@logos.cnet>
	<20040420163443.7347da48.akpm@osdl.org>
	<20040421203456.GC16891@logos.cnet>
	<40875944.4060405@colorfullife.com>
	<20040427145424.GA10530@logos.cnet>
	<408EA1DF.6050303@colorfullife.com>
	<20040428170932.GA14993@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
>  static void mqueue_delete_inode(struct inode *inode)
>  {
>  	struct mqueue_inode_info *info;
> +	struct user_struct *user;
>  	int i;
>  
>  	if (S_ISDIR(inode->i_mode)) {
>  		clear_inode(inode);
>  		return;
>  	}
> +
>  	info = MQUEUE_I(inode);
> +
> +	user = find_user(info->creator_id);
> +	if (!user)
> +		BUG();
>  	spin_lock(&info->lock);

hmm, look at that.  find_user() forgot to take any locks.  Maybe it's
relying on tasklist_lock?  I think we need the below patch.  Ingo, can you
please confirm?


Also, you'll need to do a free_uid() in here - find_user() takes a ref.

Also, I'm not sure that it's legit to go BUG if the user wasn't found.  Is
it not possible that the user has gone away and it is root who is cleaning
up the inode?

Finally, my head is gently rotating wrt this patch.  Could you please
maintain a description of what it does?  We've made several significant
design decisions in here and that info really should be captured.  The
relationship between the global and per-user limits, the sizing choices for
the per-user limits, etc.  If it can be captured in brief code comments,
that's best.  Otherwise for the changelog.

Thanks.


---

 25-akpm/kernel/sys.c  |    4 ++++
 25-akpm/kernel/user.c |   13 ++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff -puN kernel/user.c~find_user-locking kernel/user.c
--- 25/kernel/user.c~find_user-locking	Wed Apr 28 13:56:52 2004
+++ 25-akpm/kernel/user.c	Wed Apr 28 13:58:28 2004
@@ -64,9 +64,20 @@ static inline struct user_struct *uid_ha
 	return NULL;
 }
 
+/*
+ * Locate the user_struct for the passed UID.  If found, take a ref on it.  The
+ * caller must undo that ref with free_uid().
+ *
+ * If the user_struct could not be found, return NULL.
+ */
 struct user_struct *find_user(uid_t uid)
 {
-	return uid_hash_find(uid, uidhashentry(uid));
+	struct user_struct *ret;
+
+	spin_lock(&uidhash_lock);
+	ret = uid_hash_find(uid, uidhashentry(uid));
+	spin_unlock(&uidhash_lock);
+	return ret;
 }
 
 void free_uid(struct user_struct *up)
diff -puN kernel/sys.c~find_user-locking kernel/sys.c
--- 25/kernel/sys.c~find_user-locking	Wed Apr 28 13:58:42 2004
+++ 25-akpm/kernel/sys.c	Wed Apr 28 13:59:54 2004
@@ -348,6 +348,8 @@ asmlinkage long sys_setpriority(int whic
 				if (p->uid == who)
 					error = set_one_prio(p, niceval, error);
 			while_each_thread(g, p);
+			if (who)
+				free_uid(user);		/* For find_user() */
 			break;
 	}
 out_unlock:
@@ -410,6 +412,8 @@ asmlinkage long sys_getpriority(int whic
 						retval = niceval;
 				}
 			while_each_thread(g, p);
+			if (who)
+				free_uid(user);		/* for find_user() */
 			break;
 	}
 out_unlock:

_

