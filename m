Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262817AbVCPVe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbVCPVe7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVCPVem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:34:42 -0500
Received: from static.labristeknoloji.com ([81.214.24.78]:43445 "EHLO
	yssyk.iliskisel.idealteknoloji.com") by vger.kernel.org with ESMTP
	id S262815AbVCPVbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:31:11 -0500
Message-ID: <4238A591.5090400@labristeknoloji.com>
Date: Wed, 16 Mar 2005 23:30:57 +0200
From: "M.Baris Demiray" <baris@labristeknoloji.com>
Organization: Labris Teknoloji
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Trivial fix for type mismatch warning in riotty.c
Content-Type: multipart/mixed;
 boundary="------------050004040709090407050307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050004040709090407050307
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hello,
following warning encountered in 2.6.11-mm4 but it doesn't seem to
show up with this tree. Rather than casting i made it unsigned
since it doesn't have a signed usage. Some cosmetic changes done
also.

...
drivers/char/rio/riotty.c: In function `riotclose':
drivers/char/rio/riotty.c:672: warning: comparison of distinct pointer
types lacks a cast
...

PS: I've also found a fix [1] including this one but it's not in
mainline as i see.

[1] http://lkml.org/lkml/2004/12/8/91

Signed-off-by: M.Baris Demiray <baris@labristeknoloji.com>

-- 
"You have to understand, most of these people are not ready to be
unplugged. And many of them are no inert, so hopelessly dependent
on the system, that they will fight to protect it."
                                                          Morpheus



--------------050004040709090407050307
Content-Type: text/x-patch;
 name="make-end_time-unsigned-in-riotty.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="make-end_time-unsigned-in-riotty.c.patch"

--- linux-2.6.11-mm4/drivers/char/rio/riotty.c.orig	2005-03-16 22:04:40.000000000 +0200
+++ linux-2.6.11-mm4/drivers/char/rio/riotty.c	2005-03-16 22:26:03.000000000 +0200
@@ -524,16 +524,16 @@
 	register uint SysPort = dev;
 	struct ttystatics *tp;		/* pointer to our ttystruct */
 #endif
-	struct Port *PortP =ptr;	/* pointer to the port structure */
+	struct Port *PortP = ptr;	/* pointer to the port structure */
 	int deleted = 0;
 	int	try = -1; /* Disable the timeouts by setting them to -1 */
 	int	repeat_this = -1; /* Congrats to those having 15 years of 
 				     uptime! (You get to break the driver.) */
-	long end_time;
+	unsigned long end_time;
 	struct tty_struct * tty;
 	unsigned long flags;
 	int Modem;
-	int rv =0;
+	int rv = 0;
 	
 	rio_dprintk (RIO_DEBUG_TTY, "port close SysPort %d\n",PortP->PortNum);
 
@@ -620,7 +620,7 @@
 		if (repeat_this -- <= 0) {
 			rv = -EINTR;
 			rio_dprintk (RIO_DEBUG_TTY, "Waiting for not idle closed broken by signal\n");
-			RIOPreemptiveCmd(p, PortP, FCLOSE ); 
+			RIOPreemptiveCmd(p, PortP, FCLOSE); 
 			goto close_end;
 		}
 		rio_dprintk (RIO_DEBUG_TTY, "Calling timeout to flush in closing\n");
@@ -656,14 +656,12 @@
 		goto close_end;
 	}
 
-	
-
 	/* Can't call RIOShortCommand with the port locked. */
 	rio_spin_unlock_irqrestore(&PortP->portSem, flags);
 
 	if (RIOShortCommand(p, PortP, CLOSE, 1, 0) == RIO_FAIL) {
-	  RIOPreemptiveCmd(p, PortP,FCLOSE);
-	  goto close_end;
+		RIOPreemptiveCmd(p, PortP,FCLOSE);
+		goto close_end;
 	}
 
 	if (!deleted)
@@ -698,7 +696,6 @@
 */
 	PortP->Config &= ~(RIO_CTSFLOW|RIO_RTSFLOW);
 
-
 #ifdef STATS
 	PortP->Stat.CloseCnt++;
 #endif

--------------050004040709090407050307
Content-Type: text/x-vcard; charset=utf-8;
 name="baris.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="baris.vcf"

YmVnaW46dmNhcmQNCmZuOk0uQmFyaXMgRGVtaXJheQ0KbjpEZW1pcmF5O00uQmFyaXMNCm9y
ZzpMYWJyaXMgVGVrbm9sb2ppDQphZHI6OztUZWtub2tlbnQgU2lsaWtvbiBCaW5hIE5vOjI0
IE9EVFU7QW5rYXJhOzswNjUzMTtUdXJrZXkNCmVtYWlsO2ludGVybmV0OmJhcmlzQGxhYnJp
c3Rla25vbG9qaS5jb20NCnRpdGxlOllhemlsaW0gR2VsaXN0aXJtZSBVem1hbmkNCnRlbDt3
b3JrOis5MDMxMjIxMDE0OTANCnRlbDtmYXg6KzkwMzEyMjEwMTQ5Mg0KeC1tb3ppbGxhLWh0
bWw6RkFMU0UNCnVybDpodHRwOi8vd3d3LmxhYnJpc3Rla25vbG9qaS5jb20NCnZlcnNpb246
Mi4xDQplbmQ6dmNhcmQNCg0K
--------------050004040709090407050307--
