Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbRGZCF0>; Wed, 25 Jul 2001 22:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267541AbRGZCFR>; Wed, 25 Jul 2001 22:05:17 -0400
Received: from mail.myrio.com ([63.109.146.2]:14322 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S267534AbRGZCFH>;
	Wed, 25 Jul 2001 22:05:07 -0400
Message-ID: <D52B19A7284D32459CF20D579C4B0C0214A6C7@mail0.myrio.com>
From: Nat Ersoz <nat.ersoz@myrio.com>
To: linux-kernel@vger.kernel.org
Subject: IGMP join/leave time variability
Date: Wed, 25 Jul 2001 19:04:32 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Greetings,

I'm encountering time variability with IGMP joins and leaves.  I'm working
with the 2.2.19 kernel.  I've placed gettimeofday() printf's within the user
space program and do_gettimeofday() printk's within the ethernet driver.

So far, what I've found is typical of this captured data:

--- user space timestamps
996133011.376224 +UserCloseSource		
996133011.377821 -UserCloseSource
996133011.378296 +UserOpenSource: 224.0.17.103:2001
    calls:
         socket()
         setsockopt(REUSEADDR)
         bind()
         setsockopt(IP_ADD_MEMBERSHIP)
996133011.379933 -UserOpenSource: 224.0.17.103:2001: result=0

---- tcpdump output:
00:36:43.335501 > stb_nat.et.myrio.com > 224.0.17.104: igmp nreport
224.0.17.104 [ttl 1]
00:36:45.245501 > stb_nat.et.myrio.com > 224.0.17.104: igmp nreport
224.0.17.104 [ttl 1]
00:36:51.376707 > stb_nat.et.myrio.com > all-routers.mcast.net: igmp leave
224.0.17.104 [ttl 1]
00:36:52.275523 > stb_nat.et.myrio.com > 224.0.17.103: igmp nreport
224.0.17.103 [ttl 1]
00:36:53.705502 > stb_nat.et.myrio.com > 224.0.17.103: igmp nreport
224.0.17.103 [ttl 1]
00:37:02.495500 > stb_nat.et.myrio.com > 224.0.17.103: igmp nreport
224.0.17.103 [ttl 1]

---- ethernet driver timestamps (natsemi.o, modified)
Jul 26 00:36:35 stb_nat kernel: eth0: Add Multicast  996132995.817524
Jul 26 00:36:35 stb_nat kernel: ^I1.0.94.0.0.1
Jul 26 00:36:35 stb_nat kernel: eth0: Add Multicast  996132995.819686
Jul 26 00:36:35 stb_nat kernel: 1.0.94.0.17.104
Jul 26 00:36:35 stb_nat kernel: 1.0.94.0.0.1

==== Some notes:
1. The user space socket() calls take less than 4mS to complete.
2. The ethernet multicast filter gets set very quickly: less than 2 mS.
3. Tcpdump reports that the time between this leave and join is 900 mS for
this particular transaction.  We have correlated tcpdump's results with
actual traffic on the ethernet wire using a network analyzer and found
tcpdump to be accurate.

==== Linux 2.2.19 code:
I have dug into code and it seems that the function igmp_group_added(),
found in linux/net/ipv4/igmp.c, is where things really happen.  The function
igmp_start_timer() gets called with a IGMP_Initial_Report_Delay value of
(1*HZ).    From what I can tell, this amounts to up to 1 second of delay
depending on what net_random() returns in igmp_start_timer() - which agrees
with our measurements of IGMP joins varying from "very short" delays to
something a bit over a second.

==== Questions:
For our application, it would be desireable to have the leave/join occur
ASAP with respect to the user mode calls.
1. What would be the harm if I set IGMP_Initial_Report_Delay to something
very small like 5 to 10 (jiffies)?  No need for net_random() I'de expect in
that case?
2. I'm guessing that modifying igmp_start_timer() to call
igmp_timer_expire() directly is not a good idea, since the timers provide
race condition safeness. (?)

Thanks for wading through this.  I looked at the 2.4.3 igmp.c code and
noticed that its somewhat similar.  Right now our app is at 2.2.19 however.

Thanks for any help and thoughts you may offer.

Nat

________________________________________
Nat Ersoz             Myrio Corporation  
nat.ersoz@myrio.com                      
Phone: 425.897.7278   Fax:425.897.5600   
3500 Carillon Point   Kirkland, WA 98033
