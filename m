Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129674AbRB0RfV>; Tue, 27 Feb 2001 12:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbRB0RfL>; Tue, 27 Feb 2001 12:35:11 -0500
Received: from atlrel1.hp.com ([156.153.255.210]:34302 "HELO atlrel1.hp.com")
	by vger.kernel.org with SMTP id <S129674AbRB0Re7>;
	Tue, 27 Feb 2001 12:34:59 -0500
Message-ID: <3A9BC8ED.698DCA2C@fc.hp.com>
Date: Tue, 27 Feb 2001 10:34:05 -0500
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Camm Maguire <camm@enhanced.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 IDE tape problem, with ide-scsi
In-Reply-To: <54u25g3yb9.fsf_-_@intech19.enhanced.com> <3A9BC2A9.F5EE8554@fc.hp.com> <544rxg2gde.fsf@intech19.enhanced.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Camm Maguire wrote:
> 
> Thanks for the error identification.  The other drive is of a
> *different* model.  This drive showed this behavior from the day I
> bought it.  The drive could be going bad, but I doubt it.  Is it
> possible that this manufacturer (Conner) has some peculiar
> implementation of the spec?  I recall reading on this list sometime
> back of similar workarounds to unusual drives.

Since the non-wroking drive is a different model, other drive working
does not mean the st driver is sending only valid commands to the
drives. st driver is sending a command to this drive which the drive
does not like. It will help to know what that command is.

> 
> > st driver prints the SCSI command that may have caused this error only
> > when compiled with debug turned on. Maybe st driver should always print
> > the command that results in a check condition as long as the command is
> > not a Test Unit Ready or Mode Sense.
> >
> 
> Can I turn on debug mode in runtime, or do I need to recompile
> ide-scsi?

This is a compile time option, so you will have to recompile "st"
driver. If you look at drivers/scsi/st.c, near the top of the file (line
44 for 2.4.2) you will see a line

#define DEBUG 0

Change this line to set DEBUG to 1 and recompile. This may generate lot
of messages from Test Unit Ready and Mode Sense commands. You can
suppress these messages by replacing the code block within "if
(debugging)" conditional at line 241 with following:

if (SRpnt->sr_cmnd[0] != MODE_SENSE &&
                     SRpnt->sr_cmnd[0] != TEST_UNIT_READY) {
                printk(ST_DEB_MSG "st%d: Error: %x, cmd: %x %x %x %x %x
%x Len: %d\n",
                       dev, result,
                       SRpnt->sr_cmnd[0], SRpnt->sr_cmnd[1],
SRpnt->sr_cmnd[2],
                       SRpnt->sr_cmnd[3], SRpnt->sr_cmnd[4],
SRpnt->sr_cmnd[5],
                       SRpnt->sr_bufflen);
                if (driver_byte(result) & DRIVER_SENSE)
                        print_req_sense("st", SRpnt);
}

 
====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
