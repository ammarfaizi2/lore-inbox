Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <156011-17165>; Thu, 3 Dec 1998 12:56:57 -0500
Received: from cs.huji.ac.il ([132.65.16.10]:1699 "EHLO cs.huji.ac.il" ident: "SOCKWRITE-65") by vger.rutgers.edu with ESMTP id <156299-17165>; Thu, 3 Dec 1998 09:04:38 -0500
Date: Thu, 3 Dec 1998 18:20:00 +0200 (IST)
From: Oren Laadan <orenl@cs.huji.ac.il>
Reply-To: Oren Laadan <orenl@cs.huji.ac.il>
To: linux-kernel@vger.rutgers.edu, mj@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [BUG] arp replies with BOOTP [more info]
In-Reply-To: <199812022036.WAA29482@mos220.cs.huji.ac.il>
Message-ID: <Pine.BSI.3.96.981203180620.1405B-100000@mos220.cs.huji.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

> It appears that while the kenerl is waiting for a reply to a BOOTP
> request sent earlier, it mishandles ARP requests. In particular,
> it replies to every "arp who-has THIS_IP" with "THIS_IP is MY_NIC_ADDR":
> that is, publish its own NIC address as matching EVERY local IP.

A quick test showed that this problem does not occur on 2.0.X kernels.
I'm not sure where exactly within 2.1.X history it appeared.

Also - a temporary, ugly and rude hack, but most importantly - that
works for me. At least until there an "official" patch. It works by
checking within arp_rcv() if the interface is even configured to some
IP, and if not - just drop the packet. So here's a hack to the file
/net/ipv4/arp.c:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*** /net/ipv4/arp.c	Thu Dec  3 18:12:56 1998
--- /net/ipv4/arp.c	Thu Dec  3 18:14:26 1998
***************
*** 550,555 ****
--- 550,567 ----
  	    arp->ar_pln != 4)
  		goto out;
  
+ #if 1
+ 	/* XXX  rude hack to prevent ARP replies during BOOTP */
+ 	{
+ 		struct in_ifaddr *ifa = in_dev->ifa_list;
+ 		for ( ; ifa; ifa = ifa->ifa_next)
+ 			if (ifa->ifa_local || ifa->ifa_address)
+ 				break;
+ 		if (!ifa)
+ 			goto out;
+ 	}
+ #endif
+ 
  	switch (dev_type) {
  	default:	
  		if (arp->ar_pro != __constant_htons(ETH_P_IP))
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

I am not sure, though, whether maybe I should put this piece of code
actually in icmp_rcv(), which is logically correct, however - I wasn't
sure if there were any other *bad* side effects.

I welcome all comments :-)

Oren.
__________________________________________________________________________
                         ______   ____   ___  ___  _  __                  \
MOSIX Development Group  )  )  )  )   ) (  '   )   \ /      Oren Laadan    \
 The Hebrew University  /  /  /  /   /   \    /     /   orenl@cs.huji.ac.il \
 of Jerusalem,  Israel (     (  (___(  ___) _(_  __/ \_______________________)

     http://www.mosix.cs.huji.ac.il     



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
