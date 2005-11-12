Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVKLHTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVKLHTy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 02:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVKLHTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 02:19:54 -0500
Received: from pop.gmx.net ([213.165.64.20]:35810 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932183AbVKLHTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 02:19:53 -0500
X-Authenticated: #2864774
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Date: Sat, 12 Nov 2005 08:19:49 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] Expose SHM_HUGETLB in shmctl(id, IPC_STAT, ...)
CC: rohit.seth@intel.com, linux-kernel@vger.kernel.org,
       Arun Sharma <arun.sharma@google.com>, mtk-lkml@gmx.net,
       mtk-manpages@gmx.net
Message-ID: <4375A5A5.10997.1DF7B02@localhost>
In-reply-to: <20051110191254.2206860f.akpm@osdl.org>
References: <437406D4.4060304@google.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Arun Sharma <arun.sharma@google.com> wrote:
> >
> >  Andrew Morton wrote:
> > 
> >  >>>How important is this feature?
> >  >>
> >  >>Without this feature, an application has no way to figure out if a given 
> >  >>segment is hugetlb or not. Applications need to know this to be able to 
> >  >>handle alignment issues properly.
> >  >>
> >  >>Also, if the flag is exported via ipcs, the system administrator would 
> >  >>have a better idea about how the hugetlb pages she configured on the 
> >  >>system are getting used.
> >  >>
> >  > 
> >  > 
> >  > I'd suggest that any API which allows us to query the hugeness of a piece
> >  > of memory should also work for mmap(hugetld_fd...).  IOW: this capability
> >  > shouldn't be restricted to sysv shm areas.
> > 
> >  The capability I was talking about was the ability to figure out where 
> >  the configured hugetlb pages are going (vs is this a hugetlb page?).
> 
> Well, please figure out a way which has less risk of breaking userspace.
> 
> Bear in mind that the sort of apps we're talking about here are
> dubiously-written monsters with long and costly upgrade cycles and we tend
> to not get any reports until many many months after we made a kernel
> change.  It's very costly all round and we need to be cautious.

Andrew,

I am late to this discussion, but for what it's worth, a 
portable application really must use checks of the like 
(perm.mode & 0777 = 0666), because many implementations 
define additional read-only flags for perm.mode:

Tru64 5.1
#define	SHM_LOCKED	01000	/* segment locked in memory */
#define	SHM_REMOVED	02000	/* already removed */

Linux
#define	SHM_DEST	01000	/* segment will be destroyed on last detach */
#define SHM_LOCKED      02000   /* segment will not be swapped */

HP-UX 11
#  define SHM_CLEAR    01000	/* clear segment on next attach */
#  define SHM_DEST     02000	/* destroy segment when # attached = 0 */
#  define SHM_NOSWAP  010000	/* region for shared memory is memory locked */
			      /* (or should be when the region is allocated) */

AIX 5.1
#define	SHM_DEST	02000	/* destroy segment when # attached = 0 */

So the chances are probably good that portable applications 
wouldn't break with Arun's proposal.  Of course applications 
that were written just for Linux, and don't take care, might 
also be at risk, but I think the risk is probably low.  
A check of the form:

if (mode == 0666|SHM_LOCKED)

instead of:

if (mode & SHM_LOCKED)

is very obtuse.

This might not change your point of view (there is a theoretical risk 
after all), but I thought it worth mentioning.

Cheers,

Michael
