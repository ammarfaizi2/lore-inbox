Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbSKUXOf>; Thu, 21 Nov 2002 18:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265960AbSKUXOf>; Thu, 21 Nov 2002 18:14:35 -0500
Received: from h-64-105-34-70.SNVACAID.covad.net ([64.105.34.70]:48848 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265477AbSKUXOe>; Thu, 21 Nov 2002 18:14:34 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 21 Nov 2002 15:21:11 -0800
Message-Id: <200211212321.PAA16033@adam.yggdrasil.com>
To: vandrove@vc.cvut.cz, zippel@linux-m68k.org
Subject: Re: [RFC] module fs or how to not break everything at once
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

	Can you tell me what problem in the existing userland module
code (i.e., before 2.5.48) modulefs solves?  Does it actually make
the kernel smaller?  Can you give me an example?

	I agree with you that module linking should be done in user
space.  I have asked repeatedly for someone to show real benefits to
in-kernel module linking, and, so far, nobody has.  To my knowledge,
your proposal hasn't passed this test either, but I'll make a few
suggestions on it anyway.

	1. Please take Petr's advice and just make module removal
occur when you rmdir the directory.  Making the removal happen in
two stages introduces additioal states that have to be defined, such
as the state where the "module unmap" command has been received
but the module's directory has been removed.  What if somebody else
wants to load the same module again at this time?  Either you will
get flakiness in facilities that rely on automatic kernel module
loading or modprobe has to be modified to deal with that
possibility and perhaps try to do the remove itself.

	2. I would really like insmod to be able to flock modules (or
do something similar).  This would increment the reference count on a
module until insmod would exit (or would do an execve, I suppose).
This would eliminate a race when insmod is loading a module that
references symbols in other modules.  I don't think flock is actually
propagated down the vfs layer, so perhaps some other primitive could be
used.  Perhaps just holding open an open file descriptor on each of
the modules in question would be a better interface.

	3. It's not a modulefs thing, but you might want to consider
moving all symbol management to user space, including that for the
core kernel symbols.  The symbol tables can be maintained in user
files by the insmod and rmmod programs, they could even be inferred
from the module's start address and the module's .o in the file
system.  If people really want to store this data to be stored in
kernel memory, they can allocate extra space where the module is
actually loaded and their favorite symbol table format there.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
