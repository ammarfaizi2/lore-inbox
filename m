Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161100AbVLWW5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161100AbVLWW5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161113AbVLWW5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:57:53 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:15025 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1161100AbVLWW5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:57:51 -0500
Message-ID: <43AC80E5.6050906@colorfullife.com>
Date: Fri, 23 Dec 2005 23:57:41 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Jack Steiner <steiner@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] add missing memory barriers to ipc/sem.c
Content-Type: multipart/mixed;
 boundary="------------070809060408050402040400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070809060408050402040400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Two smp_wmb() statements are missing in the sysv sem code: This could 
cause stack corruptions.
The attached patch adds them.

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>

--------------070809060408050402040400
Content-Type: text/plain;
 name="patch-ipc-sem-wmb"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ipc-sem-wmb"

--- 2.6/ipc/sem.c	2005-12-19 01:36:54.000000000 +0100
+++ build-2.6/ipc/sem.c	2005-12-23 23:25:17.000000000 +0100
@@ -381,6 +381,7 @@
 			/* hands-off: q will disappear immediately after
 			 * writing q->status.
 			 */
+			smb_wmb();
 			q->status = error;
 			q = n;
 		} else {
@@ -461,6 +462,7 @@
 		n = q->next;
 		q->status = IN_WAKEUP;
 		wake_up_process(q->sleeper); /* doesn't sleep */
+		smp_wmb();
 		q->status = -EIDRM;	/* hands-off q */
 		q = n;
 	}

--------------070809060408050402040400--
