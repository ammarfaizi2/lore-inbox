Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263321AbUCTKaM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 05:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263332AbUCTKaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 05:30:12 -0500
Received: from ozlabs.org ([203.10.76.45]:1686 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263321AbUCTKaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 05:30:01 -0500
Subject: Re: Fw: Re: OOPS when force unloading sctp with CONFIG_DEBUG_SLAB
	enabled
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Sridhar Samudrala <sri@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040319160236.1271dd3c.akpm@osdl.org>
References: <20040319160236.1271dd3c.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1079778517.18641.17.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 20 Mar 2004 21:28:40 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-20 at 11:02, Andrew Morton wrote:
> Some advice on this please?

This patch just went to Linus.  Summary, there is a problem, their
patch makes it worse, but original problem only happens with rmmod
--wait.

BTW, "forced unloading of xxx causes yyy" reports pretty much have
to be ignored.

Cheers,
Rusty.
>From rusty@rustcorp.com.au
From: rusty@rustcorp.com.au
To: torvalds@osdl.org
Subject: [PATCH 1] Set mod->waiter Before Calling stop_machine

Name: Set mod->waiter Before Calling stop_machine
Status: Tested on 2.6.5-rc1-bk4

mod->waiter needs to be set before we try to stop the module: setting
it in __try_stop_module means it gets set to the kthread, not rmmod.

Spotted by someone else, but I can't find the mail... 8(

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .30682-linux-2.6.5-rc1-bk4/kernel/module.c .30682-linux-2.6.5-rc1-bk4.updated/kernel/module.c
--- .30682-linux-2.6.5-rc1-bk4/kernel/module.c	2004-03-20 09:46:01.000000000 +1100
+++ .30682-linux-2.6.5-rc1-bk4.updated/kernel/module.c	2004-03-20 10:06:26.000000000 +1100
@@ -493,7 +493,6 @@ static inline int __try_stop_module(void
 	}
 
 	/* Mark it as dying. */
-	sref->mod->waiter = current;
 	sref->mod->state = MODULE_STATE_GOING;
 	return 0;
 }
@@ -588,6 +587,9 @@ sys_delete_module(const char __user *nam
 		}
 	}
 
+	/* Set this up before setting mod->state */
+	mod->waiter = current;
+
 	/* Stop the machine so refcounts can't move and disable module. */
 	ret = try_stop_module(mod, flags, &forced);
 


-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

