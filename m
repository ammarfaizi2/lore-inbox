Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129809AbRB0Txm>; Tue, 27 Feb 2001 14:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129798AbRB0Txb>; Tue, 27 Feb 2001 14:53:31 -0500
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:17404 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S129811AbRB0Twh>; Tue, 27 Feb 2001 14:52:37 -0500
To: Khalid Aziz <khalid@fc.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 IDE tape problem, with ide-scsi
In-Reply-To: <54u25g3yb9.fsf_-_@intech19.enhanced.com> <3A9BC2A9.F5EE8554@fc.hp.com> <544rxg2gde.fsf@intech19.enhanced.com> <3A9BC8ED.698DCA2C@fc.hp.com>
From: Camm Maguire <camm@enhanced.com>
Date: 27 Feb 2001 14:52:22 -0500
In-Reply-To: Khalid Aziz's message of "Tue, 27 Feb 2001 10:34:05 -0500"
Message-ID: <54vgpvq4y1.fsf@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!  OK, with st debugging, here are the most common errors
with the Conner:

Feb 27 14:46:39 intech9 kernel: st0: Error: 28000000, cmd: 8 1 0 0 40 0 Len: 16
Feb 27 14:46:39 intech9 kernel: Info fld=0x24, Current st09:00: sns = f0  8
Feb 27 14:46:39 intech9 kernel: ASC=14 ASCQ= 3
Feb 27 14:46:39 intech9 kernel: Raw sense data:0xf0 0x00 0x08 0x00 0x00 0x00 0x24 0x0a 0x00 0x00 0x00 0x00 0x14 0x03 0x00 0x00 
Feb 27 14:46:39 intech9 kernel: st0: Sense: f0  0  8  0  0  0 24  a
Feb 27 14:46:39 intech9 kernel: st0: Tape error while reading.
Feb 27 14:46:40 intech9 kernel: st0: Error: 28000000, cmd: 5 0 0 0 0 0 Len: 16
Feb 27 14:46:40 intech9 kernel: [valid=0] Info fld=0x0, Current st09:00: sns = 70  5
Feb 27 14:46:40 intech9 kernel: ASC=20 ASCQ= 0
Feb 27 14:46:40 intech9 kernel: Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x20 0x00 0x00 0x00 
Feb 27 14:46:40 intech9 kernel: st0: Can't read block limits.
Feb 27 14:46:40 intech9 kernel: st0: Mode sense. Length 11, medium b6, WBS 10, BLL 8
Feb 27 14:46:40 intech9 kernel: st0: Density 45, tape length: 0, drv buffer: 1
Feb 27 14:46:40 intech9 kernel: st0: Block size: 512, buffer size: 32768 (64 blocks).


Any advice appreciated!

Khalid Aziz <khalid@fc.hp.com> writes:

> Camm Maguire wrote:
> > 
> > Thanks for the error identification.  The other drive is of a
> > *different* model.  This drive showed this behavior from the day I
> > bought it.  The drive could be going bad, but I doubt it.  Is it
> > possible that this manufacturer (Conner) has some peculiar
> > implementation of the spec?  I recall reading on this list sometime
> > back of similar workarounds to unusual drives.
> 
> Since the non-wroking drive is a different model, other drive working
> does not mean the st driver is sending only valid commands to the
> drives. st driver is sending a command to this drive which the drive
> does not like. It will help to know what that command is.
> 
> > 
> > > st driver prints the SCSI command that may have caused this error only
> > > when compiled with debug turned on. Maybe st driver should always print
> > > the command that results in a check condition as long as the command is
> > > not a Test Unit Ready or Mode Sense.
> > >
> > 
> > Can I turn on debug mode in runtime, or do I need to recompile
> > ide-scsi?
> 
> This is a compile time option, so you will have to recompile "st"
> driver. If you look at drivers/scsi/st.c, near the top of the file (line
> 44 for 2.4.2) you will see a line
> 
> #define DEBUG 0
> 
> Change this line to set DEBUG to 1 and recompile. This may generate lot
> of messages from Test Unit Ready and Mode Sense commands. You can
> suppress these messages by replacing the code block within "if
> (debugging)" conditional at line 241 with following:
> 
> if (SRpnt->sr_cmnd[0] != MODE_SENSE &&
>                      SRpnt->sr_cmnd[0] != TEST_UNIT_READY) {
>                 printk(ST_DEB_MSG "st%d: Error: %x, cmd: %x %x %x %x %x
> %x Len: %d\n",
>                        dev, result,
>                        SRpnt->sr_cmnd[0], SRpnt->sr_cmnd[1],
> SRpnt->sr_cmnd[2],
>                        SRpnt->sr_cmnd[3], SRpnt->sr_cmnd[4],
> SRpnt->sr_cmnd[5],
>                        SRpnt->sr_bufflen);
>                 if (driver_byte(result) & DRIVER_SENSE)
>                         print_req_sense("st", SRpnt);
> }
> 
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
