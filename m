Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbWFBU2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWFBU2E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWFBU2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:28:04 -0400
Received: from mx2.netapp.com ([216.240.18.37]:57861 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S932562AbWFBU2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:28:01 -0400
X-IronPort-AV: i="4.05,204,1146466800"; 
   d="scan'208"; a="384430462:sNHT17760972"
Subject: Re: lock_kernel called under spinlock in NFS
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: joe.korty@ccur.com
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, akpm@osdl.org,
       mingo@elte.hu
In-Reply-To: <20060602202436.GA4783@tsunami.ccur.com>
References: <20060601195535.GA28188@tsunami.ccur.com>
	 <1149192820.3549.43.camel@lade.trondhjem.org>
	 <20060602202436.GA4783@tsunami.ccur.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Fri, 02 Jun 2006 16:27:58 -0400
Message-Id: <1149280078.5621.63.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-OriginalArrivalTime: 02 Jun 2006 20:27:59.0556 (UTC) FILETIME=[0A234840:01C68683]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-02 at 16:24 -0400, Joe Korty wrote:
> On Thu, Jun 01, 2006 at 04:13:39PM -0400, Trond Myklebust wrote:
> > On Thu, 2006-06-01 at 15:55 -0400, Joe Korty wrote:
> >> Tree 5fdccf2354269702f71beb8e0a2942e4167fd992
> >> 
> >>         [PATCH] vfs: *at functions: core
> >> 
> >> introduced a bug where lock_kernel() can be called from
> >> under a spinlock.  To trigger the bug one must have
> >> CONFIG_PREEMPT_BKL=y and be using NFS heavily.  It is
> >> somewhat rare and, so far, haven't traced down the userland
> >> sequence that causes the fatal path to be taken.
> >> 
> >> The bug was caused by the insertion into do_path_lookup()
> >> of a call to file_permission().  do_path_lookup()
> >> read-locks current->fs->lock for most of its operation.
> >> file_permission() calls permission() which calls
> >> nfs_permission(), which has one path through it
> >> that uses lock_kernel().
> 
> > Nowhere should anyone be calling file_permission() under a spinlock.
> > 
> > Why would you need to read-protect current->fs in the case where you are
> > starting from a file? The correct thing to do there would appear to be
> > to read_protect only the cases where (*name=='/') and (dfd == AT_FDCWD).
> > 
> > Something like the attached patch...
> 
> 
> Hi Trond,
> I've been running with the patch for the last few hours, on an nfs-rooted
> system, and it has been working fine.  Any plans to submit this for 2.6.17?

It probably ought to be, given the nature of the sin. Andrew?

Cheers,
  Trond
