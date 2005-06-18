Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVFRDVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVFRDVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 23:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVFRDVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 23:21:38 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:26861 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S262047AbVFRDUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 23:20:39 -0400
Date: Fri, 17 Jun 2005 20:20:31 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: movq movq <movq_64@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: missing kfree in fs/ext3/balloc.c
Message-Id: <20050617202031.28523e9b.rdunlap@xenotime.net>
In-Reply-To: <20050618025312.22719.qmail@web61215.mail.yahoo.com>
References: <20050618025312.22719.qmail@web61215.mail.yahoo.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2005 19:53:12 -0700 (PDT) movq movq wrote:

| This is my first post, so be kind. Perhaps I am wrong
| here, but I was looking through fs/ext3/balloc.c and
| noticed this line:
| 
| line 268
| ...
| block_i = kmalloc(sizeof(*block_i), GFP_NOFS);
| ...
| 
| But I do not see this chunk of memory ever kfree()'d.
| Is there a reason for this or is this kfree() just
| missing?

It's not supposed to be freed in that function.
It is saved for later use at line 288:

	ei->i_block_alloc_info = block_i;

and freed (I think) in fs/ext3/super.c::ext3_clear_inode():

	EXT3_I(inode)->i_block_alloc_info = NULL;
	kfree(rsv);

where rsv is:
	struct ext3_block_alloc_info *rsv = EXT3_I(inode)->i_block_alloc_info;


However, back to fs/ext3/balloc.c::ext3_init_block_alloc_info():

{
	struct ext3_inode_info *ei = EXT3_I(inode);
[1]	struct ext3_block_alloc_info *block_i = ei->i_block_alloc_info;
	struct super_block *sb = inode->i_sb;

[2]	block_i = kmalloc(sizeof(*block_i), GFP_NOFS);
	if (block_i) {

Seems to me that <block_i> [1] is clobbered by [2] and could be a
memory leak unless the value in [1] is always NULL....

---
~Randy
