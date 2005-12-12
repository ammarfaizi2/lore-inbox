Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVLLURn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVLLURn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVLLURn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:17:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16023 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932215AbVLLURm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:17:42 -0500
Date: Mon, 12 Dec 2005 12:16:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] vm: enhance __alloc_pages to prioritize pagecache
 eviction when pressed for memory
Message-Id: <20051212121639.2e5bb1e4.akpm@osdl.org>
In-Reply-To: <20051212182236.GB828@hmsreliant.homelinux.net>
References: <20051207220401.GB13577@hmsreliant.homelinux.net>
	<20051209162901.71728620.akpm@osdl.org>
	<20051212182236.GB828@hmsreliant.homelinux.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman <nhorman@tuxdriver.com> wrote:
>
> On Fri, Dec 09, 2005 at 04:29:01PM -0800, Andrew Morton wrote:
> > Neil Horman <nhorman@tuxdriver.com> wrote:
> > >
> > > Hey all-
> > >      I was recently shown this issue, wherein, if the kernel was kept full of
> > > pagecache via applications that were constantly writing large amounts of data to
> > > disk, the box could find itself in a position where the vm, in __alloc_pages
> > > would invoke the oom killer repetatively within try_to_free_pages, until such
> > > time as the box had no candidate processes left to kill, at which point it would
> > > panic.
> > 
> > That's pretty bad.  Are you able to provide a description which would permit
> > others to reproduce this?
> 
> As promised, heres the reproducer that was given to me, and used to reproduce
> this problem:
> 
> 1) setup an nfs serve with a thread count of 2.  Of course, 1 thread might make
> the problem more easy to reproduce.  I haven't tried it yet.
> 
> 2) Setup 4 nodes to hammer the nfs mounted directory.  The 4 nodes should hammer
> out 4 gigs.  2 gigs didn't seem to be enough.
> 
> I used a locally developed tool called ior to reproduce this problem.  The tool
> can be found here:
> 
> http://www.llnl.gov/asci/platforms/purple/rfp/benchmarks/limited/ior/
> 
> I suppose anything that can write to NFS fast should be fine.  But that's what I
> did.
> 
> 
> If you do this, any node writing to the server that has more than 4GB of RAM
> should start oom killing to the point where it runs out of candidate processes
> and panics

We merged an NFS fix last week which will help throttling under heavy
writeout conditions..
