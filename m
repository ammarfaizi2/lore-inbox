Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263989AbSIQJmv>; Tue, 17 Sep 2002 05:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264002AbSIQJmD>; Tue, 17 Sep 2002 05:42:03 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:8949 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263989AbSIQJjy>; Tue, 17 Sep 2002 05:39:54 -0400
Date: Tue, 17 Sep 2002 11:37:06 +0200
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: hpa@transmeta.com, linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH][2.5.35] CPUfreq /proc/sys/ API emulation (5/5)
Message-ID: <20020917113706.J25385@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AXxEqdD4tcVTjWte"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AXxEqdD4tcVTjWte
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

CPUFreq 24-API add-on patch for 2.5.35:
kernel/cpufreq.c	cpufreq-24-API
include/linux/cpufreq.h	cpufreq-24-API
arch/i386/config.in	Transmeta LongRun does not work well with cpufreq-24-API
arch/i386/Config.help	help text for CONFIG_CPU_FREQ_24_API


diff -ruN linux-2535original/arch/i386/Config.help linux/arch/i386/Config.h=
elp
--- linux-2535original/arch/i386/Config.help	Tue Sep 17 10:35:43 2002
+++ linux/arch/i386/Config.help	Tue Sep 17 10:36:23 2002
@@ -850,6 +850,19 @@
=20
   If in doubt, say N.
=20
+CONFIG_CPU_FREQ_24_API
+  This enables the /proc/sys/cpu/ sysctl interface for controlling
+  CPUFreq, as known from the 2.4.-kernel patches for CPUFreq. Note
+  that some drivers do not support this interface or offer less
+  functionality.=20
+
+  If you say N here, you'll be able to control CPUFreq using the
+  new /proc/cpufreq interface.
+
+  For details, take a look at linux/Documentation/cpufreq.=20
+
+  If in doubt, say N.
+
 CONFIG_X86_POWERNOW_K6
   This adds the CPUFreq driver for mobile AMD K6-2+ and mobile
   AMD K6-3+ processors.
diff -ruN linux-2535original/arch/i386/config.in linux/arch/i386/config.in
--- linux-2535original/arch/i386/config.in	Tue Sep 17 10:35:43 2002
+++ linux/arch/i386/config.in	Tue Sep 17 10:36:16 2002
@@ -192,7 +192,10 @@
=20
 bool 'CPU Frequency scaling' CONFIG_CPU_FREQ
 if [ "$CONFIG_CPU_FREQ" =3D "y" ]; then
-   define_bool CONFIG_CPU_FREQ_26_API y
+   bool ' /proc/sys/cpu/ interface (2.4.)' CONFIG_CPU_FREQ_24_API
+   if [ "$CONFIG_CPU_FREQ_24_API" =3D "n" ]; then
+       define_bool CONFIG_CPU_FREQ_26_API y
+   fi
    tristate ' AMD Mobile K6-2/K6-3 PowerNow!' CONFIG_X86_POWERNOW_K6
    if [ "$CONFIG_MELAN" =3D "y" ]; then
        tristate ' AMD Elan' CONFIG_ELAN_CPUFREQ
@@ -200,7 +203,9 @@
    tristate ' VIA Cyrix III Longhaul' CONFIG_X86_LONGHAUL
    tristate ' Intel Speedstep' CONFIG_X86_SPEEDSTEP
    tristate ' Intel Pentium 4 clock modulation' CONFIG_X86_P4_CLOCKMOD
-   tristate ' Transmeta LongRun' CONFIG_X86_LONGRUN
+   if [ "$CONFIG_CPU_FREQ_24_API" =3D "n" ]; then
+       tristate ' Transmeta LongRun' CONFIG_X86_LONGRUN
+   fi
 fi
=20
 tristate 'Toshiba Laptop support' CONFIG_TOSHIBA
