Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbWJFWlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWJFWlP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 18:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbWJFWlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 18:41:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48512 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932652AbWJFWlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 18:41:14 -0400
Date: Fri, 6 Oct 2006 15:40:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Steve Dickson <SteveD@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM: Fix the gfp_mask in invalidate_complete_page2
Message-Id: <20061006154058.4190075f.akpm@osdl.org>
In-Reply-To: <1160173167.12253.17.camel@lade.trondhjem.org>
References: <1160170629.5453.34.camel@lade.trondhjem.org>
	<4526CF6F.9040006@RedHat.com>
	<1160172990.12253.14.camel@lade.trondhjem.org>
	<1160173167.12253.17.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2006 18:19:27 -0400
Trond Myklebust <Trond.Myklebust@netapp.com> wrote:

> On Fri, 2006-10-06 at 18:16 -0400, Trond Myklebust wrote:
> > Yeah using mapping_gfp_mask(mapping) sounds like a better option.
> 
> Revised patch is attached...

Well, it wasn't attached, but I can simulate it.

invalidate_complete_page() wants to be called from inside spinlocks by
drop_pagecache(), so if we wanted to pull the same trick there we'd need to
pass a new flag into invalidate_inode_pages().

It's not 100% clear what the gfp_t _means_ in the try_to_release_page()
context.  Callees will rarely want to allocate memory (true?).  So it
conveys two concepts: 

a) can sleep. (__GFP_WAIT).  That's fairly straightforward

b) can take fs locks (__GFP_FS).  This is less clear.  By passing down
   __GFP_FS we're telling the callee that it's OK to take i_mutex, even
   lock_page().  That sounds pretty unsafe in this context, particularly
   the latter, as we're already holding a page lock.

So perhaps the safer and more appropriate solution here is to pass in a
bare __GFP_WAIT.

