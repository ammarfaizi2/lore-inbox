Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269303AbUIHS41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269303AbUIHS41 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269306AbUIHS41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:56:27 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:38358 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269303AbUIHS4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:56:03 -0400
Subject: Re: [Patch 4/6]: ext3 reservations: Turn ext3 per-sb reservations
	list into an rbtree.
From: Mingming Cao <cmm@us.ibm.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>
In-Reply-To: <1094666713.1985.181.camel@sisko.scot.redhat.com>
References: <200409071302.i87D2bDf030921@sisko.scot.redhat.com>
	<20040907154833.4cc8d7a3.akpm@osdl.org> 
	<1094666713.1985.181.camel@sisko.scot.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Sep 2004 11:55:38 -0700
Message-Id: <1094669740.1180.248.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-08 at 11:05, Stephen C. Tweedie wrote:
> Hi,
> 
> On Tue, 2004-09-07 at 23:48, Andrew Morton wrote:
> 
> > Takes this structure up to 32 bytes on x86.  That's a moderate amount of
> > inode bloat for something which is only used when an application currently
> > has the inode open for writing.
> > 
> > Have you given any thought to dynamic allocation of the above?
> 
> No, none at all.  <thinks>
> 
> We already have an ext3 function that's called on all opens ---
> currently it checks nothing except O_LARGEFILE, but it's an easy and
> obvious place where we could set up the may-write bits.
> 
Yes, we could add a check anout FMODE_WRITE and a check about
inode->i_writecount in ext3_open_file(), to just do reservation
structure allocation for the first writer of the inode.

> We'd have to take special care with directories, and potentially with
> xattrs, but I don't see any great problems with doing it.
> 
> > And if we were to do that, there are a few things which we could move out
> > of the ext3 in-core inode and into the above structure, such as
> > i_next_alloc_block and i_next_alloc_goal.
> 
> Yep.
> 
> > Does the reservation code work for directory growth, btw?
> 
> Yes, it should be hidden inside the allocation code, and should work
> straight out of the box for directories.  

Yes, as you said, current reservation code could work for directories.
But we did not do reservation for directory right now because we don't
really sure whether it is worth doing it.

One thing is, if later we decide to make reservation per-fd instead of
per-inode, we probably need fd->private_data to store the per-fd
reservation structure. But this field is already been used by directory
for htree structures.


