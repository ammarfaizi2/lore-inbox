Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265712AbTF2R4v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 13:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265714AbTF2R4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 13:56:51 -0400
Received: from h80ad2721.async.vt.edu ([128.173.39.33]:19328 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265712AbTF2R4s (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 13:56:48 -0400
Message-Id: <200306291810.h5TIApEA002032@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: 2.5.73-mm2 - odd audio problem, bad intel8x0/ac97 clocking. 
In-Reply-To: Your message of "Sat, 28 Jun 2003 17:10:36 PDT."
             <20030628171036.4af51e08.akpm@digeo.com> 
From: Valdis.Kletnieks@vt.edu
References: <200306282131.h5SLVjGk001833@turing-police.cc.vt.edu>
            <20030628171036.4af51e08.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1576057118P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 29 Jun 2003 14:10:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1576057118P
Content-Type: text/plain; charset=us-ascii

On Sat, 28 Jun 2003 17:10:36 PDT, Andrew Morton said:

> >  The 'clocking to 51084' is *VERY* suspicious
> 
> It could be that do_gettimeofday() has gone silly.  Could you
> add this patch and see what it says?

Woo woo.  Good catch, Andrew.  It says:

intel8x0_measure_ac97_clock: measured 39909 usecs

Hmm.. wonder why it's 40K rather than the expected 50K...

Turns out we're running at 1.2G rather than 1.6G.. Or at least /proc/cpuinfo
says we are.  However, things are not always what they seem....

Some testing indicates it's probably b0rkage in Dave Jone's recent work
splitting/reorging the speedstep driver....

cset-davej@codemonkey.org.uk|ChangeSet|20030626004701|05850.txt

(although the comments in the cset say Dominik Brodowski did the cleanups?)

after enabling debugging in arch/i386/kernel/cpu/cpufreq/cpufreq-ich.c
(which required the attached patch), we have this (annotated) dmesg output:

Machine check exception polling timer started.
  OK, so we know approx where in boot we are now..
speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 0x10300410 0x0
    from speedstep_get_freqs()

speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 0x10300410 0x0
cpufreq: read at pmbase 0x800 + 0x50 returned 0x0
cpufreq: writing 0x1 to pmbase 0x800 + 0x50
cpufreq: read at pmbase 0x800 + 0x50 returned 0x1
cpufreq: change to 0 MHz succeeded
   all this from first call from get_freqs() to set_state(SPEEDSTEP_LOW,0); 
   Does that 'to 0mz' give you warm-n-fuzzies? Not me....  freqs.new isn't initialized yet...

speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 0xc300410 0x0
   speedstep_get_freqs() checking that we actually went low

speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 0xc300410 0x0
cpufreq: read at pmbase 0x800 + 0x50 returned 0x1
cpufreq: writing 0x0 to pmbase 0x800 + 0x50
cpufreq: read at pmbase 0x800 + 0x50 returned 0x0
cpufreq: change to 1200 MHz succeeded
   set_state(SPEEDSTEP_HIGH,0);  and again we got the wrong value in
  the message.  We went *from* 1200 *to* 1600.

speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 0x10300410 0x0
speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 0x10300410 0x0
cpufreq: currently at high speed setting - 1600 MHz
   speedstep_cpu_init();
cpufreq: speed=1600000 low=1200000 high=1600000
  my debugging to make sure low/high were set right.  All is good at this point,
  and we return from speedstep_cpu_init().

speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 0x10300410 0x0
cpufreq: read at pmbase 0x800 + 0x50 returned 0x0
cpufreq: writing 0x0 to pmbase 0x800 + 0x50
  (remember - LOW is 1 and HIGH is 0 here)
cpufreq: read at pmbase 0x800 + 0x50 returned 0x0
cpufreq: change to 1200 MHz succeeded
  Umm.. No.  We went from 1.6G to 1.6G.

OK.. Who's the wise guy? ;)

Looks to me like cpufreq_add_device() calls cpufreq_set_policy(), which ends up
calling speedstep_set_state() with notify=1.  Rememer the missing warm-n-fuzzies?

      freqs.old = speedstep_get_processor_frequency(speedstep_processor);
        freqs.new = speedstep_freqs[SPEEDSTEP_LOW].frequency;
        freqs.cpu = 0; /* speedstep.c is UP only driver */
        
        if (notify)
                cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);

which ends up calling notify_transition() ends up calling adjust_jiffies(),
and things get pear-shaped ;)

If we're going from 1200 to 1600,  this Does The Wrong Thing because
adjust_jiffies will be passed old == new == 1200 and fail to actually change
the loops_per_jiffy because the tests are > and <.

More subtly evil, when cpu_set_policy() runs, we go from 1600 to 1600, and
notify_transition is called with bogus values.  So as a result,
adjust_jiffies() gets called with old=1600 new=1200, and we reset the jiffies
inappropriately. Meanwhile, similar evil happens in time_cpufreq_notifier(),
where cpu_khz will be incorrectly set to 1200.  So cat /proc/cpuinfo
says we're at 1.2G when we're really still at 1.6G.

End result?  Processor is running at 1.6G, /proc/cpuinfo *says* 1.2G, and
jiffies_per_loop is set for 1.2G.  We call mdelay(50) at 1.6G and enough loops
for 1.2G, and end up at 80%. So the 50ms is really 40ms, and i810 gets the wrong
clocking.

And there's this remaining nit in speedstep_set_state():
        if (state == (value & 0x1)) {
                dprintk (KERN_INFO "cpufreq: change to %u MHz succeeded\n", (freqs.new / 1000));
        } else {

Not initialized the first call, and even after will print the SPEEDSTEP_LOW number no matter what.

Oh, and the debugging patch:

--- arch/i386/kernel/cpu/cpufreq/speedstep-ich.c.dist	2003-06-29 10:34:17.949264614 -0400
+++ arch/i386/kernel/cpu/cpufreq/speedstep-ich.c	2003-06-29 10:36:34.833000667 -0400
@@ -295,7 +295,7 @@
 		return -EIO;
 
 	dprintk(KERN_INFO "cpufreq: currently at %s speed setting - %i MHz\n", 
-		(speed == speedstep_low_freq) ? "low" : "high",
+		(speed == speedstep_freqs[SPEEDSTEP_LOW].frequency) ? "low" : "high",
 		(speed / 1000));
 
 	/* cpuinfo and default policy values */



--==_Exmh_-1576057118P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+/yuqcC3lWbTT17ARAvOjAKDFpt9Ur8LpLi5MN33lG0tkTpJlZwCg/U9P
gDkP5wRspoZeMrxpkZZx5YI=
=sqRG
-----END PGP SIGNATURE-----

--==_Exmh_-1576057118P--
