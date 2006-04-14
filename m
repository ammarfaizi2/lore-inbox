Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbWDNAqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWDNAqZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 20:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbWDNAqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 20:46:24 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60633 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965056AbWDNAqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 20:46:24 -0400
Date: Thu, 13 Apr 2006 17:46:11 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: hugh@veritas.com, linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 2/5] Swapless V2: Add migration swap entries
In-Reply-To: <20060413174232.57d02343.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604131743180.15965@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
 <20060413171331.1752e21f.akpm@osdl.org> <Pine.LNX.4.64.0604131728150.15802@schroedinger.engr.sgi.com>
 <20060413174232.57d02343.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2006, Andrew Morton wrote:

> Christoph Lameter <clameter@sgi.com> wrote:
> >
> > On Thu, 13 Apr 2006, Andrew Morton wrote:
> > 
> > > Christoph Lameter <clameter@sgi.com> wrote:
> > > >
> > > > +
> > > >  +	if (unlikely(is_migration_entry(entry))) {
> > > 
> > > Perhaps put the unlikely() in is_migration_entry()?
> > > 
> > > >  +		yield();
> > > 
> > > Please, no yielding.
> > > 
> > > _especially_ no unchangelogged, uncommented yielding.
> > 
> > Page migration is ongoing so its best to do something else first.
> 
> That doesn't help a lot.  What is "something else"?  What are the dynamics
> in there, and why do you feel that some sort of delay is needed?

Page migration is ongoing for the page that was faulted. This means 
the migration thread has torn down the ptes and replaced them with 
migration entries in order to prevent access to this page. The migration
thread is continuing the process of tearing down ptes, copying the page 
and then rebuilding the ptes.  When the ptes are back then the fault 
handler will no longer be invoked or it will fix up some of the bits in 
the ptes. This takes a short time, the more ptes point to a page the 
longer it will take to replace them.

