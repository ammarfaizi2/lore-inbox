Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUIVKnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUIVKnS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 06:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUIVKnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 06:43:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:59088 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264098AbUIVKnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 06:43:14 -0400
Subject: [PATCH] Monster cleanup patch #2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
Content-Type: text/plain
Message-Id: <1095849598.20684.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 22 Sep 2004 20:39:58 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This is the second version of the monster cleanup patch (I dropped
the word "boot" as it cleans up a bit more than the boot code).
Of course, we can still cleanup further ;) But at least this gives
up a "first" step that I intend to submit upstream as soon as I
have fixed legacy iSeries (help welcome finding out what's wong...)

So this is close to the final patch (except for iSeries not booting,
but I can't seem to find a way to output early debug messages on those,
if some US folks who knows those beast would be willing to help, it
would be much appreciated).

What it does is:

  - Cut all ties between prom_init (code running in the context of
the firmware at boot) and the rest of the kernel. prom_init() and
functions it uses are now in a separate file and no longer share any
global with the rest of the kernel. It's not yet a separate link entity
but it could be made one. The only communication between prom_init() 
and the rest of the kernel goes through a block of memory passed by
prom_init() which contains a flattened version of the device-tree and
a map of reserved physical memory areas. Any other information is
passed via properties added to the device-tree. I also did some major
cleanup in the prom_init code, especially in the way it allocates
memory, if you are interested, read the various comments in there.
This work main goal is to enable implementation of kexec, but it also
helps in various other ways the support of additional platform types.

 - Rework the early kernel initialization (early_setup() is now called
from the assembly in real mode before setup_system(), which itself
gets rids of some of the ifdef's (not all yet) and switch/case, look at
the comments in the code). The goal is to adapt to the prom_init changes,
make the code more readable, and make addition of new platform types
easier.

 - Cut the ties between pSeries and Powermac. Now, the kernel config
provides a choice between legacy iSeries and "multiplatform". The later
is a set of various supported platform, each of them beeing a boolean
switch, currently defined beeing pSeries and PowerMac. You can enable
both or just one of them. CONFIG_PPC_PSERIES is now specifically set
for IBM pSeries support, you can build a PowerMac kernel without pSeries
support if you which. The main goal here is to simplify addition of
new platform types.

At this point, it's very difficult to split the patch into incremental
changes, there are a _lot_ of inter dependencies. I'll try to get it
merged at once as soon as the iSeries problem is fixed.

NOTE: To apply the patch, you need first to:

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

http://gate.crashing.org/~benh/monster-cleanup-2.diff

Ben.


