Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVCRWUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVCRWUD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 17:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVCRWTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 17:19:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:18129 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262418AbVCRWS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 17:18:56 -0500
Date: Fri, 18 Mar 2005 14:17:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: rweight@us.ibm.com
Cc: dev@sw.ru, linux-kernel@vger.kernel.org
Subject: Re: RFC: Bug in generic_forget_inode() ?
Message-Id: <20050318141716.494ab02a.akpm@osdl.org>
In-Reply-To: <1111183051.7102.33.camel@russw.beaverton.ibm.com>
References: <1111183051.7102.33.camel@russw.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russ Weight <rweight@us.ibm.com> wrote:
>
> generic_forget_inode() is eventually called (within the context of
>  iput), the inode is placed on the unused list, and the inode_lock is
>  dropped.
> 
>  kswapd calls prune_icache(), locks the inode_lock, and pulls the same
>  inode off of the unused list. Upon completion, prune_icache() calls
>  dispose_list() for the inodes that it has collected.
> 
>  generic_forget_inode() calls write_inode_now(), which calls
>  __writeback_single_inode() which calls __sync_single_inode().
>  __sync_single_inode() panics when attempting to move the inode onto the
>  unused list (the last call to list_move). This is due to the poison
>  values that were previously loaded into the next and prev list pointers
>  by list_del().

It's not clear what the actual bug is here.  When you say that
__sync_single_inode() panics over the list pointers, who was it that
poisoned them?  dispose_list()?

Certainly isofs_fill_super() could trivially be rewritten to not do the
iget()/iput() but we should be sure that that's really the bug.  The inode
lifetime management is rather messy, I'm afraid.
