Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTJ0CK2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 21:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263719AbTJ0CK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 21:10:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:29121 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263295AbTJ0CKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 21:10:21 -0500
Date: Sun, 26 Oct 2003 18:10:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries.Brouwer@cwi.nl
cc: akpm@osdl.org, <davem@redhat.com>, <kuznet@ms2.inr.ac.ru>,
       <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: Linux 2.6.0-test9
In-Reply-To: <UTC200310270148.h9R1mqO06057.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0310261752160.3157-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Oct 2003 Andries.Brouwer@cwi.nl wrote:
> 
> rlogin followed by "emacs -nw".

Ok. I bet I've never seen it partly because I only use ssh (I don't even
allow rlogin to any of my machines). But you're right, rlogin certainly
not only uses OOB data, but uses SIGURG itself. I would actually expect 
that if we delay the SIGURG until after we've read the URG data, the child 
process that wants to actually read the URG data will trivially hang, 
waiting for it.

If this is easily repeatable for you, can you test just applying this
patch on top of plain -test9? It's not the patch I'd actually do in real 
life, but it's the minimal patch to verify that it's really SIGURG and 
urgent data that is the thing you see. Sounds very likely, but it would be 
good to really verify.

I think that this is, btw, the _right_ place for checking that SIGURG
anyway.

The case of being at urgent data really is a special case, and I think it
was a mistake to try to have the signal_pending() check in a common code
sequence - it's really two totally differenct cases when we check for
"should we stop here due to SIGURG handling", or "should we return because
we would have to wait for more data and we have a signal pending".

Yes, both cases test for "signal_pending(current)", but the SIGURG case
really could test for just "do we have SIGURG pending", not just "any
signal".

		Linus

--- 1.49/net/ipv4/tcp.c	Mon Oct 20 22:27:42 2003
+++ edited/net/ipv4/tcp.c	Sun Oct 26 17:59:14 2003
@@ -1536,9 +1536,15 @@
 		struct sk_buff *skb;
 		u32 offset;
 
-		/* Are we at urgent data? Stop if we have read anything. */
-		if (copied && tp->urg_data && tp->urg_seq == *seq)
-			break;
+		/* Are we at urgent data? Stop if we have read anything or have SIGURG pending. */
+		if (tp->urg_data && tp->urg_seq == *seq) {
+			if (copied)
+				break;
+			if (signal_pending(current)) {
+				copied = timeo ? sock_intr_errno(timeo) : -EAGAIN;
+				break;
+			}
+		}
 
 		/* Next get a buffer. */
 

