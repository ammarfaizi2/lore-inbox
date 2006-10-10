Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWJJNP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWJJNP0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWJJNP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:15:26 -0400
Received: from mx2.netapp.com ([216.240.18.37]:57943 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1750726AbWJJNPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:15:25 -0400
X-IronPort-AV: i="4.09,289,1157353200"; 
   d="scan'208"; a="416655109:sNHT19250860"
Subject: Re: [PATCH] VM: Fix the gfp_mask in invalidate_complete_page2
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Steve Dickson <SteveD@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <5657.1160484596@redhat.com>
References: <1160480576.5466.27.camel@lade.trondhjem.org>
	 <1160170629.5453.34.camel@lade.trondhjem.org> <2069.1160473410@redhat.com>
	 <5657.1160484596@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Tue, 10 Oct 2006 09:15:19 -0400
Message-Id: <1160486119.5466.51.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 10 Oct 2006 13:15:20.0527 (UTC) FILETIME=[230D4DF0:01C6EC6E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 13:49 +0100, David Howells wrote:
> Trond Myklebust <Trond.Myklebust@netapp.com> wrote:
> 
> > No. Invalidatepage does precisely the wrong thing: it invalidates dirty
> > data instead of committing it to disk. If you need to have the data
> > invalidated, then you should call truncate_inode_pages().
> 
> Hmmm... Good point, but you still need to handle try_to_release_page() failing,
> but that only means checking the return value of invalidate_inode_pages2_range
> (which you don't do, I notice).  Or is it defined that if must succeed if
> __GFP_WAIT is set?

The only way for it to fail if __GFP_IO is set, is if someone kills the
process.
Note that since the NFS client itself will flush out all dirty data to
disk prior to calling invalidate_inode_pages2, the only thing we're
trying to do here is to avoid races while invalidating those pages.

> With the two-phase thing, I think I'm thinking of the wrong portion of that
> file (I'm thinking of truncate_inode_pages_range()).
> 
> Should invalidate_inode_pages2_range() take a gfp_t argument to pass on down?

Maybe. Do any of the current callers care? NFS should be quite happy
with the patch that is currently in Andrew's tree.

  Trond
