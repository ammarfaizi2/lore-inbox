Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161414AbWJ3TAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161414AbWJ3TAe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161416AbWJ3TAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:00:33 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64975 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161399AbWJ3TAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 14:00:31 -0500
Subject: RE: x86-64 with nvidia MCP51 chipset: kernel does not find HPET
From: Lee Revell <rlrevell@joe-job.com>
To: "Langsdorf, Mark" <mark.langsdorf@amd.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Clemens Ladisch <clemens@ladisch.de>
In-Reply-To: <1449F58C868D8D4E9C72945771150BDF153774@SAUSEXMB1.amd.com>
References: <1449F58C868D8D4E9C72945771150BDF153774@SAUSEXMB1.amd.com>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 14:00:44 -0500
Message-Id: <1162234845.27037.37.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 11:07 -0600, Langsdorf, Mark wrote:
> > I have a 6 month old x86-64 machine with nvidia MCP51 chipset on which
> > the kernel does not detect the HPET.  According to HPET maintainer
> > Clemens Ladisch, this machine certainly has one, but it cannot be
> > enabled for lack of hardware documentation.
> > 
> > Is there anything I can do to help debug this?
> 
> If the hardware is not providing the HPET description in ACPI,
> there's little you can do, and most vendors do not provide
> the HPET description.
> 
> Do you know if there's an entry for HPET in the ACPI?

I'm not exactly an ACPI expert, but I do not think there is an entry for
HPET in the ACPI, as the check in arch/x86_64/kernel/io_apic.c fails:

 358                         /*
 359                          * All timer overrides on Nvidia are
 360                          * wrong unless HPET is enabled.
 361                          */
 362                         nvidia_hpet_detected = 0;
 363                         acpi_table_parse(ACPI_HPET,
 364                                         nvidia_hpet_check);
 365                         if (nvidia_hpet_detected == 0) {
 366                                 acpi_skip_timer_override = 1;
 367                                 printk(KERN_INFO "Nvidia board "
 368                                     "detected. Ignoring ACPI "
 369                                     "timer override.\n");
 370                         }

But, with some help from anonymous sources, I have been able to find the
HPET and make it work using a userspace driver that pokes registers by
mmap'ing /dev/mem.  So we just need a way to tell the kernel it's there.
Presumably this would require a PCI quirk.

Is this likely to be worth the trouble?

Lee


