Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262922AbSITQmQ>; Fri, 20 Sep 2002 12:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262986AbSITQmQ>; Fri, 20 Sep 2002 12:42:16 -0400
Received: from packet.digeo.com ([12.110.80.53]:61883 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262922AbSITQmP>;
	Fri, 20 Sep 2002 12:42:15 -0400
Message-ID: <3D8B5111.A318D63D@digeo.com>
Date: Fri, 20 Sep 2002 09:47:13 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: locking rules for ->dirty_inode()
References: <3D8B4421.59392B30@digeo.com> <15755.19895.544309.44729@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2002 16:47:14.0370 (UTC) FILETIME=[5F500A20:01C260C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:
> 
> ...
> Actually, I came over this while trying to describe lock ordering in
> reiser4 after I just started integrating other kernel locks there. I
> wonder, has somebody already done this, writing up kernel lock
> hierarchy, that is?
> 

I've been keeping the comment at the top of filemap.c uptodate when
I discover things.  It got smaller a while ago when certain rude
locks were spoken to.

Really, this form of representation isn't rich enough, but the
format certainly provides enough info to know when you might be
taking locks in the wrong order, and it tells you where to look
to see them being taken.

The problem with the format is that locks are only mentioned once,
and it can't describe the whole graph.  Maybe it needs something
like:


 *  ->i_shared_lock             (vmtruncate)
 *    ->private_lock            (__free_pte->__set_page_dirty_buffers)
 *      ->swap_list_lock
 *        ->swap_device_lock    (exclusive_swap_page, others)
 *          ->mapping->page_lock
 *      ->inode_lock            (__mark_inode_dirty)
 *        ->sb_lock             (fs/fs-writeback.c)
+*  ->i_shared_lock
+*    ->page_table_lock         (lots of places)
 */

Don't know.  Maybe someone somewhere has developed a notation
for this?   How are you doing it?
