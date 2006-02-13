Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751640AbWBMFUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbWBMFUl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 00:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbWBMFUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 00:20:40 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:50316 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751621AbWBMFUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 00:20:39 -0500
To: Andrew Morton <akpm@osdl.org>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, Greg KH <greg@kroah.com>,
       linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       "Yu, Luming" <luming.yu@intel.com>,
       "Ben Castricum" <lk@bencastricum.nl>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       Gerrit =?ISO-8859-1?B?QnJ1Y2ho5HVzZXI=?= <gbruchhaeuser@gmx.de>,
       Nicolas.Mailhot@LaPoste.net, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>, Patrizio Bassi <patrizio.bassi@gmail.com>,
       =?ISO-8859-1?B?Qmr2cm4=?= Nilsson <bni.swe@gmail.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>, "P. Christeas" <p_christ@hol.gr>,
       ghrt <ghrt@dial.kappa.ro>, jinhong hu <jinhong.hu@gmail.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-scsi@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: S3 sleep regression bisected (was Re: Linux 2.6.16-rc3)
In-Reply-To: Your message of "Sun, 12 Feb 2006 19:05:20 PST."
             <20060212190520.244fcaec.akpm@osdl.org> 
Date: Mon, 13 Feb 2006 05:20:27 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1F8W8R-0000qf-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In http://bugzilla.kernel.org/show_bug.cgi?id=5989, Sanjoy Mahajan has
> another regression, but he's off collecting more info.

Now collected.  The problematic commit is:

bad: [292dd876ee765c478b27c93cc51e93a558ed58bf] Pull release into acpica branch

The longer story follows (and I'll file it with the bugzilla).  The
bug is that S3 sleep hangs on the second sleep of my TP 600X,
producing an endless loop in the dmesgs (across a serial console):

  exregion-0182 [30] ex_system_memory_space: system_memory 0 (32 width) Address=0000000023FDFFC0
  exregion-0182 [30] ex_system_memory_space: system_memory 1 (32 width) Address=0000000023FDFFC0
  exregion-0287 [30] ex_system_io_space_han: system_iO 1 (8 width) Address=00000000000000B2
  exregion-0182 [29] ex_system_memory_space: system_memory 0 (32 width) Address=0000000023FDFFC0

'git bisect' narrowed the problematic commit to:

  commit 292dd876ee765c478b27c93cc51e93a558ed58bf
  Merge: d4ec6c7cc9a15a7a529719bc3b84f46812f9842e
  9fdb62af92c741addbea15545f214a6e89460865
  Author: Len Brown <len.brown@intel.com>
  Date:   Fri Jan 27 17:18:29 2006 -0500

      Pull release into acpica branch

This commit had a slightly different bug from all the other ones I
marked as bad.  This one hung on the first S3 sleep, with the same
endless loop pattern as the other bad ones (but they hang on the
second S3 sleep).

Below is the 'git bisect log', which for fun you can put in some file
and feed to 'git bisect replay somefile' :

$ git bisect log
git-bisect start
# good: [f3bcf72eb85aba88a7bd0a6116dd0b5418590dbe] Linux v2.6.16-rc1
git-bisect good f3bcf72eb85aba88a7bd0a6116dd0b5418590dbe
# bad: [e4f9aae0d74cb7d2fd5f0eb315cf9de1118fe260] Linux v2.6.16-rc2
git-bisect bad e4f9aae0d74cb7d2fd5f0eb315cf9de1118fe260
# good: [a6df590dd8b7644c8e298e3b13442bcd6ceeb739] Merge branch 'for-linus' of master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband
git-bisect good a6df590dd8b7644c8e298e3b13442bcd6ceeb739
# good: [e0e851cf30f1a9bd2e2a7624e9810378d6a2b072] reiserfs: reiserfs hang and performance fix for data=journal mode
git-bisect good e0e851cf30f1a9bd2e2a7624e9810378d6a2b072
# bad: [59ed2f59e4ea6a32f9591e378da7935f713a7000] Merge branch 'release' of git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6
git-bisect bad 59ed2f59e4ea6a32f9591e378da7935f713a7000
# good: [9fdb62af92c741addbea15545f214a6e89460865] [ACPI] merge 3549 4320 4485 4588 4980 5483 5651 acpica asus fops pnpacpi branches into release
git-bisect good 9fdb62af92c741addbea15545f214a6e89460865
# good: [61ee9cd5f2e76859222c1d64394ae633f9080163] PowerPC/PCI Hotplug build break
git-bisect good 61ee9cd5f2e76859222c1d64394ae633f9080163
# good: [e6da74e1f20ea7822e52a9e4fbd3d25bd907e471] Merge with /pub/scm/linux/kernel/git/torvalds/linux-2.6.git
git-bisect good e6da74e1f20ea7822e52a9e4fbd3d25bd907e471
# bad: [b8e4d89357fc434618a59c1047cac72641191805] [ACPI] ACPICA 20060127
git-bisect bad b8e4d89357fc434618a59c1047cac72641191805
# bad: [292dd876ee765c478b27c93cc51e93a558ed58bf] Pull release into acpica branch
git-bisect bad 292dd876ee765c478b27c93cc51e93a558ed58bf
# good: [d4ec6c7cc9a15a7a529719bc3b84f46812f9842e] [ACPI] remove "Resource isn't an IRQ" warning
git-bisect good d4ec6c7cc9a15a7a529719bc3b84f46812f9842e
