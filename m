Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290344AbSAPDlw>; Tue, 15 Jan 2002 22:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289852AbSAPDln>; Tue, 15 Jan 2002 22:41:43 -0500
Received: from femail12.sdc1.sfba.home.com ([24.0.95.108]:63165 "EHLO
	femail12.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S289965AbSAPDl3>; Tue, 15 Jan 2002 22:41:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] klibc requirements, round 2
Date: Tue, 15 Jan 2002 12:28:38 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.44.0201142151410.12435-100000@waste.org>
In-Reply-To: <Pine.LNX.4.44.0201142151410.12435-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020116034128.CRCI26021.femail12.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 January 2002 11:05 pm, Oliver Xymoron wrote:

> Fair enough. The deeper point is that the purpose of initramfs is to move
> stuff out of the kernel in to userland. Ergo, this all becomes a
> non-kernel issue. We do not want to be in the business here of packaging
> things into the ramfs archives, we rather want to give external tools and
> distros all the info they need to make intelligent choices about how to
> make the kernel bootable.

The deeper issue is what portion of initramfs changes with each minor kernel 
version, and what portion stays static through a major release.

The volatile stuff (like the module tree) we will have to supply.  The static 
stuff (like the /init script, shell to run it if it's not c code, dhcp 
client, root filesystem determination, nfs mount, etc) can live in its own 
directory as long as there is a clean well-defined API that it and the kernel 
can talk to each other through.  It doesn't even have to get rebuilt, just 
scooped up into the archive.

When initramfs is required to boot, we're going to have to supply at least a 
skeleton version of it in the kernel tarball.  But if the distributions 
supply their own uncompressed initramfs tree in a well-known location 
(something like /usr/src/initramfs, perhaps) then all the kernel build has to 
do is cpio that up, add on the volatile stuff (module directory, etc), and 
hand that archive and the bzImage off to whatever the install script is that 
copies them to /boot and updates the bootloader if necessary.

If /usr/src/initramfs isn't there, then the build process should use the 
minimalist skeleton version in the kernel tarball instead.  (The skeleton's 
purpose would mostly as example code with the absolute minimum required to 
boot a fairly straightforward system, but it should work and the only way to 
really know that is to build it and try it.)  It skeleton would largely 
serve as a baseline for distributors to add to, containing the common code 
they can't really avoid having.

So when we're breaking stuff out of the kernel and putting it into initramfs, 
we move the code it into the skeleton initramfs directory, and define a clean 
API that it and the kernel can talk to each other through.  Then later, stuff 
can be dropped from the skeleton directory if we decide it doesn't need to 
live in the kernel tarball (things like klibc which have more than one 
implementation, or a micro dhcp client that not everybody really needs in 
order to boot).

So the first question is, what parts of initramfs are going to change with 
each new kernel version (I.E. the module tree), and what stuff is going to 
stay pretty stable between major releases (the /init script?)  Second 
question, what are the APIs that the stable stuff will be calling so they 
don't necessarily have to be recompiled for each new minor release?

> Let's just try to focus on what we're taking out of the kernel in this
> process and not on all the nifty stuff that can now be added to the
> initial boot process.

Let's focus on how to separate the volatile parts of initramfs that have to 
stay in the kernel tree, and the non-volatile parts that can talk to the rest 
of the kernel through cleanly defined APIs the kernel must support.

If a section of code can't talk to the kernel through a stable API, it can 
never be moved out of the kernel tree, and there's not too much point in 
moving it out of the kernel proper, really...

Rob

