Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318789AbSH1LqD>; Wed, 28 Aug 2002 07:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318793AbSH1LqD>; Wed, 28 Aug 2002 07:46:03 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:55941 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S318789AbSH1Lpu>; Wed, 28 Aug 2002 07:45:50 -0400
Date: Wed, 28 Aug 2002 13:47:15 +0200
From: Dominik Brodowski <devel@brodo.de>
To: torvalds@transmeta.com
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.32] CPUfreq Documentation (4/4)
Message-ID: <20020828134715.E19189@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

CPUFreq documentation for 2.5.32:
CREDITS			one further CREDIT entry
Documentation/cpufreq	documentation of CPU frequency and voltage scaling=20
	support in the Linux kernel.
MAINTAINERS		one further MAINTAINERS entry
arch/i386/Config.help	Config.help texts for i386 CPUFreq drivers


diff -ruN linux-2531orig/CREDITS linux/CREDITS
--- linux-2531orig/CREDITS	Wed Aug 28 09:59:52 2002
+++ linux/CREDITS	Wed Aug 28 12:36:40 2002
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
diff -ruN linux-2531orig/Documentation/cpufreq linux/Documentation/cpufreq
--- linux-2531orig/Documentation/cpufreq	Thu Jan  1 01:00:00 1970
+++ linux/Documentation/cpufreq	Wed Aug 28 12:38:09 2002
@@ -0,0 +1,325 @@
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
+2.1   Sample script for command line interface
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
+Some architectures detect the lowest and highest possible speed
+settings, while others rely on user information on this. For the
+latter, a boot parameter is required. For the former, you can specify
+a boot parameter to set limits on the speed settings which may occur.=20
+The boot parameter has the following syntax:
+
+     cpufreq=3Dminspeed-maxspeed
+
+with both minspeed and maxspeed given in kHz. To set the lower
+limit to 59 MHz and the upper limit to 221 MHz, specify:
+
+      cpufreq=3D59000-221000
+
+Check the "Speed Limits Detection" information below on whether
+the driver detects the lowest and highest allowed speed setting
+automatically.
+
+
+ARM:
+    ARM Integrator, SA 1100, SA1110
+--------------------------------
+    Speed Limits Detection: On Integrators, the minimum speed is set
+    and the maximum speed has to be specified using the boot
+    parameter. On SA11x0s, the frequencies are fixed (59 - 287 MHz)
+
+
+AMD Elan:
+    SC400, SC410
+--------------------------------
+    Speed Limits Detection: Not implemented. You need to specify the
+    minimum and maximum frequency in the boot parameter (see above).
+
+
+VIA Cyrix Longhaul:
+    VIA Samuel/CyrixIII, VIA Cyrix Samuel/C3,=20
+    VIA Cyrix Ezra, VIA Cyrix Ezra-T
+--------------------------------
+    Speed Limits Detection: working. No need for boot parameters.
+
+
+Intel SpeedStep:
+    certain mobile Intel Pentium III (Coppermine), and all mobile
+    Intel Pentium III-M (Tualatin) and mobile Intel Pentium 4 P4-Ms.
+--------------------------------
+    Speed Limits Detection: working. No need for boot parameters.
+
+
+PowerNow! K6:
+    mobile AMD K6-2+ / K6-3+:
+--------------------------------
+    Speed Limits Detection: working. No need for boot parameters.
+    =20
+
+
+
+2. User Interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+CPUFreq uses a "sysctl" interface which is located in=20
+	/proc/sys/cpu/0/
+	/proc/sys/cpu/1/ ...	(SMP only)
+
+In these directories, you will find four files of importance for
+CPUFreq: speed-max, speed-min, speed-sync and speed:=20
+
+speed		    shows the current CPU frequency in kHz,=20
+speed-min	    the minimum supported CPU frequency, and
+speed-max	    the maximum supported CPU frequency.
+speed-sync	    is one if all CPUs need to run on the same clock
+			frequency, else zero.
+
+Please note that you might have to specify the speed limits as a boot
+parameter depending on the architecture (see above).
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
+2.1   Sample script for command line interface
+**********************************************
+
+
+Michael Ossmann <mike@ossmann.com> has written a small command line
+interface for the infinitely lazy.
+
+#!/bin/bash
+#
+# /usr/local/bin/freq
+#   simple command line interface to cpufreq
+
+[ -n "$1" ] && case "$1" in
+  "min" )
+    # set frequency to minimum
+    cat /proc/sys/cpu/0/speed-min >/proc/sys/cpu/0/speed
+    ;;
+  "max" )
+    # set frequency to maximum
+    cat /proc/sys/cpu/0/speed-max >/proc/sys/cpu/0/speed
+    ;;
+  * )
+    echo "Usage: $0 [min|max]"
+    echo "  min: set frequency to minimum and display new frequency"
+    echo "  max: set frequency to maximum and display new frequency"
+    echo "  no options: display current frequency"
+    exit 1
+    ;;
+esac
+
+# display current frequency
+cat /proc/sys/cpu/0/speed
+exit 0
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
+architecture drivers (those pieces of code that do the actual
+frequency transition), as well as to "notifiers". These are device
+drivers or other part of the kernel that need to be informed of
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
+The second argument to a CPUFreq notifier is the phase of the
+transition.=20
+
+The third argument, a void *pointer, points to a struct cpufreq_freqs
+consisting of five values: cpu, min, max, cur and new.  min and max=20
+are the minimum and maximum frequency rates that the device can=20
+tolerate. cur is the current/old speed.  new is the new speed, but=20
+might only be valid during the CPUFREQ_PRECHANGE or=20
+CPUFREQ_POSTCHANGE phases. And cpu is either the number of the=20
+affected CPU or CPUFREQ_ALL_CPUS when all CPUs are affected.
+
+Each CPUFreq notifier is called three times for a speed transition :
+
+    1. In preparation for a speed transition the kernel calls the
+    notifier with a phase of CPUFREQ_MINMAX in order to determine a
+    valid new frequency.  At this point the notifier updates the min
+    and max values to the limits the protected device / kernel code
+    needs.  Please note: Never update these values directly, use
+    cpufreq_updateminmax() instead.
+
+    2. Right before the transition the notifier is called with a phase
+    of CPUFREQ_PRECHANGE.=20
+
+    3. Right after the transition the notifier is called with a phase
+    of CPUFREQ_POSTCHANGE.
+
+For the CPUFREQ_PRECHANGE and CPUFREQ_POSTCHANGE phases the notifier
+updates all internal (e.g. device driver) states which depend on the
+CPU frequency.
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
+
+cpufreq_register()
+------------------
+cpufreq_register registers an arch driver to the CPUFreq core. Please
+note that only one arch driver may be registered at any time. -EBUSY
+is returned when an arch driver is already registered. The argument to
+cpufreq_register, struct cpufreq_driver *driver, is described later.
+
+
+cpufreq_unregister()
+--------------------
+cpufreq_unregister unregisters an arch driver, e.g. on module
+unloading. Please note that there is no check done that this is called
+from the driver which actually registered itself to the core, so
+please only call this function when you are sure the arch driver got
+registered correctly before.
+
+
+struct cpufreq_driver
+----------------
+On initialization, the arch driver is supposed to pass a pointer
+to a struct cpufreq_driver *cpufreq_driver consistng of the following
+entries:
+
+cpufreq_verify_t validate: This is a pointer to a function with the
+following definition:=20
+     unsigned int validating_function (unsigned int cpu,
+				       unsigned int kHz).=20
+It is called right before a transition occurs. The proposed new
+speed setting is passed as an argument in kHz; the validating code
+should verify this is a valid speed setting which is currently
+supported by the CPU. It shall return the closest valid CPU frequency
+in kHz.
+
+cpufreq_setspeed_t setspeed: This is a pointer to a function with the
+following definition:=20
+     void setspeed_function (unsigned int cpu, unsigned int kHz).=20
+This function shall perform the transition to the new CPU frequency=20
+given as argument in kHz. Note that this argument is exactly the same
+as the one returned by cpufreq_verify_t validate.
+
+unsigned int snyc: one if all CPUs need to run on the same core frequency
+all the time, or zero if asynchronous frequencies are possible.=20
+
+struct cpufreq_freqs *freq: if (sync=3D=3D1) this must point to one struct
+cpufreq_freqs, if (sync=3D=3D0) it must point to an array of NR_CPUS struct
+cpufreq_freqs. Each struct cpufreq_freq consists of the following entries:
+
+unsigned int freq->cur: The current CPU core frequency. Note that this
+is a requirement while the next two entries are optional.
+
+unsigned int freq->min (optional): The minimum CPU core frequency this
+CPU supports. This value may be limited further by the
+cpufreq_verify_t validate function, and so this value should be the
+minimum core frequency allowed "theoretically" on this system in this
+configuration.
+
+
+unsigned int freq->max (optional): The maximum CPU core frequency this
+CPU supports. This value may be limited further by the
+cpufreq_verify_t validate function, and so this value should be the
+maximum core frequency allowed "theoretically" on this system in this
+configuration.
+
+
+Some Requirements to CPUFreq architecture drivers
+-------------------------------------------------
+* Only call cpufreq_register() when the ability to switch CPU
+  frequencies is _verified_ or can't be missing
+* cpufreq_unregister() may only be called if cpufreq_register() has
+  been successfully(!) called before.
+* kfree() the struct cpufreq_driver only after the call to=20
+  cpufreq_unregister(), except cpufreq_register() failed.
+* Be aware that there is currently no error management in the
+  setspeed() code in the CPUFreq core. So only call yourself a
+  cpufreq_driver if you are really a working cpufreq_driver!
+
+
+
+4.  Mailing list and Links
+**************************
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
diff -ruN linux-2531orig/MAINTAINERS linux/MAINTAINERS
--- linux-2531orig/MAINTAINERS	Wed Aug 28 10:05:59 2002
+++ linux/MAINTAINERS	Wed Aug 28 12:37:17 2002
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
diff -ruN linux-2531orig/arch/i386/Config.help linux/arch/i386/Config.help
--- linux-2531orig/arch/i386/Config.help	Wed Aug 28 09:59:54 2002
+++ linux/arch/i386/Config.help	Wed Aug 28 12:39:28 2002
@@ -830,6 +830,54 @@
 CONFIG_X86_MCE_P4THERMAL
   Enabling this feature will cause a message to be printed when the P4
   enters thermal throttling.
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
 				=20
 CONFIG_TOSHIBA
   This adds a driver to safely access the System Management Mode of

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9bLhCZ8MDCHJbN8YRAnbOAJ9Ho7RmhLLD0LYK5tgB8EQuGlHu9wCeJy88
kO+2FJLah1BduuZSjy+zqHc=
=C1tZ
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
