Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTKZSAy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 13:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbTKZSAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 13:00:54 -0500
Received: from web80502.mail.yahoo.com ([66.218.79.72]:42369 "HELO
	web80502.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264271AbTKZSAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 13:00:52 -0500
Message-ID: <20031126175304.42296.qmail@web80502.mail.yahoo.com>
Date: Wed, 26 Nov 2003 09:53:04 -0800 (PST)
From: Yogesh Swami <prem_yogesh@sbcglobal.net>
Subject: Linux TCP state machine is broken?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[I'm not subscribed to this mailing list, so please CC
your reply to me]

I have been trying to implement one of the Internet
Drafts in the kernel for experimentation, and while
debugging I reliazed that TCP sender is almost always
in TCP_CA_CWR state. Since Linux doesn't follow the
RFCs, I am not sure if this is what is intended, or if
this is bug.

I think the reason the sender is always in TCP_CA_CWR
and not in TCP_CA_Open is because in the function
"tcp_transmit_skb" (tcp_out.c:190), after sending the
packet to IP-layer, the sender call tcp_enter_cwr() if
the IP layer did not return any non congestion error.
I have put the code fragement at the end of the
e-mail.

I am not clear why a successfuly transmission should
cause the sender to enter CWR (the only other places
when tcp_enter_cwr is called are when there is a ICMP
source quench or when there is ECE bit set for ECN). 

If someone could explain this to me, that would be
great.

Thanks
Yogesh


------tcp_output.c; line 279 -------------

       err = tp->af_specific->queue_xmit(skb, 0);
       if (err <= 0)
              return err;
                                                      
                         
              tcp_enter_cwr(tp);
                                                      
                         
      /* NET_XMIT_CN is special. It does not
guarantee,
       * that this packet is lost. It tells that
device
       * is about to start to drop packets or already
       * drops some packets of the same priority and
       * invokes us to send less aggressively.
       */
       return err == NET_XMIT_CN ? 0 : err;

-------------------------------------
