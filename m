Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268675AbRHBTAm>; Thu, 2 Aug 2001 15:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268556AbRHBTAd>; Thu, 2 Aug 2001 15:00:33 -0400
Received: from foobar.isg.de ([62.96.243.63]:2823 "HELO mail.isg.de")
	by vger.kernel.org with SMTP id <S268511AbRHBTAR>;
	Thu, 2 Aug 2001 15:00:17 -0400
Message-ID: <3B69A346.1736EC18@isg.de>
Date: Thu, 02 Aug 2001 21:00:22 +0200
From: Lutz Vieweg <lkv@isg.de>
Organization: Innovative Software AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: German, de, en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: scsi drivers in 2.4.6/7 fail badly on Alpha CPU / DP264 / on-board 7895 
 or Symbios 53c895
In-Reply-To: <200107310120.f6V1KGI27669@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" wrote:

> >now that I've upgraded the DDYS disk to firmware S96H I ran the
> >tests once again.
> >
> >Well, the errors did not went away (the queue-length was still
> >limited to 24 from the tests I did before, but this limit didn't
> >help either):
> 
> Hmm.  The messages indicate that some transactions never completed
> even thought the bus is completely idle.  The target seems to be functional
> too since we can select it and issue abort messages.  So the question
> becomes, "Who lost the transactions?"

Justin, I now somehow believe the problem may be outside of the
low-level SCSI drivers and due to some other change in the kernel:

I just installed an extra Symbios 53c895 Controller (sym53c8xx driver)
in the Alpha system and connected the harddisk to it.

But with 2.4.6/2.4.7 (_and_ 2.4.7-ac1) there were errors, too, and the
behaviour was quite similar to what I experienced with the on-board
7895 controller: No problems when reading, no problem when only
writing small amounts of data, but when lots of blocks get dumped
to disk, scsi-errors occur - from the Symbios driver, they looked like
this:

