Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbVKAS2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVKAS2z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 13:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbVKAS2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 13:28:55 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:2751 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751077AbVKAS2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 13:28:55 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/3] swsusp: move snapshot-handling functions to snapshot.c
Date: Tue, 1 Nov 2005 19:29:19 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200510301637.48842.rjw@sisk.pl> <200510310135.42190.rjw@sisk.pl> <20051031215938.GB14877@elf.ucw.cz>
In-Reply-To: <20051031215938.GB14877@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011929.20073.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 31 of October 2005 22:59, Pavel Machek wrote:
}-- snip --{
> 
> > > > - sys_create_pagedir
> > > 
> > > Ugly...
> > 
> > Oh, it can be done on-the-fly in
> > sys_put_this_stuff_where_appropriate(image data) (at the expense of one
> > redundant check per call).
> 
> Yes, but it is still ugly, as you keep some context across the
> syscalls.

That depends on how you implement the interface.  If you insist on using
ioctls then yes, it's ugly.  However, if it is a file in sysfs, for example,
then you have well-defined open(), close(), read() and write() operations
and it is assumed you will keep some context accross eg. write()s.
 
> > > > Cleanup: /* certainly something's gone wrong */
> > > > - sys_destroy_pagedir /* that's it */
> > > > - sys_resume_devices
> > > 
> > > You should not need to do this one. resuming devices is going to be
> > > integrated in atomic_restore, because suspending devices is there, too.
> > 
> > Yes, but I need to thaw processes anyway, so I can release memory as well.
> > OTOH, if sys_atomic_restore fails because of the lack of memory, the memory
> > should be freed _before_ resuming devices, since otherwise subsequent
> > failures are almost certain to appear (I've seen what happens in that case).
> > Now, if the memory is allocated by the kernel, I can easily put an
> > emergency memory-freeing call in sys_atomic_restore (in that case
> > sys_destroy_pagedir will be redundant, but so what?).
> 
> Ugh, I'd say "don't care about this one too much". If resume is
> failing, we have bad problems anyway.

We loose the saved system state, but the kernel that has just booted is
supposed to continue, so we should make it possible.  Alternatively,
we can do something like a panic and force the user to reboot,
in which case we can forget about the error paths, freeing memory
etc. altogether.

Greetings,
Rafael
