Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268617AbRGZSH1>; Thu, 26 Jul 2001 14:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268621AbRGZSHR>; Thu, 26 Jul 2001 14:07:17 -0400
Received: from mail.myrio.com ([63.109.146.2]:49909 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S268617AbRGZSHL>;
	Thu, 26 Jul 2001 14:07:11 -0400
Message-ID: <D52B19A7284D32459CF20D579C4B0C0214A6CB@mail0.myrio.com>
From: Nat Ersoz <nat.ersoz@myrio.com>
To: linux-kernel@vger.kernel.org
Subject: RE: IGMP join/leave time variability
Date: Thu, 26 Jul 2001 11:07:05 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This morning, after dealing with other bugs, I was able to verify (using
tcpdump) that

#define  IGMP_Initial_Report_Delay	5

fixed the "long" (1 sec) variable delay associated with the first igmp join
message.  This resolves a specific bug in our application (excessive IGMP
join delay as compared to an NT client).

Can we get something like this moved into future versions of ipv4/igmp.c?

Thanks,

Nat

-----Original Message-----
From: Torrey Hoffman [mailto:torrey.hoffman@myrio.com]
Sent: Thursday, July 26, 2001 10:47 AM
To: 'Alan Cox'; Nat Ersoz
Cc: linux-kernel@vger.kernel.org
Subject: RE: IGMP join/leave time variability



Alan Cox wrote:
 
> Read the IGMP RFC documents they discuss in detail the cases 
> where time delays and randomness are needed and important. 

I'm one of Nat's co-workers, also looking at this problem.

RFC 2236, the IGMPv2 spec, states:
"
   When a host joins a multicast group, it should immediately transmit
   an unsolicited Version 2 Membership Report for that group, in case it
   is the first member of that group on the network.  To cover the
   possibility of the initial Membership Report being lost or damaged,
   it is recommended that it be repeated once or twice after short
   delays [Unsolicited Report Interval].  
"

>From this, I infer that there should be _no_ initial delay on sending 
the IGMP join.  In fact, a quick peek at the source confirms this: 
(net/ipv4/igmp.c):

#define IGMP_Initial_Report_Delay               (1*HZ)

/* IGMP_Initial_Report_Delay is not from IGMP specs!
 * IGMP specs require to report membership immediately after
 * joining a group, but we delay the first report by a
 * small interval. It seems more natural and still does not
 * contradict to specs provided this delay is small enough.
 */

But this "small interval" is actually very noticeable in our application.

I think we'll take it out of our version, and I believe it should be 
removed from the standard kernel.

Regards,

Torrey Hoffman
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
