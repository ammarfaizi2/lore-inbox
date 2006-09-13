Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbWIMAk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbWIMAk3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 20:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030440AbWIMAk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 20:40:29 -0400
Received: from smtp-out.google.com ([216.239.45.12]:16238 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030420AbWIMAk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 20:40:28 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=mI0RVPv5YhKwf45CB65riapQVdB/MYfkUtN9rtVa/Y8Ro3+UzvcOO1B7eFSa/IHG6
	GGwBh+B3MgaB3EOjjOHZg==
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters
	(v4)	(added	user	memory)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: sekharan@us.ibm.com
Cc: Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Kirill Korotaev <dev@sw.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1158105253.4800.20.camel@linuxchandra>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>
	 <1157743424.19884.65.camel@linuxchandra>
	 <1157751834.1214.112.camel@galaxy.corp.google.com>
	 <1157999107.6029.7.camel@linuxchandra>
	 <1158001831.12947.16.camel@galaxy.corp.google.com>
	 <1158003725.6029.60.camel@linuxchandra>
	 <1158019099.12947.102.camel@galaxy.corp.google.com>
	 <1158105253.4800.20.camel@linuxchandra>
Content-Type: text/plain
Organization: Google Inc
Date: Tue, 12 Sep 2006 17:39:08 -0700
Message-Id: <1158107948.20211.47.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 16:54 -0700, Chandra Seetharaman wrote:
> On Mon, 2006-09-11 at 16:58 -0700, Rohit Seth wrote:
> > On Mon, 2006-09-11 at 12:42 -0700, Chandra Seetharaman wrote:
> > > On Mon, 2006-09-11 at 12:10 -0700, Rohit Seth wrote:
> > > > On Mon, 2006-09-11 at 11:25 -0700, Chandra Seetharaman wrote:
> > 
> > > > > There could be a default container which doesn't have any guarantee or
> > > > > limit. 
> > > > 
> > > > First, I think it is critical that we allow processes to run outside of
> > > > any container (unless we know for sure that the penalty of running a
> > > > process inside a container is very very minimal).
> > > 
> > > When I meant a default container I meant a default "resource group". In
> > > case of container that would be the default environment. I do not see
> > > any additional overhead associated with it, it is only associated with
> > > how resource are allocated/accounted.
> > > 
> > 
> > There should be some cost when you do atomic inc/dec accounting and
> > locks for add/remove resources from any container (including default
> > resource group). No?
> 
> yes, it would be there, but is not heavy, IMO.

I think anything greater than 1% could be a concern for people who are
not very interested in containers but would be forced to live with them.

> > 
> > > > 
> > > > And anything running outside a container should be limited by default
> > > > Linux settings.
> > > 
> > > note that the resource available to the default RG will be (total system
> > > resource - allocated to RGs).
> > 
> > I think it will be preferable to not change the existing behavior for
> > applications that are running outside any container (in your case
> > default resource group).
> 
> hmm, when you provide QoS for a set of apps, you will affect (the
> resource availability of) other apps. I don't see any way around it. Any
> ideas ?

When I say, existing behavior, I mean not getting impacted by some
artificial limits that are imposed by container subsystem.  IOW, if a
sysadmin is okay to have certain apps running outside of container then
he is basically forgoing any QoS for any container on that system.

>  
> > 
> > > > 
> > > > > When you create containers and assign guarantees to each of them
> > > > > make sure that you leave some amount of resource unassigned. 
> > > >                            ^^^^^ This will force the "default" container
> > > > with limits (indirectly). IMO, the whole guarantee feature gets defeated
> > > 
> > > You _will_ have limits for the default RG even if we don't have
> > > guarantees.
> > > 
> > > > the moment you bring in this fuzziness.
> > > 
> > > Not really. 
> > >  - Each RG will have a guarantee and limit of each resource. 
> > >  - default RG will have (system resource - sum of guarantees)
> > >  - Every RG will be guaranteed some amount of resource to provide QoS
> > >  - Every RG will be limited at "limit" to prevent DoS attacks.
> > >  - Whoever doesn't care either of those set them to don't care values.
> > > 
> > 
> > For the cases that put this don't care, do you depend on existing
> > reclaim algorithm (for memory) in kernel?
> 
> Yes.

So one container with these don't care condition(s) can turn the whole
guarantee thing bad.  Because existing kernel reclaimer does not know
about memory commitments to other containers.  Right?

> > 
> > > > 
> > > > > That
> > > > > unassigned resources can be used by the default container or can be used
> > > > > by containers that want more than their guarantee (and less than their
> > > > > limit). This is how CKRM/RG handles this issue.
> > > > > 
> > > > >  
> > > > 
> > > > It seems that a single notion of limit should suffice, and that limit
> > > > should more be treated as something beyond which that resource
> > > > consumption in the container will be throttled/not_allowed.
> > > 
> > > As I stated in an earlier email "Limit only" approach can prevent a
> > > system from DoS attacks (and also fits the container model nicely),
> > > whereas to provide QoS one would need guarantee.
> > > 
> > > Without guarantee, a RG that the admin cares about can starve if
> > > all/most of the other RGs consume upto their limits.
> > > 
> > > > 
> > 
> > If the limits are set appropriately so that containers total memory
> > consumption does not exceed the system memory then there shouldn't be
> > any QoS issue (to whatever extent it is applicable for specific
> > scenario).
> 
> Then you will not be work-conserving (IOW over-committing), which is one
> of the main advantage of this type of feature.
> 

If for the systems where QoS is important, not over-committing will be
fine (at least to start with).

-rohit

