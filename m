Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbTENA7S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 20:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263691AbTENA7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 20:59:18 -0400
Received: from tantale.fifi.org ([216.27.190.146]:45204 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S263688AbTENA7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 20:59:06 -0400
To: linux-kernel@vger.kernel.org
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Cryptic SCSI error messages
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 13 May 2003 18:11:50 -0700
Message-ID: <87el325o2x.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen these three times over the last two weeks...

  * Setup

      Kernel 2.4.20 + LVM 1.0.7 (both vfs-lock and lvm patches) +
      ptrace patch.

      A LVM array comprising 5 SCSI discs of various sizes and makes.

      This computer with this array has been working flawlessly for
      over 3 years. The last disk was added to the LVM array in early
      February 2003. Between February 2003 and end of April 2003, this
      server has been up all the time without a single reboot.


  * The problem.

      1. The SCSI subsystem craps out a cryptic message:

          SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
          I/O error: dev 08:20, sector 32932328

         It's always "return code = 10000" and the problem always
         happens with disk 0/0/2/0.

      2. Once, The SCSI subsystem queued an ABORT, failed, and the
         drive "host 0 channel 0 id 2 lun 0" was taken offline.

      3. LVM and ext3 crap out soon afterwards.

      4. Sometimes, the crash is severe enough that the watchdog
         triggers a machine reboot.

      5. The drive stays stuck (not seen either in the BIOS SCSI scan
         nor in the linux SCSI scan despite soft and hard resets)
         until the machine is powered off and then back on.

  * Questions:

     - What is this error 10000 which seems to be the source of the
       trouble? Is my disk dying?

     - I will run more tests tonight on this disk and will report my
       findings later. I intend to run a read-only badblocks, maybe
       followed by a non-destructive write badblocks run (if the
       read-only tests shows no problem). Any other ideas?

     - Could it be a driver problem?

     - And BTW, I find aic7xxx's habit of taking drives offline when
       they show troubles extremely annoying: in this case it might be
       justified since the drive seems to have locked up, but I've
       seen it happen on CD-Rom drives which are busy retrying to read
       a bad sector. Taking a CD-Rom drive offline for failing to be
       responsive during I/O error recovery operation is very
       heavy-handed :-)

  * SCSI info:

     - aic7xxx boot parameters:

         aic7xxx=tag_info:{{,,,,8}}

         The IBM drive has a bug with tagged queuing and anything
         higher than 8 gives me trouble.

     - /proc/scsi/scsi

          Attached devices: 
          Host: scsi0 Channel: 00 Id: 00 Lun: 00
            Vendor: SEAGATE  Model: ST336752LW       Rev: 0004
            Type:   Direct-Access                    ANSI SCSI revision: 03
          Host: scsi0 Channel: 00 Id: 01 Lun: 00
            Vendor: SEAGATE  Model: ST336752LW       Rev: 0002
            Type:   Direct-Access                    ANSI SCSI revision: 03
          Host: scsi0 Channel: 00 Id: 02 Lun: 00
            Vendor: SEAGATE  Model: ST318451LW       Rev: 0003
            Type:   Direct-Access                    ANSI SCSI revision: 03
          Host: scsi0 Channel: 00 Id: 03 Lun: 00
            Vendor: SEAGATE  Model: ST318451LW       Rev: 0002
            Type:   Direct-Access                    ANSI SCSI revision: 03
          Host: scsi0 Channel: 00 Id: 04 Lun: 00
            Vendor: IBM      Model: DRVS18V          Rev: 0140
            Type:   Direct-Access                    ANSI SCSI revision: 03
          Host: scsi0 Channel: 00 Id: 05 Lun: 00
            Vendor: SEAGATE  Model: ST39103LW        Rev: 0002
            Type:   Direct-Access                    ANSI SCSI revision: 02
          Host: scsi0 Channel: 00 Id: 06 Lun: 00
            Vendor: PIONEER  Model: CD-ROM DR-U24X   Rev: 1.01
            Type:   CD-ROM                           ANSI SCSI revision: 02

    - /proc/scsi/aic7xxx/0

        Adaptec AIC7xxx driver version: 6.2.8
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

        Serial EEPROM:
        0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 
        0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 0xc33a 
        0xb8f5 0x7c5d 0x2807 0x0010 0x0300 0xffff 0xffff 0xffff 
        0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0x0250 0x9650 

        Channel A Target 0 Negotiation Settings
                User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
                Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
                Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
                Channel A Target 0 Lun 0 Settings
                        Commands Queued 5822349
                        Commands Active 0
                        Command Openings 35
                        Max Tagged Openings 253
                        Device Queue Frozen Count 0
        Channel A Target 1 Negotiation Settings
                User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
                Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
                Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
                Channel A Target 1 Lun 0 Settings
                        Commands Queued 49712
                        Commands Active 0
                        Command Openings 45
                        Max Tagged Openings 253
                        Device Queue Frozen Count 0
        Channel A Target 2 Negotiation Settings
                User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
                Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
                Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
                Channel A Target 2 Lun 0 Settings
                        Commands Queued 31535
                        Commands Active 0
                        Command Openings 35
                        Max Tagged Openings 253
                        Device Queue Frozen Count 0
        Channel A Target 3 Negotiation Settings
                User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
                Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
                Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
                Channel A Target 3 Lun 0 Settings
                        Commands Queued 13690
                        Commands Active 0
                        Command Openings 253
                        Max Tagged Openings 253
                        Device Queue Frozen Count 0
        Channel A Target 4 Negotiation Settings
                User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
                Goal: 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
                Curr: 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
                Channel A Target 4 Lun 0 Settings
                        Commands Queued 12479
                        Commands Active 0
                        Command Openings 8
                        Max Tagged Openings 8
                        Device Queue Frozen Count 0
        Channel A Target 5 Negotiation Settings
                User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
                Goal: 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
                Curr: 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
                Channel A Target 5 Lun 0 Settings
                        Commands Queued 2678
                        Commands Active 0
                        Command Openings 253
                        Max Tagged Openings 253
                        Device Queue Frozen Count 0
        Channel A Target 6 Negotiation Settings
                User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
                Goal: 10.000MB/s transfers (10.000MHz, offset 8)
                Curr: 10.000MB/s transfers (10.000MHz, offset 8)
                Channel A Target 6 Lun 0 Settings
                        Commands Queued 5
                        Commands Active 0
                        Command Openings 1
                        Max Tagged Openings 0
                        Device Queue Frozen Count 0
        Channel A Target 7 Negotiation Settings
                User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Channel A Target 8 Negotiation Settings
                User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Channel A Target 9 Negotiation Settings
                User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Channel A Target 10 Negotiation Settings
                User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Channel A Target 11 Negotiation Settings
                User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Channel A Target 12 Negotiation Settings
                User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Channel A Target 13 Negotiation Settings
                User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Channel A Target 14 Negotiation Settings
                User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Channel A Target 15 Negotiation Settings
                User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)


  * Log files

     - First incident:

          SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
           I/O error: dev 08:20, sector 12052208
           I/O error: dev 08:20, sector 12508912
           I/O error: dev 08:20, sector 10387952
          EXT3-fs error (device lvm(58,5)): ext3_get_inode_loc: unable to read inode block - inode=6717643, block=13434894
          Aborting journal on device lvm(58,5).
          Remounting filesystem read-only
           I/O error: dev 08:20, sector 8815056
          EXT3-fs error (device lvm(58,5)): ext3_get_inode_loc: unable to read inode block - inode=6619207, block=13238282
           I/O error: dev 08:20, sector 10387952
          EXT3-fs error (device lvm(58,5)): ext3_get_inode_loc: unable to read inode block - inode=6717649, block=13434894
           I/O error: dev 08:20, sector 32932320
           I/O error: dev 08:20, sector 34243064
           I/O error: dev 08:20, sector 11698640
           I/O error: dev 08:20, sector 11698672

           ... many more of these until poweroff.


     - Second incident:

           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18828424
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18828432
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18828440
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18828448
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18828456
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18828464
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18828472
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18828480
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18828488
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18828496
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18828504
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18828512
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18828520
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18828552
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18828560
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18828568
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18838616
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18838624
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18838632
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18838640
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18838648
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18991168
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18991176
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18991184
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18991192
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18991200
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18991208
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18991216
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18991224
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 18991232

           ... many more of these until poweroff.

     - Third incident:

           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
            I/O error: dev 08:20, sector 32932328
           scsi0:0:2:0: Attempting to queue an ABORT message
           scsi0: Dumping Card State while idle, at SEQADDR 0x9
           ACCUM = 0x0, SINDEX = 0x68, DINDEX = 0xe4, ARG_2 = 0x0
           HCNT = 0x0 SCBPTR = 0x14
           SCSISEQ = 0x12, SBLKCTL = 0xa
            DFCNTRL = 0x0, DFSTATUS = 0x89
           LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
           SSTAT0 = 0x0, SSTAT1 = 0x8
           SCSIPHASE = 0x0
           STACK == 0x3, 0x108, 0x160, 0x0
           SCB count = 124
           Kernel NEXTQSCB = 74
           Card NEXTQSCB = 74
           QINFIFO entries: 
           Waiting Queue entries: 
           Disconnected Queue entries: 
           QOUTFIFO entries: 
           Sequencer Free SCB List: 20 19 6 1 24 26 3 15 29 11 27 0 23 22 8 5 21 28 25 2 16 17 13 12 10 31 30 14 4 9 18 7 
           Sequencer SCB Info: 0(c 0x60, s 0x7, l 0, t 0xff) 1(c 0x60, s 0x7, l 0, t 0xff) 2(c 0x60, s 0x7, l 0, t 0xff) 3(c 0x60, s 0x7, l 0, t 0xff) 4(c 0x60, s 0x7, l 0, t 0xff) 5(c 0x60, s 0x7, l 0, t 0xff) 6(c 0x60, s 0x7, l 0, t 0xff) 7(c 0x60, s 0x7, l 0, t 0xff) 8(c 0x60, s 0x7, l 0, t 0xff) 9(c 0x60, s 0x7, l 0, t 0xff) 10(c 0x60, s 0x7, l 0, t 0xff) 11(c 0x60, s 0x7, l 0, t 0xff) 12(c 0x60, s 0x7, l 0, t 0xff) 13(c 0x60, s 0x7, l 0, t 0xff) 14(c 0x60, s 0x7, l 0, t 0xff) 15(c 0x60, s 0x7, l 0, t 0xff) 16(c 0x60, s 0x7, l 0, t 0xff) 17(c 0x60, s 0x7, l 0, t 0xff) 18(c 0x60, s 0x7, l 0, t 0xff) 19(c 0x60, s 0x7, l 0, t 0xff) 20(c 0x60, s 0x7, l 0, t 0xff) 21(c 0x60, s 0x7, l 0, t 0xff) 22(c 0x60, s 0x7, l 0, t 0xff) 23(c 0x60, s 0x7, l 0, t 0xff) 24(c 0x60, s 0x7, l 0, t 0xff) 25(c 0x60, s 0x7, l 0, t 0xff) 26(c 0x60, s 0x7, l 0, t 0xff) 27(c 0x60, s 0x7, l 0, t 0xff) 28(c 0x60, s 0x7, l 0, t 0xff) 29(c 0x60, s 0x7, l 0, t 0xff) 30(c 0x60, s 0x7, l 0, t 0xff) 31(c 0x!
 60, s 0x7, l 0, t
           0xff) 
           Pending list: 58(c 0x64, s 0x27, l 0)
           Kernel Free SCB list: 104 78 65 57 97 83 73 1 45 101 21 86 52 108 17 19 7 99 102 63 89 81 109 50 66 16 13 68 87 111 8 117 14 118 12 107 91 5 6 36 113 15 23 26 69 47 71 103 98 43 42 39 64 119 2 35 9 80 70 88 10 62 20 22 67 3 18 11 60 31 76 40 77 114 106 82 24 105 93 59 115 112 54 46 75 51 48 96 34 72 100 123 90 27 53 92 110 28 30 41 85 29 79 32 33 55 116 25 4 56 95 38 44 49 84 61 37 94 0 122 121 120 
           DevQ(0:0:0): 0 waiting
           DevQ(0:1:0): 0 waiting
           DevQ(0:2:0): 0 waiting
           DevQ(0:3:0): 0 waiting
           DevQ(0:4:0): 0 waiting
           DevQ(0:5:0): 0 waiting
           DevQ(0:6:0): 0 waiting
           (scsi0:A:2:0): Queuing a recovery SCB
           scsi0:0:2:0: Device is disconnected, re-queuing SCB
           Recovery code sleeping
           Recovery SCB completes
           Recovery code awake
           aic7xxx_abort returns 0x2002
           scsi0:0:2:0: Attempting to queue a TARGET RESET message
           scsi0:0:2:0: Command not found
           aic7xxx_dev_reset returns 0x2002
           (scsi0:A:2:0): Unexpected busfree in Message-in phase
           SEQADDR == 0x168
           scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 2 lun 0
           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 8000002
           sd08:20: old sense key None
           Non-extended sense class 0 code 0x0
            I/O error: dev 08:20, sector 32932320
           SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 4
            I/O error: dev 08:02, sector 7510488
           EXT3-fs error (device lvm(58,5)): ext3_get_inode_loc: unable to read inode block - inode=8126613, block=16252940
           Aborting journal on device lvm(58,5).
           Remounting filesystem read-only
           EXT3-fs error (device lvm(58,5)) in ext3_reserve_inode_write: IO failure
           EXT3-fs error (device lvm(58,5)) in ext3_dirty_inode: IO failure
            I/O error: dev 08:20, sector 1212904
           EXT3-fs error (device lvm(58,5)): ext3_get_inode_loc: unable to read inode block - inode=6144183, block=1

           ... more of these.


Thanks for any help,
Phil.
