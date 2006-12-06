Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937532AbWLFTgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937532AbWLFTgo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937559AbWLFTgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:36:43 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:42014 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937503AbWLFTgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:36:42 -0500
Date: Wed, 6 Dec 2006 12:36:41 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Christoph Lameter <clameter@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061206193641.GY3013@parisc-linux.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org> <20061206192647.GW3013@parisc-linux.org> <Pine.LNX.4.64.0612061128340.27363@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612061128340.27363@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 11:29:42AM -0800, Christoph Lameter wrote:
> On Wed, 6 Dec 2006, Matthew Wilcox wrote:
> 
> > It's just been pointed out to me that the parisc one isn't safe.
> > 
> > <dhowells> imagine variable X is set to 3
> > <dhowells> CPU A issues cmpxchg(&X, 3, 5)
> > <dhowells> you'd expect that to change X to 5
> > <dhowells> but what if CPU B assigns 6 to X between cmpxchg reading X
> > and it setting X?
> 
> The same could happen with a regular cmpxchg. Cmpxchg changes it to 5 and 
> then other cpu performs a store before the next instruction.

For someone who's advocating use of cmpxchg, it seems you don't
understand its semantics!  In the scenario dhowells pointed out, X would
be left set to 5.  X should have the value 6 under any legitimate
implementation:

CPU A		CPU B
cmpxchg(3,5)
		X = 6


CPU A		CPU B
		X = 6
cmpxhcg(3,5)


CPU A
cmpxchg(3,
		X = 6
5)


Given that even yourself got confused about how to use it, perhaps it's
not a good idea to expose this primitive to most programmers anyway?
