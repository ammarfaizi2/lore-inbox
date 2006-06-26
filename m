Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932644AbWFZSy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbWFZSy4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 14:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWFZSy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 14:54:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33765 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932644AbWFZSyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 14:54:55 -0400
Date: Mon, 26 Jun 2006 11:54:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] [PATCH 2/3]: ufs: track i_size
Message-Id: <20060626115449.d0c674a4.akpm@osdl.org>
In-Reply-To: <20060626134836.GA8400@rain.homenetwork>
References: <20060626134836.GA8400@rain.homenetwork>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006 17:48:36 +0400
Evgeniy Dushistov <dushistov@mail.ru> wrote:

> To make possible proper work of `ufs_truncate'(see the next patch),
> I need to know old size of file in` ufs_truncate',
> but for some unknown for me reason VFS layer doesn't tell
> old size to file system, or at least I don't find way to get
> this information. 
> So I have to add per each inode `loff_t' field and update it
> in
> - alloc inode
> - read inode
> - commit write
> - truncate(see the next patch)
> is this right way to know "old size" in truncate method?

You can get this info by implementing inode_operations.setattr().  See the
callsite in fs/attr.c:notify_change().  You'd do something like:

ufs_setattr()
{
	loff_t old_i_size = inode->i_size;

	/* Stuff copied from notify_change(): */
	inode_change_ok()
	security_inode_setattr()
	inode_setattr()

	new_i_size = inode->i_size;
	....
}
