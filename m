Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWCCNAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWCCNAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 08:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWCCNAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 08:00:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24801 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751327AbWCCNAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 08:00:23 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060303034552.5fcedc49.akpm@osdl.org> 
References: <20060303034552.5fcedc49.akpm@osdl.org>  <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> <25676.1141385408@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/5] Optimise d_find_alias() 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 03 Mar 2006 13:00:10 +0000
Message-ID: <27600.1141390810@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> How can we get away without a barrier?

Is this what you're thinking of:

	struct dentry * d_find_alias(struct inode *inode)
	{
		struct dentry *de = NULL;

		smp_rb();
		if (!list_empty(&inode->i_dentry)) {
			spin_lock(&dcache_lock);
			de = __d_find_alias(inode, 0);
			spin_unlock(&dcache_lock);
		}
		return de;
	}


David
