Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317606AbSINXtk>; Sat, 14 Sep 2002 19:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317624AbSINXtk>; Sat, 14 Sep 2002 19:49:40 -0400
Received: from zeus.kernel.org ([204.152.189.113]:15050 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S317606AbSINXti>;
	Sat, 14 Sep 2002 19:49:38 -0400
From: Marc-Christian Petersen <m.c.p@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] procps-208-20020915 against Rik van Riel's procps-207-20020913
Date: Sun, 15 Sep 2002 01:30:21 +0200
X-Mailer: KMail [version 1.4]
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_LYBGC07YUE8DCF96PSKW"
Message-Id: <200209150130.21224.m.c.p@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_LYBGC07YUE8DCF96PSKW
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi there,

just a minimal patch for procps from http://www.surriel.com/procps/,
file "procps-207-20020913.tar.bz2".

o  minimal cosmetic fixes. Looks a bit nicer now (imo) :)
o  Added OC (overcommit_memory) to be shown from /proc/sys/kernel in top
    maybe you find this usefull or totally useless ;) ... I like it.

Patch attached.

Comments?

--=20
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
--------------Boundary-00=_LYBGC07YUE8DCF96PSKW
Content-Type: text/x-diff;
  charset="us-ascii";
  name="procps-208-20020915.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="procps-208-20020915.patch"

diff -urN procps-207-20020913/top.c procps-208-20020915/top.c
--- procps-207-20020913/top.c	2002-09-13 14:54:45.000000000 +0200
+++ procps-208-20020915/top.c	2002-09-15 01:17:42.000000000 +0200
@@ -83,6 +83,10 @@
  *
  * 2001 / 2002, Rik van Riel <riel@conectiva.com.br>
  * Added support for new VM statistics, cleaned up meminfo stuff a bit.
+ *
+ * Modified 2002/09/15, Marc-Christian Petersen <m.c.p@wolk-project.de>
+ * Added cosmetic fixes. Looks a bit nicer now.
+ * Added OC (overcommit_memory) value to be shown from /proc/sys/kernel
  */
 
 #include <errno.h>
@@ -254,7 +258,7 @@
     cpu_mapping = (int *) xmalloc (sizeof (int) * nr_cpu);
     /* read cpuname */
     for (i=0; i< nr_cpu; i++) cpu_mapping[i]=i;
