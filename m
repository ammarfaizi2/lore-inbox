Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274291AbRIYAce>; Mon, 24 Sep 2001 20:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274292AbRIYAc1>; Mon, 24 Sep 2001 20:32:27 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:63762 "HELO dvmwest.gt.owl.de")
	by vger.kernel.org with SMTP id <S274291AbRIYAcR> convert rfc822-to-8bit;
	Mon, 24 Sep 2001 20:32:17 -0400
Date: Tue, 25 Sep 2001 02:32:41 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Wrong SCSI bus scanning
Message-ID: <20010925023241.F14771@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux mail 2.4.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

For me, SCSI bus # 2 gets double-assigned. Physical layout
is currently:

	Bus 0:	AIC7xxx (U160 onboard)
		- ID0:	IBM DDYS-T18350N
		
	Bus 1:	AIC7xxx (2nd U160 onboard bus)
		- unused
	
	Bus 2:	sym53c8xx ('875)
		- ID1:	PLEXTOR CD-R PX-W1210S
		- ID2:	PLEXTOR CD-ROM PX-40TS
		- ID3:	PIONEER DVD-ROM DVD-305

	Bus 3:	ncr53c8xx ('810)
		- ID0:	HP CD-Writer 6020
		- ID1:	PLASMON CDR4220

The U160 controller attaches to my boot disk, so it is compiled-in.
Both other drivers are modules.

When I insert modules for busses #2 and #3, *both* of them get
bus #2 assigned:

==> before additional modules:
weiss-ich-doch-nicht:~# cdrecord -scanbus
Cdrecord 1.10 (i686-pc-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling
Linux sg driver version: 3.1.20
Using libscg version 'schily-0.5'
scsibus0:
        0,0,0     0) 'IBM     ' 'DDYS-T18350N    ' 'S96H' Disk
        0,1,0     1) *
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *

==> after sym53c8xx:
weiss-ich-doch-nicht:~# cdrecord -scanbus
Cdrecord 1.10 (i686-pc-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling
Linux sg driver version: 3.1.20
Using libscg version 'schily-0.5'
scsibus0:
        0,0,0     0) 'IBM     ' 'DDYS-T18350N    ' 'S96H' Disk
        0,1,0     1) *
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *
scsibus2:
        2,0,0   200) *
        2,1,0   201) 'PLEXTOR ' 'CD-R   PX-W1210S' '1.02' Removable CD-ROM
        2,2,0   202) 'PLEXTOR ' 'CD-ROM PX-40TS  ' '1.12' Removable CD-ROM
        2,3,0   203) 'PIONEER ' 'DVD-ROM DVD-305 ' '1.03' Removable CD-ROM
        2,4,0   204) *
        2,5,0   205) *
        2,6,0   206) *
        2,7,0   207) *

==> after additional insertion of ncr53c8xx:
Cdrecord 1.10 (i686-pc-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling
Linux sg driver version: 3.1.20
Using libscg version 'schily-0.5'
scsibus0:
        0,0,0     0) 'IBM     ' 'DDYS-T18350N    ' 'S96H' Disk
        0,1,0     1) *
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *
scsibus2:
        2,0,0   200) 'HP      ' 'CD-Writer 6020  ' '1.07' Removable CD-ROM
        2,1,0   201) 'PLEXTOR ' 'CD-R   PX-W1210S' '1.02' Removable CD-ROM
        2,2,0   202) 'PLEXTOR ' 'CD-ROM PX-40TS  ' '1.12' Removable CD-ROM
        2,3,0   203) 'PIONEER ' 'DVD-ROM DVD-305 ' '1.03' Removable CD-ROM
        2,4,0   204) *
        2,5,0   205) *
        2,6,0   206) *
        2,7,0   207) *

==> Now, /proc/scsi/scsi contains:

weiss-ich-doch-nicht:/proc/scsi# cat scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T18350N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 01 Lun: 00 <---------------------------
  Vendor: PLEXTOR  Model: CD-R   PX-W1210S Rev: 1.02
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 02 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-40TS   Rev: 1.12
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 03 Lun: 00
  Vendor: PIONEER  Model: DVD-ROM DVD-305  Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: HP       Model: CD-Writer 6020   Rev: 1.07
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 01 Lun: 00 <---------------------------
  Vendor: PLASMON  Model: CDR4220          Rev: 1.20
  Type:   CD-ROM                           ANSI SCSI revision: 02


...which is obviously wrong. Any suggestion on where to start
to search the bug?

MfG, JBG

-- 
Jan-Benedict Glaw . jbglaw@lug-owl.de . +49-172-7608481
