Return-Path: <linux-kernel-owner+w=401wt.eu-S1752752AbWLSGfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbWLSGfk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 01:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbWLSGfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 01:35:40 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57882 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672AbWLSGfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 01:35:38 -0500
Date: Mon, 18 Dec 2006 22:34:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <45876C65.7010301@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins> <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
 <45876C65.7010301@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Dec 2006, Nick Piggin wrote:
> 
> We never want to drop dirty data! (ignoring the truncate case, which is
> handled privately by truncate anyway)

Bzzt.

SURE we do.

We absolutely do want to drop dirty data in the writeout path.

How do you think dirty data ever _becomes_ clean data?

In other words, yes, we _do_ want to test-and-clear all the pgtable bits 
_and_ the PG_dirty bit. We want to do it for:
 - writeout
 - truncate
 - possibly a "drop" event (which could be a case for a journal entry that 
   becomes stale due to being replaced or something - kind of "truncate" 
   on metadata)

because both of those events _literally_ turn dirty state into clean 
state.

In no other circumstance do we ever want to clear a dirty bit, as far as I 
can tell. 

			Linus
