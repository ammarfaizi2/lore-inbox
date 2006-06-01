Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWFARgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWFARgV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWFARgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:36:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57992 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965255AbWFARgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:36:20 -0400
Date: Thu, 1 Jun 2006 10:40:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: michal.k.k.piotrowski@gmail.com, gregkh@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-Id: <20060601104018.b88a3173.akpm@osdl.org>
In-Reply-To: <1149182861.3115.79.camel@laptopd505.fenrus.org>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<6bffcb0e0606010851n75b49d83u9f43136b3108886c@mail.gmail.com>
	<20060601102234.4f7a9404.akpm@osdl.org>
	<1149182861.3115.79.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006 19:27:41 +0200
Arjan van de Ven <arjan@linux.intel.com> wrote:

> 
> > > http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/bug_2.jpg
> > 
> > So it's claiming that we're taking multiple i_mutexes.
> > 
> > I can't immediately see where we took the outermost i_mutex there.
> 
> inlining caused one level to be removed from the backtrace
> one level is in fs_remove_file, the sub level is usbfs_unlink (called
> from fs_remove_file)

OK.

I'll duck this patch for now, pending a tested-n-changelogged one, please.

> >   Nor is
> > it immediately obvious why this is considered to be deadlockable?
> 
> what is missing is that we tell lockdep that there is a parent-child
> relationship between those two i_mutexes, so that it knows that 1)
> they're separate and 2) that the lock take order is parent->child
> 
> 
> > (lockdep tells us that a mutex was taken at "mutex_lock+0x8/0xa", which is
> > fairly useless.  We need to report who the caller of mutex_lock() was).
> 
> yeah this has been bugging me as well; either via a wrapper around
> mutex_lock or via the gcc option to backwalk the stack (but that only
> works with frame pointers enabled.. sigh)

Actually, __builtin_return_address(0) works OK with -fomit-frame-pointer,
and that's all we need here.

