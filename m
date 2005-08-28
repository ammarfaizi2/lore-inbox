Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVH1RXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVH1RXZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 13:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbVH1RXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 13:23:25 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:310 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750700AbVH1RXZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 13:23:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Qayg/aHDPoUOac8tEo5E0MgVIFyCb8ltmLq7hbg86o82l/4/MB1JzihVCzJxnT55+l7wa7DlLCRcw9kCzOsBffcFHKvuYZjY6JelPYBZ/PJCG8b5Py0PEoukRvRxbFeneHDOD4Q7WCT0gs2kgPsYL1r5CVT8zhbScTDPfDSc1WM=
Message-ID: <907421f9050828091657321f1b@mail.gmail.com>
Date: Mon, 29 Aug 2005 00:16:58 +0800
From: mandy london <laborious.bee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: the race condition will occur in below code ?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

below is my  script in brief, when it runs for several minutes , the
computer will reboot quickly without any information  , so I can not
get knowledge form oops and something else .

I use timer and hook respectively, first , using hook to receive
packets from ICP/IP stack on wired interface, the store it in a queue
, then , when the timer arrive , the timer will invoke the
dev_queue_xmit() to send the whole  packets from wireless interface.

void timer_ack(unsigned long no_used){
     int i ;
     struct sk_buff * skb;
     struct net_device * wireless;
     wireless = dev_get_by_name("eth1");//eth1 is wireless interface
     while((skb=skb_dequeue(packet_queue))!=NULL){// get out a packet
from the queue
          dev_queue_xmit(skb);
     }
    
     mod_timer(&timer,100);// change time for polling one time per second

}

unsigned int hook_func(unsigned int hooknum,struct sk_buff **skb,
const struct net_device *in,const struct net_device *out,int
(*okfn)(struct sk_buff *)){
     
// there , I omit some the code handling the packet for the purpose of
forwording like NAT , that means I will handle the packet firstly then
I will insert it to the packet_queue

      struct sk_buff *sb = *skb;
      skb_queue_tail(packet_queue,sb);
}

I test it , normally it can run for about five minutes , then died
without anyting info.
I analyze whether my improper handling on queue leads to it. maybe
there are some race conditions I can not find out.

the most important is whether the case below have the posibility to occur?
       when the kernel run in timer then an interrupt comes , after
the interrupt return results in scheule or the hook_func()'s running ,
then the race condition will occur , I am not clear in this .

any help will be appreciated , thx~
:)
