Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWHIS17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWHIS17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 14:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWHIS17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 14:27:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38075 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751289AbWHIS16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 14:27:58 -0400
Date: Wed, 9 Aug 2006 11:27:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] unlink: monitor i_nlink
Message-Id: <20060809112740.a964e5a2.akpm@osdl.org>
In-Reply-To: <1155143839.19249.151.camel@localhost.localdomain>
References: <20060809165729.FE36B262@localhost.localdomain>
	<20060809165732.07F0AD16@localhost.localdomain>
	<20060809171109.GC7324@infradead.org>
	<1155143839.19249.151.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2006 10:17:19 -0700
Dave Hansen <haveblue@us.ibm.com> wrote:

> On Wed, 2006-08-09 at 18:11 +0100, Christoph Hellwig wrote:
> > On Wed, Aug 09, 2006 at 09:57:32AM -0700, Dave Hansen wrote:
> > > 
> > > When a filesystem decrements i_nlink to zero, it means that a
> > > write must be performed in order to drop the inode from the
> > > filesystem.
> > > 
> > > We're shortly going to have keep filesystems from being remounted
> > > r/o between the time that this i_nlink decrement and that write
> > > occurs.  
> > > 
> > > So, add a little helper function to do the decrements.  We'll
> > > tie into it in a bit to note when i_nlink hits zero.
> > > 
> > > Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
> > 
> > Acked-by: Christoph Hellwig <hch@lst.de>
> 
> > Note that we all (and especially Andrew :)) need to be carefull not to
> > introduce unguarded i_nlink decrements again.  Dave, you'll probably need
> > to do another audit when you introduce the real functionality.
> 
> Yup, I have my eyes on it.  git and mm commits should help as well.
> 

A comprehensive way to do this sort of thing is to rename the field.  We
have >500 references, so one would do:

struct inode {
	...
	union {
		unsigned int i_nlink;
		unsigned int i_nlink_use_the_accessors_please;
	}
	...
};

then, when everything in-tree is migrated, remove `i_nlink'.

It's a bit of a hassle, but it will give the most reliable result for both
in-tree and out-of-tree filesystems.

