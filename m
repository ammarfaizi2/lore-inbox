Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262992AbUKYASF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262992AbUKYASF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 19:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbUKYAQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 19:16:06 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:49848 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262943AbUKYAOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 19:14:46 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 25 Nov 2004 11:14:39 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16805.9199.955186.236115@cse.unsw.edu.au>
Cc: phil@dier.us, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm,
 and xfs
In-Reply-To: message from Andrew Morton on Wednesday November 24
References: <20041122130622.27edf3e6.phil@dier.us>
	<20041122161725.21adb932.akpm@osdl.org>
	<16805.5470.892995.589150@cse.unsw.edu.au>
	<20041124155038.3716b8a5.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 24, akpm@osdl.org wrote:
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> >
> > Would the following (untested-but-seems-to-compile -
> > explanation-of-concept) patch be at all reasonable to avoid stack
> > depth problems with stacked block devices, or is adding stuff to
> > task_struct frowned upon? 
> 
> It's always a tradeoff - we've put things in task_struct before to get
> around sticky situations.  Certainly, removing potentially unbounded stack
> utilisation is a worthwhile thing to do.
> 
> The patch bends my brain a bit.

Recursion is like that (... like recursion, that is :-).

>                                   Shouldn't the queueing happen in
> submit_bio()?

Both md and dm call generic_make_request rather than submit_bio to
start IO on slaves, so it wouldn't work in submit_bio.  If dm and md
were changes to use submit_bio, then the counts (page-in, page-out)
would be quite different...

> 
> Is bi_next free in there?  If anyone tries to do synchronous I/O things
> will get stuck.

It is my understanding the bi_next is free.  It is available for use
by ->make_request_fn and below. __make_request uses it for chaining
bio's together  into a request.  raid5 uses it for other things.

If a ->make_request_fn did synchronous IO things would definitely get
unstuck.   But I don't think they should and doubt if they do (md
certainly doesn't).

NeilBrown
