Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263946AbSIQJhy>; Tue, 17 Sep 2002 05:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263951AbSIQJhy>; Tue, 17 Sep 2002 05:37:54 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:49906 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263946AbSIQJhw>; Tue, 17 Sep 2002 05:37:52 -0400
Date: Tue, 17 Sep 2002 11:30:47 +0200
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: hpa@transmeta.com, linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH][2.5.35] CPU frequency and voltage scaling (0/5)
Message-ID: <20020917113047.C25385@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus, hpa, lkml,

The following patches add CPU frequency and volatage scaling
support (Intel SpeedStep, AMD PowerNow, etc.) to kernel 2.5.35.

As was discussed last time, the cpufreq patches have been reworked to use a
policy-based approach now. A cpufreq policy consists of four values:
cpu	-	the affected CPU nr., or CPUFREQ_ALL_CPUS for all cpus
min	-	minimum frequency in kHz
max	-	maximum frequency in kHz
policy	-	CPUFREQ_POLICY_PERFORMANCE or CPUFREQ_POLICY_POWERSAVE

The interface to userspace is /proc/cpufreq, and the user can "echo" a new
policy into this file using the following syntax:
[cpu:]min_freq:max_freq:policy		or
[cpu%]min_pctg%max_pctg%policy

with policy either "powersave" or "performance". The cpu argument is
optional.=20

In cpufreq drivers for "dumb" hardware which can only be set to a specific
frequency (and not to a frequency range), one value within the policy range
is selected, and the CPU is statically set to this frequency until a new
policy is set. "Virtual" dynamic frequency changing is not yet implemented.

For more information, take a look at the file Documentation/cpufreq in=20
patch 4/5.


Patch 1/5: cpufreq-core
-----------------------
The cpufreq core offers a common interface to the CPU clock=20
speed features of ARM, PPC and x86 CPUs. =20

In order for this code to be built, an architecture must define the
CONFIG_CPU_FREQ configuration symbol.  The i386 code follows in
parts 2 and 3, the ARM and PPC ports will most likely follow in the=20
next days or weeks.

Specifically on ARM CPUs, cpufreq_notify_transition is especially=20
important, since various ARM system on a chip implementations=20
derive peripheral clocks from the CPU clock (eg, LCD controllers,=20
SDRAM controllers, etc). The core allows these peripherals to take=20
action either prior and/or after the actual CPU clock adjustment so=20
we don't go out of tolerance. Please note that CPUFREQ_TRANSITION_NOTIFIERS
are only called on "dumb" cpufreq hardware. On Transmeta Crusoe processors,
where core frequency changes have no external implications, these can safely
be ignored.


Patch 2/5: cpufreq-i386-core
----------------------------
The main part of this patch is a CPUFreq transition notifier in=20
arch/i386/kernel/time.c. It updates the i386-specific cpu_khz,=20
cpu_data[].loops_per_jiffy and fast_gettimeoffset_quotient on=20
each frequency change.

Additionally, this patch allows "cpu_khz" to be exported (it is needed=20
for some cpufreq drivers) and adds transmeta-related MSR #defines to=20
asm-i386/msr.h


Patch 3/5: cpufreq-i386-drivers
-------------------------------
Six i386 CPUFreq drivers are ready to be merged this time. These are:
elanfreq.c:	  The AMD Elan CPU family offers extensive clock scaling
longhaul.c:	  VIA Longhaul processor clock + voltage scaling
longrun.c:        Transmeta Crusoe Longrun clock + voltage scaling
p4-clockmod.c:    clock modulation on P4 Xeon processors
powernow-k6.c:	  mobile AMD K6-2+ / mobile AMD K6-3+ clock scaling
speedstep.c:	  clock and voltage scaling on mobile Intel Pentium 3 and 4s,
		  but (unfortunately) only on ICH2-M or ICH3-M based
                  chipsets.

Support for mobile AMD K7 processors is still in development.


Patch 4/5: cpufreq-doc
----------------------
an entry to the CREDITS and the MAINTAINERS files, Config.help texts, and
extensive documentation in linux/Documentation/cpufreq


Patch 5/5: cpufreq-core-24api
-----------------------------
Some user-space tools already rely on the "old", one-frequency
/proc/sys/cpu/ interface suggested previously. This add-on patch allows a
CONFIG option which emulates this interface but still uses the policy
interface towards the cpufreq drivers.
Please note that the other patches do not rely on this patch and work fine=
=20
without this patch applied, but only with the /proc/cpufreq interface.


Comments welcome; however please ensure that the cpufreq development
list at cpufreq@www.linux.org.uk receives a copy of all comments.

	Dominik

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9hvZFZ8MDCHJbN8YRAiaoAKCEXVh57/ttOaTYcVjzJSymNja2awCgn4LV
Z2+q09lfAhWirdpD7zWP/G0=
=crV/
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
