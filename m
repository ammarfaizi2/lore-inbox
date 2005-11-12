Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVKLHio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVKLHio (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 02:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVKLHio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 02:38:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33452 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932187AbVKLHio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 02:38:44 -0500
Date: Fri, 11 Nov 2005 23:38:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Michael Kerrisk" <michael.kerrisk@gmx.net>
Cc: rohit.seth@intel.com, linux-kernel@vger.kernel.org, arun.sharma@google.com,
       mtk-lkml@gmx.net, mtk-manpages@gmx.net
Subject: Re: [PATCH] Expose SHM_HUGETLB in shmctl(id, IPC_STAT, ...)
Message-Id: <20051111233824.41075cc9.akpm@osdl.org>
In-Reply-To: <4375A5A5.10997.1DF7B02@localhost>
References: <437406D4.4060304@google.com>
	<4375A5A5.10997.1DF7B02@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Kerrisk" <michael.kerrisk@gmx.net> wrote:
>
> > Bear in mind that the sort of apps we're talking about here are
> > dubiously-written monsters with long and costly upgrade cycles and we tend
> > to not get any reports until many many months after we made a kernel
> > change.  It's very costly all round and we need to be cautious.
> 
> Andrew,
> 
> I am late to this discussion, but for what it's worth, a 
> portable application really must use checks of the like 
> (perm.mode & 0777 = 0666), because many implementations 
> define additional read-only flags for perm.mode:
> 
> Tru64 5.1
> #define	SHM_LOCKED	01000	/* segment locked in memory */
> #define	SHM_REMOVED	02000	/* already removed */
> 
> Linux
> #define	SHM_DEST	01000	/* segment will be destroyed on last detach */
> #define SHM_LOCKED      02000   /* segment will not be swapped */
> 
> HP-UX 11
> #  define SHM_CLEAR    01000	/* clear segment on next attach */
> #  define SHM_DEST     02000	/* destroy segment when # attached = 0 */
> #  define SHM_NOSWAP  010000	/* region for shared memory is memory locked */
> 			      /* (or should be when the region is allocated) */
> 
> AIX 5.1
> #define	SHM_DEST	02000	/* destroy segment when # attached = 0 */
> 
> So the chances are probably good that portable applications 
> wouldn't break with Arun's proposal.

The chances of breakage I agree are very low.  But non-zero.  I'd still
like us to find a way which is completely safe.

>  Of course applications 
> that were written just for Linux, and don't take care, might 
> also be at risk, but I think the risk is probably low.  
> A check of the form:
> 
> if (mode == 0666|SHM_LOCKED)
> 
> instead of:
> 
> if (mode & SHM_LOCKED)
> 
> is very obtuse.

Yes, but

	if ((mode & ~(SHM_LOCKED|SHM_REMOVED)) == 0666)

is pretty perverse, but more likely.  Stranger things have
been seen ;)

> This might not change your point of view (there is a theoretical risk 
> after all), but I thought it worth mentioning.

Thanks.
