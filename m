Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbUCTRkE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 12:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263485AbUCTRkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 12:40:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:26784 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263484AbUCTRkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 12:40:00 -0500
Date: Sat, 20 Mar 2004 09:39:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
In-Reply-To: <20040320133025.GH9009@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0403200937500.1106@ppc970.osdl.org>
References: <20040320133025.GH9009@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Mar 2004, Andrea Arcangeli wrote:
>
> The only bugreport I've got so far for the latest anon_vma code is from
> Jens, and it's a device driver bug in my opinion, but I'd like to have a
> definitive confirmation from you about the ->nopage API.

I'd say that this is definitely a driver bug.

If a driver wants to map non-RAM pages, that's perfectly ok, but it MUST 
NOT happen through "nopage()". The driver should map them with 
"remap_page_range()", and thus never take a page fault for such pages at 
all.

There is no reason to ever lazily map non-RAM pages - clearly they aren't 
using any "real memory", so there is no reason to not fill the page tables 
at mmap() time.

In other words, the driver is horribly broken.

		Linus
