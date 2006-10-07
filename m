Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423056AbWJGCda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423056AbWJGCda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 22:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423059AbWJGCd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 22:33:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4542 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423056AbWJGCd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 22:33:29 -0400
Date: Fri, 6 Oct 2006 19:33:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steve Dickson <SteveD@redhat.com>
Cc: Trond Myklebust <Trond.Myklebust@netapp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM: Fix the gfp_mask in invalidate_complete_page2
Message-Id: <20061006193311.a2916dff.akpm@osdl.org>
In-Reply-To: <4526E229.2020707@RedHat.com>
References: <1160170629.5453.34.camel@lade.trondhjem.org>
	<4526CF6F.9040006@RedHat.com>
	<1160172990.12253.14.camel@lade.trondhjem.org>
	<1160173167.12253.17.camel@lade.trondhjem.org>
	<20061006154058.4190075f.akpm@osdl.org>
	<4526E229.2020707@RedHat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2006 19:09:29 -0400
Steve Dickson <SteveD@redhat.com> wrote:

> > 
> > It's not 100% clear what the gfp_t _means_ in the try_to_release_page()
> > context.  Callees will rarely want to allocate memory (true?).  So it
> > conveys two concepts: 
> > 
> > a) can sleep. (__GFP_WAIT).  That's fairly straightforward
> > 
> > b) can take fs locks (__GFP_FS).  This is less clear.  By passing down
> >    __GFP_FS we're telling the callee that it's OK to take i_mutex, even
> >    lock_page().  That sounds pretty unsafe in this context, particularly
> >    the latter, as we're already holding a page lock.
> > 
> > So perhaps the safer and more appropriate solution here is to pass in a
> > bare __GFP_WAIT.
> I agree... __GFP_WAIT does seem to be a bit more straightforward...
> either way is find.. as long as it cause NFS to flush its pages...

Except NFS looks at __GFP_FS, so __GFP_WAIT won't help.

Oh well.  Passing __GFP_FS in here sort-of implies that it's OK to run
lock_page(), but if a ->releasepage() impementation tries to lock the page
it's passed then it needs its head read.

I made it GFP_KERNEL.
