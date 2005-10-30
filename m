Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVJ3WhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVJ3WhU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 17:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVJ3WhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 17:37:20 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:22963 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932375AbVJ3WhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 17:37:18 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/3] swsusp: move snapshot-handling functions to snapshot.c
Date: Sun, 30 Oct 2005 23:37:41 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200510301637.48842.rjw@sisk.pl> <200510302216.17413.rjw@sisk.pl> <20051030212832.GB19284@elf.ucw.cz>
In-Reply-To: <20051030212832.GB19284@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510302337.41526.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 30 of October 2005 22:28, Pavel Machek wrote:
> Hi!
}-- snip --{
> > Please note that the relocating code uses the page flags to mark the allocated
> > pages as well as to avoid the pages that should not be used.  In my opinion
> > no userspace process should be allowed to fiddle with the page
> > flags.
> 
> Of course, userspace would have to use separate data structure. [Hash table?]

IMO a bitmap could be used.  Anyway in that case the x86-64 arch code
would need to have access either to this structure or to the image metadata,
because it must figure out which pages are not safe.  I don't see any simple
way of making this work ...

> > Moreover, get_safe_page() is called directly by the arch code on x86-64,
> > so it has to stay in the kernel and hence it should be in snapshot.c.
> > OTOH the relocating code is nothing more than "if the page is not safe,
> > use get_safe_page() to allocate one" kind of thing, so I don't see a point
> > in taking it out of the kernel (in the future) too.
> 
> Well... for resume. If userspace does the allocation, it is:
> 
> userspace reads image
> userspace relocates it
> sys_atomic_restore(image)
> if something goes wrong, userspace is clearly responsible for freeing
> it.
> 
> How would you propose kernel<->user interface?
> 
> userspace reads pagedir
> sys_these_pages_are_forbidden(pagedir)
> userspace reads rest
> sys_atomic_restore(image)
> if something goes wrong, userspace must dealocate pages _and_ clear
> forbidden flags?

Well, you have taken these things out of context.  Namely, the userspace
process cannot freeze the other tasks, suspend devices etc., so it has to
call the kernel for these purposes anyway.  Of course if something goes
wrong it has to call the kernel to revert these steps too.  Similarly it
can call the kernel to allocate the image memory and to free it in case
something's wrong.  For example, if the userspace initiates the resume:

- if (image not found)
	exit
- sys_freeze_processes /* this one will be tricky ;-) */
- sys_create_pagedir
- while (image data) {
	sys_put_this_stuff_where_appropriate(image data);
	/* Here the kernel will do the relocation etc. if necessary */
	if (something's wrong)
		goto Cleanup; }
- sys_atomic_restore /* suspend devices, disable IRQs, restore */
Cleanup: /* certainly something's gone wrong */
- sys_destroy_pagedir /* that's it */
- sys_resume_devices
- sys_thaw_processes

> > > That should simplify error handling at least: data structures
> > > needed for relocation can be kept in userspace memory,
> > 
> > Well, after the patches that are already in -mm we don't use any additional
> > data structures for this purpose, so that's not a problem, I
> > think. ;-)
> 
> Until someone will want to get page flag bits back ;-), ok.

In that case we'll have to redesign the snapshot part top-down anyway.

Greetings,
Rafael
