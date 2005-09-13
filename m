Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbVIMRBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbVIMRBj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbVIMRBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:01:38 -0400
Received: from s1.mailresponder.info ([193.24.237.10]:36365 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S964910AbVIMRBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:01:37 -0400
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
From: Mathieu Fluhr <mfluhr@nero.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1126608030.3455.23.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
	 <1126608030.3455.23.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Nero AG
Date: Tue, 13 Sep 2005 19:01:18 +0200
Message-Id: <1126630878.2066.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, after having performed a bisection of the kernel tree (took me the
whole afternoon.... 13 compilations needed ;-) I think I am able to give
the faulty patch for these buffer underruns: 

--snip----------------------------------------------------------------
de-c-l-097:~/KernelTree/linux-2.6# git bisect bad
59121003721a8fad11ee72e646fd9d3076b5679c is first bad commit
diff-tree 59121003721a8fad11ee72e646fd9d3076b5679c (from
799d19f6ec5ca2102c61122f5219a17f1c4e961a)
Author: Christoph Lameter <christoph@lameter.com>
Date:   Thu Jun 23 00:08:25 2005 -0700

[PATCH] i386: Selectable Frequency of the Timer Interrupt

Make the timer frequency selectable. The timer interrupt may cause bus
and memory contention in large NUMA systems since the interrupt occurs
on each processor HZ times per second.

  Signed-off-by: Christoph Lameter <christoph@lameter.com>
  Signed-off-by: Shai Fultheim <shai@scalex86.org>
  Signed-off-by: Andrew Morton <akpm@osdl.org>
  Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:040000 040000 c859e995b936a0cfa1e91efdfd6351ca251b4c47
8a2d1f15a40f6e1655b5a1ff00f52cda787d46d9 M      arch
:040000 040000 2fb4f01297addda0bd07a066efe0838f043836fb
d82e3d56597b7acd571e604e640d97ea80fc3a15 M      include
:040000 040000 25bbac3c3c2d91eb5706e31779936d055897fc95
3282f7f102609c2c6a4731ae6569b34139cf8024 M      kernel
de-c-l-097:~/KernelTree/linux-2.6#
--snip----------------------------------------------------------------


So I would say that it is related to somehow some kind of timeout in
SCSI I/O (but really not sure...). As far as I saw, there is now an
option in the kernel config file related to this, so I will try to see
what happens with 1000 Hz and 100 Hz (I left the default value of 250 Hz
for my tests).

Many thanks to all that helped ;-)
Mathieu

On Tue, 2005-09-13 at 12:40 +0200, Mathieu Fluhr wrote:
> On Mon, 2005-09-12 at 20:34 -0700, Linus Torvalds wrote:
> > Ok, it's been two weeks (actually, two weeks and one day) since 2.6.13, 
> > and that means that the merge window is closed. I've released a 
> > 2.6.14-rc1, and we're now all supposed to help just clean up and fix 
> > everything, and aim for a really solid 2.6.14 release.
> > 
> 
> Sorry to bother you again and again with this stuff, but I got no answer
> from anyone... DVD burning is broken since 2.6.13-rc1 and I checked this
> morning the 2.6.14-rc1: Same status.
> 
> To be short, when burning a DVD at 16x with 2.6.12.6, no problem at all.
> With 2.6.13-rc1 and upper, lots of buffer underruns. (If someone wants
> to help, feel free to ask more details... I would be happy to help
> anyone). The only thing that I know is that it is not coming from the
> peripheral driver, as I have the same issue when using ide-cd with a
> CDROM_SEND_PACKET ioctl or usb-storage+sg with a SG_IO ioctl.
> 
> As far as I looked in the source code, it seems to be lots (and lots) of
> changes between these 2 versions, specially regarding block devices
> drivers. But the ChangeLog is so huge that it is quite impossible to
> make a step-by-step upgrade to see _where_ the problem is :-(
> 
> > Both the diffstat and the shortlog are so big that I can't post them on 
> > the kernel mailing list without getting the email killed by the size 
> > restrictions, so there's not a lot to say. 
> > 
> > alpha, arm, x86, x86-64, ppc, ia64, mips, sparc, um.. Pretty much every
> > architecture got some updates. And an absolutely _huge_ ACPI diff, largely 
> > because of some re-indentation.
> > 
> > drm, watchdog, hwmon, i2c, infiniband, input layer, md, dvb, v4l, network,
> > pci, pcmcia, scsi, usb and sound driver updates. People may appreciate
> > that the most common wireless network drivers got merged - centrino
> > support is now in the standard kernel.
> > 
> > On the filesystem level, FUSE got merged, and ntfs and xfs got updated. In 
> > the core VFS layer, the "struct files" thing is now handled with RCU and 
> > has less expensive locking.
> > 
> > And networking changes.
> > 
> > In other words, a lot of stuff all over the place. Be nice now, and follow 
> > the rules: put away the new toys, and instead work on making sure the 
> > stuff that got merged is all solid. Ok?
> > 
> > Anybody with git can do the shortlog with
> > 
> > 	git-rev-list --no-merges --pretty=short v2.6.14-rc1 ^v2.6.13 |
> > 		git-shortlog | less -S
> > 
> > which is actually pretty informative.
> > 
> > 			Linus
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

