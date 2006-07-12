Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWGLMC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWGLMC1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 08:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWGLMC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 08:02:26 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:58597 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1750987AbWGLMC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 08:02:26 -0400
Date: Wed, 12 Jul 2006 13:02:16 +0100 (BST)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: evil@vaio.testbed.de
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [x86_64] strange delays since 2.6.15 (was: Re: ohci1394: aborting
 transmission)
In-Reply-To: <44B253CE.3030308@s5r6.in-berlin.de>
Message-ID: <Pine.NEB.4.64.0607121247410.2796@vaio.testbed.de>
References: <Pine.LNX.4.64.0607100527200.10447@sheep.housecafe.de>
 <44B203F4.1030903@s5r6.in-berlin.de> <Pine.LNX.4.64.0607100852390.13858@sheep.housecafe.de>
 <44B253CE.3030308@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stefan, hello all,

sorry for not getting back to you earlier. I was not asleep though and 
the problem has not gone away - it has become worse, much worse and it 
turns out that it might not have anything to do with ohci1394 at all, 
but read on (if you're curious):

I've noticed the strange delay during bootup in 2.6.17-mm6 and thought 
"hm, this did not occur in 2.6.16...right?" but I really I have not paid 
attention to the bootup process of this box. in fact, i had no access to 
this box for a few month and have not tracked -current for a while and 
when I got access again we were somewhere at 2.6.17-rc* and I have not 
paid attention to the bootup at all.

I am currently in the middle of bisecting and I found out that
    - 2.6.14 is fine, no delays during bootup
    - 2.6.15-rc1 is showing these delays

"git-bisect log" shows (uh, linewraps):

git-bisect start
# bad: [c80dc60b03d633047c7f96be87fd59cdcdbb929f] Merge branch 'release' of git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6
git-bisect bad c80dc60b03d633047c7f96be87fd59cdcdbb929f
# good: [2b10839e32c4c476e9d94492756bb1a3e1ec4aa8] Linux v2.6.14
git-bisect good 2b10839e32c4c476e9d94492756bb1a3e1ec4aa8
# bad: [c89f2ee5f9223b864725f7344f24a037dfa76568] NFS: make iocb available everywhere in direct write path
git-bisect bad c89f2ee5f9223b864725f7344f24a037dfa76568
# bad: [27441127b086230cc4c57d6cd9a615272fb47bcd] [ALSA] Remove snd_legacy_auto_probe()
git-bisect bad 27441127b086230cc4c57d6cd9a615272fb47bcd
# bad: [7a77d918ad8fb152312525b70780f6e0052b3ee3] m68knommu: FEC ethernet header support for the ColdFire 5208
git-bisect bad 7a77d918ad8fb152312525b70780f6e0052b3ee3
# bad: [b38c6845b695141259019e2b7c0fe6c32a6e720d] mm: uml kill unused
git-bisect bad b38c6845b695141259019e2b7c0fe6c32a6e720d
# bad: [c9c7746dd333c12f482af2f1e63ea7eafc7cd529] USB: ftdi: Artemis and ATIK based USB astronomical CCD cameras
git-bisect bad c9c7746dd333c12f482af2f1e63ea7eafc7cd529
# good: [e5dfa9282f3db461a896a6692b529e1823ba98c6] Merge branch 'upstream' of master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6
git-bisect good e5dfa9282f3db461a896a6692b529e1823ba98c6
# bad: [6fbfddcb52d8d9fa2cd209f5ac2a1c87497d55b5] Merge ../bleed-2.6
git-bisect bad 6fbfddcb52d8d9fa2cd209f5ac2a1c87497d55b5
# good: [9be16a03928642f944915b8c05945fd87b7a15cb] Merge branch 'sx8' of master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6
git-bisect good 9be16a03928642f944915b8c05945fd87b7a15cb
# good: [049eb3298a832a63c55bc8d8ea4cc881ab99f84b] [ARM] 3041/1: AAEC-2000 - CLCD controller platform glue
git-bisect good 049eb3298a832a63c55bc8d8ea4cc881ab99f84b
# bad: [b7df3910c1298fee8ed7b9dfd2da74b85df5539c] drivers/media: convert to dynamic input_dev allocation
git-bisect bad b7df3910c1298fee8ed7b9dfd2da74b85df5539c


So, b7df3910c1298fee8ed7b9dfd2da74b85df5539c is bad, meaning it shows 
these delays. I've done another "git-bisect bad" after this but now 
compiling fails (see below) and now I'm stuck again.

I shall remove the ohci1394 guys from the Cc: and hope that some 
git-guru can help out, when compiling a git-bisect'ed kernel fails not 
because of being "bad" but because of compile-breakage :(

just for the record:

On Mon, 10 Jul 2006, Stefan Richter wrote:
> PS: Another simple test would be to boot with IEEE 1394 modules moved
> away so that they are not loaded.

yes, I've done that with 2.6.17-*, did not help...


Thanks,
Christian.


b7df3910c1298fee8ed7b9dfd2da74b85df5539c breaks with:

   CC      drivers/char/mem.o
/mnt/hda2/scratch/linux-2.6-git/drivers/char/mem.c: In function 
'chr_dev_init':
/mnt/hda2/scratch/linux-2.6-git/drivers/char/mem.c:924: warning: passing 
argument 2 of 'class_device_create' makes pointer from integer without a 
cast
/mnt/hda2/scratch/linux-2.6-git/drivers/char/mem.c:924: warning: passing 
argument 3 of 'class_device_create' makes integer from pointer without a 
cast
/mnt/hda2/scratch/linux-2.6-git/drivers/char/mem.c:924: warning: passing 
argument 4 of 'class_device_create' from incompatible pointer type
/mnt/hda2/scratch/linux-2.6-git/drivers/char/mem.c:924: error: too few 
arguments to function 'class_device_create'
make[3]: *** [drivers/char/mem.o] Error 1
make[2]: *** [drivers/char] Error 2
make[1]: *** [drivers] Error 2
make: *** [_all] Error 2
-- 
BOFH excuse #27:

radiosity depletion
