Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267164AbUHaGxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUHaGxO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267170AbUHaGxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:53:13 -0400
Received: from mx2.elte.hu ([157.181.151.9]:37555 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266885AbUHaGwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:52:38 -0400
Date: Tue, 31 Aug 2004 08:53:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com, tytso@mit.edu
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040831065327.GA30631@elte.hu>
References: <200408282210.03568.pnambic@unu.nu> <20040828203116.GA29686@elte.hu> <1093727453.8611.71.camel@krustophenia.net> <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net> <1093737080.1385.2.camel@krustophenia.net> <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu> <20040830090608.GA25443@elte.hu> <1093934448.5403.4.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093934448.5403.4.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Mon, 2004-08-30 at 05:06, Ingo Molnar wrote:
> > i've uploaded -Q5 to:
> > 
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q5
> 
> This fixes the PS/2 issue.  Entropy rekeying is still a big problem:
> 
> http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-bk4-Q5#/var/www/2.6.9-rc1-bk4-Q5/trace3.txt

ok. It seems the random driver is _mostly_ in shape latency-wise, except
the IP rekeying visible in the above trace. To solve this problem, could
you try the patch below, ontop of -Q5? It moves the random seed
generation outside of the spinlock - AFAICS the spinlock is only needed
to protect the IP sequence counter itself.

	Ingo

--- linux/drivers/char/random.c.orig
+++ linux/drivers/char/random.c
@@ -2226,17 +2226,18 @@ static unsigned int ip_cnt;
 
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
