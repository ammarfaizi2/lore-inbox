Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbTDRTBh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 15:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263216AbTDRTBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 15:01:37 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:31692 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S263214AbTDRTBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 15:01:36 -0400
Date: Fri, 18 Apr 2003 14:12:27 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Greg KH <greg@kroah.com>
cc: Linus Torvalds <torvalds@transmeta.com>, <sfr@canb.auug.org.au>,
       <rusty@rustcorp.com.au>, <Andries.Brouwer@cwi.nl>, <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] struct loop_info64
In-Reply-To: <20030418180630.GA7247@kroah.com>
Message-ID: <Pine.LNX.4.44.0304181345360.9070-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Apr 2003, Greg KH wrote:

> On Fri, Apr 18, 2003 at 10:55:21AM -0700, Linus Torvalds wrote:
> > 
> > But we really should have a __ptr64 type too. There's just no sane way to
> > tell gcc about it without requireing casts, which is inconvenient (which
> > means that right now it you just have to use __u64 for pointers if you
> > want to be able to share the structure across 32/64-bit architectures).
> 
> I think that's what Stephan and Rusty tried to do with the
> kernel_ulong_t typedef in include/linux/mod_devicetable.h.
> 
> Maybe that typedef could be changed into the __ptr64 type?  Stephan?

I think kernel_ulong_t serves a slightly different purpose, very specific
to the module device table stuff, i.e. it represents an unsigned long in
the kernel ABI.

It normally contains a kernel pointer, as such it's inaccessible and
worthless to userspace, anyway. The reason for its existance is the fact
the scripts/file2alias needs to parse the contents of the table in the
object file and thus needs the distance between entries, which is
sizeof(struct foo_device_id).

So as opposed to the __ptr64, we don't actually want to pass a pointer 
between user and kernel space here, nor is the size of this field constant 
at 64 bits.

It shares the problems with __ptr64, though: Making this field always 64
bits large would simplify the userspace code a little, since it wouldn't
need to know the size of a kernel pointer / unsigned long.  However, it
still needs to know the endianness, so we don't gain too much.  (That's
different from the normal compat issues, where I suppose the endianness is
the same for 32/64 bit mode).

However, the real problem is that we want a type which can be cast to a
pointer, which unsigned long is, but a general __ptr64 cannot be - on 32
bits archs one would need to cast like

	(struct foo *) (unsigned long) drv->driver_data

instead of just

	(struct foo *) drv->driver_data

which is ugly (and I think the problem Linus referred to).

(A last comment, btw: getting the size right is not all, alignment issues
in arrays of structs are much more subtle. struct {pci,usb}_device_id
happen to get it right since kernel_ulong_t are aligned to a 8 byte
boundary, but it's rather fragile).

--Kai


