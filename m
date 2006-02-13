Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWBMDIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWBMDIB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 22:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWBMDIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 22:08:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26336 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750815AbWBMDH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 22:07:59 -0500
Date: Sun, 12 Feb 2006 19:05:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, Greg KH <greg@kroah.com>,
       linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       "Yu, Luming" <luming.yu@intel.com>,
       "Ben Castricum" <lk@bencastricum.nl>, sanjoy@mrao.cam.ac.uk,
       Helge Hafting <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       linux-usb-devel@lists.sourceforge.net,
       Gerrit =?ISO-8859-1?B?QnJ1Y2ho5HVzZXI=?= <gbruchhaeuser@gmx.de>,
       Nicolas.Mailhot@LaPoste.net, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>, Patrizio Bassi <patrizio.bassi@gmail.com>,
       =?ISO-8859-1?B?Qmr2cm4=?= Nilsson <bni.swe@gmail.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>, "P. Christeas" <p_christ@hol.gr>,
       ghrt <ghrt@dial.kappa.ro>, jinhong hu <jinhong.hu@gmail.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-scsi@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: Linux 2.6.16-rc3
Message-Id: <20060212190520.244fcaec.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We still have some serious bugs, several of which are in 2.6.15 as well:

- The scsi_cmd leak, which I don't think is fixed.

- The some-x86_64-boxes-use-GFP_DMA-from-bio-layer bug, which causes
  oom-killings.

- The skbuff_head_cache leak, which has been around since at least
  2.6.11.  Another box-killer, but is seems very hard to hit. 
  (mki@mozone.net, "the dreaded oom-killer (reproducable in 2.6.11 -
  2.6.16-rc1) :(")

- http://bugzilla.kernel.org/show_bug.cgi?id=6060: an apparent ACPI
  regression.

- Nathan's "sysfs-related oops during module unload", which Greg seems to
  have under control.

- http://bugzilla.kernel.org/show_bug.cgi?id=6049 - another acpi
  regression.  We have the actual offending commit here.

- A couple of random tty-related oopses reported by Jesper Juhl.  We
  don't know why these happened - they appear to not be related to the tty
  buffering changes.

- http://bugzilla.kernel.org/show_bug.cgi?id=6038, another box-killing
  acpi regression.

- Various reports similar to
  http://bugzilla.kernel.org/show_bug.cgi?id=6011, seemingly related to USB
  PCI quirk handling.

- "Ben Castricum" <lk@bencastricum.nl> reports that ppp has started
  exhibiting mysterious failures (again).

- Nasty warnings from scsi about kobject-layer things being called from
  irq context.  James has a push-it-to-process-context patch which sadly
  assumes kmalloc() is immortal, but no other fix seems to have offered
  itself.

- In http://bugzilla.kernel.org/show_bug.cgi?id=5989, Sanjoy Mahajan has
  another regression, but he's off collecting more info.

- Helge Hafting reports a usb printer regression - I don't know if that's
  still live?

- "Carlo E.  Prelz" <fluido@fluido.as> has another USB/ehci regression
  ("ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15
  rc1").

- Gerrit Bruchhuser <gbruchhaeuser@gmx.de> seems to have an aic7xxx
  regression ("AHA-7850 doesn't detect scanner anymore") but he doesn't say
  which kernel got it right.

- http://bugzilla.kernel.org/show_bug.cgi?id=5914 - a sata bug (which is
  quite unremarkable :(), but this one is reported to eat filesystems.

- Patrizio Bassi <patrizio.bassi@gmail.com> has an alsa suspend
  regression ("alsa suspend/resume continues to fail for ens1370")

- Bjorn Nilsson <bni.swe@gmail.com> has an sk99lin regression ("3COM
  3C940, does not work anymore after upgrade to 2.6.15")

- Andrey Borzenkov <arvidjaar@mail.ru> has an acpi-cpufreq regression
  ("cannot unload acpi-cpufreq")

- "P.  Christeas" <p_christ@hol.gr> had an autofs regression ("Regression
  in Autofs, 2.6.15-git"), whic might be fixed now?

- ghrt <ghrt@dial.kappa.ro> reports an alsa regression ("PROBLEM: SB
  Live!  5.1 (emu10k1, rev.  0a) doesn't work with 2.6.15")

- jinhong hu <jinhong.hu@gmail.com> reports what appears to be a qlogic
  regression ("kernel 2.6.15 scsi problem")

- Benjamin LaHaise <bcrl@kvack.org> had an NFS problem ("NFS processes
  gettting stuck in D with currrent git").



These are clear regressions, reported in the last month by people who are
willing to test patches.  They're almost all in subsystems which have
active and professional maintainers.
