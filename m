Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWG3XBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWG3XBr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 19:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWG3XBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 19:01:47 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:49599 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964783AbWG3XBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 19:01:47 -0400
Subject: Re: 2.6.18-rc2-mm1 timer int 0 doesn't work
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Paul Fulghum <paulkf@microgate.com>,
       ak@muc.de, linux-kernel@vger.kernel.org, ebiederm@xmission.com
In-Reply-To: <20060729040337.GB29875@elte.hu>
References: <20060727015639.9c89db57.akpm@osdl.org>
	 <1154112276.3530.3.camel@amdx2.microgate.com>
	 <20060728144854.44c4f557.akpm@osdl.org> <20060728233851.GA35643@muc.de>
	 <1154132126.3349.8.camel@localhost.localdomain>
	 <1154135792.2557.7.camel@localhost.localdomain>
	 <20060728182450.8f5cbf76.akpm@osdl.org>  <20060729040337.GB29875@elte.hu>
Content-Type: text/plain
Date: Sun, 30 Jul 2006 19:00:57 -0400
Message-Id: <1154300457.10074.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-29 at 06:03 +0200, Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > 2.6.18-rc2 works fine with same config.
> > > 
> > > In this case the error is:
> > > 
> > > No per-cpu room for modules
> > 
> > yeah, sorry, that's a known problem which nobody appears to be doing 
> > anything about.  The expansion of NR_IRQS gobbles all the percpu 
> > memory in the kstat structure.
> 
> while the fundamental issue is the NR_IRQS problem which we'll fix 
> separately, Steve has a patchset to make percpu room dynamic:
> 
>   http://lkml.org/lkml/2006/4/14/137

That implementation was doomed because it added another dereference that
would kill numa implementations.  I implemented another version that
used page tables, but some people said that this would waste TLB
entries. See here

http://lwn.net/Articles/184103/

Perhaps another version that might be beneficial is one that mixes the
current approach with this one.  That is to have a dynamic page case
that would happen only after a default was exhausted.  And then we could
even warn about it if we don't like that. This way we can warn the user
if they don't like having the module's per_cpu files dynamically
allocated, which might slow down the system do to another TLB line
taken.

-- Steve
 

