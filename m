Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263988AbSIQJla>; Tue, 17 Sep 2002 05:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264002AbSIQJl3>; Tue, 17 Sep 2002 05:41:29 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:1269 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263988AbSIQJjt>; Tue, 17 Sep 2002 05:39:49 -0400
Date: Tue, 17 Sep 2002 11:35:47 +0200
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: hpa@transmeta.com, linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH][2.5.35] CPUfreq documentation (4/5)
Message-ID: <20020917113547.H25385@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7J16OGEJ/mt06A90"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7J16OGEJ/mt06A90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

CPUFreq documentation for 2.5.35:
CREDITS			one further CREDIT entry
Documentation/cpufreq	documentation of CPU frequency and voltage scaling=20
	support in the Linux kernel.
MAINTAINERS		one further MAINTAINERS entry
arch/i386/Config.help	Config.help texts for i386 CPUFreq drivers

diff -ruN linux-2535original/CREDITS linux/CREDITS
--- linux-2535original/CREDITS	Tue Sep 17 09:24:51 2002
+++ linux/CREDITS	Tue Sep 17 09:38:05 2002
@@ -438,6 +438,13 @@
 S: 411 13  Goteborg
 S: Sweden
=20
+N: Dominik Brodowski
+E: devel@brodo.de
+W: http://www.brodo.de/
+P: 1024D/725B37C6  190F 3E77 9C89 3B6D BECD  46EE 67C3 0308 725B 37C6
+D: parts of CPUFreq code, ACPI bugfixes
+S: Tuebingen, Germany
+
 N: Andries Brouwer
 E: aeb@cwi.nl
 D: random Linux hacker
