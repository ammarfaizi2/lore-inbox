Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129804AbRCATC6>; Thu, 1 Mar 2001 14:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129807AbRCATCi>; Thu, 1 Mar 2001 14:02:38 -0500
Received: from atlrel1.hp.com ([156.153.255.210]:39158 "HELO atlrel1.hp.com")
	by vger.kernel.org with SMTP id <S129804AbRCATCa>;
	Thu, 1 Mar 2001 14:02:30 -0500
Message-ID: <3A9E80B7.F5010457@fc.hp.com>
Date: Thu, 01 Mar 2001 12:02:47 -0500
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Camm Maguire <camm@enhanced.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 IDE tape problem, with ide-scsi
In-Reply-To: <Pine.LNX.4.10.10102271103360.32662-100000@master.linux-ide.org> <54lmqrsyn9.fsf@intech19.enhanced.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Camm Maguire wrote:
>The third error I get is: 
>
>Feb 27 16:01:45 intech9 kernel: st0: Error: 28000000, cmd: 8 1 0 0 40 0 Len: 16 
>Feb 27 16:01:45 intech9 kernel: Info fld=0x40, FMK Current st09:00: sns = f0 80 
>Feb 27 16:01:45 intech9 kernel: ASC= 0 ASCQ= 1 
>Feb 27 16:01:45 intech9 kernel: Raw sense data:0xf0 0x00 0x80 0x00 0x00 0x00 0x40 0x0a 0x00 0x00 0x00 0x00 0x00 0x01 0x00 0x00 
>Feb 27 16:01:45 intech9 kernel: st0: Sense: f0 0 80 0 0 0 40 a 
>Feb 27 16:01:45 intech9 kernel: st0: EOF detected (0 bytes read). 
>
>Restoring a tape typically then says 'gunzip: unexpected end of 
>file'. My guess was that the last fractional block of 32k wasn't 
>flushed to the drive. Of course, if I'm having media troubles 
>indicated by the first error above, then something else could be 
>happening, I suppose. But does erroneous block flushing in the driver 
>sound like a possibility? 

Above sense data indicates drive has encountered a filemark on a READ
command. This READ did not read a partial block since the residual count
in Sense data is set to 0x40 which is the same block count requested by
the READ command. If you were writing 32K blocks to the tape and there
indeed was a partial block at the end, the current position of the tape
is not at that partial block. Tape seems to be positioned immediately
after the last block where a filemark was written indicating end of
archive. 

Looking at the READ command (8 1 0 0 40 0), the "fixed" bit is set which
means the tape is being read in fixed block length mode. This read
command is trying to read 64 blocks from the tape. If the application is
reading data in blocks of 32K, it implies the block size on the physical
media is 512 Bytes. So when you say last 32K block may not have been
flushed to the drive, I am assuming you mean not being flushed from the
host to the tape drive. This is possible but there may be something else
going on. I would suggest setting no block limits on the drive using "mt
stsetoptions no-blklimits". See if that helps.

====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