-    header_lines = 7 + nr_cpu;
+    header_lines = 8 + nr_cpu;
     strcpy(rcfile, SYS_TOPRC);
     fp = fopen(rcfile, "r");
     if (fp != NULL) {
@@ -1022,7 +1026,7 @@
 	    sprintf(tmp, "%4d ", task->euid);
 	    break;
 	  case P_EUSER:
-	    sprintf(tmp, "%-8.8s ", task->euser);
+	    sprintf(tmp, " %-8.8s ", task->euser);
 	    break;
 	  case P_PCPU:
 	    sprintf(tmp, "%4.1f ", (float)task->pcpu / 10);
@@ -1095,7 +1099,7 @@
 	    t = (task->utime + task->stime) / Hertz;
 	    if (Cumulative)
 		t += (task->cutime + task->cstime) / Hertz;
-	    sprintf(tmp, "%6.6s ", scale_time(t,6));
+	    sprintf(tmp, "%6.6s   ", scale_time(t,6));
 	    break;
 	  case P_COMMAND:
 	    if (!show_cmd && task->cmdline && *(task->cmdline)) {
@@ -1258,22 +1262,23 @@
 	error_end(1);
     }
     if (show_memory) {
-	printf("Mem:  %7LdK av, %7LdK used, %7LdK free, %7LdK shrd, %7LdK buff",
+	printf("Mem:   %7LdK total,     %7LdK used,    %7LdK free,   %7LdK buffer",
 		mem_info.mem.total >> 10,
 		mem_info.mem.used >> 10,
 		mem_info.mem.free >> 10,
-		mem_info.mem.shared >> 10,
 		mem_info.mem.buffers >> 10);
-	PUTP(top_clrtoeol);
 	putchar('\n');
-	printf("                   %7LdK actv, %7LdK in_d, %7LdK in_c, %7LdK target",
+	printf("       %7LdK shared,    %7LdK active,  %7LdK in_dirty",
+		mem_info.mem.shared >> 10,
 		mem_info.mem.active >> 10,
-		mem_info.mem.inactive_dirty >> 10,
+		mem_info.mem.inactive_dirty >> 10);
+	putchar('\n');
+	printf("       %7LdK in_clean,  %7LdK in_target",
 		mem_info.mem.inactive_clean >> 10,
 		mem_info.mem.inactive_target >> 10);
 	PUTP(top_clrtoeol);
 	putchar('\n');
-	printf("Swap: %7LdK av, %7LdK used, %7LdK free                 %7LdK cached",
+	printf("Swap:  %7LdK total,     %7LdK used,    %7LdK free,   %7LdK cached",
 		mem_info.swap.total >> 10,
 		mem_info.swap.used >> 10,
 		mem_info.swap.free >> 10,
@@ -1309,7 +1314,8 @@
                *n_ticks_o = NULL, *i_ticks_o = NULL;
     int s_ticks, u_ticks, n_ticks, i_ticks, t_ticks;
     char str[128];
-    FILE *file;
+    FILE *file, *oc_file;
+    char buf;
 
     if (!save_history)
 	save_history = xcalloc(NULL, save_history_size);
@@ -1413,9 +1419,26 @@
      * Display stats.
      */
     if (pass > 0 && show_stats) {
-	printf("%d processes: %d sleeping, %d running, %d zombie, "
-	       "%d stopped",
+	printf("%d processes:  %d sleeping,  %d running,  %d zombie, "
+	       " %d stopped",
 	       n, sleeping, running, zombie, stopped);
+
+
+    /*
+     * Display overcommit_memory value from /proc/sys/kernel
+     */
+    oc_memory = fopen("/proc/sys/vm/overcommit_memory", "r");
+    if (oc_memory != NULL) {
+      if (fread(&buf, 1, 1, oc_memory) > 0) { 
+        printf("  /  OC: %c", buf); 
+      }
+      fclose(oc_memory);
+    }
+    /*
+     * overcommit_memory end
+     */
+
+
 	PUTP(top_clrtoeol);
 	putchar('\n');
 	if (nr_cpu == 1 || CPU_states) {
@@ -1438,8 +1461,8 @@
 	    idle_ticks *= nr_cpu;
 	  }
 	  printf("CPU states:"
-		 " %2ld%s%ld%% user, %2ld%s%ld%% system,"
-		 " %2ld%s%ld%% nice, %2ld%s%ld%% idle",
+		 "  %2ld%s%ld%% user,  %2ld%s%ld%% system,"
+		 "  %2ld%s%ld%% nice,  %2ld%s%ld%% idle",
 		 user_ticks / 10UL, decimal_point, user_ticks % 10UL,
 		 system_ticks / 10UL, decimal_point, system_ticks % 10UL,
 		 nice_ticks / 10UL, decimal_point, nice_ticks % 10UL,
diff -urN procps-207-20020913/top.h procps-208-20020915/top.h
--- procps-207-20020913/top.h	2002-09-13 14:54:45.000000000 +0200
+++ procps-208-20020915/top.h	2002-09-15 01:20:44.000000000 +0200
@@ -112,6 +112,7 @@
 int monpids_index = 0;
 int Loops = -1;	       /* number of iterations. -1 loops forever */
 int Batch = 0;         /* batch mode. Collect no input, dumb output */
+int oc_memory = 1;     /* show overcommit_memory value */
 
 /* sorting order: cpu%, mem, time (cumulative, if in cumulative mode) */
 enum {
@@ -134,13 +135,13 @@
 char *headers[] =
 {
     "  PID ", " PPID ", " UID ",
-    "USER     ", "%CPU ", "%MEM ",
+    " USER     ", "%CPU ", "%MEM ",
     "TTY      ", "PRI ", " NI ",
     "PAGEIN ", "TSIZE ", "DSIZE ",
     " SIZE ", " TRS ", "SWAP ",
     "SHARE ", "  A ", " WP ",
     "  D ", " RSS ", "WCHAN     ",
-    "STAT ", "  TIME ", "COMMAND",
+    "STAT ", "  TIME ", "  COMMAND     ",
     "LC ",
     "   FLAGS "
 };

--------------Boundary-00=_LYBGC07YUE8DCF96PSKW--

