Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262787AbSITPtx>; Fri, 20 Sep 2002 11:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSITPtx>; Fri, 20 Sep 2002 11:49:53 -0400
Received: from packet.digeo.com ([12.110.80.53]:17594 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262787AbSITPtw>;
	Fri, 20 Sep 2002 11:49:52 -0400
Message-ID: <3D8B4421.59392B30@digeo.com>
Date: Fri, 20 Sep 2002 08:52:01 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: locking rules for ->dirty_inode()
References: <15755.14336.739277.700462@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2002 15:52:02.0303 (UTC) FILETIME=[A92AB8F0:01C260BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:
> 
> Hello,
> 
> Documentation/filesystems/Locking states that all super operations may
> block, but __set_page_dirty_buffers() calls
> 
>    __mark_inode_dirty()->s_op->dirty_inode()
> 
> under mapping->private_lock spin lock. This seems strange, because file
> systems' ->dirty_inode() assume that they are allowed to block. For
> example, ext3_dirty_inode() allocates memory in
> 
>    ext3_journal_start()->journal_start()->new_handle()->...
> 

OK, thanks.

mapping->private_lock is taken there to pin page->buffers()
(Can't lock the page because set_page_dirty is called under
page_table_lock, and other locks).

I'm sure we can just move the spin_unlock up to above the
TestSetPageDirty(), but I need to zenuflect for a while over
why I did it that way.

It's necessary to expose buffer-dirtiness and page-dirtiness
to the rest of the world in the correct order.  If we set the
page dirty and then the buffers, there is a window in which writeback
could find the dirty page, try to write it, discover clean buffers
and mark the page clean.  We would end up with a !PageDirty page,
on mapping->clean_pages, with dirty buffers.  It would never be
written.

Yup.  We can move that spin_unlock up ten lines.
