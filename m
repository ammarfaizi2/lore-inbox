Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVILLxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVILLxz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 07:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVILLxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 07:53:55 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:51891 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750761AbVILLxy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 07:53:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=InK/1Rj4lOAw9IJqJeMPHj3GMHM+9hvlTZGJ0M7iCZn1jhY2WO9Si3i0WOr6tHklnH6NC8llkdQ1ORBBJP8RH04bwEEga5riiTvrYu9QgeXJoMmXHm4sXRyknFKSg+dO93i4t7VSQYkJEDRGLxw14a9Dtv8hoFqro1DYCK98Rrw=
Message-ID: <6bffcb0e050912045345b08860@mail.gmail.com>
Date: Mon, 12 Sep 2005 13:53:54 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: michal.k.k.piotrowski@gmail.com
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: Re: 2.6.13-mm2 hard lockup
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200509121228.25092.bero@arklinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509121228.25092.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/09/05, Bernhard Rosenkraenzer <bero@arklinux.org> wrote:
> 2.6.13-mm2 locks up hard occasionally (happened for me twice, each time about
> 20 minutes after booting).
> It left the following in the syslog:
> 
> Sep 11 23:19:55 dhcppc0 kernel: KERNEL: assertion ((int)tp->lost_out >= 0)
> failed at net/ipv4/tcp_input.c (2148)
> Sep 11 23:19:59 dhcppc0 kernel: KERNEL: assertion ((int)tp->lost_out >= 0)
> failed at net/ipv4/tcp_input.c (2148)
> Sep 11 23:25:23 dhcppc0 kernel: KERNEL: assertion ((int)tp->sacked_out >= 0)
> failed at net/ipv4/tcp_input.c (2147)
> Sep 11 23:26:04 dhcppc0 last message repeated 2 times
> Sep 11 23:27:55 dhcppc0 kernel: KERNEL: assertion ((int)tp->sacked_out >= 0)
> failed at net/ipv4/tcp_input.c (2147)
> Sep 11 23:27:57 dhcppc0 kernel: KERNEL: assertion ((int)tp->lost_out >= 0)
> failed at net/ipv4/tcp_input.c (2148)
> Sep 11 23:28:00 dhcppc0 kernel: KERNEL: assertion ((int)tp->sacked_out >= 0)
> failed at net/ipv4/tcp_input.c (2147)
> 
> (This was compiled without sysrq support, therefore no detailed trace)
> 
> LLaP
> bero
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Someone from netdev has sent this path. I didn't test it.

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -485,11 +485,6 @@ int tcp_fragment(struct sock *sk, struct
 	TCP_SKB_CB(buff)->when = TCP_SKB_CB(skb)->when;
 	buff->tstamp = skb->tstamp;
 
-	if (TCP_SKB_CB(skb)->sacked & TCPCB_LOST) {
-		tp->lost_out -= tcp_skb_pcount(skb);
-		tp->left_out -= tcp_skb_pcount(skb);
-	}
-
 	old_factor = tcp_skb_pcount(skb);
 
 	/* Fix up tso_factor for both original and new SKB.  */

Here is patch from Herbert Xu


diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -499,7 +499,7 @@ int tcp_fragment(struct sock *sk, struct
 	/* If this packet has been sent out already, we must
 	 * adjust the various packet counters.
 	 */
-	if (after(tp->snd_nxt, TCP_SKB_CB(buff)->end_seq)) {
+	if (!before(tp->snd_nxt, TCP_SKB_CB(buff)->end_seq)) {
 		int diff = old_factor - tcp_skb_pcount(skb) -
 			tcp_skb_pcount(buff);
 

Regards,
Michal Piotrowski
