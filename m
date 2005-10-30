Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbVJ3XEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVJ3XEZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 18:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVJ3XEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 18:04:25 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32916 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932394AbVJ3XEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 18:04:24 -0500
Date: Mon, 31 Oct 2005 00:04:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] swsusp: move snapshot-handling functions to snapshot.c
Message-ID: <20051030230407.GA1655@elf.ucw.cz>
References: <200510301637.48842.rjw@sisk.pl> <200510302216.17413.rjw@sisk.pl> <20051030212832.GB19284@elf.ucw.cz> <200510302337.41526.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510302337.41526.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Please note that the relocating code uses the page flags to mark the allocated
> > > pages as well as to avoid the pages that should not be used.  In my opinion
> > > no userspace process should be allowed to fiddle with the page
> > > flags.
> > 
> > Of course, userspace would have to use separate data structure. [Hash table?]
> 
> IMO a bitmap could be used.  Anyway in that case the x86-64 arch code
> would need to have access either to this structure or to the image metadata,
> because it must figure out which pages are not safe.  I don't see any simple
> way of making this work ...

Can you elaborate? resume is certainly going to get list of pbes...

> > > Moreover, get_safe_page() is called directly by the arch code on x86-64,
> > > so it has to stay in the kernel and hence it should be in snapshot.c.
> > > OTOH the relocating code is nothing more than "if the page is not safe,
> > > use get_safe_page() to allocate one" kind of thing, so I don't see a point
> > > in taking it out of the kernel (in the future) too.
> > 
> > Well... for resume. If userspace does the allocation, it is:
> > 
> > userspace reads image
> > userspace relocates it
> > sys_atomic_restore(image)
> > if something goes wrong, userspace is clearly responsible for freeing
> > it.
> > 
> > How would you propose kernel<->user interface?
> > 
> > userspace reads pagedir
> > sys_these_pages_are_forbidden(pagedir)
> > userspace reads rest
> > sys_atomic_restore(image)
> > if something goes wrong, userspace must dealocate pages _and_ clear
> > forbidden flags?
> 
> Well, you have taken these things out of context.  Namely, the userspace
> process cannot freeze the other tasks, suspend devices etc., so it
> has to

Yes, process freezing probably needs to be separate. Suspending
devices can well be part of atomic_snapshot operation; userspace does
not need to care.

> call the kernel for these purposes anyway.  Of course if something goes
> wrong it has to call the kernel to revert these steps too.  Similarly it
> can call the kernel to allocate the image memory and to free it in case
> something's wrong.  For example, if the userspace initiates the resume:
> 
> - if (image not found)
> 	exit
> - sys_freeze_processes /* this one will be tricky ;-) */

Why, I have it implemented? Just do not freeze the process calling you.

> - sys_create_pagedir

Ugly...

> - while (image data) {
> 	sys_put_this_stuff_where_appropriate(image data);
> 	/* Here the kernel will do the relocation etc. if necessary */
> 	if (something's wrong)
> 		goto Cleanup; }
> - sys_atomic_restore /* suspend devices, disable IRQs, restore */

Exactly. I'd like to go a

> Cleanup: /* certainly something's gone wrong */
> - sys_destroy_pagedir /* that's it */
> - sys_resume_devices

You should not need to do this one. resuming devices is going to be
integrated in atomic_restore, because suspending devices is there, too.

Here's how it looks... additionaly, I have ioctl for getting one
usable page. It is true that I did not solve error paths, yet; I'll
certainly need some way to free memory, too. 

							Pavel

int
do_resume(void)
{
	kmem = open("/dev/kmem", O_RDWR | O_LARGEFILE);
	image_fd = open(image, O_RDWR);

	if (kmem < 0) {
		fprintf(stderr, "Could not open /dev/kmem: %m\n");
		return 1;
	}

	memset(&swsusp_info, 0, sizeof(swsusp_info));
	read(image_fd, &swsusp_info, sizeof(swsusp_info));
	resume.nr_copy_pages = swsusp_info.nr_copy_pages;

	if (strcmp("swsusp3", swsusp_info.signature))
		exit(0);
	if (lseek(image_fd, 0, SEEK_SET) != 0) {
		printf("Could not seek to kill sig: %m\n");
		exit(1);
	}
	if (write(image_fd, &zeros, sizeof(swsusp_info)) != sizeof(swsusp_info)) {
		printf("Could not write to kill sig: %m\n");
		exit(1);
	}
	if (fsync(image_fd)) {
		printf("Could not fsync to kill sig: %m\n");
		exit(1);
	}
	printf("Got image, %d pages, signature [%s]\n", resume.nr_copy_pages, swsusp_info.signature);

	alloc_pagedir(resume.nr_copy_pages);
	printf("Verifying allocated pagedir: %d pages\n", walk_chain(&resume, NULL));
	printf("swsusp: Reading pagedir ");
	walk_pages_chain(&resume, (void *) read_pagedir_one);
	printf("ok\n");

	/* Need to be done twice; so that forbidden_pages comes into effect */
	alloc_pagedir(resume.nr_copy_pages);
	printf("Verifying allocated pagedir: %d pages\n", walk_chain(&resume, NULL));
	printf("swsusp: Reading pagedir ");
	walk_pages_chain(&resume, (void *) read_pagedir_one);
	printf("ok\n");

	printf("Verifying allocated pagedir: %d pages\n", walk_chain(&resume, NULL));

	/* FIXME: Need to relocate pages */
	mod = swsusp_info.nr_copy_pages / 100;
	if (!mod)
		mod = 1;
	printf("swsusp: Reading image data (%d pages):     ",
			swsusp_info.nr_copy_pages);
	walk_chain(&resume, data_read_one);
	printf("\b\b\b\bdone\n");

	if (ioctl(kmem, IOCTL_FREEZE, 0)) {
		fprintf(stderr, "Could not freeze system: %m\n");
		return 1;
	}

	if (ioctl(kmem, IOCTL_ATOMIC_RESTORE, &resume)) {
		fprintf(stderr, "Could not restore system: %m\n");
	}
	/* Ouch, at this point we'll appear in ATOMIC_SNAPSHOT syscall, if
	   things went ok... */

	return 0;
}

-- 
Thanks, Sharp!
