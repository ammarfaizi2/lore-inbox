Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129583AbRBGTgx>; Wed, 7 Feb 2001 14:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129526AbRBGTgn>; Wed, 7 Feb 2001 14:36:43 -0500
Received: from 102-209.196.48.dellhost.com ([209.196.48.102]:50449 "HELO
	mx-a.netli.com") by vger.kernel.org with SMTP id <S129498AbRBGTgY>;
	Wed, 7 Feb 2001 14:36:24 -0500
Message-ID: <3A81A204.3020002@netli.com>
Date: Wed, 07 Feb 2001 11:29:08 -0800
From: Ramana Juvvadi <juvvadi@netli.com>
Reply-To: juvvadi@netli.com
Organization: Netli Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; Preview) Gecko/20001101 Beonex/0.6-pre
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug in tcp_time_to_recover 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the following code in tcp_input.c
-----------------------------------------------------------------
static int
tcp_time_to_recover(struct sock *sk, struct tcp_opt *tp)
{
   /* Trick#1: The loss is proven. */
   if (tp->lost_out)
       return 1;

   /* Not-A-Trick#2 : Classic rule... */
   if (tcp_fackets_out(tp) > tp->reordering)
                      ^^^^^^^^^
       return 1;

   /* Trick#3: It is still not OK... But will it be useful to delay
    * recovery more?
    */
   if (tp->packets_out <= tp->reordering &&
       tp->sacked_out >= max(tp->packets_out/2, sysctl_tcp_reordering) &&
       !tcp_may_send_now(sk, tp)) {
       /* We have nothing to send. This connection is limited
        * either by receiver window or by application.
        */
       return 1;
   }

   return 0;
}
----------------------------------------------------

Shouldn't it be a >= instead of > ?

Ramana    




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