sym53c895-0:6: ERROR (40:0) (0-20-1) (1f/9f) @ (script ce0:1000bf04).
sym53c895-0: script cmd = 88080000
sym53c895-0: regdump: da 10 c0 9f 47 1f 06 0f 36 00 86 20 80 00 08 01 00 c0 4d c0 08 ff ff ff.
sym53c895-0: Downloading SCSI SCRIPTS.
sym53c895-0:6: ERROR (40:0) (0-20-0) (1f/9f) @ (script ce0:10013f00).
sym53c895-0: script cmd = 88080000
sym53c895-0: regdump: da 10 c0 9f 47 1f 06 0f 3a 00 86 20 80 01 08 01 00 18 c8 7f 08 ff ff ff.
sym53c895-0: Downloading SCSI SCRIPTS.
sym53c895-0:6: ERROR (40:0) (0-20-0) (1f/9f) @ (script ce0:10007f04).
sym53c895-0: script cmd = 88080000
sym53c895-0: regdump: da 10 c0 9f 47 1f 06 0f 76 00 86 20 80 01 00 01 00 18 c8 7f 08 ff ff ff.
sym53c895-0: Downloading SCSI SCRIPTS.
sym53c895-0:6: ERROR (40:0) (0-a0-0) (0/f) @ (script ce0:10001f04).
sym53c895-0: script cmd = 88080000
sym53c895-0: regdump: da 10 c0 0f 47 00 06 0f 56 00 86 a0 80 01 08 01 00 c8 4d c0 08 ff ff ff.
sym53c895-0: Downloading SCSI SCRIPTS.
scsi : aborting command due to timeout : pid 0, scsi2, channel 0, id 6, lun 0 Write (10) 00 00 bc 0d b0 00 00 68 00 
sym53c8xx_abort: pid=0 serial_number=55858 serial_number_at_timeout=55858
scsi : aborting command due to timeout : pid 0, scsi2, channel 0, id 6, lun 0 Write (10) 00 00 bc 0e c8 00 00 40 00 
sym53c8xx_abort: pid=0 serial_number=55859 serial_number_at_timeout=55859
scsi : aborting command due to timeout : pid 0, scsi2, channel 0, id 6, lun 0 Write (10) 00 00 bc 0e 40 00 00 20 00 
sym53c8xx_abort: pid=0 serial_number=55860 serial_number_at_timeout=55860
scsi : aborting command due to timeout : pid 0, scsi2, channel 0, id 6, lun 0 Write (10) 00 00 bc 0d 80 00 00 20 00 
sym53c8xx_abort: pid=0 serial_number=55861 serial_number_at_timeout=55861
scsi : aborting command due to timeout : pid 0, scsi2, channel 0, id 6, lun 0 Write (10) 00 00 bc 0e 68 00 00 08 00 
sym53c8xx_abort: pid=0 serial_number=55862 serial_number_at_timeout=55862
scsi : aborting command due to timeout : pid 0, scsi2, channel 0, id 6, lun 0 Write (10) 00 00 bc 0e 78 00 00 48 00 
sym53c8xx_abort: pid=0 serial_number=55863 serial_number_at_timeout=55863
scsi : aborting command due to timeout : pid 0, scsi2, channel 0, id 6, lun 0 Write (10) 00 00 bc 0f 18 00 00 68 00 
sym53c8xx_abort: pid=0 serial_number=55864 serial_number_at_timeout=55864
scsi : aborting command due to timeout : pid 0, scsi2, channel 0, id 6, lun 0 Write (10) 00 00 bc 0e 20 00 00 10 00 
sym53c8xx_abort: pid=0 serial_number=55865 serial_number_at_timeout=55865
scsi : aborting command due to timeout : pid 0, scsi2, channel 0, id 6, lun 0 Write (10) 00 00 bc 0d b0 00 00 68 00 
sym53c8xx_abort: pid=0 serial_number=55866 serial_number_at_timeout=55866
scsi : aborting command due to timeout : pid 0, scsi2, channel 0, id 6, lun 0 Write (10) 00 00 bc 0e c8 00 00 40 00 
sym53c8xx_abort: pid=0 serial_number=55867 serial_number_at_timeout=55867
scsi : aborting command due to timeout : pid 0, scsi2, channel 0, id 6, lun 0 Write (10) 00 00 bc 0e 40 00 00 20 00 
sym53c8xx_abort: pid=0 serial_number=55868 serial_number_at_timeout=55868
scsi : aborting command due to timeout : pid 0, scsi2, channel 0, id 6, lun 0 Write (10) 00 00 bc 0d 80 00 00 20 00 
sym53c8xx_abort: pid=0 serial_number=55869 serial_number_at_timeout=55869
scsi : aborting command due to timeout : pid 0, scsi2, channel 0, id 6, lun 0 Write (10) 00 00 bc 0e 68 00 00 08 00 
sym53c8xx_abort: pid=0 serial_number=55870 serial_number_at_timeout=55870
scsi : aborting command due to timeout : pid 0, scsi2, channel 0, id 6, lun 0 Write (10) 00 00 bc 0e 78 00 00 48 00 
sym53c8xx_abort: pid=0 serial_number=55871 serial_number_at_timeout=55871
scsi : aborting command due to timeout : pid 0, scsi2, channel 0, id 6, lun 0 Write (10) 00 00 bc 0f 18 00 00 68 00 
sym53c8xx_abort: pid=0 serial_number=55872 serial_number_at_timeout=55872
scsi : aborting command due to timeout : pid 0, scsi2, channel 0, id 6, lun 0 Write (10) 00 00 bc 0e 20 00 00 10 00 
sym53c8xx_abort: pid=0 serial_number=55873 serial_number_at_timeout=55873
SCSI host 2 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 2 channel 0.
sym53c8xx_reset: pid=0 reset_flags=2 serial_number=55874 serial_number_at_timeout=55874
sym53c895-0: Downloading SCSI SCRIPTS.
SCSI host 2 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 2 channel 0.
sym53c8xx_reset: pid=0 reset_flags=2 serial_number=55882 serial_number_at_timeout=55882
sym53c895-0: Downloading SCSI SCRIPTS.
SCSI host 2 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 2 channel 0.
sym53c8xx_reset: pid=0 reset_flags=2 serial_number=55890 serial_number_at_timeout=55890
sym53c895-0: Downloading SCSI SCRIPTS.
SCSI host 2 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 2 channel 0.
sym53c8xx_reset: pid=0 reset_flags=2 serial_number=55898 serial_number_at_timeout=55898
sym53c895-0: Downloading SCSI SCRIPTS.
SCSI host 2 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 2 channel 0.
sym53c8xx_reset: pid=0 reset_flags=2 serial_number=55906 serial_number_at_timeout=55906
sym53c895-0: Downloading SCSI SCRIPTS.


I double checked that I _never_ get such errors with either
the aic7xxx driver or the sym53c8xx driver within kernel 2.4.2 -
so it's probably not any kind of hardware fault and there must
be some important difference between the kernel versions that
trigger the bug - but it's unlikely that both aic7xxx and
sym53c8xx are broken in such a way to create these similar
errors.

For this reason, I CC'ed this mail to linux-scsi@vger.kernel.org
and linux-kernel@vger.kernel.org - I hope someone has an idea
what may have changed in the kernel that causes the low-level
scsi drivers to fail in such a way.

Anyone else here with problem or success stories on the
latest kernels/scsi/Alpha CPU machines?

Regards,

Lutz Vieweg

--
 Dipl. Phys. Lutz Vieweg | email: lkv@isg.de
 Innovative Software AG  | Phone/Fax: +49-69-505030 -120/-505
 Feuerbachstrasse 26-32  | http://www.isg.de/people/lkv/
 60325 Frankfurt am Main | ^^^ PGP key available here ^^^
