Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268164AbUHKSqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268164AbUHKSqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 14:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268167AbUHKSqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 14:46:17 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:56291 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S268164AbUHKSqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 14:46:05 -0400
Subject: RE: [Linux-cluster] Re: [cgl_discussion] Re: [dcl_discussion]
	Clustersummit materials
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: "Walker, Bruce J" <bruce.walker@hp.com>, linux-kernel@vger.kernel.org
Cc: Discussion of clustering software components including
	 GFS <linux-cluster@redhat.com>,
       Chris Wright <chrisw@osdl.org>, dcl_discussion@osdl.org,
       cgl_discussion@osdl.org
In-Reply-To: <3689AF909D816446BA505D21F1461AE4C75110@cacexc04.americas.cpqcorp.net>
References: <3689AF909D816446BA505D21F1461AE4C75110@cacexc04.americas.cpqcorp.net>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1092249962.4717.21.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 11 Aug 2004 11:46:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-11 at 11:19, Walker, Bruce J wrote:
> > * John Cherry (cherry@osdl.org) wrote:
> > At the summit I attended, we also talked about using GFS as the
> initial
> > "consumer" of the cluster infrastructure.  The cluster infrastructure
> > doesn't stand a chance of mainline acceptance without a consumer that
> > both validates the interfaces and hardens the services.
> 
> Given cman etc. was written for GFS, it doesn't prove much that it works
> with GFS.  Having an independent cluster effort (like OpenSSI) use the
> underlying infrastructure presents a much more compelling case.  The
> OpenSSI project has started to look into this but help from OSDL, Intel
> and/or RedHat wouldn't be discouraged.  Also, having SAF layered and/or
> ha-linux layered would also bolster the case as a general
> infrastructure.
> 
> Bruce walker
> OpenSSI project lead
> 
> 

Bruce,

I have looked over the cman protocol and find it is suboptimal.  Here is
how it works: it sends a message using multicast, adds a timeout for the
message, and waits for an acknowledgement from every node in the
system.  Once the timer expires, it resends the message.  If every node
responds, it deletes the timer.

This sort of protocol wont scale (imagine an ack from 32 nodes for every
message sent, and you can understand why) and wont work within
partitionable networks (some messages may be delivered to some in the
partition and not others).  It doesn't provide any sort of strong
membership guarantees (the same message may be delivered under various
membership views) or delivery guarantees (messages only have FIFO
guarantees, when distributed systems require agreed or safe ordering).

I am not sure if you have seen the openais project at
http://developer.osdl.org/dev/openais.  It is a userland implementation
of the SA Forum's AIS interfaces.  The openais project uses a technology
called virtual synchrony to provide cluster messaging and solves the
above problems.  The current protocol can obtain upwards of 7MB/sec
multicast transfer from 1 node to 8 nodes with encryption and
authentication.  We use encryption and MAC to ensure security.  If you
want to see the group messaging api, look at exec/gmi.h from the source
on the above website.

If we can't live with the cluster services in userland (although I'm
still not convinced), then atleast the group messaging protocol in the
kernel could be based upon 20 years of research in group messaging and
work properly under _all_ fault scenarios.

I'd invite you or other interested parties, to port the openais code for
virtual synchrony to the kernel.  I'd do it myself, but I'm focused on
implementing openais.  Then, if the protocols ended up living in kernel
space, atleast the protocols would be secure and be able to meet the
needs of all users (including cluster userland services).  The group
messaging protocol code is compact (about 3500 lines).  I'd expect with
the address family kernel stuff, it would increase to 4500 or so.

Regards
-steve

> 
> 
> 
> ______________________________________________________________________
> _______________________________________________
> cgl_discussion mailing list
> cgl_discussion@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/cgl_discussion

