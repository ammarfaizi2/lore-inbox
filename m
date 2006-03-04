Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWCDQrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWCDQrE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 11:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWCDQq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 11:46:59 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:61922 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S932169AbWCDQnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 11:43:49 -0500
Date: Sun, 05 Mar 2006 01:43:38 +0900 (JST)
Message-Id: <20060305.014338.25910236.anemo@mba.ocn.ne.jp>
To: paulus@samba.org
Cc: akpm@osdl.org, ak@muc.de, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org, johnstul@us.ibm.com,
       rth@twiddle.net
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <17417.35072.247188.486774@cargo.ozlabs.ibm.com>
References: <17417.32015.6281.253814@cargo.ozlabs.ibm.com>
	<20060304034449.3fd5e2fa.akpm@osdl.org>
	<17417.35072.247188.486774@cargo.ozlabs.ibm.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 4 Mar 2006 23:33:04 +1100, Paul Mackerras <paulus@samba.org> said:
>> > > Also I assume Atsushi-san did the patch because he saw a real problem?
>> > 
>> > Yes, one which I also saw on PPC.  The compiler (gcc-4) emits loads
>> > for jiffies, jiffies64 and wall_jiffies before storing the incremented
>> > jiffies64 value back.
>> > 
>> 
>> What was the effect of that?

paulus> The effect is that the first call to do_timer doesn't increment xtime.
paulus> This explains why the code I have to detect disagreements between
paulus> xtime and the time of day as computed from the timebase register was
paulus> finding a disagreement on the first tick, which I was scratching my
paulus> head over.

paulus> There may be other effects on architectures which use wall_jiffies to
paulus> detect lost timer ticks.  We don't have that problem on PPC and we
paulus> don't use wall_jiffies in computing time of day.

Well, I found this problem during investigating an another MIPS
do_gettimeofday() bug which was fixed recently.  It was:

	lost = jiffies - wall_jiffies;
	...
	} else if (unlikely(lost))
		usecs += lost * tick_usec;

The tick_usec should not be used here since it is based on USER_HZ.
It is 'usecs += lost * (USECS_PER_SEC /HZ)' now.

I wondered why this bug really affects gettimeofday() always though
the 'lost' should usually be 0.  And finally I noticed the
jiffies/jiffies_64 optimization issue.

---
Atsushi Nemoto
