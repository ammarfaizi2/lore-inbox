Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751562AbWEaCeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbWEaCeq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 22:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbWEaCeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 22:34:46 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:7757 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751534AbWEaCep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 22:34:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k8oJISTwOrc4hFX38h19JZfgHMpzJr2woaakQEBM89XtxuIt5WUmt5oRlvKcodPKylvazHGWx6vJRvqT839gt5HxU4RUrjm25P5KC3nV7n1TePbR4IkYj55Y7qU4ePR/8BWNWNCYQNDNudbhV9LdDxbN2z1rvpUk4SBi4O0tXbI=
Message-ID: <9e4733910605301934n378a9415tceda495ec30c6782@mail.gmail.com>
Date: Tue, 30 May 2006 22:34:34 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Pavel Machek" <pavel@ucw.cz>, "Dave Airlie" <airlied@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <447CF007.5070904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605291623k3636f7hcc12028cad5e962b@mail.gmail.com>
	 <20060530202401.GC16106@elf.ucw.cz>
	 <9e4733910605301356k64dcd75fo38e45e1b7572817f@mail.gmail.com>
	 <21d7e9970605301601t37f8d3ddwaf4a900ed8997fdf@mail.gmail.com>
	 <9e4733910605301627t2f28db08vf58c78e2656b7047@mail.gmail.com>
	 <20060530233826.GE16106@elf.ucw.cz> <447CDCB7.8080708@gmail.com>
	 <9e4733910605301747x13e1271atf5aecf335eee61c5@mail.gmail.com>
	 <447CF007.5070904@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> I was thinking of reviving this patch, because of problems with suspend/
> resume and mode setting. But if there is a plan to put an emulator as part
> of the kernel library, I'll hold off.

There's a plan but nobody is working on it right now. The first step
is to get klibc in and that seems to be taking forever. klibc is
making progress, there is a merged kernel/klibc git tree available,
I'm just not sure when it will get merged for real.

> I'm also thinking of using a different user-kernel interface.  The old
> patch creates a misc device which the daemon opens, but can the kernel
> connector do the job? I don't know anything about this.

My app wrote its results and signaled it was finished by writing to a
sysfs attribute. I'm sure one of the experts on the list will tell us
the right way to do this.

The flow is like this:
normal user ioctls device
kernel driver calls usermodehelper
what's the right way for the kernel driver to sleep here?
user space run the helper app as root
app writes to sysfs attribute
kernel driver wakes
returns out to normal user

If you look at the code for /sys/class/firmware it does most of what is needed.
Check out drivers/base/firmware_class.c

This code can be generalized to support calling out to arbitrary user
mode helpers instead of the specific firmware helper. I think I posted
a patch to do this, I don't have it locally but it may be in the
archives.

> PS: This user helper need not just do x86 calls, it might use OF or even
> X. (I believe the Xen people have something similar). A userspace
> framebuffer driver usable by the kernel console is definitely possible.

I have never been against having the driver call out into user mode,
in fact it is required for some hardware. The model I would like to
see is for everything to be controlled via a device node. Having the
device node lets you control it as a normal user and then use the
device driver to gain root when you have to have it.


-- 
Jon Smirl
jonsmirl@gmail.com
