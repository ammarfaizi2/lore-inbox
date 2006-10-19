Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161322AbWJSGDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161322AbWJSGDB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 02:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161326AbWJSGDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 02:03:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60132 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161322AbWJSGDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 02:03:00 -0400
Date: Wed, 18 Oct 2006 23:02:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "alpha @ steudten Engineering" <alpha@steudten.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: INFO: possible circular locking dependency detected
Message-Id: <20061018230243.6b40e8e8.akpm@osdl.org>
In-Reply-To: <4533980C.10403@yahoo.com.au>
References: <453391A4.5090100@steudten.org>
	<4533980C.10403@yahoo.com.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006 00:32:44 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> alpha @ steudten Engineering wrote:
> > =======================================================
> > [ INFO: possible circular locking dependency detected ]
> > 2.6.18-1.2189self #1
> > -------------------------------------------------------
> > kswapd0/186 is trying to acquire lock:
> >  (&inode->i_mutex){--..}, at: [<c0326e32>] mutex_lock+0x21/0x24
> > 
> > but task is already holding lock:
> >  (iprune_mutex){--..}, at: [<c0326e32>] mutex_lock+0x21/0x24
> > 
> > which lock already depends on the new lock.
> 
> Thanks. __grab_cache_page wants to clear __GFP_FS, because it is
> holding the i_mutex so we don't want to reenter the filesystem in
> page reclaim.

We want to be able to enter page reclaim while holding i_mutex.  Think what
the effect of not doing this would be upon write() (!)

This warning is more fallout from ntfs's insistence on taking i_mutex in
its clear_inode().  See lengthy and unproductive discussion at
http://lkml.org/lkml/2006/7/26/185 .

