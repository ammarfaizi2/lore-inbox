Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318116AbSIETbf>; Thu, 5 Sep 2002 15:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318113AbSIETbf>; Thu, 5 Sep 2002 15:31:35 -0400
Received: from Scotty-EUnet.AT.EU.net ([193.83.12.34]:62875 "EHLO
	www.scotty.co.at") by vger.kernel.org with ESMTP id <S318099AbSIETbd>;
	Thu, 5 Sep 2002 15:31:33 -0400
Message-ID: <3D77B216.8070205@fl.priv.at>
Date: Thu, 05 Sep 2002 21:35:50 +0200
From: Friedrich Lobenstock <fl@fl.priv.at>
Reply-To: Linux-SCSI Mailingliste <linux-scsi@vger.kernel.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; ast-ES; rv:1.0.0) Gecko/20020529
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux-SCSI Mailingliste <linux-scsi@vger.kernel.org>
CC: Linux-Kernel Mailingliste <linux-kernel@vger.kernel.org>
Subject: blocksize limitations in scsi tape driver (st) when used with DLT1
 tape drives?
X-Enigmail-Version: 0.62.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm having an odd problem here. I use SuSE Linux 8.0 with kernel
2.4.18-64GB-SMP, arkeia as backup software and a Tandberg
VS80 (DLT1) streamer.

After some trial and error I found out that I have to use a fixed block
size for DLT streamers (same applies to LTO ones). This document,
found at HP, tells you in details about which blocksize to use:
   http://www.hp.com/cposupport/information_storage/support_doc/lpg50167.html

Now I told arkeia to use a blocksize of 65536, 32768 and 16384 and it
could not write to the tape. All I got in the log was:

Sep  4 22:04:50 filesrv kernel: st: Unloaded.
Sep  4 22:08:40 filesrv kernel: st: Version 20020205, bufsize 32768, wrt 30720, max init. bufs 4, s/g segs 16
Sep  4 22:08:40 filesrv kernel: st0: Block limits 2 - 16777214 bytes.
Sep  4 22:08:41 filesrv kernel: st0: Incorrect block size.
Sep  4 22:08:45 filesrv kernel: st0: Write not multiple of tape block size.

Sep  4 23:20:06 filesrv kernel: st: Unloaded.
Sep  4 23:20:30 filesrv kernel: st: Version 20020205, bufsize 524288, wrt 522240, max init. bufs 16, s/g segs 64
Sep  4 23:20:30 filesrv kernel: st0: Block limits 2 - 16777214 bytes.
Sep  4 23:20:33 filesrv kernel: st0: Incorrect block size.
Sep  4 23:20:35 filesrv kernel: st0: Write not multiple of tape block size.

(As you might have notice in the second case I'm loading st with buffer_kbs=512,
max_buffers=16 and max_sg_segs=64 but that makes no difference compared to the
default values)


BUT now comes the cloo: at and below a blocksize of 8192 it was possible
to write to the tape. At 1024 the backup slowed down from 20 min to 4 hours,
but at 8192 the backup speed is normal (the later on with the st options
you can see above, but haven't tested if that makes a difference).

LTO drives in contrast to DLT drives are happy with a blocksize of 1024
and backup speed is normal at this blocksize.

Everytime when arkeia could not write to the tape I checked with mt to
display the blocksize and I verified that arkeia set it to the value I
told it to. Now with arkeia set to a blocksize of 8192:

filesrv:~ # mt -f /dev/st0 status
drive type = Generic SCSI-2 tape
drive status = 1073750016
sense key error = 0
residue count = 0
file number = 0
block number = 0
Tape block size 8192 bytes. Density code 0x40 (unknown).
Soft error count since last status=0
General status bits on (41010000):
  BOT ONLINE IM_REP_EN

I think there must be something wrong in the scsi tape driver(st).
Can someone shine some light on this?

PS: Reply-to set to linux-scsi.

-- 
MfG / Regards
Friedrich Lobenstock