diff -ruN linux-2535original/Documentation/cpufreq linux/Documentation/cpuf=
req
--- linux-2535original/Documentation/cpufreq	Thu Jan  1 01:00:00 1970
+++ linux/Documentation/cpufreq	Tue Sep 17 09:41:16 2002
@@ -0,0 +1,362 @@
+     CPU frequency and voltage scaling code in the Linux(TM) kernel
+
+
+		         L i n u x    C P U F r e q
+
+
+
+
+		    Dominik Brodowski  <devel@brodo.de>
+		     David Kimdon <dwhedon@debian.org>
+
+
+
+   Clock scaling allows you to change the clock speed of the CPUs on the
+    fly. This is a nice method to save battery power, because the lower
+            the clock speed, the less power the CPU consumes.
+
+
+
+Contents:
+---------
+1.  Supported architectures
+2.  User interface
+2.1   /proc/cpufreq interface  [2.6]
+2.2.  /proc/sys/cpu/ interface [2.4]
+3.  CPUFreq core and interfaces
+3.1   General information
+3.2   CPUFreq notifiers
+3.3   CPUFreq architecture drivers
+4.  Mailing list and Links
+
+
+
+1. Supported architectures
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+
+ARM:
+    ARM Integrator, SA 1100, SA1110
+--------------------------------
+    This driver will be ported to new CPUFreq core soon, so
+    far it will not work.
+
+
+AMD Elan:
+    SC400, SC410
+--------------------------------
+    You need to specify the highest allowed CPU frequency as=20
+    a module parameter ("max_freq") or as boot parameter=20
+    ("elanfreq=3D"). Else the available speed range will be=20
+    limited to the speed at which the CPU runs while this
+    module is loaded.
+
+
+VIA Cyrix Longhaul:
+    VIA Samuel/CyrixIII, VIA Cyrix Samuel/C3,=20
+    VIA Cyrix Ezra, VIA Cyrix Ezra-T
+--------------------------------
+    If you do not want to scale the Front Side Bus or voltage,
+    pass the module parameter "dont_scale_fsb 1" or
+    "dont_scale_voltage 1". Additionally, it is advised that
+    you pass the current Front Side Bus speed (in MHz) to=20
+    this module as module parameter "current_fsb", e.g.=20
+    "current_fsb 133" for a Front Side Bus speed of 133 MHz.
+
+
+Intel SpeedStep:
+    certain mobile Intel Pentium III (Coppermine), and all mobile
+    Intel Pentium III-M (Tualatin) and mobile Intel Pentium 4 P4-Ms.
+--------------------------------
+    Unfortunately only modern Intel ICH2-M and ICH3-M chipsets are=20
+    supported.
+
+
+P4 CPU Clock Modulation:
+    Intel Pentium 4 Xeon processors
+---------------------------------
+    Note that you can only switch the speed of two logical CPUs at
+    once - but each phyiscal CPU may have different throttling levels.
+    Unfortunately, the cpu_khz value=20
+
+
+PowerNow! K6:
+    mobile AMD K6-2+ / mobile K6-3+:
+--------------------------------
+    No known issues.
+
+
+Transmeta Crusoe Longrun:
+    Transmeta Crusoe processors:
+--------------------------------
+    Does not work with the 2.4. /proc/sys/cpu/ interface.
+
+
+
+2. User Interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+2.1   /proc/cpufreq interface [2.6]
+***********************************
+
+Starting in the patches for kernel 2.5.33, CPUFreq uses a "policy"
+interface /proc/cpufreq.
+
+When you "cat" this file, you'll find something like:
+
+--
+          minimum CPU frequency  -  maximum CPU frequency  -  policy
+CPU  0       1200000 ( 75%)      -     1600000 (100%)      -  performance
+--
+
+This means the current policy allows this CPU to be run anywhere
+between 1.2 GHz (the value is in kHz) and 1.6 GHz with an eye towards
+performance.
+
+To change the policy, "echo" the desired new policy into
+/proc/cpufreq. Use one of the following formats:
+
+cpu_nr:min_freq:max_freq:policy
+cpu_nr%min_freq%max_freq%policy
+min_freq:max_freq:policy
+
+with cpu_nr being the CPU which shall be affected, min_freq and
+max_freq the lower and upper limit of the CPU core frequency in kHz,
+and policy either "performance" or "powersave".
+A few examples:
+
+root@notebook:#echo -n "0:0:0:powersave" > /proc/cpufreq
+     sets the CPU #0 to the lowest supported frequency.
+
+root@notebook:#echo -n "1%100%100%performance" > /proc/cpufreq
+     sets the CPU #1 to the highest supported frequency.
+
+root@notebook:#echo -n "1000000:2000000:performance" > /proc/cpufreq
+     to set the frequency of all CPUs between 1 GHz and 2 GHz and to
+     the policy "performance".
+
+Please note that the values you "echo" into /proc/cpufreq are
+validated first, and may be limited by hardware or thermal
+considerations. Because of this, a read from /proc/cpufreq might=20
+differ from what was written into it.
+
+
+When you read /proc/cpufreq for the first time after a CPUFreq driver
+has been initialized, you'll see the "default policy" for this
+driver. If this does not suit your needs, you can pass a boot
+parameter to the cpufreq core. Use the following synatx for this:
+   "cpufreq=3Dmin_freq:max_freq:policy", i.e. you may not chose a
+   specific CPU and you need to specify the limits in kHz and not in
+   per cent.
+
+
+2.2   /proc/cpufreq interface [2.4]
+***********************************
+
+Previsiously (and still available as a config option), CPUFreq used=20
+a "sysctl" interface which is located in=20
+	/proc/sys/cpu/0/
+	/proc/sys/cpu/1/ ...	(SMP only)
+
+In these directories, you will find three files of importance for
+CPUFreq: speed-max, speed-min and speed:=20
+
+speed		    shows the current CPU frequency in kHz,=20
+speed-min	    the minimum supported CPU frequency, and
+speed-max	    the maximum supported CPU frequency.
+
+
+To change the CPU frequency, "echo" the desired CPU frequency (in kHz)
+to speed. For example, to set the CPU speed to the lowest/highest
+allowed frequency do:
+
+root@notebook:# cat /proc/sys/cpu/0/speed-min > /proc/sys/cpu/0/speed
+root@notebook:# cat /proc/sys/cpu/0/speed-max > /proc/sys/cpu/0/speed
+
+
+
+3.  CPUFreq core and interfaces
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+
+3.1   General information
+*************************
+
+The CPUFreq core code is located in linux/kernel/cpufreq.c. This
+cpufreq code offers a standardized interface for the CPUFreq
+architecture drivers (those pieces of code that do actual
+frequency transitions), as well as to "notifiers". These are device
+drivers or other part of the kernel that need to be informed of
+policy changes (like thermal modules like ACPI) or of all
+frequency changes (like timing code) or even need to force certain
+speed limits (like LCD drivers on ARM architecture). Additionally, the
+kernel "constant" loops_per_jiffy is updated on frequency changes
+here.
+
+
+3.2   CPUFreq notifiers
+***********************
+
+CPUFreq notifiers conform to the standard kernel notifier interface.
+See linux/include/linux/notifier.h for details on notifiers.
+
+There are two different CPUFreq notifiers - policy notifiers and
+transition notifiers.
+
+
+3.2.1 CPUFreq policy notifiers
+******************************
+
+These are notified when a new policy is intended to be set. Each
+CPUFreq policy notifier is called three times for a policy transition:
+
+1.) During CPUFREQ_ADJUST all CPUFreq notifiers may change the limit if
+    they see a need for this - may it be thermal considerations or
+    hardware limitations.
+
+2.) During CPUFREQ_INCOMPATIBLE only changes may be done in order to avoid
+    hardware failure.
+
+3.) And during CPUFREQ_NOTIFY all notifiers are informed of the new policy
+   - if two hardware drivers failed to agree on a new policy before this
+   stage, the incompatible hardware shall be shut down, and the user
+   informed of this.
+
+The phase is specified in the second argument to the notifier.
+
+The third argument, a void *pointer, points to a struct cpufreq_freqs
+consisting of five values: cpu, min, max, policy and max_cpu_freq. Min=20
+and max are the lower and upper frequencies (in kHz) of the new
+policy, policy the new policy, cpu the number of the affected CPU or
+CPUFREQ_ALL_CPUS for all CPUs; and max_cpu_freq the maximum supported
+CPU frequency. This value is given for informational purposes only.
+
+
+3.2.2 CPUFreq transition notifiers
+**********************************
+
+These are notified twice when the CPUfreq driver switches the CPU core
+frequency and this change has any external implications.
+
+The second argument specifies the phase - CPUFREQ_PRECHANGE or
+CPUFREQ_POSTCHANGE.
+
+The third argument is a struct cpufreq_freqs with the following
+values:
+cpu	- number of the affected CPU or CPUFREQ_ALL_CPUS
+old	- old frequency
+new	- new frequency
+
+
+3.3   CPUFreq architecture drivers
+**********************************
+
+CPUFreq architecture drivers are the pieces of kernel code that
+actually perform CPU frequency transitions. These need to be
+initialized separately (separate initcalls), and may be
+modularized. They interact with the CPUFreq core in the following way:
+
+cpufreq_register()
+------------------
+cpufreq_register registers an arch driver to the CPUFreq core. Please
+note that only one arch driver may be registered at any time. -EBUSY
+is returned when an arch driver is already registered. The argument to
+cpufreq_register, struct cpufreq_driver *driver, is described later.
+
+cpufreq_unregister()
+--------------------
+cpufreq_unregister unregisters an arch driver, e.g. on module
+unloading. Please note that there is no check done that this is called
+from the driver which actually registered itself to the core, so
+please only call this function when you are sure the arch driver got
+registered correctly before.
+
+cpufreq_notify_transition()
+---------------------------
+On "dumb" hardware where only fixed frequency can be set, the driver
+must call cpufreq_notify_transition() once before, and once after the
+actual transition.
+
+struct cpufreq_driver
+---------------------
+On initialization, the arch driver is supposed to pass a pointer
+to a struct cpufreq_driver *cpufreq_driver consisting of the following
+entries:
+
+cpufreq_verify_t verify: This is a pointer to a function with the
+	following definition:
+	void verify_function (struct cpufreq_policy *policy).
+	This function must verify the new policy is within the limits
+	supported by the CPU, and at least one supported CPU is within
+	this range. It may be useful to use cpufreq.h /
+	cpufreq_verify_within_limits for this.
+
+cpufreq_setpolicy_t setpolicy: This is a pointer to a function with
+	the following definition:
+	void setpolicy_function (struct cpufreq_policy *policy).
+	This function must set the CPU to the new policy. If it is a
+	"dumb" CPU which only allows fixed frequencies to be set, it
+	shall set it to the lowest within the limit for
+	CPUFREQ_POLICY_POWERSAVE, and to the highest for
+	CPUFREQ_POLICY_PERFORMANCE. Once CONFIG_CPU_FREQ_DYNAMIC is
+	implemented, it can use a dynamic method to adjust the speed
+	between the lower and upper limit.
+
+struct cpufreq_policy   *policy: This is an array of NR_CPUS struct
+       cpufreq_policies, containing the current policies set for these
+       CPUs. Note that policy[0].max_cpu_freq must contain the
+       absolute maximum CPU frequency supported by _all_ CPUs.
+
+In case the driver is expected to run with the 2.4.-style API
+(/proc/sys/cpu/.../), two more values must be passed
+#ifdef CONFIG_CPU_FREQ_24_API
+	unsigned int            cpu_min_freq;
+	unsigned int            cpu_cur_freq[NR_CPUS];
+#endif
+	with cpu_min_freq being the minimum CPU frequency supported by
+	the CPUs; and the entries in cpu_cur_freq reflecting the
+	current speed of the appropriate CPU.
+=09
+
+Some Requirements to CPUFreq architecture drivers
+-------------------------------------------------
+* Only call cpufreq_register() when the ability to switch CPU
+  frequencies is _verified_ or can't be missing
+* cpufreq_unregister() may only be called if cpufreq_register() has
+  been successfully(!) called before.
+* kfree() the struct cpufreq_driver only after the call to=20
+  cpufreq_unregister(), unless cpufreq_register() failed.
+* Be aware that there is currently no error management in the
+  setpolicy() code in the CPUFreq core. So only call yourself a
+  cpufreq_driver if you are really a working cpufreq_driver!
+
+
+
+4. Mailing list and Links
+*************************
+
+
+Mailing List
+------------
+There is a CPU frequency changing CVS commit and general list where
+you can report bugs, problems or submit patches. To post a message,
+send an email to cpufreq@www.linux.org.uk, to subscribe go to
+http://www.linux.org.uk/mailman/listinfo/cpufreq. Previous post to the
+mailing list are available to subscribers at
+http://www.linux.org.uk/mailman/private/cpufreq/.
+
+
+Links
+-----
+the FTP archives:
+* ftp://ftp.linux.org.uk/pub/linux/cpufreq/
+
+how to access the CVS repository:
+* http://cvs.arm.linux.org.uk/
+
+the CPUFreq Mailing list:
+* http://www.linux.org.uk/mailman/listinfo/cpufreq
+
+Clock and voltage scaling for the SA-1100:
+* http://www.lart.tudelft.nl/projects/scaling
+
+CPUFreq project homepage
+* http://www.brodo.de/cpufreq/
diff -ruN linux-2535original/MAINTAINERS linux/MAINTAINERS
--- linux-2535original/MAINTAINERS	Tue Sep 17 09:22:42 2002
+++ linux/MAINTAINERS	Tue Sep 17 09:38:36 2002
@@ -364,6 +364,11 @@
 W:	http://www.fi.muni.cz/~kas/cosa/
 S:	Maintained
