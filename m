Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbUEAMII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUEAMII (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 08:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUEAMII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 08:08:08 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:25615 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261728AbUEAMIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 08:08:04 -0400
Date: Sat, 1 May 2004 20:10:01 +0800 (WST)
From: raven@themaw.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm1
In-Reply-To: <Pine.LNX.4.58.0405011413010.5547@raven.themaw.net>
Message-ID: <Pine.LNX.4.58.0405012001560.3168@donald.themaw.net>
References: <20040430014658.112a6181.akpm@osdl.org>
 <Pine.LNX.4.58.0405011413010.5547@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.2, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, PATCH_UNIFIED_DIFF,
	QUOTED_EMAIL_TEXT, REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2004, Ian Kent wrote:

> On Fri, 30 Apr 2004, Andrew Morton wrote:
> 
> > 
> > - The autofs4 patch series may be ready to go.  This is an invitation to
> >   interested parties to submit their final review comments...
> 
> Jeff Moyer has pointed out a couple of things that need to be 
> checked.
> 
> Hopefully I'll be able to post the result today.
> 

Jeff noticed something else that was missing from the 2.4 -> 2.6 
conversion (see below).

To all,

Looking at the code in fs/autofs4/waitq.c again, due to Jeff Moyers' 
comments, I really think I've got the locking wrong.

Can someone review this considering the case where two process do an ls of 
the same directory, that is a potential autofs4 mount (ie. an empty 
directory not yet a mountpoint), at the same time.

--- linux-2.6.6-rc2-mm2/fs/autofs4/root.c.orig	2004-05-01 19:35:08.000000000 +0800
+++ linux-2.6.6-rc2-mm2/fs/autofs4/root.c	2004-05-01 19:38:31.000000000 +0800
@@ -93,6 +93,7 @@
 {
 	struct dentry *top = dentry->d_sb->s_root;
 
+	spin_lock(&dcache_lock);
 	for(; dentry != top; dentry = dentry->d_parent) {
 		struct autofs_info *ino = autofs4_dentry_ino(dentry);
 
@@ -101,6 +102,7 @@
 			ino->last_used = jiffies;
 		}
 	}
+	spin_unlock(&dcache_lock);
 }
 
 /*
