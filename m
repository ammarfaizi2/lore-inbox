Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269251AbUINJ4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269251AbUINJ4c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 05:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269252AbUINJ4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 05:56:31 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61388 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269251AbUINJ4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:56:19 -0400
Date: Tue, 14 Sep 2004 11:57:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: [patch] sched: fix latency in random driver
Message-ID: <20040914095731.GA24622@elte.hu>
References: <20040914091529.GA21553@elte.hu> <20040914093855.GA23258@elte.hu> <20040914095110.GA24094@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <20040914095110.GA24094@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


the attached patch fixes possibly long scheduling latencies in the
/dev/random driver's rekey_seq_generator() function, by moving the
expensive get_random_bytes() function out from under ip_lock.

has been in the -VP patchset for quite some time.

	Ingo

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-latency-random.patch"


the attached patch fixes possibly long scheduling latencies in the
/dev/random driver's rekey_seq_generator() function, by moving the
expensive get_random_bytes() function out from under ip_lock.

has been in the -VP patchset for quite some time.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/drivers/char/random.c.orig	
+++ linux/drivers/char/random.c	
@@ -2220,17 +2220,18 @@ static unsigned int ip_cnt;
 
 static void rekey_seq_generator(void *private_)
 {
-	struct keydata *keyptr;
+	struct keydata *keyptr, tmp;
 	struct timeval 	tv;
 
 	do_gettimeofday(&tv);
+	get_random_bytes(tmp.secret, sizeof(tmp.secret));
 
 	spin_lock_bh(&ip_lock);
 	keyptr = &ip_keydata[ip_cnt&1];
 
 	keyptr = &ip_keydata[1^(ip_cnt&1)];
 	keyptr->rekey_time = tv.tv_sec;
-	get_random_bytes(keyptr->secret, sizeof(keyptr->secret));
+	memcpy(keyptr->secret, tmp.secret, sizeof(keyptr->secret));
 	keyptr->count = (ip_cnt&COUNT_MASK)<<HASH_BITS;
 	mb();
 	ip_cnt++;

--0OAP2g/MAC+5xKAE--
