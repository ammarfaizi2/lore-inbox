Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268021AbUHPXpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268021AbUHPXpf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 19:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268026AbUHPXpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 19:45:35 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64647 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268021AbUHPXpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 19:45:21 -0400
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>, tytso@mit.edu
In-Reply-To: <20040813103151.GH8135@elte.hu>
References: <1090832436.6936.105.camel@mindpipe>
	 <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu>
	 <20040812235116.GA27838@elte.hu> <1092374851.3450.13.camel@mindpipe>
	 <1092375673.3450.15.camel@mindpipe>  <20040813103151.GH8135@elte.hu>
Content-Type: text/plain
Message-Id: <1092699974.13981.95.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 19:46:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-13 at 06:31, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O6
> > 
> > Ugh, this is a bad one:
> > 
> > preemption latency trace v1.0
> > -----------------------------
> >  latency: 506 us, entries: 157 (157)
> >  process: evolution/3461, uid: 1000
> >  nice: 0, policy: 0, rt_priority: 0
> > =======>
> >  0.000ms (+0.000ms): get_random_bytes (__check_and_rekey)
> [...]
> >  0.493ms (+0.001ms): local_bh_enable (__check_and_rekey)
> 
> indeed this is a new one. Entropy rekeying every 300 seconds. Most of
> the overhead comes from the memcpy's - 10 usecs a pop!
> 

I have attached a patch that effectively disables extract_entropy.  I am
adding Theodore T'so to the cc: list as he is the author of the code in
question.

For the time being this hack is required to avoid ~0.5 ms
non-preemptible sections caused by the excessive memcpy's in
extract_entropy.

I am not a crypto expert, but it seems like there would be a zero-copy
solution.  Alternatively, a way to tell the system that we just don't
need THAT much entropy would be acceptable.  I would gladly trade
predictable TCP sequence numbers for the ability to do low latency
audio.

Ingo, can you add this to -P3, unless someone proposes a better way?

Lee

--- linux-2.6.8.1/drivers/char/random.c	2004-08-14 06:54:48.000000000 -0400
+++ linux-2.6.8.1-P2/drivers/char/random.c	2004-08-16 19:26:29.000000000 -0400
@@ -1354,6 +1354,8 @@
 static ssize_t extract_entropy(struct entropy_store *r, void * buf,
 			       size_t nbytes, int flags)
 {
+	return nbytes;
+    
 	ssize_t ret, i;
 	__u32 tmp[TMP_BUF_SIZE];
 	__u32 x;




