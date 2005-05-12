Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVELCfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVELCfN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 22:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVELCfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 22:35:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:50830 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261286AbVELCfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 22:35:03 -0400
Date: Wed, 11 May 2005 19:33:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix of dcache race leading to busy inodes on umount
Message-Id: <20050511193352.2c9a9201.akpm@osdl.org>
In-Reply-To: <42822A2A.6000909@sw.ru>
References: <42822A2A.6000909@sw.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> wrote:
>
> This patch fixes dcache race between shrink_dcache_XXX functions
> and dput().
> 
> Example race scenario:
> 
> 	CPU 0				CPU 1
> umount /dev/sda1
> generic_shutdown_super          shrink_dcache_memory()
> shrink_dcache_parent            dput dentry
> select_parent                   prune_one_dentry()
>                                  <<<< child is dead, locks are released,
>                                    but parent is still referenced!!! >>>>
> 
> skip dentry->parent,
> since it's d_count > 0
> 
> message: BUSY inodes after umount...
>                                  <<< parent is left on dentry_unused
> 				   list, referencing freed super block
> 
> We faced these messages about busy inodes constantly after some stress 
> testing with mount/umount operations parrallel with some other activity.
> This patch helped the problem.
> 
> The patch was heavilly tested on 2.6.8 during 2 months,
> this forward-ported version boots and works ok as well.
> 

You've provided no description of how the patch solves the problem.

> /* dcache_lock protects shrinker's list */
> static void shrink_dcache_racecheck(struct dentry *parent, int *racecheck)
> {
> 	struct super_block *sb;
> 	struct dcache_shrinker *ds;
> 
> 	sb = parent->d_sb;
> 	list_for_each_entry(ds, &sb->s_dshrinkers, list) {
> 		/* is one of dcache shrinkers working on the dentry? */
> 		if (ds->dentry == parent) {
> 			*racecheck = 1;
> 			break;
> 		}
> 	}
> }
> 
> 

This all looks awfully hacky.  Why is it done this way, and is there no
cleaner solution?
