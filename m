Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283398AbRK2VPo>; Thu, 29 Nov 2001 16:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283395AbRK2VPe>; Thu, 29 Nov 2001 16:15:34 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:17150 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S283399AbRK2VPR>; Thu, 29 Nov 2001 16:15:17 -0500
Message-ID: <3C06A62A.1F7A34D2@nortelnetworks.com>
Date: Thu, 29 Nov 2001 16:18:34 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: ethernet links should remember routes the same as addresses
In-Reply-To: <3C068ED1.D5E2F536@nortelnetworks.com.suse.lists.linux.kernel> <p73r8qhqrmi.fsf@amdsim2.suse.de> <3C06A1C8.C133F725@nortelnetworks.com> <3C06A294.4070906@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> 
> Christopher Friesen wrote:
> 
> > If the driver re-init is totally separate from the routing code, is there any
> > real reason why shutting down the driver *should* remove all routes to that
> > device?  Maybe the simplest solution would be a new ioctl that would be a link
> > *reset*...just down/up the link without affecting anything else....
> 
> What would want want the down/up to do?  The reason I ask is that there is
> an MII-DIAG option to reset the transceiver, if that's all you want to do.
> 
> If you want to remove/re-install the driver, then you have to clean up
> all the links pointing to it (ie the routes associated with the
> device), or you will have all kinds of nasty dangling pointers (logical
> or otherwise) to clean up...

We've got what looks like a bug in the tulip driver (or maybe buggy hardware)
that under certain circumstances can block with what looks like a problem in the
ring buffer.  Someone is looking at the driver, but in the meantime the only way
to fix it is to do "ip link set dev ethX down" followed by "ip link set dev ethX
up".  Whatever code path this causes in the driver is enough to fix the issue. 
I assume its due to the re-initialization of the buffer descriptors.

On some consideration, maybe it would make more sense in this case to add
something to the driver itself to re-initialize itself rather than involving the
rest of the kernel.  However, I do think that taking down a link and bringing it
back up should be inverse procedures.  If there were routes associated with a
link before taking it down, then they should be associated with it after
bringing it back up, whether or not they stick around when the link is actually
down.  This is how addresses behave, so I think routes should be similar.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
