Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317387AbSIEJrM>; Thu, 5 Sep 2002 05:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317396AbSIEJrM>; Thu, 5 Sep 2002 05:47:12 -0400
Received: from zok.SGI.COM ([204.94.215.101]:41181 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S317387AbSIEJrK>;
	Thu, 5 Sep 2002 05:47:10 -0400
Date: Thu, 5 Sep 2002 02:50:17 -0700 (PDT)
From: Jeremy Higdon <jeremy@classic.engr.sgi.com>
Message-Id: <10209050250.ZM52132@classic.engr.sgi.com>
In-Reply-To: James Bottomley <James.Bottomley@steeleye.com>
        "Re: aic7xxx sets CDR offline, how to reset?" (Sep  4, 11:24am)
References: <200209041624.g84GOJC02683@localhost.localdomain>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: aic7xxx sets CDR offline, how to reset?
Cc: Doug Ledford <dledford@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 4, 11:24am, James Bottomley wrote:
> 
> jeremy@classic.engr.sgi.com said:
> > For example, in Fibrechannel using class 3 (the usual)
> 
> > 	send command (command frame corrupted; device does not receive)
> > 	send barrier (completes normally)
> > 	... (lots of time goes by, many more commands are processed)
> > 	timeout original command whose command frame was corrupted 
> 
> This doesn't look right to me from the SCSI angle  I don't see how you can get 
> a successful disconnect on a command the device doesn't receive (I take it 
> this is some type of Fibre magic?).  Of course, if the device (or its proxy) 
> does receive the command then the ordered queue tag implementation requires 
> that the corrupted frame command be processed prior to the barrier,  this 
> isn't optional if you obey the spec.  Thus, assuming the processor does no 
> integrity checking of the command until it does processing (this should be a 
> big if), then we still must get notification of the failed command before the 
> barrier tag is begun.  Obviously, from that notification we do then race to 
> eliminate the overtaking tags.

You don't have disconnect per se with Fibre (or with other packet based
interfaces).  A command is sent as a frame.  If the frame is corrupted
or lost on the way to the target, then the target will never know about
the command having been sent.  There are obvious problems if that command
has an ordered tag, preceded and followed by simple tags dependent on
the ordered semantics being followed, and where the simple tagged commands
following don't wait for the ordered tag to finish.  There are other
failure modes too, of course.

> > There was also the problem of the queue full to the barrier command,
> > etc. 
> 
> The queue full problem still exists.  I've used this argument against the 
> filesystem people many times at the various fora where it has been discussed.  
> The situation is that everyone agrees that it's a theoretical problem, but 
> no-one is convinced that it will actually occur in practice (I think it falls 
> into the "risk we're willing to take" category).

I guess it all depends on how sensitive one is to getting it wrong.  In
any case, it looks as though you are doing what you can . . . .

> James

thanks

jeremy
