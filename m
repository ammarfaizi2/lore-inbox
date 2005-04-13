Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVDMRq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVDMRq1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 13:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVDMRq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 13:46:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61059 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261172AbVDMRqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 13:46:13 -0400
Date: Wed, 13 Apr 2005 18:46:11 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] sound/oss/rme96xx.c: fix two check after use
Message-ID: <20050413174611.GU8859@parcelfarce.linux.theplanet.co.uk>
References: <3SGgN-41r-1@gated-at.bofh.it> <3SGA8-4n3-9@gated-at.bofh.it> <E1DLfIV-0000pl-Fa@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DLfIV-0000pl-Fa@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 12:40:38PM +0200, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> Al Viro <viro@parcelfarce.linux.theplanet.co.uk> wrote:
> > On Wed, Apr 13, 2005 at 04:17:42AM +0200, Adrian Bunk wrote:
> 
> >> This patch fixes two check after use found by the Coverity checker.
> > 
> > Bullshit.  ->private_data is set by rme96xx_open() to guaranteed non-NULL
> > and never changed elsewhere.  Same comment about reading the fscking
> > source, BUG_ON(), etc.
> 
> If there are checks, they should be there for a purpose, and any sane
> reader will asume these checks to be nescensary.

Really?  Even in "obviously buggy code"?

> If they are dead code, you
> can say that, but please don't flame Adrian for fixing obviously buggy code

...

> in a way that is sane and at least more correct than the original without
> using several days of his lifetime to analyze the whole driver.

Funny, that.  "several days" in this case boils down to grep for accesses
to that field in driver (and stuff #included from it).  Which yields exactly
one assignment (in ->open()).  Combined with understanding that
	a) ->open() is definitely going to be executed before any calls of
->read() and
	b) nothing in generic code ever touches ->private_data
	c) if rme96xx_open() returns 0, it will leave us with non-NULL
->private_data.

Five minutes total.  And no, "fix" did not give more correct code -
in all cases it yields exactly the same behaviour.  All it does is
	* shifting what in effect is if (0) {do something odd} from
one place to another
	* making the warning go away

Note that warning had (correctly) pointed to fishy logics in the driver.
Shutting it up and leaving the real problem intact (and hidden) is
not particulary useful.

> Instead, you
> could provide the correct fix.

"Remove bogus checks".
