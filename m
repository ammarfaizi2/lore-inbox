Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbUBKGlL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 01:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUBKGlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 01:41:11 -0500
Received: from ns.suse.de ([195.135.220.2]:62445 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263564AbUBKGlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 01:41:04 -0500
Date: Fri, 13 Feb 2004 23:14:07 +0100
From: Andi Kleen <ak@suse.de>
To: Alex Pankratov <ap@swapped.cc>
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] [1/2] hlist: replace explicit checks of hlist
 fields w/ func calls
Message-Id: <20040213231407.208204c4.ak@suse.de>
In-Reply-To: <4029CB7B.3090409@swapped.cc>
References: <4029CB7B.3090409@swapped.cc>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004 22:28:11 -0800
Alex Pankratov <ap@swapped.cc> wrote:

> 
> Second patch removes if's from hlist_xxx() functions. The idea
> is to terminate the list not with 0, but with a pointer at a
> special 'null' item. Luckily a single 'null' can be shared
> between all hlists _without_ any synchronization, because its
> 'next' and 'pprev' fields are never read. In fact, 'next' is
> not accessed at all, and 'pprev' is used only for writing.

I disagree with this change. The problem is that in a loop
you need a register now to store the terminating element
and compare to it instead of just testing for zero. This can generate 
much worse code  on register starved i386 than having the conditional.

If you really want to avoid the conditional you could restructure
it so that i386 gcc can use a CMOV* (by using a pointer that either
points to a dummy or the target). But that would make the code
somewhat uglier and may not be worth it.

-Andi
