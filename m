Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269661AbTGJWv0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269663AbTGJWv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:51:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34570 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269661AbTGJWvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:51:08 -0400
Date: Fri, 11 Jul 2003 00:05:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.75
Message-ID: <20030711000546.B20214@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030710223548.A20214@flint.arm.linux.org.uk> <Pine.LNX.4.44.0307101512350.4757-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0307101512350.4757-100000@home.osdl.org>; from torvalds@osdl.org on Thu, Jul 10, 2003 at 03:26:09PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 03:26:09PM -0700, Linus Torvalds wrote:
> On Thu, 10 Jul 2003, Russell King wrote:
> > 
> > Well, only two words from me.  Oh Shit.
> 
> Hey, this is already much later than it should have been, so it's not as
> if this is a huge surprise.

Absolutely no surprise.  In any case, the long development cycle isn't
what ARM stuff needs.

For example, during 2.3, people only started serious merging with myself
of the StrongARM SoC code towards the end of 2.3 when it became important
to them for 2.4.  That caused the serial layer rewrite around 2.4.2 time
and later spawned the cpufreq project, both of which has been maintained
ever since.  Now that StrongARM SoC has been end of life'd by Intel, most
of the work which went into 2.5 is wasted because probably no one will
ever use it.

A fine example of this was what happened with the touchscreen stuff
(thank god we got the input layer in 2.5.)

I see the same thing happening to the Intel PXA (Xscale stuff.)
Virtually the whole of the ARM community is working on 2.4 for Xscale
because that's the current stable kernel.  They're not interested in 2.6
until 2.6 actually comes out.  At this point, everyone will want their
drivers to work on that kernel.  Of course, 2.8 will be too late.

And then yours truely then ends up with loads of crap patches and we
start the process again.

The major problem is that embedded developers only care about what
works for them and what they can provide to their customers.  Once
that's done, they don't have any interest in cleaning stuff up nor
feeding obvious bug fixes back up.

> > The 2.5.70 ARM patch currently looks like this:
> 
> We can sort it out later. Obviously, clearly arm-specific patches (ie
> stuff in arch/arm and include/asm-arm) I wouldn't mind per se, but I'd
> rather hold back on even those just to make the patches and the changlogs
> not be mixed up with the "main bugfixes".

I've still got to sort out the module space and /proc/kcore - we allocate
the module space between TASK_SIZE and PAGE_OFFSET, which needs vmalloc
to be aware that entries on the vmlist may cover two allocatable areas.
Maybe this has changed, I haven't had time to look into this.  This is
probably the main reason why stock 2.5 (since Rusty's module changes
went in, recent) has never built for ARM.

I don't think the kclist stuff really fits this for me - it doesn't
allow me to do allocations off it, and I don't want yet another
list for modules.  I guess I'm going to stick with my current approach
of having two memory spaces in the vmlist.  (see patch).

> We've never had a first stable release that has all architectures
> up-to-date, and I'm not planning on changing that for 2.6.x. This is _not_
> the time to try to make my tree build on arm (or other architectures
> either), considering that my tree hasn't been the main ARM tree for a long 
> time.

Hasn't ever, I'm afraid.  I can't think of any stock kernel which has
been usable, let alone been compilable for ARM.  Which, IMO, is a pretty
sorry statement to make.


--- orig/mm/vmalloc.c	Tue May 27 10:05:48 2003
+++ linux/mm/vmalloc.c	Tue May 27 10:14:45 2003
@@ -178,21 +178,11 @@
 	return err;
 }
 
-
-/**
- *	get_vm_area  -  reserve a contingous kernel virtual area
- *
- *	@size:		size of the area
- *	@flags:		%VM_IOREMAP for I/O mappings or VM_ALLOC
- *
- *	Search an area of @size in the kernel virtual mapping area,
- *	and reserved it for out purposes.  Returns the area descriptor
- *	on success or %NULL on failure.
- */
-struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
+struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
+				unsigned long start, unsigned long end)
 {
 	struct vm_struct **p, *tmp, *area;
-	unsigned long addr = VMALLOC_START;
+	unsigned long addr = start;
 
 	area = kmalloc(sizeof(*area), GFP_KERNEL);
 	if (unlikely(!area))
@@ -209,12 +199,14 @@
 
 	write_lock(&vmlist_lock);
 	for (p = &vmlist; (tmp = *p) ;p = &tmp->next) {
+		if ((unsigned long)tmp->addr < addr)
+			continue;
 		if ((size + addr) < addr)
 			goto out;
 		if (size + addr <= (unsigned long)tmp->addr)
 			goto found;
 		addr = tmp->size + (unsigned long)tmp->addr;
-		if (addr > VMALLOC_END-size)
+		if (addr > end - size)
 			goto out;
 	}
 
@@ -239,6 +231,21 @@
 }
 
 /**
+ *	get_vm_area  -  reserve a contingous kernel virtual area
+ *
+ *	@size:		size of the area
+ *	@flags:		%VM_IOREMAP for I/O mappings or VM_ALLOC
+ *
+ *	Search an area of @size in the kernel virtual mapping area,
+ *	and reserved it for out purposes.  Returns the area descriptor
+ *	on success or %NULL on failure.
+ */
+struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
+{
+	return __get_vm_area(size, flags, VMALLOC_START, VMALLOC_END);
+}
+
+/**
  *	remove_vm_area  -  find and remove a contingous kernel virtual area
  *
  *	@addr:		base address


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

