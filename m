Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbUBVS1Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 13:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUBVS1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 13:27:25 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:14513 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261719AbUBVS1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 13:27:23 -0500
From: oschoett@t-online.de (Oliver Schoett)
To: linux-kernel@vger.kernel.org
CC: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
CC: <Oliver.Heilmann@drkw.com>
Subject: Re: SiS 746FX AGP 3.0 problem
References: <200402210044.55107.volker.hemmann@heim10.tu-clausthal.de>
Date: 22 Feb 2004 19:22:27 +0100
In-Reply-To: <1rsJ5-430-3@gated-at.bofh.it>
Message-ID: <s23znbbq8ik.fsf@oschoett.dialin.t-online.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Seen: false
X-ID: bLD4jiZXQeHJGuQzzwZuG9v2+OLGpV9Ln9CE1wnMsTHwTzgwnF+Xwh
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de> writes:

 > [1] testgart first run, garbled output
 > [2] testgart second run, immidiatly after the first one, 'repairs' output.
 > 
 > After a first run of testgart, X will startup fine too.

Looks pretty much like the timing problem Oliver Heilmann observed on
the SiS 648FX and SiS 648 north bridge chips, which caused similar
problems on my SiS 648 system: modules would fail to initialise or
wedge the system on first use (see
<s23oerukbnp.fsf@oschoett.dialin.t-online.de>), but work fine if the
card had been initialised some other way since boot.

It appears that the chips are electrically unstable for ca. 5ms after
switching them to AGP 3.0, and the effects vary depending on what your
driver does in that interval.

Try Oliver Heilmann's patch from the linux-kernel post

   Date: Thu, 12 Feb 2004 00:10:08 +0100
   Subject: [PATCH] AGP 648[FX] cleaned+fixed but still have problem. Plz help.
   Message-ID: <1076540358.609.60.camel@cobra>

adjusting so that the 10ms timeout (see the call to schedule_timeout
in the patch) is done also in the case of your 746FX chip.  It may
well be that the instability appears in a larger class of SiS chips
than we know so far.

Instead of patching the patch, it is perhaps easier for a first test
to just use the forced timeout shown in the patch below (apply to a
clean kernel with patch option -p1; patches fine into 2.6.3).  That
already solved the problems on my machine and showed that my SiS 648
had the timing problem.

Regards,

Oliver Schoett


--- linux-2.6.2/drivers/char/agp/generic.c	2004-02-07 15:05:02.000000000 +0100
+++ linux-2.6.2-sis648/drivers/char/agp/generic.c	2004-02-07 15:19:16.000000000 +0100
@@ -524,6 +524,10 @@
 		printk(KERN_INFO PFX "Putting AGP V%d device at %s into %dx mode\n",
 				agp_v3 ? 3 : 2, pci_name(device), mode);
 		pci_write_config_dword(device, agp + PCI_AGP_COMMAND, command);
+
+		/* work around SIS648 instability by delaying a bit */
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout((HZ+99)/100); /* >= 1/100th of a second */
 	}
 }
 EXPORT_SYMBOL(agp_device_command);

