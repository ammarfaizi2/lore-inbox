Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWERRGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWERRGn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 13:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWERRGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 13:06:43 -0400
Received: from mournblade.cat.pdx.edu ([131.252.208.27]:50368 "EHLO
	mournblade.cat.pdx.edu") by vger.kernel.org with ESMTP
	id S1750831AbWERRGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 13:06:42 -0400
Date: Thu, 18 May 2006 10:06:24 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200605181706.k4IH6ObD000595@murzim.cs.pdx.edu>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: commit of [PATCH] Fix file lookup without ref
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > From Suzanne Wood Tue May  9 23:53:03 2006
 > In studying proc_readfd() of fs/proc/base.c, I'd looked back
 > at the linux-2.5.60 version which was prior to the conversion
 > to RCU and noticed that rather than straight spin_lock() as 
 > introduced in this patch, proc_fd_link() and proc_lookupfd() 
 > used read_lock(&files->file_lock).  Similarly, for __do_SAK() 
 > in drivers/char/tty_io.c

In include/linux/file.h, a change between linux-2.5.60 and
linux-2.6.17 was rwlock_t file_lock to spinlock_t file_lock.

In http://marc.theaimsgroup.com/?l=lse-tech&m=98235007317770&w=2
John Hawkes apparently explains this in Finding #3, 
"Because clone'd threads share the identical files_struct, we have
hundreds of threads doing the read_lock() on the same
(rwlock_t)file_lock.  This does not cause overt lock contention (because
with this test load there is no writer-owner of the file_lock), but it
does mean that each read_lock() and each read_unlock() dirties the
file_lock word, which produces that cacheblock ping-pong effect when
another thread on another CPU accesses that same file_lock word."
as referenced by
  http://lwn.net/2001/0412/a/fd-management.php3

Thanks.
Suzanne

 > > List:       git-commits-head
 > > Subject:    [PATCH] Fix file lookup without ref
 > > From:       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
 > > Date:       2006-04-19 17:00:12
 > > 
 > > commit ca99c1da080345e227cfb083c330a184d42e27f3
 > > tree e417b4c456ae31dc1dde8027b6be44a1a9f19395
 > > parent fb30d64568fd8f6a21afef987f11852a109723da
 > > author Dipankar Sarma <dipankar@in.ibm.com> Wed, 19 Apr 2006 12:21:46 -0700
 > > committer Linus Torvalds <torvalds@g5.osdl.org> Wed, 19 Apr 2006 23:13:51 -0700
 > > 
 > > [PATCH] Fix file lookup without ref
