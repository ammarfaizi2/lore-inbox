Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbSKHWhk>; Fri, 8 Nov 2002 17:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbSKHWhk>; Fri, 8 Nov 2002 17:37:40 -0500
Received: from packet.digeo.com ([12.110.80.53]:62873 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262506AbSKHWhh>;
	Fri, 8 Nov 2002 17:37:37 -0500
Message-ID: <3DCC3E38.29B0ABEF@digeo.com>
Date: Fri, 08 Nov 2002 14:44:08 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: get_user_pages rewrite (completed, updated for 2.4.46)
References: <20021107110840.P659@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2002 22:44:08.0458 (UTC) FILETIME=[59584EA0:01C28778]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> 
> Hi Andrew,
> 
> now I have implemented the big get_user_pages rewrite.


/* &custom_page_walker - A custom page walk handler for walk_user_pages().
 * vma:         The vma we walk pages of.
 * page:        The page we found or an %ERR_PTR() value
 * virt_addr:   The virtual address we are at while walking.
 * customdata:  Anything you would like to pass additionally.
 *
 * Returns:
 *      Negative values -> ERRNO values.
 *      0               -> continue page walking.
 *      1               -> abort page walking.
 *
 * If this functions gets a page, for which %IS_ERR(@page) is true, than it
 * should do it's cleanup of customdata and return -PTR_ERR(@page).
 *
 * This function is called with @vma->vm_mm->page_table_lock held,
 * if IS_ERR(@vma) is not true.
 *
 * But if IS_ERR(@vma) is true, IS_ERR(@page) is also true, since if we have no
 * vma, then we also have no user space page.
 *
 * If it returns a negative value, then the page_table_lock must be dropped
 * by this function, if it is held.
 */

This locking is rather awkward.  Why is it necessary, and can it
be simplified??

wrt the removal of the vmas arg to get_user_pages(): I assume this
was because none of the multipage callers were using it?

The patches would be easier to follow if things were sequenced a
little differently: lose the intermediate steps.  Or just roll
the whole thing into a single patch, really.  I don't think there
are any intermediate steps in this one?
