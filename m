Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319529AbSH3Gu2>; Fri, 30 Aug 2002 02:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319530AbSH3Gu2>; Fri, 30 Aug 2002 02:50:28 -0400
Received: from dp.samba.org ([66.70.73.150]:57031 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319529AbSH3Gu1>;
	Fri, 30 Aug 2002 02:50:27 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: rmk@arm.linux.org.uk, Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: cpu controls in driverfs?
Date: Fri, 30 Aug 2002 16:53:16 +1000
Message-Id: <20020830015512.A44D22C092@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

	I current put the cpu online controls in /proc, they really
should be in driverfs somewhere.  There doesn't seem to be any cpus in
driverfs at the moment: Pat, where should they go?

My current code looks like:

+static void __init create_entries(struct proc_dir_entry *parent,
+				  unsigned int cpu)
+{
+	struct proc_dir_entry *e;
+
+	e = create_proc_entry("online", 0644, parent);
+	e->data = (void *)cpu;
+	e->read_proc = &read_online;
+	e->write_proc = &write_online;
+}
+
+static int __init create_per_cpu_entries(void)
+{
+	unsigned int i;
+	struct proc_dir_entry *cpudir, *dir;
+
+	cpudir = proc_mkdir("sys/cpu", NULL);
+	for (i = 0; i < NR_CPUS; i++) {
+		char cpuname[20];
+
+		if (cpu_possible(i)) {
+			sprintf(cpuname, "%i", i);
+			dir = proc_mkdir(cpuname, cpudir);
+
+			create_entries(dir, i);
+		}
+	}
+	return 0;
+}
+
+__initcall(create_per_cpu_entries);

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
