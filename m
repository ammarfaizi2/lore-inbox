Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287359AbSACVva>; Thu, 3 Jan 2002 16:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287368AbSACVvV>; Thu, 3 Jan 2002 16:51:21 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:53776 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287359AbSACVvG>;
	Thu, 3 Jan 2002 16:51:06 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Thu, 03 Jan 2002 16:30:55 CDT."
             <Pine.GSO.4.21.0201031623580.23693-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 04 Jan 2002 08:50:52 +1100
Message-ID: <21246.1010094652@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002 16:30:55 -0500 (EST), 
Alexander Viro <viro@math.psu.edu> wrote:
><shrug> kernel build doesn't have to use it - if I mount a writable layer
>atop of the clean tree and build in the resulting tree, build system
>doesn't need to have any idea of that fact.

I have one big problem with unionfs and make, it cannot handle this
scenario.

* Mount COW layer over clean tree.
* Edit a file, writing to the COW layer.
* Build the kernel.
* Decide that you don't want the change, delete the COW version,
  exposing the original version of the file, timestamp goes backwards.
* Build the kernel.
* make sees source timestamp < object timestamp and does not rebuild,
  the kernel source and object do not match.

Obviously this is a design flaw in make, using only timestamps has been
shown to be unreliable.  As long as people use the standard make
program, they will have problems with union filesystems.  The problem
is not restricted to unionfs, NFS timestamp skew also affects make, as
well as checking out code from source repositories when the timestamp
goes backwards.

>That's the point - you are
>emulating the thing that is generally useful and belongs to different
>layer - namely, the kernel.

I agree that unionfs is useful but it is not the panacea for kbuild
that you think it is.  The kbuild wrapper around make takes care of the
timestamp problems as well as handling separate source and object
trees, IOW it does unionfs plus a lot more work.

If make did not rely on timestamps I would have been pushing for
unionfs a long time ago, but as long as we are stuck with make's
design, unionfs is not a fix.  I thought about replacing make entirely
with another tool like Scons but decided that none of the other tools
on their own could cope with the peculiarities of the kernel build nor
were they stable enough yet.

