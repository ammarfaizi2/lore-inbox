Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTJ0JsS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 04:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTJ0JsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 04:48:18 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:38042 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261188AbTJ0JsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 04:48:08 -0500
Date: Mon, 27 Oct 2003 10:47:53 +0100 (MET)
Message-Id: <200310270947.h9R9lr8M003468@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andries.Brouwer@cwi.nl, torvalds@osdl.org
Subject: Re: Linux 2.6.0-test9
Cc: akpm@osdl.org, davem@redhat.com, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Oct 2003 18:10:03 -0800 (PST), Linus Torvalds wrote:
>On Mon, 27 Oct 2003 Andries.Brouwer@cwi.nl wrote:
>> 
>> rlogin followed by "emacs -nw".
>
>Ok. I bet I've never seen it partly because I only use ssh (I don't even
>allow rlogin to any of my machines). But you're right, rlogin certainly
>not only uses OOB data, but uses SIGURG itself. I would actually expect 
>that if we delay the SIGURG until after we've read the URG data, the child 
>process that wants to actually read the URG data will trivially hang, 
>waiting for it.
>
>If this is easily repeatable for you, can you test just applying this
>patch on top of plain -test9? It's not the patch I'd actually do in real 
>life, but it's the minimal patch to verify that it's really SIGURG and 
>urgent data that is the thing you see. Sounds very likely, but it would be 
>good to really verify.

This patch does fix the rlogin + emacs -nw problems.

/Mikael

>--- 1.49/net/ipv4/tcp.c	Mon Oct 20 22:27:42 2003
>+++ edited/net/ipv4/tcp.c	Sun Oct 26 17:59:14 2003
>@@ -1536,9 +1536,15 @@
> 		struct sk_buff *skb;
> 		u32 offset;
> 
>-		/* Are we at urgent data? Stop if we have read anything. */
>-		if (copied && tp->urg_data && tp->urg_seq == *seq)
>-			break;
>+		/* Are we at urgent data? Stop if we have read anything or have SIGURG pending. */
>+		if (tp->urg_data && tp->urg_seq == *seq) {
>+			if (copied)
>+				break;
>+			if (signal_pending(current)) {
>+				copied = timeo ? sock_intr_errno(timeo) : -EAGAIN;
>+				break;
>+			}
>+		}
> 
> 		/* Next get a buffer. */
> 
