Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUAYAjR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 19:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbUAYAjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 19:39:16 -0500
Received: from dsl081-085-091.lax1.dsl.speakeasy.net ([64.81.85.91]:60289 "EHLO
	mrhankey.megahappy.net") by vger.kernel.org with ESMTP
	id S261262AbUAYAjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 19:39:14 -0500
Date: Sat, 24 Jan 2004 16:38:20 -0800 (PST)
From: Bryan Whitehead <driver@megahappy.net>
X-X-Sender: driver@mrhankey.homeip.net
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, nathans@sgi.com,
       owner-xfs@oss.sgi.com
Subject: Re: [PATCH 2.6.2-rc1-mm2] fs/xfs/xfs_log_recover.c
In-Reply-To: <20040124082606.A3107@infradead.org>
Message-ID: <Pine.LNX.4.58.0401241633440.20068@mrhankey.homeip.net>
References: <20040124073111.34B2313A354@mrhankey.megahappy.net>
 <20040124082606.A3107@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should have been more clear in the frist email. Sorry.

The variable "flags" is used in an if statement without having a value 
assigned.

There is 2 switch statements that do this: (ITEM_TYPE(itemq) They execute 
one right after the other with no returns. So it is redundant.

I think the patch fixes a cut/paste accident...

Here is a more complete diff so you can see what is going on:
--- fs/xfs/xfs_log_recover.c.orig       2004-01-23 23:17:35.402907768 
-0800
+++ fs/xfs/xfs_log_recover.c    2004-01-23 23:19:09.368622808 -0800
@@ -1539,27 +1539,20 @@
                itemq_next = itemq->ri_next;
                buf_f = (xfs_buf_log_format_t *)itemq->ri_buf[0].i_addr;
                switch (ITEM_TYPE(itemq)) {
                case XFS_LI_BUF:
                        flags = buf_f->blf_flags;
                        break;
                case XFS_LI_6_1_BUF:
                case XFS_LI_5_3_BUF:
                        obuf_f = (xfs_buf_log_format_v1_t*)buf_f;
                        flags = obuf_f->blf_flags;
-                       break;
-               }
-
-               switch (ITEM_TYPE(itemq)) {
-               case XFS_LI_BUF:
-               case XFS_LI_6_1_BUF:
-               case XFS_LI_5_3_BUF:
                        if (!(flags & XFS_BLI_CANCEL)) {
                                
xlog_recover_insert_item_frontq(&trans->r_itemq,
                                                                itemq);
                                break;
                        }
                case XFS_LI_INODE:
                case XFS_LI_6_1_INODE:
                case XFS_LI_5_3_INODE:
                case XFS_LI_DQUOT:
                case XFS_LI_QUOTAOFF:



On Sat, 24 Jan 2004, Christoph Hellwig wrote:

> On Fri, Jan 23, 2004 at 11:31:11PM -0800, Bryan Whitehead wrote:
> > 
> > This fixes a warning on compile of the xfs fs module.
> 
> This patch looks very strange.  What error do you get without it?
> 

-- 
Bryan Whitehead
Email:driver@megahappy.net
WorkE:driver@jpl.nasa.gov
