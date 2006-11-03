Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWKCIVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWKCIVV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 03:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWKCIVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 03:21:21 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52879 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751375AbWKCIVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 03:21:20 -0500
X-Sasl-enc: n0faDkOt8vCkjunksPMyXTtqzKUbnijh+d0i7nnvViA2 1162542079
Date: Fri, 3 Nov 2006 16:21:11 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
cc: "bibo,mao" <bibo.mao@intel.com>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.19-rc3 autofs crash on my IA64 box
In-Reply-To: <20061102183020.446D.Y-GOTO@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0611031610070.7573@raven.themaw.net>
References: <45485478.8060909@intel.com> <20061102183020.446D.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2006, Yasunori Goto wrote:

> Hello.
> 
> > hi,
> >   2.6.19-rc3 kernel crashes on my IA64 box, it seems the problem
> > of autofs fs. I debug this problem, if autofs kernel does not
> > match daemon version, it will call autofs_catatonic_mode.
> > But at that time sbi->pipe is NULL.
> > 
> > void autofs_catatonic_mode(struct autofs_sb_info *sbi)
> > {
> >    .........
> >    fput(sbi->pipe);        /* Close the pipe */
> > 	^^^^^^^^^^^^
> >  	sbi->pipe seems NULL;
> >    autofs_hash_dputall(&sbi->dirhash); /* Remove all dentry pointers */
> > }
> > 
> 
> My box crashed too.
> 
> Following fix does not seem enough.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116110204104327&w=2
> If version does not match at autofs_fill_super(), then sbi->pipe
> is not set yet.
> I suppose something like following patch is necessary.
> 
> Thanks.
> 
> -------------
> Index: stocktest/fs/autofs/waitq.c
> ===================================================================
> --- stocktest.orig/fs/autofs/waitq.c	2006-03-10 11:36:40.000000000 +0900
> +++ stocktest/fs/autofs/waitq.c	2006-11-02 18:44:58.000000000 +0900
> @@ -40,7 +40,8 @@ void autofs_catatonic_mode(struct autofs
>  		wake_up(&wq->queue);
>  		wq = nwq;
>  	}
> -	fput(sbi->pipe);	/* Close the pipe */
> +	if (sbi->pipe)
> +		fput(sbi->pipe);	/* Close the pipe */
>  	autofs_hash_dputall(&sbi->dirhash); /* Remove all dentry pointers */
>  }

I've checked this and this is not the only problem.
Also autofs4_ is called with s->s_root NULL in this case.

The attached patch ensures that the autofs filesystem is initialized to be 
catatonic until super block setup is complete which avoids the problem 
above. It also checks s->s_root before use.

Could someone seeing this problem try this patch out please.

Ian

---
--- linux-2.6.19-rc4-mm2/fs/autofs4/waitq.c.mount-fail-panic	2006-11-03 15:35:01.000000000 +0800
+++ linux-2.6.19-rc4-mm2/fs/autofs4/waitq.c	2006-11-03 15:35:22.000000000 +0800
@@ -41,10 +41,8 @@ void autofs4_catatonic_mode(struct autof
 		wake_up_interruptible(&wq->queue);
 		wq = nwq;
 	}
-	if (sbi->pipe) {
-		fput(sbi->pipe);	/* Close the pipe */
-		sbi->pipe = NULL;
-	}
+	fput(sbi->pipe);	/* Close the pipe */
+	sbi->pipe = NULL;
 }
 
 static int autofs4_write(struct file *file, const void *addr, int bytes)
--- linux-2.6.19-rc4-mm2/fs/autofs4/inode.c.mount-fail-panic	2006-11-03 14:42:46.000000000 +0800
+++ linux-2.6.19-rc4-mm2/fs/autofs4/inode.c	2006-11-03 15:20:55.000000000 +0800
@@ -99,6 +99,9 @@ static void autofs4_force_release(struct
 	struct dentry *this_parent = sbi->sb->s_root;
 	struct list_head *next;
 
+	if (!sbi->sb->s_root)
+		return;
+
 	spin_lock(&dcache_lock);
 repeat:
 	next = this_parent->d_subdirs.next;
@@ -310,7 +313,8 @@ int autofs4_fill_super(struct super_bloc
 	s->s_fs_info = sbi;
 	sbi->magic = AUTOFS_SBI_MAGIC;
 	sbi->pipefd = -1;
-	sbi->catatonic = 0;
+	sbi->pipe = NULL;
+	sbi->catatonic = 1;
 	sbi->exp_timeout = 0;
 	sbi->oz_pgrp = process_group(current);
 	sbi->sb = s;
@@ -388,6 +392,7 @@ int autofs4_fill_super(struct super_bloc
 		goto fail_fput;
 	sbi->pipe = pipe;
 	sbi->pipefd = pipefd;
+	sbi->catatonic = 0;
 
 	/*
 	 * Success! Install the root dentry now to indicate completion.
--- linux-2.6.19-rc4-mm2/fs/autofs/waitq.c.mount-fail-panic	2006-11-03 15:36:11.000000000 +0800
+++ linux-2.6.19-rc4-mm2/fs/autofs/waitq.c	2006-11-03 15:37:04.000000000 +0800
@@ -41,6 +41,7 @@ void autofs_catatonic_mode(struct autofs
 		wq = nwq;
 	}
 	fput(sbi->pipe);	/* Close the pipe */
+	sbi->pipe = NULL;
 	autofs_hash_dputall(&sbi->dirhash); /* Remove all dentry pointers */
 }
 
--- linux-2.6.19-rc4-mm2/fs/autofs/inode.c.mount-fail-panic	2006-11-03 14:40:56.000000000 +0800
+++ linux-2.6.19-rc4-mm2/fs/autofs/inode.c	2006-11-03 15:24:01.000000000 +0800
@@ -136,7 +136,8 @@ int autofs_fill_super(struct super_block
 
 	s->s_fs_info = sbi;
 	sbi->magic = AUTOFS_SBI_MAGIC;
-	sbi->catatonic = 0;
+	sbi->pipe = NULL;
+	sbi->catatonic = 1;
 	sbi->exp_timeout = 0;
 	sbi->oz_pgrp = process_group(current);
 	autofs_initialize_hash(&sbi->dirhash);
@@ -180,6 +181,7 @@ int autofs_fill_super(struct super_block
 	if ( !pipe->f_op || !pipe->f_op->write )
 		goto fail_fput;
 	sbi->pipe = pipe;
+	sbi->catatonic = 0;
 
 	/*
 	 * Success! Install the root dentry now to indicate completion.
