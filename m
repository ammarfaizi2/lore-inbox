Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVHAW4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVHAW4t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 18:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVHAW4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 18:56:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:25988 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261233AbVHAW4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 18:56:47 -0400
Date: Mon, 1 Aug 2005 15:56:43 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Josip Loncaric <josip@lanl.gov>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] net/sunrpc: fix time conversion error
Message-ID: <20050801225643.GA4285@us.ibm.com>
References: <42EE9014.7080205@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EE9014.7080205@lanl.gov>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.08.2005 [15:11:48 -0600], Josip Loncaric wrote:
> Line 589 of linux-2.6.11.10/net/sunrpc/svcsock.c is obviously wrong:
> 
>                 skb->stamp.tv_usec = xtime.tv_nsec * 1000;
> 
> To convert nsec to usec, one should divide instead of multiplying:
> 
>                 skb->stamp.tv_usec = xtime.tv_nsec / 1000;
> 
> The same bug could be present in the latest kernels, although I haven't 
> checked.  This bug makes svc_udp_recvfrom() timestamps incorrect.

Agreed, the conversion is wrong. I think the code is buggy period, as it
accesses xtime without grabbing the xtime_lock first. Following patch
should fix both issues.

Description: This function incorrectly multiplies a nanosecond value by
1000, instead of dividing by 1000, to obtain a corresponding microsecond
value. Fix the math. Also, the function incorrectly accesses xtime
without using the xtime_lock. Fixed as well. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 svcsock.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

--- 2.6.13-rc4/net/sunrpc/svcsock.c	2005-07-29 14:11:50.000000000 -0700
+++ 2.6.13-rc4-dev/net/sunrpc/svcsock.c	2005-08-01 15:51:11.000000000 -0700
@@ -559,6 +559,7 @@ svc_udp_recvfrom(struct svc_rqst *rqstp)
 	struct svc_serv	*serv = svsk->sk_server;
 	struct sk_buff	*skb;
 	int		err, len;
+        unsigned long	seq;
 
 	if (test_and_clear_bit(SK_CHNGBUF, &svsk->sk_flags))
 	    /* udp sockets need large rcvbuf as all pending
@@ -585,8 +586,11 @@ svc_udp_recvfrom(struct svc_rqst *rqstp)
 		dprintk("svc: recvfrom returned error %d\n", -err);
 	}
 	if (skb->stamp.tv_sec == 0) {
-		skb->stamp.tv_sec = xtime.tv_sec; 
-		skb->stamp.tv_usec = xtime.tv_nsec * 1000; 
+		do {
+			seq = read_seqbegin(&xtime_lock);
+			skb->stamp.tv_sec = xtime.tv_sec; 
+			skb->stamp.tv_usec = xtime.tv_nsec / 1000; 
+		} while (read_seqretry(&xtime_lock, seq));
 		/* Don't enable netstamp, sunrpc doesn't 
 		   need that much accuracy */
 	}
