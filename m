Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbUKITv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbUKITv6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 14:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbUKITv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 14:51:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:52120 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261652AbUKITvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 14:51:33 -0500
Date: Tue, 9 Nov 2004 11:51:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@novell.com>
Cc: shaggy@austin.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zap_pte_range should not mark non-uptodate pages dirty
Message-Id: <20041109115122.767f923f.akpm@osdl.org>
In-Reply-To: <20041109144659.GC17639@x30.random>
References: <20041021223613.GA8756@dualathlon.random>
	<20041021160233.68a84971.akpm@osdl.org>
	<20041021232059.GE8756@dualathlon.random>
	<20041021164245.4abec5d2.akpm@osdl.org>
	<20041022003004.GA14325@dualathlon.random>
	<20041022012211.GD14325@dualathlon.random>
	<20041021190320.02dccda7.akpm@osdl.org>
	<20041022161744.GF14325@dualathlon.random>
	<20041022162433.509341e4.akpm@osdl.org>
	<1100009730.7478.1.camel@localhost>
	<20041109144659.GC17639@x30.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@novell.com> wrote:
>
> On Tue, Nov 09, 2004 at 08:15:30AM -0600, Dave Kleikamp wrote:
>  > Andrew & Andrea,
>  > What is the status of this patch?  It would be nice to have it in the
>  > -mm4 kernel.
> 
>  I think we should add an msync in front of O_DIRECT reads too (msync
>  won't hurt other users, and it'll provide full coherency), everything
>  else is ok (the msync can be added as an incremental patch).

I don't think we have a simple way of syncing all ptes which map the pages
without actually shooting those pte's down, via zap_page_range().  A
filemap_sync() will only sync the caller's mm's ptes.

I guess it would be pretty simple to add a sync_but_dont_unmap field to
struct zap_details, and propagate that down.  So we can reuse all the
unmap_vmas() code for an all-mms pte sync.

It could all get very expensive if someone has a bit of the file mapped
though.  Testing is needed there.

