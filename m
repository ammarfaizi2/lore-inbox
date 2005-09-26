Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVIZKd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVIZKd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 06:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVIZKd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 06:33:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35992 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750704AbVIZKd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 06:33:56 -0400
Date: Mon, 26 Sep 2005 12:33:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/3][Fix] swsusp: prevent swsusp from failing if there's too many pagedir pages
Message-ID: <20050926103336.GA3693@elf.ucw.cz>
References: <200509252018.36867.rjw@sisk.pl> <200509252044.00928.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509252044.00928.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> There's a silent assumption in swsusp that always
> sizeof(struct swsusp_info) <= PAGE_SIZE, which is wrong, because
> eg. on x86-64 sizeof(swp_entry_t) = 8.  This causes swsusp to skip some pagedir
> pages while reading the image if there are too many of them (depending on the
> architecture, approx. 500 on x86-64).

Last time I did the math, swsusp_info could cover a *lot* of
memory. It was wrong not to check for overflow, but I do not think we
want to introduce *yet another* linklist.

Lets see...

for i386, we have 768 pagedir entries. Each pagedir entry points to
page with 1023 pointers to pages. That means that up-to 768*1023*4096
bytes image can be saved to swap ~= 768 * 1K * 4K ~= 3 GB. That's more
than enough for i386.

for x86-64, we can have 128 pagedir entries (could not we fit more
there? 384 entries should fit, no?). Each pagedir entry has 511
pointers to pages (IIRC)... that is up-to 128*511*4K ~= 64*1K*4K = 256
MB image. Hmm, that should still be enough for any 512MB machine, and
probably okay for much bigger machines, too...

We can still get to 768 MB image (good enough for any 1.5GB machine,
and probably for anything else, too).

If that is not good enough for you, can you simply allocate more than
1 page for swsusp_info? No need for linklists yet.

Andrew, please drop this one. It is too complex solution for quite a
simple problem.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
