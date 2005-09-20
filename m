Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbVITPRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbVITPRl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbVITPRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:17:41 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:22230 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S965027AbVITPRk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:17:40 -0400
Date: Tue, 20 Sep 2005 17:17:26 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Robin Holt <holt@sgi.com>
Cc: Paul Jackson <pj@sgi.com>, zippel@linux-m68k.org, akpm@osdl.org,
       torvalds@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
In-Reply-To: <20050920145449.GA31461@lnx-holt.americas.sgi.com>
Message-ID: <Pine.LNX.4.61.0509201707410.21394@openx3.frec.bull.fr>
References: <20050912153135.3812d8e2.pj@sgi.com> <Pine.LNX.4.61.0509131120020.3728@scrub.home>
 <20050913103724.19ac5efa.pj@sgi.com> <Pine.LNX.4.61.0509141446590.3728@scrub.home>
 <20050914124642.1b19dd73.pj@sgi.com> <Pine.LNX.4.61.0509150116150.3728@scrub.home>
 <20050915104535.6058bbda.pj@sgi.com> <20050920005743.4ea5f224.pj@sgi.com>
 <20050920120523.GC21435@lnx-holt.americas.sgi.com> <20050920072255.0096f1bb.pj@sgi.com>
 <20050920145449.GA31461@lnx-holt.americas.sgi.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/09/2005 17:30:48,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/09/2005 17:30:50,
	Serialize complete at 20/09/2005 17:30:50
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2005, Robin Holt wrote:

> This makes things even easier!!!
> 
> When you create a cpuset, set the refcount to 0.  The root
> cpuset is the exception and has a refcount of 1.
> 
> When tasks are added to the cpuset, increment the refcount.
> 
> When child cpusets are created, increment the refcount.  Each
> cpuset has a list of children that is protected by a single
> lock.
> 
> Whenever you are decrementing the cpuset's refcount, use
> atomic_dec_and_lock on the parents child list lock.  If the
> notify_on_release property is set, you remove the child from
> the list.
> 
> When the vfs code is traversing the list, you need to ensure
> that it does not iterate unless the child list lock is held.
> I have not looked at how you implemented the vfs stuff, but
> that should be easily accomplished.

IIRC, that's the key. 
There was never a real issue about notify_on_release on the internal 
locking of the cpusets. But with the VFS...

The problem lies in how the VFS takes the semaphores on the inodes
when doing a rmdir(). It locks the parent's inode, and then the child's 
inode. And because of the cascading cpuset removal with the previous 
'autoclean' feature, the cpuset code tried to do the same thing, but in 
the reverse order. There was once a version of the code that seemed to 
work, but with inodes semaphores released and re-taken in the good order. 
Ugly, and unsafe.

(All this from memory, I don't guarantee its accuracy).

	Simon.

