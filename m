Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319226AbSIDQUG>; Wed, 4 Sep 2002 12:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319227AbSIDQUB>; Wed, 4 Sep 2002 12:20:01 -0400
Received: from host194.steeleye.com ([216.33.1.194]:33804 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S319226AbSIDQT5>; Wed, 4 Sep 2002 12:19:57 -0400
Message-Id: <200209041624.g84GOJC02683@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Jeremy Higdon <jeremy@classic.engr.sgi.com>
cc: Doug Ledford <dledford@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset? 
In-Reply-To: Message from Jeremy Higdon <jeremy@classic.engr.sgi.com> 
   of "Wed, 04 Sep 2002 00:40:26 PDT." <10209040040.ZM49716@classic.engr.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Sep 2002 11:24:19 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeremy@classic.engr.sgi.com said:
> For example, in Fibrechannel using class 3 (the usual)

> 	send command (command frame corrupted; device does not receive)
> 	send barrier (completes normally)
> 	... (lots of time goes by, many more commands are processed)
> 	timeout original command whose command frame was corrupted 

This doesn't look right to me from the SCSI angle  I don't see how you can get 
a successful disconnect on a command the device doesn't receive (I take it 
this is some type of Fibre magic?).  Of course, if the device (or its proxy) 
does receive the command then the ordered queue tag implementation requires 
that the corrupted frame command be processed prior to the barrier,  this 
isn't optional if you obey the spec.  Thus, assuming the processor does no 
integrity checking of the command until it does processing (this should be a 
big if), then we still must get notification of the failed command before the 
barrier tag is begun.  Obviously, from that notification we do then race to 
eliminate the overtaking tags.

> There was also the problem of the queue full to the barrier command,
> etc. 

The queue full problem still exists.  I've used this argument against the 
filesystem people many times at the various fora where it has been discussed.  
The situation is that everyone agrees that it's a theoretical problem, but 
no-one is convinced that it will actually occur in practice (I think it falls 
into the "risk we're willing to take" category).

James


