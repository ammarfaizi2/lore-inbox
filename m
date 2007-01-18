Return-Path: <linux-kernel-owner+w=401wt.eu-S1750860AbXARHrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbXARHrA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 02:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbXARHq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 02:46:59 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:51151 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbXARHq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 02:46:59 -0500
Date: Thu, 18 Jan 2007 08:45:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
       Pierre Peiffer <pierre.peiffer@bull.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>, Jakub Jelinek <jakub@redhat.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>
Subject: Re: [PATCH 2.6.20-rc5 4/4] sys_futex64 : allows 64bit futexes
Message-ID: <20070118074556.GB29128@elte.hu>
References: <45ADDF60.5080704@bull.net> <45ADE6B5.8050402@bull.net> <20070118001758.GB17257@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118001758.GB17257@infradead.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.3 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Jan 17, 2007 at 10:04:53AM +0100, Pierre Peiffer wrote:
> > Hi,
> > 
> > This latest patch is an adaptation of the sys_futex64 syscall 
> > provided in -rt patch (originally written by Ingo). It allows the 
> > use of 64bit futex.
> 
> Big NACK here, we don't need yet another goddamn multiplexer.  Please 
> make this individual syscalls for the actual operations.

actually, we have a big multiplexer there already, so it's only 
symmetric. Nothing is served by doing it half-assed. I raised the issue 
of the multiplexer back when the first futex API was merged (years ago), 
and it was rejected. Now whether you like it or not we've got to live 
with that decision. You are certainly free to introduce a patchset with 
a completely new set of syscall vectors to demultiplex all futex APIs, 
but to just start a half-done demultiplexing makes zero sense.

> > +	if (!ret) {
> > +		switch (cmp) {
> > +		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
> > +		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
> 
> Please indent this properly, the ret = .. and reak need to go onto a 
> line on it's own.

this is the standard (already upstream) arithmetics style there for the 
futex cmp ops, and it expresses things in a compact way. See 
include/asm-i386/futex.h:

                switch (cmp) {
                case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
                case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
                case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
                case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
                case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
                case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
                default: ret = -ENOSYS;
                }

Pierre correctly matched the existing style.

	Ingo
