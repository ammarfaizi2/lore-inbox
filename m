Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267798AbUIJUya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267798AbUIJUya (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 16:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267810AbUIJUya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 16:54:30 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:56803 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S267798AbUIJUxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 16:53:54 -0400
Subject: Re: [Linux-cluster] New virtual synchrony API for the kernel: was
	Re: [Openais] New API in openais
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Discussion of clustering software components including
	 GFS <linux-cluster@redhat.com>,
       Daniel Phillips <phillips@redhat.com>, openais@lists.osdl.org,
       linux-ha-dev@lists.linux-ha.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040910175129.GT7359@marowsky-bree.de>
References: <1093941076.3613.14.camel@persist.az.mvista.com>
	 <1093973757.5933.56.camel@cherrybomb.pdx.osdl.net>
	 <1093981842.3613.42.camel@persist.az.mvista.com>
	 <200409011115.45780.phillips@redhat.com>
	 <1094104992.5515.47.camel@persist.az.mvista.com>
	 <20040910175129.GT7359@marowsky-bree.de>
Content-Type: text/plain; charset=UTF-8
Organization: MontaVista Software, Inc.
Message-Id: <1094849594.23862.184.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 10 Sep 2004 13:53:15 -0700
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-10 at 10:51, Lars Marowsky-Bree wrote:
> On 2004-09-01T23:03:12,
>    Steven Dake <sdake@mvista.com> said:
> 
> I've been pretty busy the last couple of days, so please bear with me
> for my late reply.
> 
> A virtual synchrony group messaging component would certainly be
> immensely helpful. As it pretty strongly ties to membership events (as
> you very correctly point out), I do think we need to review the APIs
> here.
> 
> Could you post some sample code and how / where you'd propose to merge
> it in?
> 

The virtual synchrony APIs I propose we start with can be reviewed at:

http://developer.osdl.org/dev/openais/htmldocs/index.html

There is a sample program using these interfaces at:

http://developer.osdl.org/dev/openais/src/test/testevs.c

> Also, again, I'm not sure this needs to be in the kernel. Do you have
> upper bounds of the memory consumption? Would the speed really benefit
> from being in the kernel?
> 
Right now, the entire openais project with all the services it provides
consumes 2MB of ram at idle.  I'd expect under load its about 3MB.  The
group messaging protocol portion of that uses perhaps 1 MB of ram.  It
will reject new messages if its buffers are full, so it cannot grow
wildly.

Your definately correct; a virtual syncrhony protocol doesn't absolutely
have to be in the kernel.  In fact, it is implemented today completely
in userland with 8.5MB/sec throughput to large groups with encryption
and authentication.

You could gain some network performance by ridding UDP from the IP
header, but this is only 8 bytes.

There is little performance gain in using the kernel (as basically, a
kernel thread/process would have to be created to operate the protocol).

The only point of a kernel virtual syncrhony API is to standardize on
one set of messaging APIs for the kernel projects that require messaging
(and at a higher level, distributed locks, fencing, etc).

We want to avoid is two seperate messaging protocols operating at the
same time (performance drain).

We also want to choose wisely the messaging model and protocol we use. 
If we don't, we could have problems later.

> OTOH, all other networking protocols such as TCP, SCTP or even IP/Sec
> live in kernel space, so clearly there's prior evidence of this being a
> reasonable idea.
> 
> 
> Sincerely,
>     Lars Marowsky-Brée <lmb@suse.de>

