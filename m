Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbUKEQ0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbUKEQ0y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 11:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbUKEQ0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 11:26:53 -0500
Received: from mailhost.digitalinterfacesltd.com ([62.69.87.37]:11019 "EHLO
	ntserver4.diluk.co.uk") by vger.kernel.org with ESMTP
	id S262716AbUKEQZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 11:25:14 -0500
Message-ID: <C18BA5DDB58DD511BD0700C0DF0DD4501EEC6A@NTSERVER4>
From: SUPPORT <support@4bridgeworks.com>
To: "'Matthew Wilcox'" <matthew@wil.cx>, Thomas Babut <thomas@babut.net>
Cc: linux-kernel@vger.kernel.org, Linux SCSI <linux-scsi@vger.kernel.org>,
       groudier@free.fr
Subject: RE: Kernel 2.6.x hangs with Symbios Logic 53c1010 Ultra3 SCSI Ada
	pter
Date: Fri, 5 Nov 2004 16:25:03 -0000 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4C354.013890D0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4C354.013890D0
Content-Type: text/plain;
	charset="iso-8859-1"

Hi Guys,

I've been seeing problems with various tape drives and PPR. And a SCSI 3 SE
disk is interesting as well! SE and PPR don't get on too well;) The problems
we are seeing are generally indicated by a "phase change 6-7" error. And I
know there are others who have had problems from various messages on this
list

This wouldn't be too much of a problem but rather than then reverting to
using legacy sync and wide it just keeps trying PPR - for ever as far as I
can make out. And the drives struggle on using async;(

The following may help as a temporary fix for those who are desperate. We
are using this while we get on with higher priority items and we find time
to look at it more closely.

--- 2.6.9a/drivers/scsi/scsi_scan.c	2004-10-11 03:58:24.000000000 +0100
+++ 2.6.9b/drivers/scsi/scsi_scan.c	2004-11-04 12:20:09.000000000 +0000
@@ -578,7 +578,7 @@
 	sdev->lockable = sdev->removable;
 	sdev->soft_reset = (inq_result[7] & 1) && ((inq_result[3] & 7) ==
2);
 
-	if (sdev->scsi_level >= SCSI_3 || (sdev->inquiry_len > 56 &&
+	if (/*sdev->scsi_level >= SCSI_3 ||*/ (sdev->inquiry_len > 56 &&
 		inq_result[56] & 0x04))
 		sdev->ppr = 1;
 	if (inq_result[7] & 0x60)

Using this all the drives I've tried that normally use PPR still use PPR.
The drives that do not support PPR no longer cause problems - PPR is no
longer sent to these problem drives.

Matthew - I have attached some bits of SCSI analyser traces which I hope may
be useful. An IBM SCSI 3 SE disk and a couple of LTO tape drives - IBM and
HP. The HP causes severe problems as modprobe hangs without the fix. I have
also seen drives that do unexpected disconnects if they get sent PPR.

Sorry no logs from linux/sym53c8xx - I may be can find some if you want to
see whats happening there.

I have been toying with the idea of disabling PPR capability if PPR is
rejected - forcing sdev->ppr=0 in the driver when it determines PPR has been
rejected - but I'm not sure that's right. There are drives which reject
negotiation - legacy sync and wide at least - while they are initialising
but will then accept it later on.

Question - where does the full source for the sym53c8xx_2 driver live these
days now that Gerard no long maintains it?


Regards
Richard


Richard Waltham
Bridgeworks Ltd
135 Somerford Road,
Christchurch
Dorset, BH23 3PY
England.

Tel 0870 121 0708
Fax 0870 121 0709

Email: richardw@4bridgeworks.com



> -----Original Message-----
> From: Matthew Wilcox [mailto:matthew@wil.cx]
> Sent: 05 November 2004 13:44
> To: Thomas Babut
> Cc: linux-kernel@vger.kernel.org; Linux SCSI; matthew@wil.cx;
> groudier@free.fr
> Subject: Re: Kernel 2.6.x hangs with Symbios Logic 53c1010 Ultra3 SCSI
> Adapter
> 
> 
> On Fri, Nov 05, 2004 at 01:52:32PM +0100, Thomas Babut wrote:
> > Here I am again with some news. :)
> 
> Um, again?  This is the first I've heard from you.  BTW, 
> Gerard seems to
> be unreachable, which is why I took over the driver.
> 
> > I tried last night Kernel 2.6.0 and 2.6.1 (both vanilla) 
> and the system 
> > bootet up with the controller! Then I tried this:
> > 
> > 1) unpack vanilla Kernel 2.6.9
> > 2) copy drivers/scsi/sym53c8xx_comm.h, 
> drivers/scsi/sym53c8xx_defs.h and 
> > the whole directory drivers/scsi/sym53c8xx_2/* from Kernel 
> 2.6.1 into 
> > the Kernel 2.6.9 source
> > 
> > It booted, too. But on all this three 2.6 Kernels the 
> SCSI-Harddisk has 
> > got very poor performance. With Kernel 2.4.26 and 2.4.27 it 
> makes almost 
> > 30 MB/s. With all three 2.6 Kernels it makes about 5 MB/s.
> 
> Sounds like your drive isn't negotiating the correct transfer rate.
> If it's able to do 30MB/s, I guess it should be negotiating at least
> wide, 20MHz -- 5MB/s sounds like asynchronous.
> 
> > (see 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109953598029428&w=2 
> > for detailed hardware specs and other informations)
> 
> Hrm.  Domain validation is failing.  I bet what's going on is that the
> controller is U160-capable, so we're sending a PPR message to 
> the drive
> which is going haywire.  I do hope we don't have to start blacklisting
> drives as being PPR-incapable.
> 
> Can you turn on negotiation debugging and send me the result?  If you
> have 2.1.18m, that's sym53c8xx.debug=0x200 ... earlier than that, it's
> sym53c8xx=debug:0x200
> 
> Now ... you say:
> 
> > sym0: SCSI BUS reset detected.
> > sym0: SCSI BUS has been reset.
> > sym0: SCSI BUS operation completed.
> > 
> > At this point only a hard-reset helps.
> 
> Do you mean the machine freezes at this point, or you can't 
> boot because
> this drive has your root partition on it and it can't be 
> found?  If the
> former, this is another bug that needs to be fixed.
> 
> -- 
> "Next the statesmen will invent cheap lies, putting the blame upon 
> the nation that is attacked, and every man will be glad of those
> conscience-soothing falsities, and will diligently study 
> them, and refuse
> to examine any refutations of them; and thus he will by and 
> by convince 
> himself that the war is just, and will thank God for the better sleep 
> he enjoys after this process of grotesque self-deception." -- 
> Mark Twain
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


------_=_NextPart_000_01C4C354.013890D0
Content-Type: text/plain;
	name="HP_LTO.txt"
Content-Disposition: attachment;
	filename="HP_LTO.txt"

Protocol Phase Analysis
   File name: LINUX6.DTT
Marker range: ANCHOR(70) to CURRENT(96)
Session name: None
Session desc: None
 Session ids: iids:7 tid(lun)[devtype]:3(0)[1]
Sess filters: None
Session date: 2-Nov-04  10:38:58 - 10:41:03
NNNNN = Phase Event Number (1st event is 0)
SSS.mmm_uuu_nnn = Difference Time (Secs.milli_micro_nano)
NNNNN SSS.mmm_uuu_nnn
   70           3_300  Arb
   71           2_192  Arbwin 7
   72           0_800 +Select 7,3
   73           0_716 +Sel/Resel End
   74           4_060 +MsgOut C0 Identify
   75      14_066_128  CMD - Inquiry     
                        12 00 00 00 32 00
   76          18_660  DataIn (N)
                    0h: 01 80 03 02 2D 00 01 30 ....-..0
                    8h: 48 50 20 20 20 20 20 20 HP      
                   10h: 55 6C 74 72 69 75 6D 20 Ultrium 
                   18h: 31 2D 53 43 53 49 20 20 1-SCSI  
                   20h: 45 31 32 44 00 00 00 00 E12D....
                   28h: 00 00 00 24 44 52 2D 31 ...$DR-1
                   30h: 30 00                   0.
                       (50 Bytes)
   77       1_240_728  DEnd  50 Bytes
   78           1_460  Status 00 Good
   79           2_936  MsgIn  00 Cmd Complete
   80          67_264 Bus Free
   81           3_404  Arb
   82           2_188  Arbwin 7
   83           0_800 +Select 7,3
   84           0_708 +Sel/Resel End
   85         442_892 +MsgOut C0 Identify
                              01 06 04
                        Parallel Protocol Pw:?,off:?,Width:?,
                        flags:?
   86  20.000_481_056 +MsgIn  07 Msg Reject
   87         201_336 Bus Reset
   88  10.003_609_516 Bus Free
   89           3_504  Arb
   90           2_188  Arbwin 7
   91           0_804 +Select 7,3
   92           0_720 +Sel/Resel End
   93         249_068 +MsgOut C0 Identify
                              01 06 04
                        Parallel Protocol Pw:?,off:?,Width:?,
                        flags:?
   94  15.001_441_328 +MsgIn  07 Msg Reject
   95         201_704 Bus Reset
   96           0_000 Bus Free

------_=_NextPart_000_01C4C354.013890D0
Content-Type: text/plain;
	name="IBM_DSK.txt"
Content-Disposition: attachment;
	filename="IBM_DSK.txt"

Protocol Phase Analysis
   File name: LINUX8.DTT
Marker range: ANCHOR(89) to CURRENT(101)
Session name: None
Session desc: None
 Session ids: iids:7 tid(lun)[devtype]:2(0)[0]
Sess filters: None
Session date: 2-Nov-04  12:56:07 - 12:58:54
NNNNN = Phase Event Number (1st event is 0)
SSS.mmm_uuu_nnn = Difference Time (Secs.milli_micro_nano)
NNNNN SSS.mmm_uuu_nnn
   89           3_304  Arb
   90           2_204  Arbwin 7
   91           1_000 +Select 7,2
   92           1_608 +Sel/Resel End
   93         268_012 +MsgOut C0 Identify
                              01 06 04 0A 00 00 01 00
                        Parallel Protocol Pw:25ns,
                        off:0,Width:16 bits,
                        IU=0 DT=0 QAS=0
   94          43_052  MsgIn  07 Msg Reject
   95         287_268  CMD - Inquiry     
                        12 00 00 00 A4 00
   96       6_890_292  DataIn (N)
                    0h: 00 00 03 02 9F 00 01 3A .......:
                    8h: 49 42 4D 20 20 20 20 20 IBM     
                   10h: 44 4E 45 53 2D 33 30 39 DNES-309
                   18h: 31 37 30 57 20 20 20 20 170W    
                   20h: 53 41 33 30 41 4A 31 33 SA30AJ13
                   28h: 4B 31 31 36 00 00 00 00 K116....
                   30h: 00 00 00 00 00 00 00 00 ........
                   38h: 00 00 00 00 00 00 00 00 ........
                   40h: 00 00 00 00 00 00 00 00 ........
                   48h: 00 00 00 00 00 00 00 00 ........
                   50h: 00 00 00 00 00 00 00 00 ........
                   58h: 00 00 00 00 00 00 00 00 ........
                   60h: 28 43 29 20 43 6F 70 79 (C) Copy
                   68h: 72 69 67 68 74 20 49 42 right IB
                   70h: 4D 20 43 6F 72 70 2E 20 M Corp. 
                   78h: 31 39 39 38 2E 20 41 6C 1998. Al
                       (128 Bytes)
   97         101_564  DEnd  164 Bytes  0.024 MB/S
   98           2_156  Status 00 Good
   99           2_520  MsgIn  00 Cmd Complete
  100          76_796 Bus Free
  101           0_000  Arb

------_=_NextPart_000_01C4C354.013890D0
Content-Type: text/plain;
	name="IBM_LTO.txt"
Content-Disposition: attachment;
	filename="IBM_LTO.txt"

Protocol Phase Analysis
   File name: TREBER7.DTT
Marker range: ANCHOR(101) to CURRENT(113)
Session name: None
Session desc: None
 Session ids: iids:7 tid(lun)[devtype]:2(0)[1]
Sess filters: None
Session date: 18-Oct-04  15:04:24 - 15:06:33
NNNNN = Phase Event Number (1st event is 0)
SSS.mmm_uuu_nnn = Difference Time (Secs.milli_micro_nano)
NNNNN SSS.mmm_uuu_nnn
  101           3_300  Arb
  102           2_188  Arbwin 7
  103         198_808 +Select 7,2
  104          23_016 +Sel/Resel End
  105       1_752_620 +MsgOut C0 Identify
                              01 06
                        Extended Msg+Len
  106       4_837_064 +MsgIn  07 Msg Reject
  107       1_104_660  CMD - Inquiry     
                        12 00 00 00 26 00
  108           9_788  DataIn (N)
                    0h: 01 80 03 02 21 00 01 30 ....!..0
                    8h: 49 42 4D 20 20 20 20 20 IBM     
                   10h: 55 4C 54 33 35 38 30 2D ULT3580-
                   18h: 54 44 31 20 20 20 20 20 TD1     
                   20h: 31 38 4E 32 00 00       18N2..
                       (38 Bytes)
  109           4_440  DEnd  38 Bytes
  110           1_236  Status 00 Good
  111           1_736  MsgIn  00 Cmd Complete
  112          44_392 Bus Free
  113           0_000  Arb

------_=_NextPart_000_01C4C354.013890D0--
