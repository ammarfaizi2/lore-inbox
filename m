Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279814AbRLEFnW>; Wed, 5 Dec 2001 00:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280035AbRLEFnM>; Wed, 5 Dec 2001 00:43:12 -0500
Received: from leeloo.zip.com.au ([203.12.97.48]:5391 "EHLO
	mangalore.zipworld.com.au") by vger.kernel.org with ESMTP
	id <S279814AbRLEFnA>; Wed, 5 Dec 2001 00:43:00 -0500
Message-ID: <3C0DB3D6.9C86B865@zip.com.au>
Date: Tue, 04 Dec 2001 21:42:46 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Josh McKinney <forming@home.com>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Fwd: binutils in debian unstable is broken.
In-Reply-To: <20011205050513.GD1442@cy599856-a.home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh McKinney wrote:
> 
> This seems to be a kernel bug which is shown with the new version of ld.  Thought I would
> forward this along so maybe it can get fixed.
> 
> ...
> drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols
> in discarded section .text.exit'

It is a kernel bug, and it's going to break a truckload
of PCI drivers, along with uhci_pci_remove().

What is happening is this:  a typical driver has:

static void __devexit remove_foo(...)
{}

static struct pci_driver foo_driver = {
	...
	remove: remove_foo;
};

The problem is that if foo.c is statically linked into the
kernel, and if CONFIG_HOTPLUG is not set, __devexit evaluates
to __exit.  And in vmlinux.lds we've asked the linker to
discard all the contents of section .text.exit.

The problem appears to be that the linker is now actually doing what
we asked it to do, so the `remove_foo' entry in that table now points
at a function which isn't going to be linked into the kernel.  Oh dear.

Workarounds are:

1) Enable CONFIG_HOTPLUG

2) Change vmlinux.lds so we don't drop the .text.exit section (this
   is effectively the same as 1)

3) Something else.  HJ's #ifdef MODULE works OK.  It has a rather
   internecine relationship with the workings of __devexit though.
