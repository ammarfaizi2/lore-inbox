Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbVLSPDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVLSPDy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 10:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbVLSPDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 10:03:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16581 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932198AbVLSPDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 10:03:53 -0500
Date: Mon, 19 Dec 2005 15:03:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [patch 15/15] Generic Mutex Subsystem, arch-semaphores.patch
Message-ID: <20051219150352.GC9809@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@ftp.linux.org.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
References: <20051219014043.GK28038@elte.hu> <1135002846.13138.258.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135002846.13138.258.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 09:34:06AM -0500, Steven Rostedt wrote:
> >  acpi_status
> >  acpi_os_create_semaphore(u32 max_units, u32 initial_units,
> > acpi_handle * handle)
> >  {
> > -       struct semaphore *sem = NULL;
> > +       struct arch_semaphore *sem = NULL;
> >  
> >         ACPI_FUNCTION_TRACE("os_create_semaphore");
> >  
> > -       sem = acpi_os_allocate(sizeof(struct semaphore));
> > +       sem = acpi_os_allocate(sizeof(struct arch_semaphore));
> 
> [OT]
> This is why I prefer sizeof(*sem) over sizeof(struct type_of_sem) but I
> regress.  And I don't buy that argument of the mistaken sizeof(sem)
> since, I've never had to deal with that bug!  Oh well, each to their
> own.

What's more important is that acpi is doing something fundamentally stupid
here.  Putting a lock into a separate allocation (and the allocator wrapped
again..) is just freaking stupid, period.

Someone needs to go through ACPI and rewrite this freaking junk into proper
linux code.  Maybe it'd even get less buggy if a single person finally had
a chance to actually understand all of the code after only half of it is
left ;-) 

> 
> -- Steve
> 
> >         if (!sem)
> >                 return_ACPI_STATUS(AE_NO_MEMORY);
> > -       memset(sem, 0, sizeof(struct semaphore));
> > +       memset(sem, 0, sizeof(struct arch_semaphore));
> >         sema_init(sem, initial_units);

and a memset to it, WTF..  seems like the acpi people just need to be shot.

