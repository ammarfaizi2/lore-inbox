Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270494AbTGSEbS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 00:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270495AbTGSEbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 00:31:18 -0400
Received: from h80ad2569.async.vt.edu ([128.173.37.105]:15746 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270494AbTGSEbN (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 00:31:13 -0400
Message-Id: <200307190446.h6J4k5bF004659@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Simon Boulet <simon.boulet@divahost.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1+ Alsa + Intel 82801CA/CAM AC'97 Audio OOPS 
In-Reply-To: Your message of "Fri, 18 Jul 2003 22:10:12 EDT."
             <20030719021012.GA919@i2650> 
From: Valdis.Kletnieks@vt.edu
References: <20030719021012.GA919@i2650>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-702582913P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Jul 2003 00:46:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-702582913P
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-7032364120"

This is a multipart MIME message.

--==_Exmh_-7032364120
Content-Type: text/plain; charset=us-ascii

On Fri, 18 Jul 2003 22:10:12 EDT, Simon Boulet <simon.boulet@divahost.net>  said:

> Also, the OSS (non-ALSA) Intel ICH (i8xx) loads correctly but the sound 
> output is  slow (rate or clocking problem?). My sound was fine under 
> 2.4.21.
> 

> i810_audio: only 48Khz playback available.

> i810_audio: setting clocking to 64937

I was having problems with i810_audio clocking as well.  It turned out to be
the Intel Speedstep support, of all things.  *IF* your kernel includes:

CONFIG_X86_SPEEDSTEP_ICH=y

it was possible to end up with a broken value for loops_per_jiffie.  I've
attached a patch that fixes the bug and does a few cleanups...

If you don't have the SpeedStep support in your kernel, then your
problem is elsewhere... Good luck... ;)

/Valdis

--==_Exmh_-7032364120
Content-Type: text/plain ; name="speedstep.patch2"; charset=us-ascii
Content-Description: speedstep.patch2
Content-Disposition: attachment; filename="speedstep.patch2"

--- arch/i386/kernel/cpu/cpufreq/speedstep-ich.c.linus	2003-07-03 23:31:43.000000000 -0400
+++ arch/i386/kernel/cpu/cpufreq/speedstep-ich.c	2003-07-04 09:57:07.981299808 -0400
@@ -77,15 +77,17 @@
 	u8			value;
 	unsigned long		flags;
 	struct cpufreq_freqs	freqs;
+	int			newfreq;
 
 	if (!speedstep_chipset_dev || (state > 0x1))
 		return;
 
 	freqs.old = speedstep_get_processor_frequency(speedstep_processor);
-	freqs.new = speedstep_freqs[SPEEDSTEP_LOW].frequency;
+	freqs.new = speedstep_freqs[state].frequency;
 	freqs.cpu = 0; /* speedstep.c is UP only driver */
 	
-	if (notify)
+	/* make sure we've initialized before calling notify */
+	if (notify && (freqs.new != 0))
 		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
 	/* get PMBASE */
@@ -136,13 +138,16 @@
 
 	dprintk(KERN_DEBUG "cpufreq: read at pmbase 0x%x + 0x50 returned 0x%x\n", pmbase, value);
 
+	/* freqs.new may not be set yet - need local copy */
+	newfreq = speedstep_get_processor_frequency(speedstep_processor);
 	if (state == (value & 0x1)) {
-		dprintk (KERN_INFO "cpufreq: change to %u MHz succeeded\n", (freqs.new / 1000));
+		dprintk (KERN_INFO "cpufreq: change to %u MHz succeeded\n", (newfreq / 1000));
 	} else {
 		printk (KERN_ERR "cpufreq: change failed - I/O error\n");
 	}
 
-	if (notify)
+	/* Make sure we're initialized before calling notify */
+	if (notify && (freqs.new != 0))
 		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 
 	return;
@@ -295,7 +300,7 @@
 		return -EIO;
 
 	dprintk(KERN_INFO "cpufreq: currently at %s speed setting - %i MHz\n", 
-		(speed == speedstep_low_freq) ? "low" : "high",
+		(speed == speedstep_freqs[SPEEDSTEP_LOW].frequency) ? "low" : "high",
 		(speed / 1000));
 
 	/* cpuinfo and default policy values */

--==_Exmh_-7032364120--


--==_Exmh_-702582913P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/GM0NcC3lWbTT17ARAloUAJ9TdVr8Cy+tpQa4lJjFVjmQLHZJPgCg8gmh
wuU6rOPT5XUvENoYaTURvrE=
=mlCU
-----END PGP SIGNATURE-----

--==_Exmh_-702582913P--
