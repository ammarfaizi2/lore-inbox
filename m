Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266617AbUHQTSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266617AbUHQTSu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 15:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266630AbUHQTSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 15:18:50 -0400
Received: from thunk.org ([140.239.227.29]:42396 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S266617AbUHQTSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 15:18:45 -0400
Date: Tue, 17 Aug 2004 15:18:19 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040817191819.GA19449@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Florian Schmidt <mista.tapas@gmx.net>
References: <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092374851.3450.13.camel@mindpipe> <1092375673.3450.15.camel@mindpipe> <20040813103151.GH8135@elte.hu> <1092699974.13981.95.camel@krustophenia.net> <20040817074826.GA1238@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817074826.GA1238@elte.hu>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 09:48:26AM +0200, Ingo Molnar wrote:
> > +	return nbytes;
> > +    
> 
> since this effectively disables the random driver i cannot add it to the
> patch.

The problem isn't extract_entropy(), as much as the fact that we're
calling it from check_and_rekey(), which in turn is being called by
the secure TCP sequence number generation code.  If you are looking
for a more localized way of getting rid of the probably while
minimizing the amount of code that's being disabled, you can simply do
this instead:

--- random.c	2004-08-09 02:26:29 -0400
+++ random.c.new	2004-08-17 14:04:56 -0400
@@ -2207,7 +2207,8 @@
 #undef K3
 
 /* This should not be decreased so low that ISNs wrap too fast. */
-#define REKEY_INTERVAL	300
+#define REKEY_INTERVAL	((time_t) -1)
+
 /*
  * Bit layout of the tcp sequence numbers (before adding current time):
  * bit 24-31: increased after every key exchange

WARNING: this will effectively disable the secure TCP sequence
generation, thus making your system more vulnerable to TCP hijacking
attacks --- but if you cared about such attacks, you'd be using Real
Crypto in your application progams anyway...

> there's another thing you could try: various SHA_CODE_SIZE values in
> drivers/char/random.c. Could you try 1, 2 and 3, does it change the
> overhead as seen in the trace?

I doubt SHA_CODE_SIZE will make a sufficient difference to avoid the
latency problems.  What we would need to do is to change the code so
that the rekey operation in __check_and_rekey takes place in a
workqueue.  Say, something like this (warning, I haven't tested this
patch; if it breaks, you get to keep both pieces):

===== drivers/char/random.c 1.45 vs edited =====
--- 1.45/drivers/char/random.c	2004-08-08 02:43:40 -04:00
+++ edited/drivers/char/random.c	2004-08-17 15:15:57 -04:00
@@ -2241,30 +2241,35 @@
 static spinlock_t ip_lock = SPIN_LOCK_UNLOCKED;
 static unsigned int ip_cnt;
 
-static struct keydata *__check_and_rekey(time_t time)
+static void rekey_seq_generator(void *private_)
 {
 	struct keydata *keyptr;
+	struct timeval 	tv;
+
+	do_gettimeofday(&tv);
+
 	spin_lock_bh(&ip_lock);
 	keyptr = &ip_keydata[ip_cnt&1];
-	if (!keyptr->rekey_time || (time - keyptr->rekey_time) > REKEY_INTERVAL) {
-		keyptr = &ip_keydata[1^(ip_cnt&1)];
-		keyptr->rekey_time = time;
-		get_random_bytes(keyptr->secret, sizeof(keyptr->secret));
-		keyptr->count = (ip_cnt&COUNT_MASK)<<HASH_BITS;
-		mb();
-		ip_cnt++;
-	}
+
+	keyptr = &ip_keydata[1^(ip_cnt&1)];
+	keyptr->rekey_time = tv.tv_sec;
+	get_random_bytes(keyptr->secret, sizeof(keyptr->secret));
+	keyptr->count = (ip_cnt&COUNT_MASK)<<HASH_BITS;
+	mb();
+	ip_cnt++;
+
 	spin_unlock_bh(&ip_lock);
-	return keyptr;
 }
 
+static DECLARE_WORK(rekey_work, rekey_seq_generator, NULL);
+
 static inline struct keydata *check_and_rekey(time_t time)
 {
 	struct keydata *keyptr = &ip_keydata[ip_cnt&1];
 
 	rmb();
 	if (!keyptr->rekey_time || (time - keyptr->rekey_time) > REKEY_INTERVAL) {
-		keyptr = __check_and_rekey(time);
+		schedule_work(&rekey_work);
 	}
 
 	return keyptr;

						- Ted
