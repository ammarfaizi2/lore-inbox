Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266317AbRGJNfr>; Tue, 10 Jul 2001 09:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266312AbRGJNfh>; Tue, 10 Jul 2001 09:35:37 -0400
Received: from host194.steeleye.com ([216.33.1.194]:22030 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S266303AbRGJNfU>; Tue, 10 Jul 2001 09:35:20 -0400
Message-Id: <200107101335.f6ADZ4f01436@localhost.localdomain>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Douglas Gilbert <dougg@torque.net>
cc: "Cress, Andrew R" <andrew.r.cress@intel.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH-2.4.3] scsi logging 
In-Reply-To: Message from Douglas Gilbert <dougg@torque.net> 
   of "Tue, 10 Jul 2001 00:34:05 EDT." <3B4A85BD.FE0E2D61@torque.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 10 Jul 2001 09:35:04 -0400
From: Eddie Williams <Eddie.Williams@steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andy, a name from the past... :-)

I agree with Doug.  I think the behavior of the sg driver to not log errors or 
do retries is appropriate.  To put in context to yours and mine past lives, 
NCR MP/RAS had similar functionality in the libscsi interface.  That interface 
also turned error logging and retries off by default.  This is necessary for 
an interface that is to be used for error diagnosis, recovery, probing and the 
like.

LifeKeeper uses the sg driver to probe for devices and to get the serial 
number that you listed in (1) in the original request.  This can and will 
generate errors that one would not want logged.  The difficult part about 
logging errors is the "thundering herd" problem.  If you log a lot of 
unnecessary or meaningless errors then the "real" errors are lost in the flow. 
 I think one of the responsibilities of using the sg driver is that an 
application has to handle the errors that will occur and log or retry as 
appropriate.

I think SANE and cdrecored are just two examples of programs that expect this 
behavior (no logging of errors).  LifeKeeper is another example.  I would be 
willing to bet there are others.  So changing this behavior could have a wide 
ranging affect.

Getting back to your first comment (sorry I have already deleted your initial 
mail) did you provide the patch for getting the serial number?  Note that 
getting the serial number is not a required SCSI feature so you wont get 100% 
of the devices.

Eddie Williams

> Andrew wrote:
> > I'd like to propose the following patch to 3 SCSI mid-layer 
> > files from kernel 2.4.3.  I have tested this with 2.4.3, 
> > but it should be relevant to other 2.4.x kernels also.
> > 
> > It has the following changes/enhancements:
> > 1) Log the disk serial number during scsi_scan() 
> >    - scsi_scan.c.
> >    Why: This is a requirement in some environments to 
> >    ensure unambiguous identification of a particular 
> >    problem disk.
> > 2) Interpret additional values in print_sense_internal()
> >    - constants.c.  Why: The detail wrt Illegal Requests 
> >    is very useful, since it can indicate either an 
> >    application bug or an incompatible feature of the device.
> > 3) Don't skip logging sense errors for sg functions - sg.c.
> >    Why: All sense errors should be logged so that a 
> >    potential scsi device hardware problem doesn't go
> >    unrecognized.
> 
> Andrew,
> I would object to point 3). SANE, and to a lesser extent
> cdrecord, execute lots of commands that give SCSI check
> conditions and would bloat the log and the console with
> many serious looking messages. Those error 
> indications are conveyed back to the app via the sg 
> interface so the information is not lost. There is an 
> ioctl in the sg driver [SG_SET_DEBUG] to turn on that 
> output to the log/console [the default is off (to
> stop the curious querying the maintainer about the
> strange messages in their logs)].
> 
> Doug Gilbert
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org


