Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136418AbREDOxM>; Fri, 4 May 2001 10:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136415AbREDOxC>; Fri, 4 May 2001 10:53:02 -0400
Received: from host194.steeleye.com ([216.33.1.194]:56332 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S136411AbREDOwt>; Fri, 4 May 2001 10:52:49 -0400
Message-Id: <200105041452.f44EqI101653@localhost.localdomain>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Doug Ledford <dledford@redhat.com>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Linux Cluster using shared scsi 
In-Reply-To: Message from Doug Ledford <dledford@redhat.com> 
   of "Wed, 02 May 2001 13:47:40 EDT." <3AF0483C.49C8CF90@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 04 May 2001 10:52:18 -0400
From: Eddie Williams <Eddie.Williams@steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:
>
> ...
>
> If told to hold a reservation, then resend your reservation request once every
> 2 seconds (this actually has very minimal CPU/BUS usage and isn't as big a
> deal as requesting a reservation every 2 seconds might sound).  The first time
> the reservation is refused, consider the reservation stolen by another machine
> and exit (or optionally, reboot).

I agree that the resend of the reservation is not all that big but there is 
also the proverbial "straw that broke the Camel's back."  When there is enough 
activity there could be logic added to avoid sending reservations.  In all 
cases when a reservation is forcefully removed the result will cause the 
device to return a UNIT ATTENTION (Well, I guess I know that is the behavior 
on Parallel SCSI, is this true for FC?).  So the host should know with the 
next command issued that it lost the reservation (not necessarily that someone 
else has stolen it but that for some reason the device just lost it).  So you 
could "check" to see if within the last 2 seconds (a) has an IO completed and 
(b) every IO that completed in that 2 second span completed without any 
"error".  In error I mean without incident, such as a check condition.  In 
this case the reservation is not needed as you know nothing has happened to 
cause the reservation to be lost.  Perhaps in this heavy load situation you 
could even add logic to issue the reservation as soon as the mid-layer is 
aware that the reservation was broken maybe saving a second or so?

I see this as an enhancement that could be added on later, perhaps keep in 
mind this enhancement so that your initial development does not make it more 
difficult to implement it later.

Eddie


