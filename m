Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758632AbWK1ADU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758632AbWK1ADU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 19:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758636AbWK1ADU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 19:03:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41649 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1758632AbWK1ADT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 19:03:19 -0500
Message-ID: <456B7A5A.1070202@redhat.com>
Date: Mon, 27 Nov 2006 18:52:58 -0500
From: Wendy Cheng <wcheng@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] prune_icache_sb
References: <4564C28B.30604@redhat.com> <20061122153603.33c2c24d.akpm@osdl.org>
In-Reply-To: <20061122153603.33c2c24d.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> This search is potentially inefficient.  It would be better walk
> sb->s_inodes.
>
>   
Not sure about walking thru sb->s_inodes for several reasons....

1. First, the changes made are mostly for file server setup with large 
fs size - the entry count in sb->s_inodes may not be shorter then 
inode_unused list.
2. Different from calls such as drop_pagecache_sb() (that doesn't do 
list entry removal), we're walking thru the list to dispose the entries. 
This implies we are walking thru one list (sb->s_inodes) to remove the 
other list's entries (inode_unused). This feels awkward.
3. The new code will be very similar to current prune_icache() with few 
differences - e.g., we really don't want to list_move() within the 
sb->s_inodes list itself (as done in prune_icache() that moves the 
examined entry to the tail of the inode_unused list). We have to either 
duplicate the code or clutter the current prune_icache() routine.

Pruning based on sb->s_inodes *does* have its advantage but a simple and 
plain patch as shown in previous post (that has been well-tested out in 
two large scale production systems) could be equally effective. Make 
sense ?

-- Wendy

