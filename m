Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbTHaQAw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 12:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbTHaQAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 12:00:52 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:41389 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262619AbTHaQAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 12:00:47 -0400
Message-ID: <3F522017.2060703@kegel.com>
Date: Sun, 31 Aug 2003 09:19:35 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Andrea VM changes
References: <3F52199B.5020808@kegel.com> <20030831154827.GE30196@wohnheim.fh-wedel.de>
In-Reply-To: <20030831154827.GE30196@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> On Sun, 31 August 2003 08:51:55 -0700, Dan Kegel wrote:
> 
>>In the test-and-measurement system I'm developing,
>>it turned out the sanest thing to do with OOM conditions
>>was to consider them user errors, and to handle them
>>by dumping memory usage info about processes and slab caches,
>>then halt.  It's been very helpful because it turns flaky
>>conditions into rock-solid failures.  Too bad this drastic
>>approach isn't appropriate for general use.
> 
> 
> Sound interesting.  Can you send a patch for the interested and
> unafraid?

This is against 2.4.21 or so.

--- mm.old/oom_kill.c	Mon Apr 28 17:23:19 2003
+++ mm/oom_kill.c	Mon Apr 28 20:22:23 2003
@@ -20,9 +20,13 @@
  #include <linux/swap.h>
  #include <linux/swapctl.h>
  #include <linux/timex.h>
+#include <asm/uaccess.h>

  /* #define DEBUG */

+#define CONFIG_OOM_HALT
+#ifndef CONFIG_OOM_HALT
+
  /**
   * int_sqrt - oom_kill.c internal function, rough approximation to sqrt
   * @x: integer of which to calculate the sqrt
@@ -193,6 +197,62 @@
  	return;
  }

+#else
+
+/**
+ * oom_halt - log out of memory condition, then halt system.
+ *
+ * For embedded systems which can't tolerate the chance that
+ * the oom killer will kill the wrong process, and would rather
+ * simply log the event in detail and halt.
+ */
+static void
+oom_halt(void)
+{
+	struct task_struct *p;
+	struct file *file;
+	int ret;
+
+	printk(KERN_EMERG "oom: Out of memory!\n");
+
+	printk(KERN_EMERG "oom: VM and RSS in KB, pid, and mm ptr for each task:\n");
+	read_lock(&tasklist_lock);
+	for_each_task(p) {
+		if (p->mm)
+			printk(KERN_EMERG "oom> vm %5d rss %5d pid %5d mm %p (%s)\n",
+			   p->mm->total_vm * (PAGE_SIZE / 1024),
+			   p->mm->rss * (PAGE_SIZE / 1024), p->pid, p->mm, p->comm);
+	}
+	read_unlock(&tasklist_lock);
+
+	file = filp_open("/proc/slabinfo", O_RDONLY, 0);
+	if (IS_ERR(file) || !file->f_op || !file->f_op->read)
+		goto out;
+	printk(KERN_EMERG "oom: Contents of /proc/slabinfo:\n");
+	do {
+		char buf[128];
+		int pos;
+		mm_segment_t fs = get_fs();
+		/* read one line */
+		for (pos = 0; pos < sizeof (buf); pos++) {
+			set_fs(KERNEL_DS);
+			ret = file->f_op->read(file, buf + pos, 1, &file->f_pos);
+			set_fs(fs);
+			if (ret != 1 || buf[pos] == '\n')
+				break;
+		}
+		buf[pos] = 0;
+		printk(KERN_EMERG "oom> %s\n", buf);
+	} while (ret == 1);
+	/* filp_close(file, NULL); */
+out:
+	printk(KERN_EMERG "oom: Halting.\n");
+	cli();
+	machine_halt();
+}
+
+#endif
+
  /**
   * out_of_memory - is the system out of memory?
   */
@@ -237,7 +297,11 @@
  	/*
  	 * Ok, really out of memory. Kill something.
  	 */
  	lastkill = now;
+#ifdef CONFIG_OOM_HALT
+	oom_halt();
+#else
  	oom_kill();
+#endif

  reset:
  	first = now;

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

