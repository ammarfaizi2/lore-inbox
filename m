Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266314AbUGBHUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266314AbUGBHUe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 03:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266491AbUGBHUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 03:20:34 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:7601 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S266486AbUGBHUc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 03:20:32 -0400
Date: Fri, 2 Jul 2004 00:20:20 -0700 (PDT)
From: Yichen Xie <yxie@cs.stanford.edu>
X-X-Sender: yxie@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUGS] [CHECKER] 99 synchronization bugs and a lock summary
 database
In-Reply-To: <20040701213837.0b97c21e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0407020008190.5069-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> AFAICT fs/sysv/itree.c:find_shared is innocent.

I guess here's what has triggered the warning by the tool:

get_branch may try to acquire pointers_lock (itree.c:103) on one of its
paths, which was held (line 287) by find_shared...

> fs/nfsd/nfsproc.c:nfsd_proc_link is a bit obscure.  There's a bug in a
> callee of nfsd_proc_link(): nfsd_link() can forget to do an fh_unlock() on
> an error path (the goto out_nfserr).  Is that what the tool is referring
> to?

fh_put calls fh_unlock(fhp), which "up"s fhp->fh_dentry->d_inode->i_sem. 
two calls in a row "up"s that semaphore twice, which upset the tool and 
triggered the warning.

yichen

