Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWBFWYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWBFWYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWBFWYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:24:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43909 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932388AbWBFWYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:24:46 -0500
Date: Mon, 6 Feb 2006 14:26:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: ak@suse.de, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: OOM behavior in constrained memory situations
Message-Id: <20060206142638.104ec9eb.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0602061410160.18919@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com>
	<20060206131026.53dbd8d5.akpm@osdl.org>
	<Pine.LNX.4.62.0602061410160.18919@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Mon, 6 Feb 2006, Andrew Morton wrote:
> 
> > Do we really want to kill the application?  A more convetional response
> > would be to return NULL from the page allocator and let that trickle back.
> 
> Ok. But ultimately that will lead to a application fault or the 
> termination of the application .

Yup.  The application gets to decide what to do if its stat() or read() or
whatever failed.

> > The hugepage thing is special, because it's a pagefault, not a syscall.
> 
> The same can happen if a pagefault occurs in the application but the page 
> allocator cannot satisfy the allocation. At that point we need to 
> determine if the allocation was restricted. If so then we are not really 
> in an OOM situation and the app could be terminated.
>

Not too sure what you mean here.

The current behaviour of a oom-in-pagefault is to kill the caller via
do_exit(SIGKILL).  (Perhaps hugetlbpages should be doing that too).

If the page allocator decides "hey, this was a restricted allocation
attempt and we cannot satisfy it" then it should return NULL and if it's a
pagefault the app will do the do_exit(SIGKILL).  If it's a syscall, that
syscall will return an error indication (and there's a decent chance that
the application will then misbehave, but that's life).

