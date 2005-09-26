Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbVIZLLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbVIZLLV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 07:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVIZLLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 07:11:21 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:61640 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751042AbVIZLLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 07:11:20 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/3][Fix] swsusp: prevent swsusp from failing if there's too many pagedir pages
Date: Mon, 26 Sep 2005 13:11:28 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200509252018.36867.rjw@sisk.pl> <200509252044.00928.rjw@sisk.pl> <20050926103336.GA3693@elf.ucw.cz>
In-Reply-To: <20050926103336.GA3693@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509261311.29269.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 26 of September 2005 12:33, Pavel Machek wrote:
> Hi!
> 
> > There's a silent assumption in swsusp that always
> > sizeof(struct swsusp_info) <= PAGE_SIZE, which is wrong, because
> > eg. on x86-64 sizeof(swp_entry_t) = 8.  This causes swsusp to skip some pagedir
> > pages while reading the image if there are too many of them (depending on the
> > architecture, approx. 500 on x86-64).
> 
> Last time I did the math, swsusp_info could cover a *lot* of
> memory. It was wrong not to check for overflow, but I do not think we
> want to introduce *yet another* linklist.

Yes, I thought of another solution, but any of them would require more
than one swap page and I'd have to track the swap offsets of them somehow.

> Lets see...
> 
> for i386, we have 768 pagedir entries. Each pagedir entry points to
> page with 1023 pointers to pages. That means that up-to 768*1023*4096
> bytes image can be saved to swap ~= 768 * 1K * 4K ~= 3 GB. That's more
> than enough for i386.
> 
> for x86-64, we can have 128 pagedir entries (could not we fit more
> there? 384 entries should fit, no?).

Yes.  To be exact, 460.

> Each pagedir entry has 511 pointers to pages (IIRC)...

512, I think.

> that is up-to 128*511*4K ~= 64*1K*4K = 256 MB image.
> Hmm, that should still be enough for any 512MB machine, and 
> probably okay for much bigger machines, too...
> 
> We can still get to 768 MB image (good enough for any 1.5GB machine,
> and probably for anything else, too).
> 
> If that is not good enough for you, can you simply allocate more than
> 1 page for swsusp_info? No need for linklists yet.

I can.  The problem is I have to track the swap offsets of these pages
which is necessary for resume.  Is it guaranteed that the swap offsets
of pages allocated in a row will be consecutive?

> Andrew, please drop this one. It is too complex solution for quite a
> simple problem.

Perhaps it is.  Anyway the problem hit me when I was playing with swsusp on
a machine with 768 MB of RAM.

Greetings,
Rafael
