Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbUJYS72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUJYS72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 14:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbUJYS51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:57:27 -0400
Received: from siaag1ad.compuserve.com ([149.174.40.6]:10975 "EHLO
	siaag1ad.compuserve.com") by vger.kernel.org with ESMTP
	id S261220AbUJYS4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 14:56:41 -0400
Date: Mon, 25 Oct 2004 14:53:52 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Kernel 2.6.9 Page Allocation Failures w/TSO+rollup.patch
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200410251456_MC3-1-8D29-C332@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicj Piggin wrote:

> Does it cause any noticable problems? If not, then stay with
> 2.6.9.
>
> However, it would be nice to get to the bottom of it. It might
> just be happening by chance on 2.6.9 but not 2.6.8.1 though...

  Isn't this the problem fixed by the below patch?  (Sorry I didn't
get sender name when I collected it.)  Some were skeptical this
would fix it but it has worked for those who tried...

  Oh and BTW what is rollup.patch?


# The following patch makes it allocate skb_headlen(skb) - len instead
# of skb->len - len.  When skb is linear there is no difference.  When
# it's non-linear we only ever copy the bytes in the header.
#
===== net/ipv4/tcp_output.c 1.67 vs edited =====
--- 1.67/net/ipv4/tcp_output.c  2004-10-01 13:56:45 +10:00
+++ edited/net/ipv4/tcp_output.c        2004-10-17 18:58:47 +10:00
@@ -455,8 +455,12 @@
 {
        struct tcp_opt *tp = tcp_sk(sk);
        struct sk_buff *buff;
-       int nsize = skb->len - len;
+       int nsize;
        u16 flags;
+
+       nsize = skb_headlen(skb) - len;
+       if (nsize < 0)
+               nsize = 0;
 
        if (skb_cloned(skb) &&
            skb_is_nonlinear(skb) &&

--Chuck Ebbert  25-Oct-04  14:54:36
