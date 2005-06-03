Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVFCHe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVFCHe2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 03:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVFCHe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 03:34:28 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:49426 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261173AbVFCHeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 03:34:20 -0400
Message-ID: <42A006E8.9000601@tuxrocks.com>
Date: Fri, 03 Jun 2005 01:29:44 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
Subject: Re: [PATCH 1/4] new timeofday core subsystem (v. B1)
References: <1117667378.6801.80.camel@cog.beaverton.ibm.com>
In-Reply-To: <1117667378.6801.80.camel@cog.beaverton.ibm.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

john stultz wrote:
> Andrew, All,
> 	I'm just re-spinning this to resolve a conflict w/ the CPUFREQ changes
> Linus accepted last night.
<snip>

John,

I have found an issue with these TOD subsystem patches, and I
think it's only an issue on systems that use CPUFREQ.  Whenever
the frequency changes, at least some portions of the kernel
get confused about their notion of time.  Here are some
example entries from my syslog:

Jun  3 00:33:40 moebius kernel: [  145.023201] cpufreq-core: target for CPU 0: 800000 kHz, relation 0
Jun  3 00:33:47 moebius kernel: [  114.838909] cpufreq-core: target for CPU 0: 1000000 kHz, relation 0
Jun  3 00:33:47 moebius kernel: [  114.838977] freq-table: request for target 1000000 kHz (relation: 0) for cpu 0
Jun  3 00:33:47 moebius kernel: [   92.161872] codec_semaphore: semaphore is not ready [0x1][0x700300]
Jun  3 00:33:52 moebius kernel: [   97.433279] cpufreq-core: target for CPU 0: 1200000 kHz, relation 0
Jun  3 00:33:58 moebius kernel: [   66.352233] cpufreq-core: target for CPU 0: 1400000 kHz, relation 0
Jun  3 00:34:08 moebius kernel: [   85.547260] cpufreq-core: target for CPU 0: 1200000 kHz, relation 0
Jun  3 00:34:16 moebius kernel: [  211.791738] cpufreq-core: target for CPU 0: 800000 kHz, relation 0
Jun  3 00:34:27 moebius kernel: [  112.941898] cpufreq-core: target for CPU 0: 1000000 kHz, relation 0
Jun  3 00:34:31 moebius kernel: [  231.793121] cpufreq-core: target for CPU 0: 800000 kHz, relation 0
Jun  3 00:34:41 moebius kernel: [  147.122593] cpufreq-core: target for CPU 0: 1200000 kHz, relation 0
Jun  3 00:34:42 moebius kernel: [  123.906802] cpufreq-core: target for CPU 0: 1000000 kHz, relation 0
Jun  3 00:34:46 moebius kernel: [  251.342116] cpufreq-core: target for CPU 0: 800000 kHz, relation 0
Jun  3 00:34:51 moebius kernel: [  192.985214] cpufreq-core: target for CPU 0: 1000000 kHz, relation 0

The printk times are taken from sched_clock(), which now
varies depending on the cpu frequency.  Without these patches,
the printk times appear to consistently increase at the right rate.
I'm not sure what other portions of the kernel are affected by
this (watchdogs firing, or other issues?).

Thanks,

Frank
- -- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCoAboaI0dwg4A47wRAmWsAJsHJ3sYtUqXKqjnualA3JTOih9RwACeIulR
CCKYtqdZ/096knyiwZf6X44=
=SjAZ
-----END PGP SIGNATURE-----
