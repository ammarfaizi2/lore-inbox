Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbTJVHLd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 03:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbTJVHLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 03:11:31 -0400
Received: from dark.beer.net ([204.145.225.20]:26636 "EHLO dark.beer.net")
	by vger.kernel.org with ESMTP id S263457AbTJVHL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 03:11:29 -0400
Date: Wed, 22 Oct 2003 02:11:20 -0500 (CDT)
Message-Id: <200310220711.h9M7BKAf099719@dark.beer.net>
From: "Michael Glasgow" <glasgowNOSPAM@beer.net>
To: "Andy Lutomirski" <luto@stanford.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: posix capabilities inheritance
In-reply-to: <fa.f36f4t9.1rg8j3v@ifi.uio.no>
References: <fa.f36f4t9.1rg8j3v@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski wrote:
> 1. Can a process have capabilities in its inheritable set and not
> in its permitted set?  POSIX allows such processes to be created
> (pI = pP = full, then execute (fI = 0, fP = 0).

Sure, this is apparent to me in reading the spec.  I'm not exactly
sure if this is relavent though:  if pP = pE = 0, it does not seem
like it should be possible for pI=full to have any effect on exec,
unless I am missing something.

> Nevertheless, its pP evolution rule assumes that this never happens
> (pI capabilities can reappear).

Certainly with the current rule as implemented in 2.4, it looks as
though you can regain permitted flags: pP' = (fP & X) | (fI & pI)

Is this what you mean when you say they can reappear?  WRT the
spec itself, I don't see this assumption.  The rule could just as
easily be:  pP' = (fP & X) | (pP & fI & pI)  (just an example)
The rule in your patch seems like it should be compliant as well.

I'm not saying there aren't some problems to be worked out with
the spec; I think there are.  But I don't think this is a case of
the spec being broken per se -- just too vague.

> 2. If a process has pE < pP (i.e. some caps disabled, e.g. uid=0,
> euid!=0), and exec's fE=full, then its capabilities get re-enabled.
> This seems like a pretty serious breakage of userspace.

How is this any different from traditional *nix setuid semantics?
I suppose I can see your point somewhat if you are concerned
specifically about the case where pE < pP execs fE=full && fP=0,
but I am unconvinced this constitutes serious breakage.  On the
contrary, I think it seems most reasonable for those caps to be
reenabled, especially for caps where fI=1, but perhaps even when
fI=0.

I'm still looking over your patches to try to figure out how exactly
you think this stuff should work.  I'm glad to see someone out
there is thinking about this.  You're right, it's pretty complex
and still far from useable.

--
Michael Glasgow < glasgow at beer dot net >
