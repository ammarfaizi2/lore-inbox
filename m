Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318868AbSHRGot>; Sun, 18 Aug 2002 02:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318869AbSHRGot>; Sun, 18 Aug 2002 02:44:49 -0400
Received: from waste.org ([209.173.204.2]:30696 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318868AbSHRGos>;
	Sun, 18 Aug 2002 02:44:48 -0400
Date: Sun, 18 Aug 2002 01:48:46 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020818064846.GQ21643@waste.org>
References: <Pine.LNX.4.44.0208172058200.1640-100000@home.transmeta.com> <1029652262.898.12.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029652262.898.12.camel@phantasy>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2002 at 02:31:02AM -0400, Robert Love wrote:
> On Sun, 2002-08-18 at 00:01, Linus Torvalds wrote:
> 
> > So I think that if we just made the code be much less trusting (say, 
> > consider the TSC information per interrupt to give only a single bit of 
> > entropy, for example), and coupled that with making network devices always 
> > be considered sources of entropy, we'd have a reasonable balance. 
> 
> I think that sounds good.
> 
> I have a patch which I can send - it needs to be rediffed I suspect -
> that has each network device feed the entropy pool. (Actually, it
> creates a new flag, SA_NET_RANDOM, that defines to SA_SAMPLE_RANDOM or 0
> depending on a configure setting.  If you want it unconditional, that is
> just as easy though).

I think I have a compromise that'll make everyone happy here. I've
added a tunable called trust_pct in /proc/sys/kernel/random. Set it to
100% and untrusted sources will always add a bit of entropy. Defaults
to zero, which should be fine for everyone who's got a head.

Then we can add SA_SAMPLE_RANDOM for network devices unconditionally.

Untested, applies on top of my previous patches:

diff -ur a/drivers/char/random.c b/drivers/char/random.c
--- a/drivers/char/random.c	2002-08-17 20:54:02.000000000 -0500
+++ b/drivers/char/random.c	2002-08-18 01:38:58.000000000 -0500
@@ -724,6 +724,7 @@
  */
 static int benford[16]={0,0,0,1,2,3,4,5,5,6,7,7,8,9,9,10};
 static int last_ctxt=0;
+static int trust_break=50, trust_pct=0, trust_min=0, trust_max=100;
 
 void add_timing_entropy(void *src, unsigned datum)
 {
@@ -764,6 +765,18 @@
 		delta>>=es->shift;
 		bits=benford[int_log2_16bits(delta & 0xffff)];
 	}
+
+	/* Throw in an untrusted bit as entropy trust_pct% of the time */
+	if(trust_pct && !bits)
+	{
+		trust_break+=trust_pct;
+		if(trust_break>100)
+		{
+			bits=1;
+			trust_break-=100;
+		}
+	}
+
 	batch_entropy_store(datum^time, bits);
 }
 
@@ -1779,6 +1792,10 @@
 	{RANDOM_UUID, "uuid",
 	 NULL, 16, 0444, NULL,
 	 &proc_do_uuid, &uuid_strategy},
+	{RANDOM_TRUST_PCT, "trust_pct",
+	 &trust_pct, sizeof(int), 0644, NULL,
+	 &proc_dointvec_minmax, &sysctl_intvec, 0,
+	 &trust_min, &trust_max},
 	{0}
 };
 
diff -ur a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	2002-08-17 00:30:00.000000000 -0500
+++ b/include/linux/sysctl.h	2002-08-18 01:37:54.000000000 -0500
@@ -182,7 +182,8 @@
 	RANDOM_READ_THRESH=3,
 	RANDOM_WRITE_THRESH=4,
 	RANDOM_BOOT_ID=5,
-	RANDOM_UUID=6
+	RANDOM_UUID=6,
+	RANDOM_TRUST_PCT=7
 };
 
 /* /proc/sys/bus/isa */


-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
