Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280118AbRKECOt>; Sun, 4 Nov 2001 21:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280120AbRKECOk>; Sun, 4 Nov 2001 21:14:40 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:12 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S280118AbRKECOY>;
	Sun, 4 Nov 2001 21:14:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Jeff Dike <jdike@karaya.com>
Subject: Re: Special Kernel Modification
Date: Sun, 4 Nov 2001 18:14:12 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200111050158.UAA05147@ccure.karaya.com>
In-Reply-To: <200111050158.UAA05147@ccure.karaya.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E160ZHB-0001Ae-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jeff,
> A virtual machine would be an administratively easy way of doing this.
>
> Let the 'app' be a VM with the real apps installed inside.  The users would
> effectively be confined to a *file* on the host, not merely their home
> directories.
>
> My (biased :-) recommendation would be User-mode Linux
> (http://user-mode-linux.sourceforge.net), but VMWare would work as
> well.

I'm afraid that would scale horribly on anything greater than a very modest 
load:

1) There is a fairly significant overhead due to running inside a VM, which 
would certainly pile up over multiple invocations. Besides the overhead of 
the VM, you have the have the additional overhead caused by such things as 
having multiple running kernels doing exactly the same thing, all running 
seperate copies of the required system daemons.
2) Upgrading/changing the system configuration would require modifying -all- 
of the VMs. This could be partially alleviated by using an NFS root, but then 
the overhead mentioned above becomes even more looming
3) Implicitly shared memory no longer works too well, and this is one of the 
reasons Unix is so strong as a terminal server:
  You have thirty people running StarOffice from /usr/bin, and because        
they've all mmap()ed the same binary, the read only portions are all shared,  
and will definitely stay in memory in the event of memory pressure. The same 
things goes for all the libraries and mmap()'ed data files StarOffice uses, 
including some pretty hefty ones such as glibc. Even many of the writable 
pages will be shared until someone decides to write to one of them, and then 
the writer will get a private copy.
  Now, try 30 people all running from VMs. They all must have a seperate copy 
of the otherwise sharable portions of StarOffice, and all of its 
dependancies. Memory pressure quickly rises, and it will start swapping out 
one copy of StarOffice in favour of an identical portion of another copy (!). 
System quickly becomes unusable. 

So, to summarize, you could use a VM, and it'd work well for containment, but 
it'd be pretty useless as far as performance, ease of administration, and 
scaling go. Comments?

-Ryan
