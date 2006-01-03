Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWACTcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWACTcG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWACTcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:32:05 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:31975 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932491AbWACTcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:32:04 -0500
Date: Tue, 3 Jan 2006 11:30:53 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 6/9] clockpro-clockpro.patch
In-Reply-To: <20051231221215.GA4024@dmt.cnet>
Message-ID: <Pine.LNX.4.62.0601031129160.21019@schroedinger.engr.sgi.com>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
 <20051230224312.765.58575.sendpatchset@twins.localnet> <20051231002417.GA4913@dmt.cnet>
 <1136026117.17853.46.camel@twins> <20051231221215.GA4024@dmt.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2005, Marcelo Tosatti wrote:

> > > > + * res | h/c | tst | ref || Hcold | Hhot | Htst || Flt
> > > > + * ----+-----+-----+-----++-------+------+------++-----
> > > > + *  1  |  1  |  0  |  1  ||=1101  | 1100 |=1101 ||
> > > > + *  1  |  1  |  0  |  0  ||=1100  | 1000 |=1100 ||
> > > > + * ----+-----+-----+-----++-------+------+------++-----
> > > > + *  1  |  0  |  1  |  1  || 1100  | 1001 | 1001 ||
> > > > + *  1  |  0  |  1  |  0  ||X0010  | 1000 | 1000 ||
> > > > + *  1  |  0  |  0  |  1  || 1010  |=1001 |=1001 ||
> > > > + *  1  |  0  |  0  |  0  ||X0000  |=1000 |=1000 ||
> > > > + * ----+-----+-----+-----++-------+------+------++-----
> > > > + * ----+-----+-----+-----++-------+------+------++-----
> > > > + *  0  |  0  |  1  |  1  ||       |      |      || 1100
> > > > + *  0  |  0  |  1  |  0  ||=0010  |X0000 |X0000 ||
> > > > + *  0  |  0  |  0  |  1  ||       |      |      || 1010 
> > state table, it describes how (in the original paper) the three hands
> > modify the page state. Given the state in the first four columns, the
> > next three columns give a new state for each hand; hand cold, hot and
> > test. The last column describes the action of a pagefault.
> > 
> > Ex. given a resident cold page in its test period that is referenced
> > (1011):
> >  - Hand cold will make it 1100, that is, a resident hot page;
> >  - Hand hot will make it 1001, that is, a resident cold page with a
> > reference; and
> >  - Hand test will also make it 1001.
> > 
> > (The prefixes '=' and 'X' are used to indicate: not changed, and remove
> > from list - that can be either move from resident->non-resident or
> > remove altogether).
> 
> I see - can you add this info to the patch?

Hmm.. This looks as if it would be better to manage the page state as 
a bitmap rather than individual bits. Could we put this state in 
an integer variable and do an array lookup to get to the next state? 
