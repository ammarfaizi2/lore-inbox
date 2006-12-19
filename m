Return-Path: <linux-kernel-owner+w=401wt.eu-S932929AbWLSUDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932929AbWLSUDu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 15:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932927AbWLSUDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 15:03:50 -0500
Received: from twinlark.arctic.org ([207.29.250.54]:55922 "EHLO
	twinlark.arctic.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932929AbWLSUDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 15:03:49 -0500
Date: Tue, 19 Dec 2006 12:03:48 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612191159540.29238@twinlark.arctic.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins> <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
 <45876C65.7010301@yahoo.com.au> <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006, Linus Torvalds wrote:

> On Tue, 19 Dec 2006, Nick Piggin wrote:
> > 
> > We never want to drop dirty data! (ignoring the truncate case, which is
> > handled privately by truncate anyway)
> 
> Bzzt.
> 
> SURE we do.
> 
> We absolutely do want to drop dirty data in the writeout path.
> 
> How do you think dirty data ever _becomes_ clean data?
> 
> In other words, yes, we _do_ want to test-and-clear all the pgtable bits 
> _and_ the PG_dirty bit. We want to do it for:
>  - writeout
>  - truncate
>  - possibly a "drop" event (which could be a case for a journal entry that 
>    becomes stale due to being replaced or something - kind of "truncate" 
>    on metadata)
> 
> because both of those events _literally_ turn dirty state into clean 
> state.
> 
> In no other circumstance do we ever want to clear a dirty bit, as far as I 
> can tell. 

i admit this may not be entirely relevant, but it seems like a good place 
to bring up an old problem:  when a disk dies with lots of queued writes 
it can totally bring a system to its knees... even after the disk is 
removed.  i wrote up something about this a while ago:

http://lkml.org/lkml/2005/8/18/243

so there's another reason to "clear a dirty bit"... well, in fact -- drop 
the pages entirely.

-dean
