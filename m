Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280021AbRKECoN>; Sun, 4 Nov 2001 21:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280132AbRKECoD>; Sun, 4 Nov 2001 21:44:03 -0500
Received: from mnh-1-21.mv.com ([207.22.10.53]:52237 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S280021AbRKECnu>;
	Sun, 4 Nov 2001 21:43:50 -0500
Message-Id: <200111050402.XAA05891@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Special Kernel Modification 
In-Reply-To: Your message of "Sun, 04 Nov 2001 18:14:12 PST."
             <E160ZHB-0001Ae-00@localhost> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Nov 2001 23:02:08 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bodnar42@phalynx.dhs.org said:
> So, to summarize, you could use a VM, and it'd work well for
> containment, but  it'd be pretty useless as far as performance, ease
> of administration, and  scaling go. 

Yeah, that's mostly wrong.

> Comments?

They follow...

> 1) There is a fairly significant overhead due to running inside a VM,
> which  would certainly pile up over multiple invocations. Besides the
> overhead of  the VM, you have the have the additional overhead caused
> by such things as  having multiple running kernels doing exactly the
> same thing, all running  seperate copies of the required system
> daemons.

This can be minimized.  What the original poster asked for is a one-application
jail.  So, you boot up a filesystem that runs only that app, perhaps even
as the init process.  No system daemons, nothing but the app and whatever it 
runs.

> Now, try 30 people all running from VMs. They all must have a seperate
> copy  of the otherwise sharable portions of StarOffice, and all of its
>  dependancies. Memory pressure quickly rises, and it will start
> swapping out  one copy of StarOffice in favour of an identical portion
> of another copy (!).  System quickly becomes unusable. 

Nope.  Duplicate block caching can be eliminated by making the root filesystem
a COW device (http://user-mode-linux.sourceforge.net/shared_fs.html) and 
mounting it sychronously.  COWing it will allow it to be shared among all VMs, 
with any changes being stored in the private COW file.  Mounting it synchronous
will disable caching in the VM.  So, for a number of virtual machines, there
will be, in total, slightly more than one copy of their data in the host's
memory.

Another possibility is hostfs.  You can directly mount a host directory
inside UML.  That can obviously be shared between UMLs, so you again 
eliminate all the duplication.

> 2) Upgrading/changing the system configuration would require modifying
> -all-  of the VMs. This could be partially alleviated by using an NFS
> root, but then  the overhead mentioned above becomes even more looming

This is a problem for a COWed block device, but it's trivial for a shared
hostfs directory.  Just dump the new bits in.

				Jeff

