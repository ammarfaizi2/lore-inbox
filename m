Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318299AbSIFALX>; Thu, 5 Sep 2002 20:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318324AbSIFALX>; Thu, 5 Sep 2002 20:11:23 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:18950 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S318299AbSIFALW>; Thu, 5 Sep 2002 20:11:22 -0400
Date: Thu, 5 Sep 2002 17:15:55 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux-Kernel Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: blocksize limitations in scsi tape driver (st) when used with DLT1 tape drives?
Message-ID: <20020906001555.GD3942@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux-Kernel Mailingliste <linux-kernel@vger.kernel.org>
References: <20020905200208.22430.qmail@dag.newtech.fi> <3D77C5C7.3010909@fl.priv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D77C5C7.3010909@fl.priv.at>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 10:59:51PM +0200, Friedrich Lobenstock wrote:
> Dag Nygren wrote:
> >I have successfully been using Legato Networker with a
> >blocksize of 32k with my DLT here.
> >
> >But the way Legato wants to do it is to decide about the
> >blocksize itself.
> >This means that the driver should NOT decide on the BS, but
> >pass on anything written through it, meaning a blocksize setting
> >of 0 (or variable blocksize).
> >
> >Perhaps Arkeia works the same way ?
> 
> I used variable blocksize (=0) before but then after about 3.5 gigs stored
> on the tape I get scsi-error and arkeia interprets this as end-of-tape.
> 
> Aug  6 02:13:50 filesrv kernel: st0: Error with sense data: Info 
> fld=0x2000, Deferred st09:00: sns = f1  3
> Aug  6 02:13:50 filesrv kernel: ASC=80 ASCQ= 1
> Aug  6 02:13:50 filesrv kernel: Raw sense data:0xf1 0x00 0x03 0x00 0x00 
> 0x20 0x00 0x16 0x00 0x00 0xe6 0xc2 0x80 0x01 0x00 0x00 0x00 0x00 0x83 0x00 
> 0x37 0x00 0x00 0x00 0x21 0x00 0x90 0x7f 0x3a 0x00
> Aug  6 02:13:50 filesrv kernel: klogd 1.4.1, ---------- state change 
> ----------
> Aug  6 02:13:50 filesrv kernel: Inspecting /boot/System.map-2.4.18-64GB-SMP
> Aug  6 02:13:50 filesrv kernel: Loaded 13537 symbols from 
> /boot/System.map-2.4.18-64GB-SMP.
> Aug  6 02:13:50 filesrv kernel: Symbols match kernel version 2.4.18.
> Aug  6 02:13:50 filesrv kernel: Loaded 481 symbols from 13 modules.
> Aug  6 02:13:50 filesrv kernel: st0: Error with sense data: Info fld=0x1, 
> Current st09:00: sns = f0  3
> Aug  6 02:13:50 filesrv kernel: ASC= c ASCQ= 0
> Aug  6 02:13:50 filesrv kernel: Raw sense data:0xf0 0x00 0x03 0x00 0x00 
> 0x00 0x01 0x16 0x00 0x00 0xe6 0xc2 0x0c 0x00 0x00 0x00 0x00 0x00 0x83 0x00 
> 0x37 0x00 0x00 0x00 0x21 0x00 0x90 0x7f 0x3a 0x00
> 
> I had this problem with LTO drives too and here the arkeia faq tells one
> to set fixed block size.
> 
> And when you look a the HP document referenced in my last mail:
> 
>    ISSUE: Block sizes of LESS THAN 64 KB for DLT1/DLT VS80 and 32 KB for
>           all other DAT and DLT drives can drastically increase the 
>           backup/restore
>           time and severely affect the performance of the drive.
> 
> SOLUTION: Most backup applications allow viewing and adjusting the block
>           size used for a particular device. See below for advice on how
>           to achieve this for CA ARCserve, Veritas Backup Exec and Tapeware.
> 
> (I capitalized "less than" to emphasis its occurance)
> 
> I you missed the link here it is again:
>   http://www.hp.com/cposupport/information_storage/support_doc/lpg50167.html
> 
> Did you check with mt after Legato Networker did a backup which blocksize
> it set?

Generally one sets the device block size (driver) to variable
and instructs the backup software to use a largish
block size.  The two are somewhat independent.

HP is right about small block sizes at the app level.
Writing small blocks not only ruins performance but the
latencies mean the tape drive has to do lots of
repositioning which stresses the tape and the drive.

I don't do tape drive firmware but the following is my best
understanding of the situation.  What you tell the
application regarding block size determines the amount of
overhead for headers and the size of the buffer used for
write(2).  Using a large block size at the application level
usually helps performance thereby enabling it to better keep
up with the tape drive.

On the device level each block is terminated by a
end-of-block marker and there is a space (blank tape)
between it and the next block to allow for positioning.  If
you set fixed size blocks it may have to reposition (stop,
rewind, play looking for header) between blocks.  Small
blocks mean wasted tape (reduced capacity) and wear-and-tear
on the drive and media.  As you can imagine repositioning
means reduced throughput.  Having a fixed device block size that
differs from the application block size can cause problems
especially if their relationship is subject to hysteresis.

Using variable block size allows the drive to stream as long
as you can keep up with it.  If you fall behind (buffer
underrun) it will put an end of block and space.  This is
independent of the application block size.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
