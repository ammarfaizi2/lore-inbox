Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262472AbRENUUM>; Mon, 14 May 2001 16:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262481AbRENUUC>; Mon, 14 May 2001 16:20:02 -0400
Received: from linux.vmri.hu ([193.225.208.140]:4878 "EHLO linux.vmri.hu")
	by vger.kernel.org with ESMTP id <S262472AbRENUTq>;
	Mon, 14 May 2001 16:19:46 -0400
Message-ID: <3B003E2E.7287DC0B@sch.bme.hu>
Date: Mon, 14 May 2001 22:21:02 +0200
From: Marcell Gal <cell@sch.bme.hu>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mostrows@speakeasy.net
CC: linux-kernel@vger.kernel.org, paulus@samba.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: Scheduling in interrupt BUG. [Patch]
In-Reply-To: <3AFFBF14.7D7BAB01@sch.bme.hu> <15103.53345.869090.593925@slug.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch solved the problem. Should be ready for inclusion in 2.4.
No more 'Scheduling in interrupt' under those conditions.
Thanx for the thoughts, solution and the amazing speed.
You guys are doing a really great job!

I hope we can get the earlier mentioned NULL ptr in all_ppp_units list
straight
soon. (I have a simple workaround - the mentioned hash, that even improves
speed,
but I a real fix would be more satisfaction. The relevant part of
ppp_generic.c
is so simple that it's really strange it is not correct.. ).

thanx:
    Cell

Michal Ostrowski wrote:

> Anybody care to comment on this?
> mostrows@speakeasy.net

--- linuxold/drivers/net/pppoe.c        Mon May 14 22:06:44 2001
+++ linux/drivers/net/pppoe.c   Mon May 14 22:11:25 2001
@@ -4,9 +4,9 @@
  * PPPoX --- Generic PPP encapsulation socket family
  * PPPoE --- PPP over Ethernet (RFC 2516)
  *
  *
- * Version:    0.6.5
+ * Version:    0.6.6
  *
  * 030700 :     Fixed connect logic to allow for disconnect.
  * 270700 :    Fixed potential SMP problems; we must protect against
  *             simultaneous invocation of ppp_input
@@ -18,8 +18,9 @@
  *             in pppoe_release.
  * 051000 :    Initialization cleanup.
  * 111100 :    Fix recvmsg.
  * 050101 :    Fix PADT procesing.
+ * 140501 :    pppoe_backlog_rcv must call bh_lock_sock, not lock_sock.
  *
  * Author:     Michal Ostrowski <mostrows@styx.uwaterloo.ca>
  * Contributors:
  *             Arnaldo Carvalho de Melo <acme@xconectiva.com.br>
@@ -383,11 +384,11 @@
  *
  ***********************************************************************/
 int pppoe_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 {
-       lock_sock(sk);
+       bh_lock_sock(sk);
        pppoe_rcv_core(sk, skb);
-       release_sock(sk);
+       bh_unlock_sock(sk);
        return 0;
 }


--
You'll never see all the places, or read all the books, but fortunately,
they're not all recommended.



