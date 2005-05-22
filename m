Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVEVRiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVEVRiJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 13:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVEVRiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 13:38:09 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:17828 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261211AbVEVRh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 13:37:57 -0400
Message-ID: <4290C36A.7020006@colorfullife.com>
Date: Sun, 22 May 2005 19:37:46 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.7) Gecko/20050417 Fedora/1.7.7-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: patrick@erdbeere.net, rdunlap@xenotime.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipcsem: remove superflous decrease variable from sys_semtimedop
Content-Type: multipart/mixed;
 boundary="------------050709060801050904090600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050709060801050904090600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

Patrick noticed that the initial scan of the semaphore operations logs 
decrease and increase operations seperately, but then both cases are 
or'ed together and decrease is never used.
The attached patch removes the decrease parameter - it shrinks 
sys_semtimedop() by 56 bytes.
Could you add it to your tree?

Signed-Of-By: Manfred Spraul <manfred@colorfullife.com>

--
    Manfred

--------------050709060801050904090600
Content-Type: text/plain;
 name="patch-ipcsem-nodecrease"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ipcsem-nodecrease"

--- 2.6/ipc/sem.c	2005-05-16 20:03:40.000000000 +0200
+++ build-2.6/ipc/sem.c	2005-05-22 09:23:00.000000000 +0200
@@ -1054,7 +1054,7 @@
 	struct sembuf fast_sops[SEMOPM_FAST];
 	struct sembuf* sops = fast_sops, *sop;
 	struct sem_undo *un;
-	int undos = 0, decrease = 0, alter = 0, max;
+	int undos = 0, alter = 0, max;
 	struct sem_queue queue;
 	unsigned long jiffies_left = 0;
 
@@ -1089,13 +1089,10 @@
 		if (sop->sem_num >= max)
 			max = sop->sem_num;
 		if (sop->sem_flg & SEM_UNDO)
-			undos++;
-		if (sop->sem_op < 0)
-			decrease = 1;
-		if (sop->sem_op > 0)
+			undos = 1;
+		if (sop->sem_op != 0)
 			alter = 1;
 	}
-	alter |= decrease;
 
 retry_undos:
 	if (undos) {

--------------050709060801050904090600--
