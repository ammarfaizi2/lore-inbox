Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265038AbRFZRKl>; Tue, 26 Jun 2001 13:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265043AbRFZRKb>; Tue, 26 Jun 2001 13:10:31 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:3089 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265038AbRFZRKR>;
	Tue, 26 Jun 2001 13:10:17 -0400
Date: Tue, 26 Jun 2001 10:07:34 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        suganuma <suganuma@hpc.bs1.fc.nec.co.jp>,
        Anton Blanchard <antonb@au.ibm.com>,
        Jason McMullan <jmcmullan@linuxcare.com>
Subject: Re: [ANNOUNCE] HotPlug CPU patch against 2.4.5
Message-ID: <20010626100734.A20758@kroah.com>
In-Reply-To: <m15BG8K-001UIwC@mozart>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m15BG8K-001UIwC@mozart>; from rusty@rustcorp.com.au on Sat, Jun 16, 2001 at 11:29:00PM +1000
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 16, 2001 at 11:29:00PM +1000, Rusty Russell wrote:
> Hi all,
> 
> 	http://sourceforge.net/projects/lhcs/
> 
> 	Version 0.3 (untested) of the HotPlug CPU Patch is out, with
> ia64 and x86 support.

Here's a patch to the patch that adds /sbin/hotplug support (sorry, I
couldn't resist...)

It also fixes a '}' problem in fs/proc/proc_misc.c

thanks,

greg k-h

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpu-hotplug-2.4.5.patch"

diff -Naur -X /home/greg/linux/dontdiff linux-2.4.5-hotplug/fs/proc/proc_misc.c linux-2.4.5-hotplug-greg/fs/proc/proc_misc.c
--- linux-2.4.5-hotplug/fs/proc/proc_misc.c	Tue Jun 26 09:23:00 2001
+++ linux-2.4.5-hotplug-greg/fs/proc/proc_misc.c	Tue Jun 26 09:43:57 2001
@@ -295,6 +295,7 @@
 			jif - (  kstat.per_cpu_user[i] \
 			           + kstat.per_cpu_nice[i] \
 			           + kstat.per_cpu_system[i]));
+	}
 	len += sprintf(page + len,
 		"page %u %u\n"
                 "swap %u %u\n"
diff -Naur -X /home/greg/linux/dontdiff linux-2.4.5-hotplug/kernel/cpu.c linux-2.4.5-hotplug-greg/kernel/cpu.c
--- linux-2.4.5-hotplug/kernel/cpu.c	Tue Jun 26 09:23:00 2001
+++ linux-2.4.5-hotplug-greg/kernel/cpu.c	Tue Jun 26 10:00:45 2001
@@ -8,6 +8,7 @@
 #include <linux/notifier.h>
 #include <linux/sched.h>
 #include <linux/sched.h>
+#include <linux/kmod.h>		/* for hotplug_path */
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
@@ -17,6 +18,38 @@
 
 static struct notifier_block *cpu_chain = NULL;
 
+#ifdef CONFIG_HOTPLUG
+/* Notify userspace when a cpu event occurs,
+ * by running '/sbin/hotplug cpu' with certain
+ * environment variables set.
+ */
+static int cpu_run_sbin_hotplug(unsigned int cpu, char *action)
+{
+	char *argv[3], *envp[5], cpu_str[12], action_str[32];
+	int i;
+
+	sprintf(cpu_str, "CPU=%d", cpu);
+	sprintf(action_str, "ACTION=%s", action);
+
+	i = 0;
+	argv[i++] = hotplug_path;
+	argv[i++] = "cpu";
+	argv[i] = 0;
+
+	i = 0;
+	/* minimal command environment */
+	envp [i++] = "HOME=/";
+	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+	envp [i++] = cpu_str;
+	envp [i++] = action_str;
+	envp [i] = 0;
+
+	return call_usermodehelper(argv [0], argv, envp);
+}
+#else
+#define cpu_run_sbin_hotplug(cpu, action) ({ 0; })
+#endif
+
 /* Should really be in a header somewhere. */
 asmlinkage long sys_sched_get_priority_max(int policy);
 
@@ -120,6 +153,8 @@
 	/* Die, CPU, die! */
 	__cpu_die(cpu);
 
+	cpu_run_sbin_hotplug(cpu, "remove");
+
  out:
 	up(&cpucontrol);
 	return ret;
@@ -145,6 +180,8 @@
 	/* Friendly to make sure everyone knows it's up before we
 	   return */
 	__synchronize_kernel();
+
+	cpu_run_sbin_hotplug(cpu, "add");
 
  out:
 	up(&cpucontrol);

--0OAP2g/MAC+5xKAE--
