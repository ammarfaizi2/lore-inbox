Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264986AbTA1Uhh>; Tue, 28 Jan 2003 15:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267687AbTA1Uhh>; Tue, 28 Jan 2003 15:37:37 -0500
Received: from pizda.ninka.net ([216.101.162.242]:37273 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264986AbTA1Uhg>;
	Tue, 28 Jan 2003 15:37:36 -0500
Date: Tue, 28 Jan 2003 12:34:13 -0800 (PST)
Message-Id: <20030128.123413.51821993.davem@redhat.com>
To: benoit-lists@fb12.de
Cc: kuznet@ms2.inr.ac.ru, dada1@cosmosbay.com, cgf@redhat.com, andersg@0x63.nu,
       lkernel2003@tuxers.net, linux-kernel@vger.kernel.org, tobi@tobi.nu
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x,
 through Cisco PIX
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030128201645.A29746@turing.fb12.de>
References: <200301281409.RAA28740@sex.inr.ac.ru>
	<20030128.103534.115458142.davem@redhat.com>
	<20030128201645.A29746@turing.fb12.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Sebastian Benoit <benoit-lists@fb12.de>
   Date: Tue, 28 Jan 2003 20:16:45 +0100

   David S. Miller(davem@redhat.com)@2003.01.28 10:35:34 +0000:
   > Good set of debug checks would be the following:
   
   no output, i did 4 tests, everytime i was able to lock the ssh-connection
   within a few seconds. kernel 2.5.59 + your debug-patch.

Thanks for testing, how about this new patch at the end of this email?
Does it make the problem go away?

Alexey, most solid report is that 2.5.43-bk1 makes bug appear.
This is good because it sort of narrows things down.  What is
contained there in networking is:

1) initial stackable dst logic, should not cause problems
2) addition of UDP sendfile and ip_append_*() logic
3) fix to tcp_check_req() "fix" :-)  it only changes bahevior
   on connect so should not be a problem

I heavily, therefore, suspect #2 which is why I am poking around
in the tcp.c changes to change checksumming and copying semantics.

--- net/ipv4/tcp.c.~1~	Tue Jan 28 12:40:09 2003
+++ net/ipv4/tcp.c	Tue Jan 28 12:41:48 2003
@@ -1089,11 +1089,13 @@
 				if (!skb)
 					goto wait_for_memory;
 
+#if 0
 				/*
 				 * Check whether we can use HW checksum.
 				 */
 				if (sk->route_caps & (NETIF_F_IP_CSUM|NETIF_F_NO_CSUM|NETIF_F_HW_CSUM))
 					skb->ip_summed = CHECKSUM_HW;
+#endif
 
 				skb_entail(sk, tp, skb);
 				copy = mss_now;