diff -ruN linux-2535original/include/linux/cpufreq.h linux/include/linux/cp=
ufreq.h
--- linux-2535original/include/linux/cpufreq.h	Tue Sep 17 10:35:43 2002
+++ linux/include/linux/cpufreq.h	Tue Sep 17 10:35:57 2002
@@ -155,4 +155,98 @@
 #endif
=20
=20
+#ifdef CONFIG_CPU_FREQ_24_API
+/*********************************************************************
+ *                        CPUFREQ 2.4. INTERFACE                     *
+ *********************************************************************/
+int cpufreq_setmax(unsigned int cpu);
+#ifdef CONFIG_PM
+int cpufreq_restore(void);
+#endif
+int cpufreq_set(unsigned int kHz, unsigned int cpu);
+unsigned int cpufreq_get(unsigned int cpu);
+
+/* /proc/sys/cpu */
+enum {
+	CPU_NR   =3D 1,           /* compatibilty reasons */
+	CPU_NR_0 =3D 1,
+	CPU_NR_1 =3D 2,
+	CPU_NR_2 =3D 3,
+	CPU_NR_3 =3D 4,
+	CPU_NR_4 =3D 5,
+	CPU_NR_5 =3D 6,
+	CPU_NR_6 =3D 7,
+	CPU_NR_7 =3D 8,
+	CPU_NR_8 =3D 9,
+	CPU_NR_9 =3D 10,
+	CPU_NR_10 =3D 11,
+	CPU_NR_11 =3D 12,
+	CPU_NR_12 =3D 13,
+	CPU_NR_13 =3D 14,
+	CPU_NR_14 =3D 15,
+	CPU_NR_15 =3D 16,
+	CPU_NR_16 =3D 17,
+	CPU_NR_17 =3D 18,
+	CPU_NR_18 =3D 19,
+	CPU_NR_19 =3D 20,
+	CPU_NR_20 =3D 21,
+	CPU_NR_21 =3D 22,
+	CPU_NR_22 =3D 23,
+	CPU_NR_23 =3D 24,
+	CPU_NR_24 =3D 25,
+	CPU_NR_25 =3D 26,
+	CPU_NR_26 =3D 27,
+	CPU_NR_27 =3D 28,
+	CPU_NR_28 =3D 29,
+	CPU_NR_29 =3D 30,
+	CPU_NR_30 =3D 31,
+	CPU_NR_31 =3D 32,
+};
+
+/* /proc/sys/cpu/{0,1,...,(NR_CPUS-1)} */
+enum {
+	CPU_NR_FREQ_MAX =3D 1,
+	CPU_NR_FREQ_MIN =3D 2,
+	CPU_NR_FREQ =3D 3,
+};
+
+#define CTL_CPU_VARS_SPEED_MAX { \
+                ctl_name: CPU_NR_FREQ_MAX, \
+                data: &cpu_max_freq, \
+                procname: "speed-max", \
+                maxlen:	sizeof(cpu_max_freq),\
+                mode: 0444, \
+                proc_handler: proc_dointvec, }
+
+#define CTL_CPU_VARS_SPEED_MIN { \
+                ctl_name: CPU_NR_FREQ_MIN, \
+                data: &cpu_min_freq, \
+                procname: "speed-min", \
+                maxlen:	sizeof(cpu_min_freq),\
+                mode: 0444, \
+                proc_handler: proc_dointvec, }
+
+#define CTL_CPU_VARS_SPEED(cpunr) { \
+                ctl_name: CPU_NR_FREQ, \
+                procname: "speed", \
+                mode: 0644, \
+                proc_handler: cpufreq_procctl, \
+                strategy: cpufreq_sysctl, \
+                extra1: (void*) (cpunr), }
+
+#define CTL_TABLE_CPU_VARS(cpunr) static ctl_table ctl_cpu_vars_##cpunr[] =
=3D {\
+                CTL_CPU_VARS_SPEED_MAX, \
+                CTL_CPU_VARS_SPEED_MIN, \
+                CTL_CPU_VARS_SPEED(cpunr),  \
+                { ctl_name: 0, }, }
+
+/* the ctl_table entry for each CPU */
+#define CPU_ENUM(s) { \
+                ctl_name: (CPU_NR + s), \
+                procname: #s, \
+                mode: 0555, \
+                child: ctl_cpu_vars_##s }
+
+#endif /* CONFIG_CPU_FREQ_24_API */
+
 #endif /* _LINUX_CPUFREQ_H */
