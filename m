Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129847AbRB0MC6>; Tue, 27 Feb 2001 07:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129900AbRB0MCi>; Tue, 27 Feb 2001 07:02:38 -0500
Received: from ns1.whiterose.net ([208.155.122.237]:13326 "HELO
	ns1.whiterose.net") by vger.kernel.org with SMTP id <S129847AbRB0MCd>;
	Tue, 27 Feb 2001 07:02:33 -0500
Date: Tue, 27 Feb 2001 06:58:38 -0500 (EST)
From: M Sweger <mikesw@ns1.whiterose.net>
To: linux-kernel@vger.kernel.org
Subject: Re: linux 2.2.19pre14 SCSI v5.1.33 patch AIC7895 comments. (fwd)
Message-ID: <Pine.BSF.4.21.0102270658160.49899-100000@ns1.whiterose.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



---------- Forwarded message ----------
Date: Mon, 26 Feb 2001 17:19:00 -0500
From: Doug Ledford <dledford@redhat.com>
To: M Sweger <mikesw@ns1.whiterose.net>
Subject: Re: linux 2.2.19pre14 SCSI v5.1.33 patch AIC7895 comments.

M Sweger wrote:
> 
> Hello Doug,
> 
>     Just to let you know that I've upgraded from linux 2.2.19pre5
> to linux 2.2.19pre14 and here is an updated status.
> 
> 1). My machine is a Dell optiplex 333mhz Intel with a 2940U2W AIC-7895
>     chipset and SCSI BIOS v1.33S2   (where S means special Dell stuff)
> 
> 2). This newer patch includes the new scsi driver
>     v5.1.33/3.2.4 instead of the old one v5.1.31/3.2.4.
> 
> 3). Earlier, I emailed you about a,
>      "Data overrun in data-in phase, tag 1;
>       Have seen  Data Phase. Length=255, NumSGs=1.
>       sg[0] - Addr = 0x7fea380 : Length 255"
> 
> error message during bootup for linux kernels 2.2.15-2.2.19pre5.
> 
> 4). HOWEVER, with this newer patch, the "data overrun" error messages
>     disappear. I've recompiled with TCQ enabled and disabled and with
>     the TCQ queue size 8 and 24 and no boot problem was encountered.
>     Moreover, there wasn't any problems running it on UMSDOS with
>     a Western Digital 9.1 Gig SCSI drive.
> 
>     I wonder what changed that eliminated this data overrun problem
>     in this newer SCSI driver v5.1.33? The Changelog doesn't seem
>     to hint at a fix in this area.
> 
> Things look good to go.

I fixed the WIDE_RESIDUE handler to do the right thing, which fixes the data
overrun.  Since your drive is operating in wide mode, it transfers two bytes
at a time.  Since the INQUIRY command that linux sends out is set to a length
of 255 bytes, the drive obviously can't send 255 bytes without having an odd
tag along byte.  It then sends a WIDE_RESIDUE message to the card to let it
know that the 256th byte was garbage and ignore it.  In the old driver, we
didn't handle that message properly and as a result, we thought it was legit
and that caused us to signal a data overrun.  Now we handle it, we reduce the
byte count by 1, and we no longer have an overrun.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems

