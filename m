Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbTDAO7Q>; Tue, 1 Apr 2003 09:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262582AbTDAO7Q>; Tue, 1 Apr 2003 09:59:16 -0500
Received: from kestrel.vispa.uk.net ([62.24.228.12]:32528 "EHLO
	kestrel.vispa.uk.net") by vger.kernel.org with ESMTP
	id <S262580AbTDAO7P>; Tue, 1 Apr 2003 09:59:15 -0500
Message-ID: <3E89AB56.3080000@walrond.org>
Date: Tue, 01 Apr 2003 16:08:06 +0100
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: rgooch@atnf.csiro.au
Subject: Linux 2.4-bk: Kernel BUG at dcache.c:653
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On about 50% of reboots of a server, I get this BUG message while the 
kernel has just started processing my init script.

This is a dual P3 machine with DAC960 raid card.

I am running the latest 2.4-bk kernel

Any clues what might cause this? Since I am running Richard Gooch's 
simpleinit (with homebrew scripts) which does loads of init stuff in 
parallel, I'm sure they must be the cause.

Very early in the scripts, root is remounted ro and fscked, then 
remounted rw, while other parallel scripts wait on it to complete.

What does this BUG indicate? It occurs in this function:

/**
  * d_instantiate - fill in inode information for a dentry
  * @entry: dentry to complete
  * @inode: inode to attach to this dentry
  *
  * Fill in inode information in the entry.
  *
  * This turns negative dentries into productive full members
  * of society.
  *
  * NOTE! This assumes that the inode count has been incremented
  * (or otherwise set) by the caller to indicate that it is now
  * in use by the dcache.
  */

void d_instantiate(struct dentry *entry, struct inode * inode)
{
     if (!list_empty(&entry->d_alias)) BUG();
     spin_lock(&dcache_lock);
     if (inode)
         list_add(&entry->d_alias, &inode->i_dentry);
     entry->d_inode = inode;
     spin_unlock(&dcache_lock);
}


Andrew Walrond

