Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267830AbUHUUmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267830AbUHUUmk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 16:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267822AbUHUUmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 16:42:39 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:40079 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S267811AbUHUUlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 16:41:25 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Lee Revell'" <rlrevell@joe-job.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sat, 21 Aug 2004 23:41:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <1093078705.854.77.camel@krustophenia.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcSHXQk+8oUtfe1CTZCDGxrSnvHCRAAaHuzg
Message-Id: <S267811AbUHUUlZ/20040821204148Z+875@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I added the patch, indeed this was just one of the few modifications I tried
before. The result is failure, the TCP/IP stack still does the checksum...
Perhaps after this modification, the condition that the packet is not
"eaten" may not be telling the system that there is a checksum error, but
instead, just dropping packets by not igniting the TCP ACK function.

-----Original Message-----
From: Lee Revell [mailto:rlrevell@joe-job.com] 
Sent: Saturday, August 21, 2004 10:58 AM
To: Josan Kadett
Cc: linux-kernel
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level

On Sat, 2004-08-21 at 05:50, Josan Kadett wrote:
> Here is the very original linux-kernel mailing list, and if I cannot find
an
> answer here, then nowhere on earth can this answer be found. I also saw
some
> other messages regarding the same issue on the net. None of them is
answered
> correctly; and also as if this is a very "forbidden" thing to disable the
> checksums, most replies are as if they are "unbreakable rules of god".
> Really, I am losing my patience with this. It is also very odd to write a
> low-level application in order to just disable a "feature" of the kernel
to
> deal with a faulty piece of embedded firmware.
> 

Try this.  I have no idea whether it will work.  If it breaks you get to
keep both halves.

--- net/ipv4/tcp_input.c	2004-08-20 16:37:12.000000000 -0400
+++ net/ipv4/tcp_input.c-new	2004-08-21 04:56:51.000000000 -0400
@@ -4234,8 +4234,7 @@
 				}
 			}
 			if (!eaten) {
-				if (tcp_checksum_complete_user(sk, skb))
-					goto csum_error;
+				tcp_checksum_complete_user(sk, skb);
 
 				/* Predicted packet is in window by
definition.
 				 * seq == rcv_nxt and rcv_wup <= rcv_nxt.
@@ -4291,7 +4290,7 @@
 
 slow_path:
 	if (len < (th->doff<<2) || tcp_checksum_complete_user(sk, skb))
-		goto csum_error;
+		;
 
 	/*
 	 * RFC1323: H1. Apply PAWS check first.

Lee




