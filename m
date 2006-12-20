Return-Path: <linux-kernel-owner+w=401wt.eu-S932943AbWLTB54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943AbWLTB54 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 20:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932949AbWLTB54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 20:57:56 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:34999 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932943AbWLTB5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 20:57:55 -0500
Subject: Re: [RFC] HZ free ntp
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1166578357.5594.3.camel@localhost>
References: <20061204204024.2401148d.akpm@osdl.org>
	 <Pine.LNX.4.64.0612060348150.1868@scrub.home>
	 <20061205203013.7073cb38.akpm@osdl.org>
	 <1165393929.24604.222.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0612061334230.1867@scrub.home>
	 <20061206131155.GA8558@elte.hu>
	 <Pine.LNX.4.64.0612061422190.1867@scrub.home>
	 <1165956021.20229.10.camel@localhost>
	 <Pine.LNX.4.64.0612131338420.1867@scrub.home>
	 <1166037549.6425.21.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0612132125450.1867@scrub.home>
	 <1166578357.5594.3.camel@localhost>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 17:54:18 -0800
Message-Id: <1166579658.5594.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 17:32 -0800, john stultz wrote:
> On Wed, 2006-12-13 at 21:40 +0100, Roman Zippel wrote:
> > On Wed, 13 Dec 2006, john stultz wrote:
> > > > You don't have to introduce anything new, it's tick_length that changes
> > > > and HZ that becomes a variable in this function.
> > >
> > > So, forgive me for rehashing this, but it seems we're cross talking
> > > again. The context here is the dynticks code. Where HZ doesn't change,
> > > but we get interrupts at much reduced rates.
> > 
> > I know and all you have to change in the ntp and some related code is to
> > replace HZ there with a variable, thus make it changable, so you can
> > increase the update interval (i.e. it becomes 1s/hz instead of 1s/HZ).
> 
> Untested patch below. Does this vibe better with you are suggesting?

And here would be the follow on patch (again *untested*) for
CONFIG_NO_HZ slowing the time accumulation down to once per second.

thanks
-john


diff --git a/include/linux/timex.h b/include/linux/timex.h
index 8241e6e..3beb539 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -286,7 +286,11 @@ #endif /* !CONFIG_TIME_INTERPOLATION */
 
 #define TICK_LENGTH_SHIFT	32
 
+#ifdef CONFIG_NO_HZ
+#define NTP_INTERVAL_FREQ  (1)
+#else
 #define NTP_INTERVAL_FREQ  (HZ)
+#endif
 #define NTP_INTERVAL_LENGTH (NSEC_PER_SEC/NTP_INTERVAL_FREQ)
 
 /* Returns how long ticks are at present, in ns / 2^(SHIFT_SCALE-10). */
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index d0ba190..53979a9 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -127,12 +127,14 @@ EXPORT_SYMBOL_GPL(ktime_get_ts);
  */
 static void hrtimer_get_softirq_time(struct hrtimer_base *base)
 {
+	struct timespec ts;
 	ktime_t xtim, tomono;
 	unsigned long seq;
 
 	do {
 		seq = read_seqbegin(&xtime_lock);
-		xtim = timespec_to_ktime(xtime);
+		getnstimeofday(&ts);
+		xtim = timespec_to_ktime(ts);
 		tomono = timespec_to_ktime(wall_to_monotonic);
 
 	} while (read_seqretry(&xtime_lock, seq));


