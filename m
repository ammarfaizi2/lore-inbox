Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbULUBgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbULUBgF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 20:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbULUBgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 20:36:04 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:57219 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261724AbULUBgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 20:36:00 -0500
Subject: Re: ioctl assignment strategy?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pjotr Kourzanov <peter.kourzanov@xs4all.nl>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <41C756CA.5080504@xs4all.nl>
References: <1103067067.2826.92.camel@chatsworth.hootons.org>
	 <20041215004620.GA15850@kroah.com> <41C04FFA.6010407@nortelnetworks.com>
	 <20041217234854.GA24506@kroah.com> <41C70DF2.80101@nortelnetworks.com>
	 <41C756CA.5080504@xs4all.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103589129.32548.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Dec 2004 00:32:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-20 at 22:48, Pjotr Kourzanov wrote:
>    /That/ is exactly what FS API is good for: returning error values is 
> done via read(/sys/mystuff/errno,&err,4), getting handles is done via 
> open(/sys/mystuff/mycomp) and doing new calls is just calling FS API 
> with the *file* handle. Registration, depending on your definition of it

Except in the real world when little things come up like 
synchronization or complex API's that don't fit read/write terribly well
(committing sets of changes, synchronous object replies)
 
> can be viewed as a link(/sys/mystuff/object,/sys/mystuff/subsystem) or 
> as a write(/sys/mystuff/subsystem/registered,"object"). Take a peek into 
> Plan9 from Bell Labs for inspiration...

And everything can be implemented in purest lisp on a turing machine.
You forgot the usefulness test.

> > What's the big problem with ioctls anyways?  I mean, in a closed 
> > environment where I'm writing both the userspace and the kernelspace 
> > side of things.


<rant>

It offends the plan 9 bigots and their pet religion. Not that they don't
have a good point in many cases 8)

Ioctls do have some serious problems that make them nice to avoid

1. Each ioctl handler has its own data structures. While you could write
XML objects to encapsulate this in write() it is also true in many cases
that there is a simple logical expression of the operation - eg
configuration options tend to fit well into files as you can see with
/sysfs - unless they need to be atomic transactions with rollback at
which point the same people who decry ioctl will hate embedding sqlite
in the kernel

Seriously however - multiple structures means multiple validation
functions means more new code and more errors. It's a lot easier to get
ioctls wrong. There are a lot of things that don't need to be ioctl. A
look at security history says in general "ioctls cause bugs"

2. Ioctl structures tend to be binary. Welcome to 32/64bit emulation
hell. Good design can avoid this. Good design is not XML for this
purpose.

3. Ioctl is unstructured and so each ioctl is a new mystery to the
programmer. We all know how write works and in many cases  echo "451" >
/proc/sys/vm/blah is quite obvious.

4. It's hard to ioctl from the command line or scripts

The "ioctls are evil" blind hate department really annoy me however
because like all extreme views the truth very rarely fits their model

</rant>

