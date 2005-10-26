Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbVJZIgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbVJZIgX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 04:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVJZIgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 04:36:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41137 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932591AbVJZIgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 04:36:22 -0400
Message-ID: <435F3FFC.6020303@RedHat.com>
Date: Wed, 26 Oct 2005 04:36:12 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nfs@lists.sourceforge.net
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Bad  nsec conversion  in svc_udp_recvfrom()
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In patch-2.6.14-rc5 there is the following:
@@ -584,13 +583,16 @@ svc_udp_recvfrom(struct svc_rqst *rqstp)
         /* possibly an icmp error */
         dprintk("svc: recvfrom returned error %d\n", -err);
     }
-   if (skb->stamp.tv_sec == 0) {
-       skb->stamp.tv_sec = xtime.tv_sec;
-       skb->stamp.tv_usec = xtime.tv_nsec / NSEC_PER_USEC;
+   if (skb->tstamp.off_sec == 0) {
+       struct timeval tv;
+
+       tv.tv_sec = xtime.tv_sec;
+       tv.tv_usec = xtime.tv_nsec * 1000;
+       skb_set_timestamp(skb, &tv);
         /* Don't enable netstamp, sunrpc doesn't
            need that much accuracy */
     }
-   svsk->sk_sk->sk_stamp = skb->stamp;
+   skb_get_timestamp(skb, &svsk->sk_sk->sk_stamp);
     set_bit(SK_DATA, &svsk->sk_flags); /* there may be more data... */

     /*
Shouldn't tv.tv_usec = xtime.tv_nsec * 1000
be tv.tv_usec = xtime.tv_nsec / 1000 or possible
tv.tv_usec = xtime.tv_nsec / NSEC_PER_USEC ?

The was fixed by a previous patch
(see http://lkml.org/lkml/2005/8/1/251)
but now it seems to be broken again...

steved.


