Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVKJWGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVKJWGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 17:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVKJWGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 17:06:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32401 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932195AbVKJWGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 17:06:39 -0500
Date: Thu, 10 Nov 2005 14:06:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arun Sharma <arun.sharma@google.com>
Cc: rohit.seth@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Expose SHM_HUGETLB in shmctl(id, IPC_STAT, ...)
Message-Id: <20051110140621.47729c5b.akpm@osdl.org>
In-Reply-To: <4373BE8D.2070104@google.com>
References: <20051109184623.GA21636@sharma-home.net>
	<20051109222223.538309e4.akpm@osdl.org>
	<43739302.1080404@google.com>
	<20051110115941.1cbe1ae7.akpm@osdl.org>
	<4373BE8D.2070104@google.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arun Sharma <arun.sharma@google.com> wrote:
>
> Andrew Morton wrote:
> 
> >>The man page on my system says:
> >>
> >>               unsigned short mode;  /* Permissions + SHM_DEST and
> >>                                         SHM_LOCKED flags */
> >>
> >>I looked for a precendent before sending the patch and thought that 
> >>SHM_LOCKED was a good one.
> >>
> > 
> > 
> > hm, OK.   But an app could still do
> > 
> > 	if (mode == 0666|SHM_LOCKED)
> > 
> 
> I'd argue that the app should really be doing (perm.mode & 0777 = 0666)

I find your faith in your fellow programmers to be trluy inspirational ;)

> > 
> > How important is this feature?
> 
> Without this feature, an application has no way to figure out if a given 
> segment is hugetlb or not. Applications need to know this to be able to 
> handle alignment issues properly.
> 
> Also, if the flag is exported via ipcs, the system administrator would 
> have a better idea about how the hugetlb pages she configured on the 
> system are getting used.
> 

I'd suggest that any API which allows us to query the hugeness of a piece
of memory should also work for mmap(hugetld_fd...).  IOW: this capability
shouldn't be restricted to sysv shm areas.

I can't think of any syscall which can be sanely overloaded for this.

The most general way of exposing this info would be to export it in
/proc/pid/maps in some back-compatible manner.

And once I've lost the "oh oh we'd need to write 100 lines of userspace
code for that" bunfight I'd say add a new syscall sys_query_pagesize(void
*addr) which returns the size of the page which backs `addr'.

But then again, if it was possible to write 100 lines of userspace code, we
wouldn't need this capability at all.  I bet if the userspace guys tried a
bit harder they'd work out a way of teaching their applications to remember
what they did.
