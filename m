Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277302AbRJRAPe>; Wed, 17 Oct 2001 20:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277313AbRJRAPY>; Wed, 17 Oct 2001 20:15:24 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:3852 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S277302AbRJRAPM>; Wed, 17 Oct 2001 20:15:12 -0400
Date: Wed, 17 Oct 2001 18:20:25 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: SCSI tape load problem with Exabyte Drive
Message-ID: <20011017182025.A26712@vger.timpanogas.org>
In-Reply-To: <20011016153623.A21324@vger.timpanogas.org> <Pine.LNX.4.33.0110170935300.2271-100000@kai.makisara.local> <20011017105535.C24698@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011017105535.C24698@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Wed, Oct 17, 2001 at 10:55:35AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kai,

We have seen some other weirdness, but it seems related to the 
file handle engine in Linux.  When we open a handle from 
a user space context via ioctl() calls through to our kernel
level components, close this handle from another kernel 
thread, then attempt to reopen the handle from a 
differnt kernel thread, we are seeing a return code
of -21 (EISDIR) from filp_open() which is strange and 
looks like a bug.  

We are then unable to reopen the handle to /dev/st0 or /dev/st1
until the system has been rebooted.  This looks like either
a bug in Linux or something we have caused by using handles
in this manner.

Do you have any idea what might be happening here.

Jeff 


On Wed, Oct 17, 2001 at 10:55:35AM -0700, Jeff V. Merkey wrote:
> On Wed, Oct 17, 2001 at 09:43:42AM +0300, Kai Makisara wrote:
> > On Tue, 16 Oct 2001, Jeff V. Merkey wrote:
> > 
> > >
> > >
> > > On 2.4.6 with st and AICXXXX driver, issuance of an MTLOAD command
> > > via st ioctl() calls results in a unit attention and failure of
> > > the drive while loading a tape from an EXB-480 robotics tape
> > > library.
> > >
> > > Code which generates this error is attached.  The error will not
> > > clear unless the code first closes the open handle to the device,
> > > then reopens the handle and retries the load command.  The failure
> > > scenario is always the same.  The first MTLOAD command triggers
> > > the tape drive to load the tape, then all subsequent commands
> > > fail until the handle is closed and the device is reopened and
> > > a second MTLOAD command gets issued, then the drive starts
> > > working.
> > >
> > This is a "feature" of the st driver: if you get UNIT ATTENTION anywhere
> > else than within open(), it is considered an error. In most cases this is
> > true but MTLOAD is an exception. I have not thought about this exception
> > and noone before you has reported it ;-)
> > 
> > As you say, the workaround is to close and reopen the device after MTLOAD.
> > You should not need the second MTLOAD.
> > 
> > I will think about a fix to this problem. The basic reason for not
> > allowing UNIT ATTENTION anywhere is that flushing the driver state
> > properly in any condition is complicated and there has been no legitimate
> > reason to allow this. However, here it should be sufficient to use a no-op
> > SCSI command after LOAD to get the UNIT ATTENTION.
> > 
> > 	Kai
> >
> 
> Kai,
> 
> Thanks for the prompt response.  We will continue using the current
> recovery method since this appears to work based upon your 
> description of what is happening here.  I will remove the second MTLOAD 
> command and test with the robotics library.  Sounds like it should
> work OK.  Please let us know what you decide if you feel a workaround
> is needed for this problem, and we will be happy to test it for 
> you.
> 
> Do-na-da Go-hv-e
> 
> Wa-do
> 
> Thanks
> 
> Jeff
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
