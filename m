Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262540AbTCMS6e>; Thu, 13 Mar 2003 13:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262543AbTCMS6e>; Thu, 13 Mar 2003 13:58:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27561 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262540AbTCMS6c>;
	Thu, 13 Mar 2003 13:58:32 -0500
Date: Thu, 13 Mar 2003 19:09:08 +0000
From: Matthew Wilcox <willy@debian.org>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [Ext2-devel] [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-ID: <20030313190908.GC29631@parcelfarce.linux.theplanet.co.uk>
References: <m3el5bmyrf.fsf@lexa.home.net> <20030313103948.Z12806@schatzie.adilger.int> <m3d6kvhzuu.fsf@lexa.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3d6kvhzuu.fsf@lexa.home.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 09:43:05PM +0300, Alex Tomas wrote:
> 
> fs/attr.c:
>         if (ia_valid & ATTR_SIZE) {
>                 if (attr->ia_size == inode->i_size) {
>                         if (ia_valid == ATTR_SIZE)
>                                 goto out;       /* we can skip lock_kernel() */
>                 } else {
>                         lock_kernel();
>                         error = vmtruncate(inode, attr->ia_size);
>                         unlock_kernel();
>                         if (error)
>                                 goto out;
>                 }
>         }
> 
> so, all (!) truncates are serialized

This looks like a bug.  It should be safe to delete them.  Rationale:

 - Documentation/filesystems/Locking says ->truncate is called without the BKL.
 - This isn't the only place vmtruncate() is called.  Several of the callers
   do it without the BKL (eg xfs, cifs).
 - vmtruncate() appears to handle its own locking (mapping->i_shared_sem)

Comments?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
