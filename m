Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265014AbTFLVfG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 17:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbTFLVet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 17:34:49 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:39358 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265014AbTFLVe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 17:34:29 -0400
Date: Thu, 12 Jun 2003 14:44:18 -0700
From: Andrew Morton <akpm@digeo.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix vmtruncate race and distributed filesystem race
Message-Id: <20030612144418.49f75066.akpm@digeo.com>
In-Reply-To: <150040000.1055452098@baldur.austin.ibm.com>
References: <133430000.1055448961@baldur.austin.ibm.com>
	<20030612134946.450e0f77.akpm@digeo.com>
	<20030612140014.32b7244d.akpm@digeo.com>
	<150040000.1055452098@baldur.austin.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2003 21:48:15.0200 (UTC) FILETIME=[53DFBE00:01C3312C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> wrote:
>
> 
> --On Thursday, June 12, 2003 14:00:14 -0700 Andrew Morton <akpm@digeo.com>
> wrote:
> 
> > And this does require that ->nopage be entered with page_table_lock held,
> > and that it drop it.
> 
> I think that's a worse layer violation than referencing inode in
> do_no_page.  We shouldn't require that the filesystem layer mess with the
> page_table_lock.

Well it is not "worse".  Futzing with i_sem in do_no_page() is pretty gross.
You could add vm_ops->prevalidate() or something if it worries you.

btw, it should be synchronising with
file->f_dentry->d_inode->i_mapping->host->i_sem, not
file->f_dentry->d_inode->i_sem.  do_truncate() also seems to be taking the
(potentially) wrong semaphore.


