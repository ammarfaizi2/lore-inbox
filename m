Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290787AbSBFUYn>; Wed, 6 Feb 2002 15:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290791AbSBFUYe>; Wed, 6 Feb 2002 15:24:34 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:58267 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S290787AbSBFUYW>; Wed, 6 Feb 2002 15:24:22 -0500
Message-ID: <3C6192A5.911D5B4F@nortelnetworks.com>
Date: Wed, 06 Feb 2002 15:31:33 -0500
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: want opinions on possible glitch in 2.4 network error reporting
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been looking around in the 2.4 networking stack, and I noticed that when
the tulip (and no doubt many other) driver cannot put any more outgoing packets
on the queue, it calls netif_stop_queue().  Then, in dev_queue_xmit() we check
this flag by calling netif_queue_stopped().  My concern is that if this flag is
true, we return -ENETDOWN.  Is this really the proper return code for this? If
anything, the network is too active.  It seems to me that it would make more
sense to have some kind of congestion return code rather than claiming that the
network is down.

I think it would make sense to return -ENOBUFS in this case, as its already
listed in the sendto() man page, and the description matches the error because
the command could succeed if retried.

I ran into a somewhat related issue on a 2.2.16 system, where I had an app that
was calling sendto() on 217000 packets/sec, even though the wire could only
handle about 127000 packets/sec.  I got no errors at all in sendto, even though
over a third of the packets were not actually being sent.


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
