Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWC2WsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWC2WsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWC2WsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:48:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54732 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750810AbWC2WsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:48:07 -0500
Date: Wed, 29 Mar 2006 14:50:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: bharata@in.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: dcache leak in 2.6.16-git8 II
Message-Id: <20060329145013.37c87323.akpm@osdl.org>
In-Reply-To: <200603300026.59131.ak@suse.de>
References: <200603270750.28174.ak@suse.de>
	<200603271822.28043.ak@suse.de>
	<20060327190027.24498e3a.akpm@osdl.org>
	<200603300026.59131.ak@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Tuesday 28 March 2006 05:00, Andrew Morton wrote:
> > Andi Kleen <ak@suse.de> wrote:
> > >
> > > On Monday 27 March 2006 13:48, Bharata B Rao wrote:
> > > > On Mon, Mar 27, 2006 at 07:50:20AM +0200, Andi Kleen wrote:
> > > > > 
> > > > > A 2GB x86-64 desktop system here is currently swapping itself to death after
> > > > > a few days uptime.
> > > > > 
> > > > > Some investigation shows this:
> > > > > 
> > > > > inode_cache         1287   1337    568    7    1 : tunables   54   27    8 : slabdata    191    191      0
> > > > > dentry_cache      1867436 1867643    208   19    1 : tunables  120   60    8 : slabdata  98297  98297      0
> > > > > 
> > > > 
> > > > Would it be possible to try out this experimental patch which
> > > > gets some stats from the dentry cache ?
> > > 
> > > It should be trivial to reproduce by other people. Biggest workload
> > > is kernel compiles and quilt.
> > > 
> > > After a few hours with -git12 it's already at
> > > 
> > > dentry_cache      947013 952014    208   19    1 : tunables  120   60    8 : slabdata  50100  50106    480
> > > 
> > > and starting to go into swap.
> > > 
> > > I can't imagine I'm the only one seeing this?
> > > 
> > > I have a few x86-64 patches applied too, but they don't change anything
> > > in this area.
> > 
> > I don't think I can reproduce this on x86 uniproc.  (avtab_node_cache
> > is a different story - maintainers separately pinged).
> 
> 
> I got another OOM from this with -git13. Unfortunately it seems to take a few days at least
> to trigger.
> 
> dentry_cache      999168 1024594    208   19    1 : tunables  120   60    8 : slabdata  53926  53926      0 : shrinker stat 18522624 8871000
> 
> Hrm interesting is this one:
> 
> sock_inode_cache  996784 996805    704    5    1 : tunables   54   27    8 : slabdata 199361 199361      0
> 
> Most of the leaked dentries seem to be sockets. I didn't notice this earlier.
> 
> This was with the debugging patches applied btw. 
> 
> So maybe we have a socket leak?

It looks that way.  Didn't someone else report a sock_inode_cache leak?

> I still got a copy of the /proc in case anybody wants more information.

We have this fancy new /proc/slab_allocators now, it might show something
interesting.  It needs CONFIG_DEBUG_SLAB_LEAK.

