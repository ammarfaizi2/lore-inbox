Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261750AbSJJS0X>; Thu, 10 Oct 2002 14:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261807AbSJJS0X>; Thu, 10 Oct 2002 14:26:23 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:60685 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261750AbSJJS0R>;
	Thu, 10 Oct 2002 14:26:17 -0400
Date: Thu, 10 Oct 2002 11:27:56 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: johnstul@us.ibm.com
Subject: [PATCH] i386 timer changes for 2.5.41
Message-ID: <20021010182756.GB25871@kroah.com>
References: <20021010182652.GA25871@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021010182652.GA25871@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.748   -> 1.749  
#	               (new)	        -> 1.1     include/asm-i386/timer.h
#	               (new)	        -> 1.1     arch/i386/kernel/timers/timer.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/09	johnstul@us.ibm.com	1.749
# i386 timer core: introduce struct timer_ops
# 
# provides the infrastructure needed via the timer_ops structure, 
# as well as the select_timer() function for choosing the best 
# available timer
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/timers/timer.c	Thu Oct 10 11:21:16 2002
@@ -0,0 +1,31 @@
+#include <linux/kernel.h>
+#include <asm/timer.h>
+
+/* list of externed timers */
+/* eg: extern struct timer_opts timer_XXX*/;
+
+/* list of timers, ordered by preference, NULL terminated */
+static struct timer_opts* timers[] = {
+	/* eg: &timer_XXX */
+	NULL,
+};
+
+
+/* iterates through the list of timers, returning the first 
+ * one that initializes successfully.
+ */
+struct timer_opts* select_timer(void)
+{
+	int i = 0;
+	
+	/* find most preferred working timer */
+	while (timers[i]) {
+		if (timers[i]->init)
+			if (timers[i]->init() == 0)
+				return timers[i];
+		++i;
+	}
+		
+	panic("select_timer: Cannot find a suitable timer\n");
+	return NULL;
+}
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/timer.h	Thu Oct 10 11:21:16 2002
@@ -0,0 +1,20 @@
+#ifndef _ASMi386_TIMER_H
+#define _ASMi386_TIMER_H
+
+/**
+ * struct timer_ops - used to define a timer source
+ *
+ * @init: Probes and initializes the timer.  Returns 0 on success, anything
+ *	else on failure.
+ * @mark_offset: called by the timer interrupt
+ * @get_offset: called by gettimeofday().  Returns the number of ms since the
+ *	last timer intruupt.
+ */
+struct timer_opts{
+	int (*init)(void);
+	void (*mark_offset)(void);
+	unsigned long (*get_offset)(void);
+};
+
+extern struct timer_opts* select_timer(void);
+#endif