diff -ruN linux-2535original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-2535original/kernel/cpufreq.c	Tue Sep 17 10:35:43 2002
+++ linux/kernel/cpufreq.c	Tue Sep 17 10:36:02 2002
@@ -28,6 +28,9 @@
 #include <linux/proc_fs.h>
 #endif
=20
+#ifdef CONFIG_CPU_FREQ_24_API
+#include <linux/sysctl.h>
+#endif
=20
=20
 /**
@@ -65,6 +68,16 @@
 };
=20
=20
+#ifdef CONFIG_CPU_FREQ_24_API
+/**
+ * A few values needed by the 2.4.-compatible API
+ */
+static unsigned int     cpu_max_freq;
+static unsigned int     cpu_min_freq;
+static unsigned int     cpu_cur_freq[NR_CPUS];
+#endif
+
+
=20
 /*********************************************************************
  *                              2.6. API                             *
@@ -327,6 +340,389 @@
=20
=20
 /*********************************************************************
+ *                        2.4. COMPATIBLE API                        *
+ *********************************************************************/
+
+#ifdef CONFIG_CPU_FREQ_24_API
+/* NOTE #1: when you use this API, you may not use any other calls,
+ * except cpufreq_[un]register_notifier, of course.
+ */
+
+/**=20
+ * cpufreq_set - set the CPU frequency
+ * @freq: target frequency in kHz
+ * @cpu: CPU for which the frequency is to be set
+ *
+ * Sets the CPU frequency to freq.
+ */
+int cpufreq_set(unsigned int freq, unsigned int cpu)
+{
+	struct cpufreq_policy policy;
+	down(&cpufreq_driver_sem);
+	if (!cpufreq_driver || !cpu_max_freq) {
+		up(&cpufreq_driver_sem);
+		return -EINVAL;
+	}
+
+	policy.min =3D freq;
+	policy.max =3D freq;
+	policy.policy =3D CPUFREQ_POLICY_POWERSAVE;
+	policy.cpu =3D cpu;
+=09
+	up(&cpufreq_driver_sem);
+
+	return cpufreq_set_policy(&policy);
+}
+EXPORT_SYMBOL_GPL(cpufreq_set);
+
+
+/**=20
+ * cpufreq_setmax - set the CPU to the maximum frequency
+ * @cpu - affected cpu;
+ *
+ * Sets the CPU frequency to the maximum frequency supported by
+ * this CPU.
+ */
+int cpufreq_setmax(unsigned int cpu)
+{
+	if (!cpu_online(cpu) && (cpu !=3D CPUFREQ_ALL_CPUS))
+		return -EINVAL;
+	return cpufreq_set(cpu_max_freq, cpu);
+}
+EXPORT_SYMBOL_GPL(cpufreq_setmax);
+
+
+/**=20
+ * cpufreq_get - get the current CPU frequency (in kHz)
+ * @cpu: CPU number - currently without effect.
+ *
+ * Get the CPU current (static) CPU frequency
+ */
+unsigned int cpufreq_get(unsigned int cpu)
+{
+	if (!cpu_online(cpu))
+		return -EINVAL;
+	return cpu_cur_freq[cpu];
+}
+EXPORT_SYMBOL(cpufreq_get);
+
+
+#ifdef CONFIG_SYSCTL
+
+
+/*********************** cpufreq_sysctl interface ********************/
+static int
+cpufreq_procctl(ctl_table *ctl, int write, struct file *filp,
+		void *buffer, size_t *lenp)
+{
+	char buf[16], *p;
+	int cpu =3D (int) ctl->extra1;
+	int len, left =3D *lenp;
+
+	if (!left || (filp->f_pos && !write) || !cpu_online(cpu)) {
+		*lenp =3D 0;
+		return 0;
+	}
+
+	if (write) {
+		unsigned int freq;
+
+		len =3D left;
+		if (left > sizeof(buf))
+			left =3D sizeof(buf);
+		if (copy_from_user(buf, buffer, left))
+			return -EFAULT;
+		buf[sizeof(buf) - 1] =3D '\0';
+
+		freq =3D simple_strtoul(buf, &p, 0);
+		cpufreq_set(freq, cpu);
+	} else {
+		len =3D sprintf(buf, "%d\n", cpufreq_get(cpu));
+		if (len > left)
+			len =3D left;
+		if (copy_to_user(buffer, buf, len))
+			return -EFAULT;
+	}
+
+	*lenp =3D len;
+	filp->f_pos +=3D len;
+	return 0;
+}
+
+static int
+cpufreq_sysctl(ctl_table *table, int *name, int nlen,
+	       void *oldval, size_t *oldlenp,
+	       void *newval, size_t newlen, void **context)
+{
+	int cpu =3D (int) table->extra1;
+
+	if (!cpu_online(cpu))
+		return -EINVAL;
+
+	if (oldval && oldlenp) {
+		size_t oldlen;
+
+		if (get_user(oldlen, oldlenp))
+			return -EFAULT;
+
+		if (oldlen !=3D sizeof(unsigned int))
+			return -EINVAL;
+
+		if (put_user(cpufreq_get(cpu), (unsigned int *)oldval) ||
+		    put_user(sizeof(unsigned int), oldlenp))
+			return -EFAULT;
+	}
+	if (newval && newlen) {
+		unsigned int freq;
+
+		if (newlen !=3D sizeof(unsigned int))
+			return -EINVAL;
+
+		if (get_user(freq, (unsigned int *)newval))
+			return -EFAULT;
+
+		cpufreq_set(freq, cpu);
+	}
+	return 1;
+}
+
+/* ctl_table ctl_cpu_vars_{0,1,...,(NR_CPUS-1)} */
+/* due to NR_CPUS tweaking, a lot of if/endifs are required, sorry */
+        CTL_TABLE_CPU_VARS(0);
+#if NR_CPUS > 1
+	CTL_TABLE_CPU_VARS(1);
+#endif
+#if NR_CPUS > 2
+	CTL_TABLE_CPU_VARS(2);
+#endif
+#if NR_CPUS > 3
+	CTL_TABLE_CPU_VARS(3);
+#endif
+#if NR_CPUS > 4
+	CTL_TABLE_CPU_VARS(4);
+#endif
+#if NR_CPUS > 5
+	CTL_TABLE_CPU_VARS(5);
+#endif
+#if NR_CPUS > 6
+	CTL_TABLE_CPU_VARS(6);
+#endif
+#if NR_CPUS > 7
+	CTL_TABLE_CPU_VARS(7);
+#endif
+#if NR_CPUS > 8
+	CTL_TABLE_CPU_VARS(8);
+#endif
+#if NR_CPUS > 9
+	CTL_TABLE_CPU_VARS(9);
+#endif
+#if NR_CPUS > 10
+	CTL_TABLE_CPU_VARS(10);
+#endif
+#if NR_CPUS > 11
+	CTL_TABLE_CPU_VARS(11);
+#endif
+#if NR_CPUS > 12
+	CTL_TABLE_CPU_VARS(12);
+#endif
+#if NR_CPUS > 13
+	CTL_TABLE_CPU_VARS(13);
+#endif
+#if NR_CPUS > 14
+	CTL_TABLE_CPU_VARS(14);
+#endif
+#if NR_CPUS > 15
+	CTL_TABLE_CPU_VARS(15);
+#endif
+#if NR_CPUS > 16
+	CTL_TABLE_CPU_VARS(16);
+#endif
+#if NR_CPUS > 17
+	CTL_TABLE_CPU_VARS(17);
+#endif
+#if NR_CPUS > 18
+	CTL_TABLE_CPU_VARS(18);
+#endif
+#if NR_CPUS > 19
+	CTL_TABLE_CPU_VARS(19);
+#endif
+#if NR_CPUS > 20
+	CTL_TABLE_CPU_VARS(20);
+#endif
+#if NR_CPUS > 21
+	CTL_TABLE_CPU_VARS(21);
+#endif
+#if NR_CPUS > 22
+	CTL_TABLE_CPU_VARS(22);
+#endif
+#if NR_CPUS > 23
+	CTL_TABLE_CPU_VARS(23);
+#endif
+#if NR_CPUS > 24
+	CTL_TABLE_CPU_VARS(24);
+#endif
+#if NR_CPUS > 25
+	CTL_TABLE_CPU_VARS(25);
+#endif
+#if NR_CPUS > 26
+	CTL_TABLE_CPU_VARS(26);
+#endif
+#if NR_CPUS > 27
+	CTL_TABLE_CPU_VARS(27);
+#endif
+#if NR_CPUS > 28
+	CTL_TABLE_CPU_VARS(28);
+#endif
+#if NR_CPUS > 29
+	CTL_TABLE_CPU_VARS(29);
+#endif
+#if NR_CPUS > 30
+	CTL_TABLE_CPU_VARS(30);
+#endif
+#if NR_CPUS > 31
+	CTL_TABLE_CPU_VARS(31);
+#endif
+#if NR_CPUS > 32
+#error please extend CPU enumeration
+#endif
+
+/* due to NR_CPUS tweaking, a lot of if/endifs are required, sorry */
+static ctl_table ctl_cpu_table[NR_CPUS + 1] =3D {
+	CPU_ENUM(0),
+#if NR_CPUS > 1
+	CPU_ENUM(1),
+#endif
+#if NR_CPUS > 2
+	CPU_ENUM(2),
+#endif
+#if NR_CPUS > 3
+	CPU_ENUM(3),
+#endif
+#if NR_CPUS > 4
+	CPU_ENUM(4),
+#endif
+#if NR_CPUS > 5
+	CPU_ENUM(5),
+#endif
+#if NR_CPUS > 6
+	CPU_ENUM(6),
+#endif
+#if NR_CPUS > 7
+	CPU_ENUM(7),
+#endif
+#if NR_CPUS > 8
+	CPU_ENUM(8),
+#endif
+#if NR_CPUS > 9
+	CPU_ENUM(9),
+#endif
+#if NR_CPUS > 10
+	CPU_ENUM(10),
+#endif
+#if NR_CPUS > 11
+	CPU_ENUM(11),
+#endif
+#if NR_CPUS > 12
+	CPU_ENUM(12),
+#endif
+#if NR_CPUS > 13
+	CPU_ENUM(13),
+#endif
+#if NR_CPUS > 14
+	CPU_ENUM(14),
+#endif
+#if NR_CPUS > 15
+	CPU_ENUM(15),
+#endif
+#if NR_CPUS > 16
+	CPU_ENUM(16),
+#endif
+#if NR_CPUS > 17
+	CPU_ENUM(17),
+#endif
+#if NR_CPUS > 18
+	CPU_ENUM(18),
+#endif
+#if NR_CPUS > 19
+	CPU_ENUM(19),
+#endif
+#if NR_CPUS > 20
+	CPU_ENUM(20),
+#endif
+#if NR_CPUS > 21
+	CPU_ENUM(21),
+#endif
+#if NR_CPUS > 22
+	CPU_ENUM(22),
+#endif
+#if NR_CPUS > 23
+	CPU_ENUM(23),
+#endif
+#if NR_CPUS > 24
+	CPU_ENUM(24),
+#endif
+#if NR_CPUS > 25
+	CPU_ENUM(25),
+#endif
+#if NR_CPUS > 26
+	CPU_ENUM(26),
+#endif
+#if NR_CPUS > 27
+	CPU_ENUM(27),
+#endif
+#if NR_CPUS > 28
+	CPU_ENUM(28),
+#endif
+#if NR_CPUS > 29
+	CPU_ENUM(29),
+#endif
+#if NR_CPUS > 30
+	CPU_ENUM(30),
+#endif
+#if NR_CPUS > 31
+	CPU_ENUM(31),
+#endif
+#if NR_CPUS > 32
+#error please extend CPU enumeration
+#endif
+	{
+		ctl_name:	0,
+	}
+};
+
+static ctl_table ctl_cpu[2] =3D {
+	{
+		ctl_name:	CTL_CPU,
+		procname:	"cpu",
+		mode:		0555,
+		child:		ctl_cpu_table,
+	},
+	{
+		ctl_name:	0,
+	}
+};
+
+struct ctl_table_header *cpufreq_sysctl_table;
+
+static inline void cpufreq_sysctl_init(void)
+{
+	cpufreq_sysctl_table =3D register_sysctl_table(ctl_cpu, 0);
+}
+
+static inline void cpufreq_sysctl_exit(void)
+{
+	unregister_sysctl_table(cpufreq_sysctl_table);
+}
+
+#else
+#define cpufreq_sysctl_init()
+#define cpufreq_sysctl_exit()
+#endif /* CONFIG_SYSCTL */
+#endif /* CONFIG_CPU_FREQ_24_API */
+
+
+
+/*********************************************************************
  *                     NOTIFIER LISTS INTERFACE                      *
  *********************************************************************/
