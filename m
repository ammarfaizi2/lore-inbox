Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVBPPfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVBPPfq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 10:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVBPPfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 10:35:45 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:16140 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S262044AbVBPPff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 10:35:35 -0500
Date: Wed, 16 Feb 2005 23:20:21 +0800 (WST)
From: raven@themaw.net
To: Jan Blunck <j.blunck@tu-harburg.de>
cc: viro@parcelfarce.linux.theplanet.co.uk,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] dcache d_drop() bug fix / __d_drop() use fix
In-Reply-To: <421355A4.6000305@tu-harburg.de>
Message-ID: <Pine.LNX.4.61.0502162318240.8161@donald.themaw.net>
References: <421355A4.6000305@tu-harburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-101.1, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, PATCH_UNIFIED_DIFF,
	QUOTED_EMAIL_TEXT, RCVD_IN_ORBS, RCVD_IN_OSIRUSOFT_COM, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2005, Jan Blunck wrote:

> This is a re-submission of the patch I sent about a month ago.
>
> While working on my code I realized that d_drop() might race against 
> __d_lookup(). __d_drop() (which is called by d_drop() after acquiring the 
> dcache_lock) is accessing dentry->d_flags to set the DCACHE_UNHASHED flag. 
> This shouldn't be done without holding dentry->d_lock, like stated in 
> dcache.h:
>
> struct dentry {
> ...
> unsigned int d_flags;		/* protected by d_lock */
>        ...
> };
>
> Therefore d_drop() must acquire the dentry->d_lock. Likewise every use of 
> __d_drop() must acquire that lock.
>
> This patch fixes d_drop() and every grep'able __d_drop() use. This patch is 
> against today's http://linux.bkbits.net/linux-2.5.
>

For my part, in autofs4, I would prefer:

--- linux-2.6.9/fs/autofs4/root.c.d_lock	2005-02-16 23:15:18.000000000 +0800
+++ linux-2.6.9/fs/autofs4/root.c	2005-02-16 23:15:35.000000000 +0800
@@ -621,7 +621,7 @@
  		spin_unlock(&dcache_lock);
  		return -ENOTEMPTY;
  	}
-	__d_drop(dentry);
+	d_drop(dentry);
  	spin_unlock(&dcache_lock);

  	dput(ino->dentry);
