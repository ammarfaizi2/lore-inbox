Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268315AbUIWHwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268315AbUIWHwx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 03:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268316AbUIWHwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 03:52:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:28377 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268315AbUIWHws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 03:52:48 -0400
Subject: [PATCH] ppc64: monster cleanup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1095925729.21793.47.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 23 Sep 2004 17:48:50 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This is the long awaited "monster cleanup" patch. It's huge and moves
some files around, so to apply it, you need to do some file renaming
first (I did that to avoid bloating the patch and so that Linus can
do proper bk mv and not lose history). Details about the patch content
are later in this mail, I'll start with the detail of applying it first ;)

The patch should be merged asap. It's a bit difficult to maintain of
tree and any further patch after this one will be a pain to backport.
Since 2.6.9 will be a milestone for some distros, it would be nasty
if, for example, this went into early 2.6.10, thus any further patch
beeing a pain to backport to 2.6.9. But then, I'll let you decide here :)

It would be extremely difficult to break this patch in pieces. However,
I have tested it on a wide variety of ppc64 machines (rs64 iSeries, POWER3
pSeries, POWER4 pSeries SMP, POWER4 pSeries LPAR, POWER5 pSeries LPAR with
SMT, js20 blade, and of course Apple G5). In general, if the machine boots,
it will work, there is little to no impact on code that is run after boot.

To apply the patch, you need first to:

  rm arch/ppc64/boot/addSystemMap.c
  rm include/asm-ppc64/bootx.h
  mv arch/ppc64/kernel/chrp_setup.c arch/ppc64/kernel/pSeries_setup.c
  mv arch/ppc64/kernel/pSeries_htab.c arch/ppc64/mm/hash_native.c

I intentionally didn't include those changes in the patch, so you can
use the "bk" equivalents and it does the right thing for bitkeeper
users.

After the patch is applied, if you use a revision control, don't forget
to check in those 2 new files:

  include/asm-ppc64/plpar_wrappers.h
  arch/ppc64/kernel/prom_init.c

The patch itself is too big for the lists and is available at:

http://gate.crashing.org/~benh/monster-cleanup-3.diff

(Let me know if you want it as a separate email). It should apply on a bk
snapshot I did today.

The description now:

This is the third & hopefully final version of the monster cleanup
patch. It does significant cleanups of the early boot code of the
ppc64 kernel, and begins the long process of cleaning up & splitting
properly the platform support.

It completely reworks the interface between the early code that is
run in the firmware context (prom_init) and the rest of the kernel,
in such a way that will make kexec or static device-tree for embedded
people possible. The early init code can eventually be moved to a
separate link entity, it no longer touches any of the kernel globals,
everything is passed via a single blob of data in memory containing
a flattened version of the device-tree and a memory reserve map.

While doing it, I also cut the ties between pSeries and Powermac. Now,
the kernel config provides a choice between legacy iSeries and
"multiplatform". The later is a set of various supported platform,
each of them beeing a boolean switch, currently defined beeing pSeries
and PowerMac. You can enable both or just one of them. CONFIG_PPC_PSERIES
is now specifically set for IBM pSeries support, you can build a PowerMac
kernel without pSeries support if you which.
The main goal here is to simplify addition of new platform types.

Regards,
Ben.


