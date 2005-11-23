Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbVKWWN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbVKWWN5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbVKWWN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:13:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26013 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932571AbVKWWN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:13:56 -0500
Date: Wed, 23 Nov 2005 14:13:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andi Kleen <ak@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
In-Reply-To: <1132783540.13095.23.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0511231411220.13959@g5.osdl.org>
References: <437B5A83.8090808@suse.de> <438359D7.7090308@suse.de> 
 <p7364qjjhqx.fsf@verdi.suse.de>  <1132764133.7268.51.camel@localhost.localdomain>
  <20051123163906.GF20775@brahms.suse.de>  <1132766489.7268.71.camel@localhost.localdomain>
  <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org>  <4384AECC.1030403@zytor.com>
  <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>  <1132782245.13095.4.camel@localhost.localdomain>
  <20051123211353.GR20775@brahms.suse.de> <1132783540.13095.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Nov 2005, Alan Cox wrote:
>
> On Mer, 2005-11-23 at 22:13 +0100, Andi Kleen wrote:
> > The idea was to turn LOCK on only if the process has any
> > shared writable mapping and num_online_cpus() > 0.
> 
> That makes a lot of sense, and if we hit hardware that does funky stuff
> then the driver can set a 'vma needs lock' bit for the same effect.
> 
> > Might be a bit costly to rewrite all the page tables for that case
> > just to change the PAT index.  A bit is nicer for that.
> 
> CPU insert/remove is performed how many times a second ? Or for that
> matter why not just reload the PAT register and keep the index the
> same ?

It's not about CPU insert/remove.

It's about a single-threaded process becoming multi-threaded, ie a simple 
"clone()" operation (or doing a shared mmap).

So it needs to be _fast_. 

I would strongly argue that it's not a TLB/PAT operation at all. It has 
nothing to do with the address of the operation. It's a global bit, and 
it's in the cr3 just because that's what gets reloaded on task switching. 
But it could be in the CS register too, for all I care..

		Linus
