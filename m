Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271737AbRH1Wp5>; Tue, 28 Aug 2001 18:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271738AbRH1Wpr>; Tue, 28 Aug 2001 18:45:47 -0400
Received: from biancha.hardboiledegg.com ([66.38.186.202]:41476 "HELO
	biancha.hardboiledegg.com") by vger.kernel.org with SMTP
	id <S271737AbRH1Wpe>; Tue, 28 Aug 2001 18:45:34 -0400
Date: Tue, 28 Aug 2001 18:45:48 -0400
From: Marc Heckmann <heckmann@hbesoftware.com>
To: linux-kernel@vger.kernel.org
Subject: [resend] small patch for 2.4.9 VM
Message-ID: <20010828184548.D16303@hbe.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-AntiVirus: scanned for viruses by AMaViS 0.2.1-pre3 (http://amavis.org/)
X-AntiVirus: scanned for viruses by AMaViS 0.2.1-pre3 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

just resending this now that linus is back. 

calling swap_out() on every kswapd wakeup seems wrong to me.... I've seen swap grow 
while there was no vm pressure at all... Please correct me if I'm wrong. Anyway the 
patch below is quick fix. maybe not the nicest though.

as for the horrible OOM (or near OOM) performance, I tried putting kswapd to sleep 
if we have enough free pages but still an inactive shortage as I mentioned in my 
previous mail. no change. but then again do_try_free_pages has changed quite a bit 
since 2.4.9-pre3.

--MGYHOYXEY6WxJCY8
Content-Type: message/rfc822
Content-Disposition: inline

Date: Thu, 23 Aug 2001 07:21:04 -0400
From: Marc Heckmann <heckmann@hbe.ca>
To: linux-kernel@vger.kernel.org
Subject: small patch for 2.4.9 VM
Message-ID: <20010823072104.A13430@hbe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i

[not on list, please CC me]

Hi,

I've been tracking the vm changes in the 2.4.9-pre series. I was seeing
really good improvements with 2.4.9-pre3 but then in pre4 it went to shit
on my box (192mb, 200mb swap). The page cache was huge at all times and
went pretty deep into swap on light loads. staring at the diff between
pre3 and pre4, I noticed that background page aging in kswapd has changed
[see do_try_free_pages], instead of just doing refill_inactive_scan(), it
now does swap_out() first, then refill_inactive. Somehow, this seems to
prevent proper page aging or something [please correct me if i'm wrong,
haven't had the time to stare at swap_out() yet]. Anyway the short patch
below, makes it behave like pre3 which is quite good for me.  This might
also be the cause of other peoples mm problems with 2.4.9 final.

also, pre3 behaved _very_ good during OOM situations but then after pre4
it degraded to something similar to 2.4.8. The pre4 changes causes
do_try_free_pages to be constantly called by kswapd until _both_ the the
inactive_shortage and the free_shortage are gone. kswapd used to sleep for
a second if at least one of them wasn't short on pages. using some
printk's to debug, I noticed that there are enough free pages, but the
inactive target is _never_ reached so kswapd just goes nuts. This is also
why we don't go into OOM since the oom test only tests free pages and
cache. I think Rik might have commented on this already in another thread.  
When I have time, I'll try putting kswapd to sleep for a second if we have
enough free pages, but not enough inactive ones.

I noticed that a lot of comments in the VM are now bogus with 2.4.9. I
really think that the changes between pre3 and pre4 could have been better
commented. I'm sure the changes have a reason to be there, but having
justification for them would really help to debug the thing.

 -marc

--- linux/mm/vmscan.c.orig.249	Thu Aug 16 23:55:50 2001
+++ linux/mm/vmscan.c	Thu Aug 23 12:35:32 2001
@@ -818,9 +818,11 @@
 #define GENERAL_SHORTAGE 4
 static int do_try_to_free_pages(unsigned int gfp_mask, int user)
 {
-	/* Always walk at least the active queue when called */
-	int shortage = INACTIVE_SHORTAGE;
+	int shortage = 0;
 	int maxtry;
+
+	/* Always walk at least the active queue when called */
+	refill_inactive_scan(DEF_PRIORITY);
 
 	maxtry = 1 << DEF_PRIORITY;
 	do {

--MGYHOYXEY6WxJCY8--

