Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVJAOEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVJAOEJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 10:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVJAOEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 10:04:08 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:1999 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750806AbVJAOEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 10:04:07 -0400
Subject: Re: Infinite interrupt loop, INTSTAT = 0
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>
In-Reply-To: <20050928183324.GA51793@dspnet.fr.eu.org>
References: <20050928134514.GA19734@dspnet.fr.eu.org>
	 <1127919909.4852.7.camel@mulgrave>
	 <20050928160744.GA37975@dspnet.fr.eu.org>
	 <1127924686.4852.11.camel@mulgrave>
	 <20050928171052.GA45082@dspnet.fr.eu.org>
	 <1127929909.4852.34.camel@mulgrave>
	 <20050928183324.GA51793@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Sat, 01 Oct 2005 09:03:54 -0500
Message-Id: <1128175434.4921.9.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 20:33 +0200, Olivier Galibert wrote:
> Ok, for git HEAD 95001ee9256df846e374f116c92ca8e0beec1527.  The system
> has the nice idea not to crash at the end, so I can fish everything
> out of /var/log/messages (kernel messages only):

Well ... at least that's slightly better behaviour ...

I'm afraid the initial analysis is that this is a bug in the adaptec
sequencer (again) which no-one has the docs to fix.  Guessing about the
cause, I'd say it's most likely some type of data overrun, so it might
be possible to change the operating parameters of the system so it no
longer trips ...

> Sep 28 20:21:16 m82 kernel: scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
> Sep 28 20:21:16 m82 kernel:         <Adaptec AIC7902 Ultra320 SCSI adapter>
> Sep 28 20:21:16 m82 kernel:         aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs
> Sep 28 20:21:16 m82 kernel: 
> Sep 28 20:21:16 m82 kernel:   Vendor: SEAGATE   Model: ST373207LC        Rev: 0003
> Sep 28 20:21:16 m82 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
> Sep 28 20:21:17 m82 kernel:  target0:0:0: asynchronous.
> Sep 28 20:21:17 m82 kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 4
> Sep 28 20:21:17 m82 kernel:  target0:0:0: Beginning Domain Validation
> Sep 28 20:21:17 m82 kernel:  target0:0:0: wide asynchronous.
> Sep 28 20:21:17 m82 kernel:  target0:0:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS RDSTRM RTI WRFLOW PCOMP (6.25 ns, offset 63)
> Sep 28 20:21:17 m82 kernel:  target0:0:0: Ending Domain Validation
> Sep 28 20:21:17 m82 kernel:   Vendor: SUPER     Model: GEM318            Rev: 0   
> Sep 28 20:21:17 m82 kernel:   Type:   Processor                          ANSI SCSI revision: 02
> Sep 28 20:21:17 m82 kernel:  target0:0:6: asynchronous.
> Sep 28 20:21:17 m82 kernel:  target0:0:6: Beginning Domain Validation
> Sep 28 20:21:17 m82 kernel:  target0:0:6: Ending Domain Validation
> Sep 28 20:21:17 m82 kernel: ACPI: PCI Interrupt 0000:02:02.1[B] -> GSI 33 (level, low) -> IRQ 209
> Sep 28 20:21:17 m82 kernel: scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
> Sep 28 20:21:17 m82 kernel:         <Adaptec AIC7902 Ultra320 SCSI adapter>
> Sep 28 20:21:17 m82 kernel:         aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs
> Sep 28 20:21:17 m82 kernel: 
> Sep 28 20:21:17 m82 kernel:   Vendor: VP-1252-  Model: FB951223-VOL#00   Rev: R001
> Sep 28 20:21:17 m82 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
> Sep 28 20:21:17 m82 kernel:  target1:0:0: asynchronous.
> Sep 28 20:21:17 m82 kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth 4
> Sep 28 20:21:17 m82 kernel:  target1:0:0: Beginning Domain Validation
> Sep 28 20:21:17 m82 kernel:  target1:0:0: wide asynchronous.
> Sep 28 20:21:17 m82 kernel:  target1:0:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS RTI WRFLOW PCOMP (6.25 ns, offset 127)

The first thing to try here is to bring the offset down to 63 like all
the other devices.  You can do this by

echo 63 > /sys/class/spi_transport/target1\:0\:0/max_offset
echo 1 > /sys/class/spi_transport/target1\:0\:0/revalidate

Which should retrigger the above domain validation but this time come
back with an offset of 63.

*before* getting to the mount on /dev/sdb1.

If that doesn't fix it, the next steps will be to begin lowering the
transmission parameters.

James


