Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130223AbRB1PYC>; Wed, 28 Feb 2001 10:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130228AbRB1PXw>; Wed, 28 Feb 2001 10:23:52 -0500
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:34289 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S130223AbRB1PXh>; Wed, 28 Feb 2001 10:23:37 -0500
To: Khalid Aziz <khalid@fc.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 IDE tape problem, with ide-scsi
In-Reply-To: <54u25g3yb9.fsf_-_@intech19.enhanced.com> <3A9BC2A9.F5EE8554@fc.hp.com> <544rxg2gde.fsf@intech19.enhanced.com> <3A9BC8ED.698DCA2C@fc.hp.com> <54vgpvq4y1.fsf@intech19.enhanced.com> <3A9BEF68.72EEF0E8@fc.hp.com>
From: Camm Maguire <camm@enhanced.com>
Date: 28 Feb 2001 10:23:07 -0500
In-Reply-To: Khalid Aziz's message of "Tue, 27 Feb 2001 13:18:16 -0500"
Message-ID: <54g0gyhlwk.fsf@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings, and thank you so much for your helpful reply!!

Khalid Aziz <khalid@fc.hp.com> writes:

> Camm Maguire wrote:
> > 
> > Greetings!  OK, with st debugging, here are the most common errors
> > with the Conner:
> > 
> > Feb 27 14:46:39 intech9 kernel: st0: Error: 28000000, cmd: 8 1 0 0 40 0 Len: 16
> > Feb 27 14:46:39 intech9 kernel: Info fld=0x24, Current st09:00: sns = f0  8
> > Feb 27 14:46:39 intech9 kernel: ASC=14 ASCQ= 3
> > Feb 27 14:46:39 intech9 kernel: Raw sense data:0xf0 0x00 0x08 0x00 0x00 0x00 0x24 0x0a 0x00 0x00 0x00 0x00 0x14 0x03 0x00 0x00
> > Feb 27 14:46:39 intech9 kernel: st0: Sense: f0  0  8  0  0  0 24  a
> > Feb 27 14:46:39 intech9 kernel: st0: Tape error while reading.
> 
> This was a read command that failed. Request sense information shows a
> sense key of 0x08 which is a "Blank check". This sense key indicates
> either a blank medium found or another error at EOD. ASC/ASCQ of
> 0x14/0x03 say "End-Of-Data not found". This indicates something wrong
> with the tape or maybe the drive needs cleaning. Do you get this error
> with more than one tape?
> 

Tape drive has been cleaned, but I'll look into behavior with other
tapes.  Thanks for the tip!  One thing I miss about ide tapes
(compared to the old floppy tapes) is the apparent inability to
reformat them.

> 
> > Feb 27 14:46:40 intech9 kernel: st0: Error: 28000000, cmd: 5 0 0 0 0 0 Len: 16
> > Feb 27 14:46:40 intech9 kernel: [valid=0] Info fld=0x0, Current st09:00: sns = 70  5
> > Feb 27 14:46:40 intech9 kernel: ASC=20 ASCQ= 0
> > Feb 27 14:46:40 intech9 kernel: Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x20 0x00 0x00 0x00
> > Feb 27 14:46:40 intech9 kernel: st0: Can't read block limits.
> 
> This was a "Read Block Limits" command which the drive claimed it does
> not recognize. "Read Block Limits" is a mandatory command for SCSI
> sequential access devices which is why "st" is issuing this command. The
> tape drive you have is not SCSI, so the manufacturer chose not to
> implement this command. The driver may still be able to work after "Read
> Block Limits" fails, but I have not read enough code to be sure.
> 
> > Feb 27 14:46:40 intech9 kernel: st0: Mode sense. Length 11, medium b6, WBS 10, BLL 8
> > Feb 27 14:46:40 intech9 kernel: st0: Density 45, tape length: 0, drv buffer: 1
> > Feb 27 14:46:40 intech9 kernel: st0: Block size: 512, buffer size: 32768 (64 blocks).
> > 

OK, great!  Thanks for pointing this out!  I think I may be having a
problem with blocking on this drive, so I'll dig a little into st.c
and see if it handles this case OK.

The third error I get is:

Feb 27 16:01:45 intech9 kernel: st0: Error: 28000000, cmd: 8 1 0 0 40 0 Len: 16
Feb 27 16:01:45 intech9 kernel: Info fld=0x40, FMK Current st09:00: sns = f0 80
Feb 27 16:01:45 intech9 kernel: ASC= 0 ASCQ= 1
Feb 27 16:01:45 intech9 kernel: Raw sense data:0xf0 0x00 0x80 0x00 0x00 0x00 0x40 0x0a 0x00 0x00 0x00 0x00 0x00 0x01 0x00 0x00 
Feb 27 16:01:45 intech9 kernel: st0: Sense: f0  0 80  0  0  0 40  a
Feb 27 16:01:45 intech9 kernel: st0: EOF detected (0 bytes read).

Restoring a tape typically then says 'gunzip: unexpected end of
file'.  My guess was that the last fractional block of 32k wasn't
flushed to the drive.  Of course, if I'm having media troubles
indicated by the first error above, then something else could be
happening, I suppose.  But does erroneous block flushing in the driver
sound like a possibility?

Take care,

> > Any advice appreciated!
> 
> ====================================================================
> Khalid Aziz                             Linux Development Laboratory
> (970)898-9214                                        Hewlett-Packard
> khalid@fc.hp.com                                    Fort Collins, CO
> 
> 

-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
