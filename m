Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWFAR16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWFAR16 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbWFAR15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:27:57 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:31378 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S964987AbWFAR14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:27:56 -0400
Subject: Re: 2.6.17-rc5-mm2
From: Arjan van de Ven <arjan@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, gregkh@suse.de,
       mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20060601102234.4f7a9404.akpm@osdl.org>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <6bffcb0e0606010851n75b49d83u9f43136b3108886c@mail.gmail.com>
	 <20060601102234.4f7a9404.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Jun 2006 19:27:41 +0200
Message-Id: <1149182861.3115.79.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/bug_2.jpg
> 
> So it's claiming that we're taking multiple i_mutexes.
> 
> I can't immediately see where we took the outermost i_mutex there.

inlining caused one level to be removed from the backtrace
one level is in fs_remove_file, the sub level is usbfs_unlink (called
from fs_remove_file)

>   Nor is
> it immediately obvious why this is considered to be deadlockable?

what is missing is that we tell lockdep that there is a parent-child
relationship between those two i_mutexes, so that it knows that 1)
they're separate and 2) that the lock take order is parent->child


> (lockdep tells us that a mutex was taken at "mutex_lock+0x8/0xa", which is
> fairly useless.  We need to report who the caller of mutex_lock() was).

yeah this has been bugging me as well; either via a wrapper around
mutex_lock or via the gcc option to backwalk the stack (but that only
works with frame pointers enabled.. sigh)
