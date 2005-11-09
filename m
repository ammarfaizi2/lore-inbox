Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbVKILB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbVKILB2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 06:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVKILB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 06:01:28 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:62434 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1751333AbVKILB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 06:01:27 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17265.55057.438316.467289@gargle.gargle.HOWL>
Date: Wed, 9 Nov 2005 14:01:37 +0300
To: Christoph Lameter <clameter@sgi.com>
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       torvalds@osdl.org, Hirokazu Takahashi <taka@valinux.co.jp>,
       Magnus Damm <magnus.damm@gmail.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Paul Jackson <pj@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 6/8] Direct Migration V2: Avoid writeback / page_migrate() method
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.mm
In-Reply-To: <20051108210417.31330.72381.sendpatchset@schroedinger.engr.sgi.com>
References: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
	<20051108210417.31330.72381.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter writes:
 > Migrate a page with buffers without requiring writeback
 > 
 > This introduces a new address space operation migrate_page() that
 > may be used by a filesystem to implement its own version of page migration.
 > 
 > A version is provided that migrates buffers attached to pages. Some
 > filesystems (ext2, ext3, xfs) are modified to utilize this feature.
 > 
 > The swapper address space operation are modified so that a regular
 > migrate_pages() will occur for anonymous pages without writeback
 > (migrate_pages forces every anonymous page to have a swap entry).
 > 
 > V1->V2:
 > - Fix CONFIG_MIGRATION handling
 > 
 > Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
 > Signed-off-by: Christoph Lameter <clameter@sgi.com>
 > 
 > Index: linux-2.6.14-mm1/include/linux/fs.h
 > ===================================================================
 > --- linux-2.6.14-mm1.orig/include/linux/fs.h	2005-11-07 11:48:46.000000000 -0800
 > +++ linux-2.6.14-mm1/include/linux/fs.h	2005-11-08 10:18:51.000000000 -0800
 > @@ -332,6 +332,8 @@ struct address_space_operations {
 >  			loff_t offset, unsigned long nr_segs);
 >  	struct page* (*get_xip_page)(struct address_space *, sector_t,
 >  			int);
 > +	/* migrate the contents of a page to the specified target */
 > +	int (*migrate_page) (struct page *, struct page *);
 >  };
 >  
 >  struct backing_dev_info;
 > @@ -1679,6 +1681,12 @@ extern void simple_release_fs(struct vfs
 >  
 >  extern ssize_t simple_read_from_buffer(void __user *, size_t, loff_t *, const void *, size_t);
 >  
 > +#ifdef CONFIG_MIGRATION
 > +extern int buffer_migrate_page(struct page *, struct page *);
 > +#else
 > +#define buffer_migrate_page(a,b) NULL
 > +#endif

Depending on the CONFIG_MIGRATION, the type of buffer_migrate_page(a,b)
expansion is either int or void *, which doesn't look right.

Moreover below you have initializations

        .migrate_page		= buffer_migrate_page,

that wouldn't compile when CONFIG_MIGRATION is not defined (as macro
requires two arguments).

Nikita.