=20
@@ -484,6 +880,14 @@
 		cpufreq_driver->policy[policy->cpu].policy =3D policy->policy;
 	}
 =09
+#ifdef CONFIG_CPU_FREQ_24_API
+	if (policy->cpu =3D=3D CPUFREQ_ALL_CPUS) {
+		for (i=3D0;i<NR_CPUS;i++)
+			cpu_cur_freq[i] =3D policy->max;
+	} else
+		cpu_cur_freq[policy->cpu] =3D policy->max;
+#endif
+
 	cpufreq_driver->setpolicy(policy);
 =09
 	up(&cpufreq_driver_sem);
@@ -592,6 +996,20 @@
 	cpufreq_proc_init();
 #endif
=20
+#ifdef CONFIG_CPU_FREQ_24_API
+	down(&cpufreq_driver_sem);
+	cpu_min_freq          =3D driver_data->cpu_min_freq;
+	cpu_max_freq          =3D driver_data->policy[0].max_cpu_freq;
+	{
+		unsigned int i;
+		for (i=3D0; i<NR_CPUS; i++) {
+			cpu_cur_freq[i] =3D driver_data->cpu_cur_freq[i];
+		}
+	}
+	up(&cpufreq_driver_sem);
+
+	cpufreq_sysctl_init();
+#endif
 	if (ret) {
 		down(&cpufreq_driver_sem);
 		cpufreq_driver =3D NULL;
@@ -628,6 +1046,10 @@
 	cpufreq_proc_exit();
 #endif
=20
+#ifdef CONFIG_CPU_FREQ_24_API
+	cpufreq_sysctl_exit();
+#endif
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(cpufreq_unregister);
@@ -666,6 +1088,10 @@
=20
 #ifdef CONFIG_CPU_FREQ_26_API
 		cpufreq_set_policy(&policy);
+#endif
+
+#ifdef CONFIG_CPU_FREQ_24_API
+		cpufreq_set(cpu_cur_freq[i], i);
 #endif
 	}
=20


--AXxEqdD4tcVTjWte
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9hvfBZ8MDCHJbN8YRAux9AJ9Y4k2cHBMUxYHnDk+psF3rLuTKQgCfTgwz
W80Oqg+rCSExBYdpYc0rM6U=
=WapS
-----END PGP SIGNATURE-----

--AXxEqdD4tcVTjWte--
