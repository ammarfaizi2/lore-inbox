Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbUDDVvi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 17:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbUDDVvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 17:51:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:54971 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262840AbUDDVvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 17:51:37 -0400
Date: Sun, 4 Apr 2004 14:51:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.5-aa1 arch updates
Message-Id: <20040404145126.03156a15.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0404041446430.22502-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0404041446430.22502-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> I notice that's a __GFP_REPEAT allocation, but even those fail when
>  OOM-killed - I find its alias __GFP_NOFAIL very misleading.

#define __GFP_REPEAT	0x400	/* Retry the allocation.  Might fail */
#define __GFP_NOFAIL	0x800	/* Retry for ever.  Cannot fail */

__GFP_REPEAT is mainly for higher-order allocations which would otherwise
have given up too early.

__GFP_NOFAIL means "the caller is lame and cannot handle a failure".

Yes, they're the same thing at present.  But if someone chooses to change
the page allocator so that it returns 0 on exhaustion rather than
oom-killing, these two things become different - the altered page allocator
should continue to loop-until-success on __GFP_NOFAIL allocations.

I guess this means that __GFP_NOFAIL allocators shouldn't be oom-killed.