=20
+CPU FREQUENCY DRIVERS
+L:      cpufreq@www.linux.org.uk
+W:      http://www.brodo.de/cpufreq/
+S:      Maintained
+
 CPUID/MSR DRIVER
 P:	H. Peter Anvin
 M:	hpa@zytor.com
diff -ruN linux-2535original/arch/i386/Config.help linux/arch/i386/Config.h=
elp
--- linux-2535original/arch/i386/Config.help	Tue Sep 17 09:25:17 2002
+++ linux/arch/i386/Config.help	Tue Sep 17 10:02:21 2002
@@ -839,7 +839,75 @@
 CONFIG_X86_MCE_P4THERMAL
   Enabling this feature will cause a message to be printed when the P4
   enters thermal throttling.
-				=20
+
+CONFIG_CPU_FREQ
+  Clock scaling allows you to change the clock speed of CPUs on the
+  fly. This is a nice method to save battery power on notebooks,
+  because the lower the clock speed, the less power the CPU consumes.
+
+  For more information, take a look at linux/Documentation/cpufreq or
+  at <http://www.brodo.de/cpufreq/>
+
+  If in doubt, say N.
+
+CONFIG_X86_POWERNOW_K6
+  This adds the CPUFreq driver for mobile AMD K6-2+ and mobile
+  AMD K6-3+ processors.
+
+  For details, take a look at linux/Documentation/cpufreq.=20
+
+  If in doubt, say N.
+
+CONFIG_X86_P4_CLOCKMOD
+  This adds the CPUFreq driver for Intel Pentium 4 / XEON
+  processors.
+
+  You need to specify the processor minimum and maximum speed as=20
+  boot parameter: cpufreq=3Dminspeed-maxspeed , with both arguments
+  given in kHz.=20
+
+  For details, take a look at linux/Documentation/cpufreq.=20
+
+  If in doubt, say N.
+
+CONFIG_ELAN_CPUFREQ
+  This adds the CPUFreq driver for AMD Elan SC400 and SC410
+  processors.
+
+  You need to specify the processor minimum and maximum speed as=20
+  boot parameter: cpufreq=3Dminspeed-maxspeed , with both arguments
+  given in kHz.=20
+
+  For details, take a look at linux/Documentation/cpufreq.=20
+
+  If in doubt, say N.
+
+CONFIG_X86_LONGHAUL
+  This adds the CPUFreq driver for VIA Samuel/CyrixIII,=20
+  VIA Cyrix Samuel/C3, VIA Cyrix Ezra and VIA Cyrix Ezra-T=20
+  processors.
+
+  For details, take a look at linux/Documentation/cpufreq.=20
+
+  If in doubt, say N.
+
+CONFIG_X86_SPEEDSTEP
+  This adds the CPUFreq driver for certain mobile Intel Pentium III
+  (Coppermine), all mobile Intel Pentium III-M (Tulatin) and all
+  mobile Intel Pentium 4 P4-Ms.
+
+  For details, take a look at linux/Documentation/cpufreq.=20
+
+  If in doubt, say N.
+
+CONFIG_X86_LONGRUN
+  This adds the CPUFreq driver for Transmeta Crusoe processors which
+  support LongRun.
+
+  For details, take a look at linux/Documentation/cpufreq.=20
+
+  If in doubt, say N.
+
 CONFIG_TOSHIBA
   This adds a driver to safely access the System Management Mode of
   the CPU on Toshiba portables with a genuine Toshiba BIOS. It does



--7J16OGEJ/mt06A90
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9hvdyZ8MDCHJbN8YRAjG0AJ4lUew7BuQsdOqSBo1ZlzR93YF10QCcD2Dy
JZKf9/2+UqRrAPrQYBXdUAE=
=6NoO
-----END PGP SIGNATURE-----

--7J16OGEJ/mt06A90--
