Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWHDETN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWHDETN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 00:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWHDETN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 00:19:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60127 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030232AbWHDETN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 00:19:13 -0400
Date: Thu, 3 Aug 2006 21:18:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: greg@kroah.com, zach@vmware.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, hch@infradead.org, rusty@rustcorp.com.au,
       jlo@vmware.com, xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com, jeremy@goop.org
Subject: Re: A proposal - binary
Message-Id: <20060803211850.3a01d0cc.akpm@osdl.org>
In-Reply-To: <44D2B678.6060400@xensource.com>
References: <44D1CC7D.4010600@vmware.com>
	<20060803190605.GB14237@kroah.com>
	<44D24DD8.1080006@vmware.com>
	<20060803200136.GB28537@kroah.com>
	<44D2B678.6060400@xensource.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2006 19:52:40 -0700
Jeremy Fitzhardinge <jeremy@xensource.com> wrote:

> Greg KH wrote:
> > On Thu, Aug 03, 2006 at 12:26:16PM -0700, Zachary Amsden wrote:
> >   
> >> Who said that?  Please smack them on the head with a broom.  We are all 
> >> actively working on implementing Rusty's paravirt-ops proposal.  It 
> >> makes the API vs ABI discussion moot, as it allow for both.
> >>     
> >
> > So everyone is still skirting the issue, oh great :)
> >   

A reasonable summary.  A few touchups:

> I don't really think there's an issue to be skirted here.  The current 
> plan is to design and implement a paravirt_ops interface, which is a 
> typical Linux source-level interface between the bulk of the kernel and 
> a set of hypervisor-specific backends.  Xen, VMWare and other interested 
> parties are working together on this interface to make sure it meets 
> everyone's needs (and if you have another hypervisor you'd like to 
> support with this interface, we want to hear from you).
> 
> Until VMWare proposed VMI, Xen was the only hypervisor needing support, 
> so it was reasonable that the Xen patches just go straight to Xen.

No, even if vmware wasn't on the scene, the proposal to make the
Linux->hypervisor interface be specific to one hypervisor implementation is
a concern.  That would remain true if vmware were to suddenly vanish. 
It is a major interface, and interfaces are a major issue.

>  But 
> with paravirtops the result will be more flexible, since a kernel will 
> be configurable to run on any combination of supported hypervisor or on 
> bare hardware.
> 
> As far as I'm concerned, the issue of whether VMI has a stable ABI or 
> not is one which on the VMI side of the paravirtops interface, and it 
> doesn't have any wider implications.
> 
> Certainly Xen will maintain a backwards compatible hypervisor interface 
> for as long as we want/need to, but that's a matter for our side of 
> paravirtops.  And the paravirtops interface will change over time as the 
> kernel does, and the backends will be adapted to match, either using the 
> same ABI to the underlying hypervisor, or an expanded one, or whatever; 
> it doesn't matter as far as the rest of the kernel is concerned.
> 
> There's the other question of whether VMI is a suitable interface for 
> Xen, making the whole paravirt_ops exercise redundant.  Zach and VMWare 
> are claiming to have a VMI binding to Xen which is full featured with 
> good performance.  That's an interesting claim, and I don't doubt that 
> its somewhat true.  However, they haven't released either code for this 
> interface or detailed performance results, so its hard to evaluate.

That was a major goofup from a kernel-development-process POV.  They're
working hard to get that code out to us.

>  And 
> with anything in this area, its always the details that matter: what 
> tests, on what hardware, at what scale?  Does VMI really expose all of 
> Xen's features, or does it just use a bare-minimum subset to get things 
> going?  And how does the interface fit with short and long term design 
> goals?

This is a key issue and to some extent all bets are off until that code
emerges.  Because it could be that the VMI->Xen implementation works well,
and that any present shortcomings can be resolved with acceptable effort.

If that happens, it puts a cloud over paravirtops.

But we just don't know any of this until we can get that code into the
right people's hands.

> I don't think anybody is willing to answer these questions with any 
> confidence.  VMWare's initial VMI proposal was very geared towards their 
> particular hypervisor architecture; it has been modified over time to be 
> a little closer to Xen's model, in order to efficiently support the Xen 
> binding.  But Xen and ESX have very different designs and underlying 
> philosophies, so I wouldn't expect a single interface to fit comfortably 
> with either.

Maybe, maybe not.  Until we have an implementation to poke at this is all
speculation.  And it is most regrettable that we're being put in a position
where we are forced to speculate.

> As far as LKML is concerned, the only interface which matters is the 
> Linux -> <something> interface, which is defined within the scope of the 
> Linux development process.  That's what paravirt_ops is intended to be.

I must confess that I still don't "get" paravirtops.  AFACIT the VMI
proposal, if it works, will make that whole layer simply go away.  Which
is attractive.  If it works.

> And being a Linux API, paravirt_ops can avoid duplicating other Linux 
> interfaces. For example, VMI, like the Xen hypervisor interface, need 
> various ways to deal with time.  The rest of the kernel needn't know or 
> care about those interfaces, because the paravirt backend for each can 
> also register a clocksource, or use other kernel APIs to expose that 
> interface (some of which we'll probably develop/expand over time as 
> needed, but in the normal way kernel interfaces chance).
> 

