Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267869AbUHES06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267869AbUHES06 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267876AbUHES05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:26:57 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:25061 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S267869AbUHESF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:05:58 -0400
Date: Thu, 5 Aug 2004 20:05:57 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, linux-390@vm.marist.edu
Cc: arjanv@redhat.com, tim.bird@am.sony.com, mulix@mulix.org, alan@redhat.com,
       crisw@osdl.org, jan.glauber@de.ibm.com
Subject: [PATCH] timer (6/6): add cpu steal time fields to procps.
Message-ID: <20040805180557.GG9240@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] timer (6/6): add cpu steal time fields to procps.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Make use of the cpu steal time field in /proc/stat that has been
introduces by the cputime patch. The new output of top looks like
this:

top - 09:50:20 up 11 min,  3 users,  load average: 8.94, 7.17, 3.82
Tasks:  78 total,   8 running,  70 sleeping,   0 stopped,   0 zombie
 Cpu0 : 38.7%us,  4.2%sy,  0.0%ni,  0.0%id,  2.4%wa,  1.8%hi,  0.0%si, 53.0%st
 Cpu1 : 38.5%us,  0.6%sy,  0.0%ni,  5.1%id,  1.3%wa,  1.9%hi,  0.0%si, 52.6%st
 Cpu2 : 54.0%us,  0.6%sy,  0.0%ni,  0.6%id,  4.9%wa,  1.2%hi,  0.0%si, 38.7%st
 Cpu3 : 49.1%us,  0.6%sy,  0.0%ni,  1.2%id,  0.0%wa,  0.0%hi,  0.0%si, 49.1%st
 Cpu4 : 35.9%us,  1.2%sy,  0.0%ni, 15.0%id,  0.6%wa,  1.8%hi,  0.0%si, 45.5%s
 Cpu5 : 43.0%us,  2.1%sy,  0.7%ni,  0.0%id,  4.2%wa,  1.4%hi,  0.0%si, 48.6%st
Mem:    251832k total,   155448k used,    96384k free,     1212k buffers
Swap:   524248k total,    17716k used,   506532k free,    18096k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
20629 root      25   0 30572  27m 7076 R 55.2 11.1   0:02.14 cc1
20617 root      25   0 40600  37m 7076 R 47.0 15.1   0:03.04 cc1
20635 root      24   0 26356  20m 7076 R 42.3  8.4   0:00.75 cc1
20638 root      25   0 23196  17m 7076 R 27.0  7.2   0:00.46 cc1
20642 root      25   0 15028 9824 7076 R 18.2  3.9   0:00.31 cc1
20644 root      20   0 14852 9648 7076 R 17.0  3.8   0:00.29 cc1
   26 root       5 -10     0    0    0 S  0.6  0.0   0:00.03 kblockd/5
  915 root      16   0  3012  884 2788 R  0.6  0.4   0:02.33 top
    1 root      16   0  2020  284 1844 S  0.0  0.1   0:00.06 init

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diff -urN procps-3.2.0/proc/sysinfo.c procps-3.2.0-steal/proc/sysinfo.c
--- procps-3.2.0/proc/sysinfo.c	2004-07-16 09:52:29.000000000 +0200
+++ procps-3.2.0-steal/proc/sysinfo.c	2004-07-16 09:51:44.000000000 +0200
@@ -216,11 +216,11 @@
 #define NAN (-0.0)
 #endif
 #define JT unsigned long long
-void seven_cpu_numbers(double *restrict uret, double *restrict nret, double *restrict sret, double *restrict iret, double *restrict wret, double *restrict xret, double *restrict yret){
-    double tmp_u, tmp_n, tmp_s, tmp_i, tmp_w, tmp_x, tmp_y;
+void seven_cpu_numbers(double *restrict uret, double *restrict nret, double *restrict sret, double *restrict iret, double *restrict wret, double *restrict xret, double *restrict yret, double *restrict zret){
+    double tmp_u, tmp_n, tmp_s, tmp_i, tmp_w, tmp_x, tmp_y, tmp_z;
     double scale;  /* scale values to % */
-    static JT old_u, old_n, old_s, old_i, old_w, old_x, old_y;
-    JT new_u, new_n, new_s, new_i, new_w, new_x, new_y;
+    static JT old_u, old_n, old_s, old_i, old_w, old_x, old_y, old_z;
+    JT new_u, new_n, new_s, new_i, new_w, new_x, new_y, new_z;
     JT ticks_past; /* avoid div-by-0 by not calling too often :-( */
 
     tmp_w = 0.0;
@@ -229,10 +229,12 @@
     new_x = 0;
     tmp_y = 0.0;
     new_y = 0;
+    tmp_z = 0.0;
+    new_z = 0;
  
     FILE_TO_BUF(STAT_FILE,stat_fd);
-    sscanf(buf, "cpu %Lu %Lu %Lu %Lu %Lu %Lu %Lu", &new_u, &new_n, &new_s, &new_i, &new_w, &new_x, &new_y);
-    ticks_past = (new_u+new_n+new_s+new_i+new_w+new_x+new_y)-(old_u+old_n+old_s+old_i+old_w+old_x+old_y);
+    sscanf(buf, "cpu %Lu %Lu %Lu %Lu %Lu %Lu %Lu %Lu", &new_u, &new_n, &new_s, &new_i, &new_w, &new_x, &new_y, &new_z);
+    ticks_past = (new_u+new_n+new_s+new_i+new_w+new_x+new_y+new_z)-(old_u+old_n+old_s+old_i+old_w+old_x+old_y+old_z);
     if(ticks_past){
       scale = 100.0 / (double)ticks_past;
       tmp_u = ( (double)new_u - (double)old_u ) * scale;
@@ -242,6 +244,7 @@
       tmp_w = ( (double)new_w - (double)old_w ) * scale;
       tmp_x = ( (double)new_x - (double)old_x ) * scale;
       tmp_y = ( (double)new_y - (double)old_y ) * scale;
+      tmp_z = ( (double)new_z - (double)old_z ) * scale;
     }else{
       tmp_u = NAN;
       tmp_n = NAN;
@@ -250,6 +253,7 @@
       tmp_w = NAN;
       tmp_x = NAN;
       tmp_y = NAN;
+      tmp_z = NAN;
     }
     SET_IF_DESIRED(uret, tmp_u);
     SET_IF_DESIRED(nret, tmp_n);
@@ -258,6 +262,7 @@
     SET_IF_DESIRED(wret, tmp_w);
     SET_IF_DESIRED(iret, tmp_x);
     SET_IF_DESIRED(wret, tmp_y);
+    SET_IF_DESIRED(wret, tmp_z);
     old_u=new_u;
     old_n=new_n;
     old_s=new_s;
@@ -265,6 +270,7 @@
     old_w=new_w;
     old_i=new_x;
     old_w=new_y;
+    old_z=new_z;
 }
 #undef JT
 #endif
@@ -341,7 +347,7 @@
 
 /***********************************************************************/
 
-void getstat(jiff *restrict cuse, jiff *restrict cice, jiff *restrict csys, jiff *restrict cide, jiff *restrict ciow, jiff *restrict cxxx, jiff *restrict cyyy,
+void getstat(jiff *restrict cuse, jiff *restrict cice, jiff *restrict csys, jiff *restrict cide, jiff *restrict ciow, jiff *restrict cxxx, jiff *restrict cyyy, jiff *restrict czzz,
 	     unsigned long *restrict pin, unsigned long *restrict pout, unsigned long *restrict s_in, unsigned long *restrict sout,
 	     unsigned *restrict intr, unsigned *restrict ctxt,
 	     unsigned int *restrict running, unsigned int *restrict blocked,
@@ -363,9 +369,10 @@
   *ciow = 0;  /* not separated out until the 2.5.41 kernel */
   *cxxx = 0;  /* not separated out until the 2.6.0-test4 kernel */
   *cyyy = 0;  /* not separated out until the 2.6.0-test4 kernel */
+  *czzz = 0;  /* not separated out until the 2.6.x??? kernel */
 
   b = strstr(buff, "cpu ");
-  if(b) sscanf(b,  "cpu  %Lu %Lu %Lu %Lu %Lu %Lu %Lu", cuse, cice, csys, cide, ciow, cxxx, cyyy);
+  if(b) sscanf(b,  "cpu  %Lu %Lu %Lu %Lu %Lu %Lu %Lu %Lu", cuse, cice, csys, cide, ciow, cxxx, cyyy, czzz);
 
   b = strstr(buff, "page ");
   if(b) sscanf(b,  "page %lu %lu", pin, pout);
diff -urN procps-3.2.0/proc/sysinfo.h procps-3.2.0-steal/proc/sysinfo.h
--- procps-3.2.0/proc/sysinfo.h	2004-07-16 09:52:29.000000000 +0200
+++ procps-3.2.0-steal/proc/sysinfo.h	2004-07-16 09:51:44.000000000 +0200
@@ -55,7 +55,7 @@
 
 #define BUFFSIZE 8192
 typedef unsigned long long jiff;
-extern void getstat(jiff *restrict cuse, jiff *restrict cice, jiff *restrict csys, jiff *restrict cide, jiff *restrict ciow, jiff *restrict cxxx, jiff *restrict cyyy,
+extern void getstat(jiff *restrict cuse, jiff *restrict cice, jiff *restrict csys, jiff *restrict cide, jiff *restrict ciow, jiff *restrict cxxx, jiff *restrict cyyy, jiff *restrict czzz,
 	     unsigned long *restrict pin, unsigned long *restrict pout, unsigned long *restrict s_in, unsigned long *restrict sout,
 	     unsigned *restrict intr, unsigned *restrict ctxt,
 	     unsigned int *restrict running, unsigned int *restrict blocked,
diff -urN procps-3.2.0/top.c procps-3.2.0-steal/top.c
--- procps-3.2.0/top.c	2004-07-16 09:52:29.000000000 +0200
+++ procps-3.2.0-steal/top.c	2004-07-16 09:51:44.000000000 +0200
@@ -904,8 +904,9 @@
    if (!fgets(buf, sizeof(buf), fp)) std_err("failed /proc/stat read");
    cpus[Cpu_tot].x = 0;  // FIXME: can't tell by kernel version number
    cpus[Cpu_tot].y = 0;  // FIXME: can't tell by kernel version number
+   cpus[Cpu_tot].z = 0;  // FIXME: can't tell by kernel version number
    if (4 > sscanf(buf, CPU_FMTS_JUST1
-      , &cpus[Cpu_tot].u, &cpus[Cpu_tot].n, &cpus[Cpu_tot].s, &cpus[Cpu_tot].i, &cpus[Cpu_tot].w, &cpus[Cpu_tot].x, &cpus[Cpu_tot].y))
+      , &cpus[Cpu_tot].u, &cpus[Cpu_tot].n, &cpus[Cpu_tot].s, &cpus[Cpu_tot].i, &cpus[Cpu_tot].w, &cpus[Cpu_tot].x, &cpus[Cpu_tot].y, &cpus[Cpu_tot].z))
          std_err("failed /proc/stat read");
    // and just in case we're 2.2.xx compiled without SMP support...
    if (1 == Cpu_tot) memcpy(cpus, &cpus[1], sizeof(CPU_t));
@@ -918,8 +919,9 @@
       if (!fgets(buf, sizeof(buf), fp)) std_err("failed /proc/stat read");
       cpus[i].x = 0;  // FIXME: can't tell by kernel version number
       cpus[i].y = 0;  // FIXME: can't tell by kernel version number
+      cpus[i].z = 0;  // FIXME: can't tell by kernel version number
       if (4 > sscanf(buf, CPU_FMTS_MULTI
-         , &cpus[i].u, &cpus[i].n, &cpus[i].s, &cpus[i].i, &cpus[i].w, &cpus[i].x, &cpus[i].y))
+         , &cpus[i].u, &cpus[i].n, &cpus[i].s, &cpus[i].i, &cpus[i].w, &cpus[i].x, &cpus[i].y, &cpus[i].z))
             std_err("failed /proc/stat read");
    }
    return cpus;
@@ -1587,6 +1589,8 @@
       States_fmts = STATES_line2x5;
    if (linux_version_code >= LINUX_VERSION(2, 6, 0))  // grrr... only some 2.6.0-testX :-(
       States_fmts = STATES_line2x6;
+   if (linux_version_code >= LINUX_VERSION(2, 6, 7))
+      States_fmts = STATES_line2x7;
 
       /* get virtual page size -- nearing huge! */
    Page_size = getpagesize();
@@ -2809,7 +2813,7 @@
    /* we'll trim to zero if we get negative time ticks,
       which has happened with some SMP kernels (pre-2.4?) */
 #define TRIMz(x)  ((tz = (SIC_t)(x)) < 0 ? 0 : tz)
-   SIC_t u_frme, s_frme, n_frme, i_frme, w_frme, x_frme, y_frme, tot_frme, tz;
+   SIC_t u_frme, s_frme, n_frme, i_frme, w_frme, x_frme, y_frme, z_frme, tot_frme, tz;
    float scale;
 
    u_frme = cpu->u - cpu->u_sav;
@@ -2819,7 +2823,8 @@
    w_frme = cpu->w - cpu->w_sav;
    x_frme = cpu->x - cpu->x_sav;
    y_frme = cpu->y - cpu->y_sav;
-   tot_frme = u_frme + s_frme + n_frme + i_frme + w_frme + x_frme + y_frme;
+   z_frme = cpu->z - cpu->z_sav;
+   tot_frme = u_frme + s_frme + n_frme + i_frme + w_frme + x_frme + y_frme + z_frme;
    if (1 > tot_frme) tot_frme = 1;
    scale = 100.0 / (float)tot_frme;
 
@@ -2834,6 +2839,7 @@
       , (float)w_frme * scale
       , (float)x_frme * scale
       , (float)y_frme * scale
+      , (float)z_frme * scale
    ));
    Msg_row += 1;
 
@@ -2845,6 +2851,7 @@
    cpu->w_sav = cpu->w;
    cpu->x_sav = cpu->x;
    cpu->y_sav = cpu->y;
+   cpu->z_sav = cpu->z;
 
 #undef TRIMz
 }
diff -urN procps-3.2.0/top.h procps-3.2.0-steal/top.h
--- procps-3.2.0/top.h	2004-07-16 09:52:29.000000000 +0200
+++ procps-3.2.0-steal/top.h	2004-07-16 09:51:44.000000000 +0200
@@ -195,8 +195,8 @@
            calculations.  It exists primarily for SMP support but serves
            all environments. */
 typedef struct CPU_t {
-   TIC_t u, n, s, i, w, x, y;                             // as represented in /proc/stat
-   TIC_t u_sav, s_sav, n_sav, i_sav, w_sav, x_sav, y_sav; // in the order of our display
+   TIC_t u, n, s, i, w, x, y, z;                          // as represented in /proc/stat
+   TIC_t u_sav, s_sav, n_sav, i_sav, w_sav, x_sav, y_sav, z_sav; // in the order of our display
 } CPU_t;
 
         /* These 2 types support rcfile compatibility */
@@ -357,11 +357,11 @@
         /* These are the possible fscanf formats used in /proc/stat
            reads during history processing.
            ( 5th number only for Linux 2.5.41 and above ) */
-#define CPU_FMTS_JUST1  "cpu %Lu %Lu %Lu %Lu %Lu %Lu %Lu"
+#define CPU_FMTS_JUST1  "cpu %Lu %Lu %Lu %Lu %Lu %Lu %Lu %Lu"
 #ifdef PRETEND4CPUS
 #define CPU_FMTS_MULTI CPU_FMTS_JUST1
 #else
-#define CPU_FMTS_MULTI  "cpu%*d %Lu %Lu %Lu %Lu %Lu %Lu %Lu"
+#define CPU_FMTS_MULTI  "cpu%*d %Lu %Lu %Lu %Lu %Lu %Lu %Lu %Lu"
 #endif
 
         /* Summary Lines specially formatted string(s) --
@@ -376,6 +376,8 @@
    " %#5.1f%% \02user,\03 %#5.1f%% \02system,\03 %#5.1f%% \02nice,\03 %#5.1f%% \02idle,\03 %#5.1f%% \02IO-wait\03\n"
 #define STATES_line2x6  "%s\03" \
    " %#4.1f%% \02us,\03 %#4.1f%% \02sy,\03 %#4.1f%% \02ni,\03 %#4.1f%% \02id,\03 %#4.1f%% \02wa,\03 %#4.1f%% \02hi,\03 %#4.1f%% \02si\03\n"
+#define STATES_line2x7  "%s\03" \
+   "%#5.1f%%\02us,\03%#5.1f%%\02sy,\03%#5.1f%%\02ni,\03%#5.1f%%\02id,\03%#5.1f%%\02wa,\03%#5.1f%%\02hi,\03%#5.1f%%\02si,\03%#5.1f%%\02st\03\n"
 #ifdef CASEUP_SUMMK
 #define MEMORY_line1  "Mem: \03" \
    " %8uK \02total,\03 %8uK \02used,\03 %8uK \02free,\03 %8uK \02buffers\03\n"
diff -urN procps-3.2.0/vmstat.c procps-3.2.0-steal/vmstat.c
--- procps-3.2.0/vmstat.c	2004-07-16 09:52:29.000000000 +0200
+++ procps-3.2.0-steal/vmstat.c	2004-07-16 10:37:11.486408880 +0200
@@ -149,15 +149,15 @@
 ////////////////////////////////////////////////////////////////////////////
 
 static void new_header(void){
-  printf("procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----\n");
+  printf("procs -----------memory---------- ---swap-- -----io---- -system-- -----cpu------\n");
   printf(
-    "%2s %2s %6s %6s %6s %6s %4s %4s %5s %5s %4s %5s %2s %2s %2s %2s\n",
+    "%2s %2s %6s %6s %6s %6s %4s %4s %5s %5s %4s %4s %2s %2s %2s %2s %2s\n",
     "r","b",
     "swpd", "free", a_option?"inact":"buff", a_option?"active":"cache",
     "si","so",
     "bi","bo",
     "in","cs",
-    "us","sy","id","wa"
+    "us","sy","id","wa", "st"
   );
 }
 
@@ -193,13 +193,13 @@
 ////////////////////////////////////////////////////////////////////////////
 
 static void new_format(void) {
-  const char format[]="%2u %2u %6lu %6lu %6lu %6lu %4u %4u %5u %5u %4u %5u %2u %2u %2u %2u\n";
+  const char format[]="%2u %2u %6lu %6lu %6lu %6lu %4u %4u %5u %5u %4u %4u %2u %2u %2u %2u %2u\n";
   unsigned int tog=0; /* toggle switch for cleaner code */
   unsigned int i;
   unsigned int hz = Hertz;
   unsigned int running,blocked,dummy_1,dummy_2;
-  jiff cpu_use[2], cpu_nic[2], cpu_sys[2], cpu_idl[2], cpu_iow[2], cpu_xxx[2], cpu_yyy[2];
-  jiff duse, dsys, didl, diow, Div, divo2;
+  jiff cpu_use[2], cpu_nic[2], cpu_sys[2], cpu_idl[2], cpu_iow[2], cpu_xxx[2], cpu_yyy[2], cpu_zzz[2];
+  jiff duse, dsys, didl, diow, dstl, Div, divo2;
   unsigned long pgpgin[2], pgpgout[2], pswpin[2], pswpout[2];
   unsigned int intr[2], ctxt[2];
   unsigned int sleep_half; 
@@ -210,7 +210,7 @@
   new_header();
   meminfo();
 
-  getstat(cpu_use,cpu_nic,cpu_sys,cpu_idl,cpu_iow,cpu_xxx,cpu_yyy,
+  getstat(cpu_use,cpu_nic,cpu_sys,cpu_idl,cpu_iow,cpu_xxx,cpu_yyy,cpu_zzz,
 	  pgpgin,pgpgout,pswpin,pswpout,
 	  intr,ctxt,
 	  &running,&blocked,
@@ -220,7 +220,8 @@
   dsys= *cpu_sys + *cpu_xxx + *cpu_yyy;
   didl= *cpu_idl;
   diow= *cpu_iow;
-  Div= duse+dsys+didl+diow;
+  dstl= *cpu_zzz;
+  Div= duse+dsys+didl+diow+dstl;
   divo2= Div/2UL;
   printf(format,
 	 running, blocked,
@@ -236,7 +237,8 @@
 	 (unsigned)( (100*duse                    + divo2) / Div ),
 	 (unsigned)( (100*dsys                    + divo2) / Div ),
 	 (unsigned)( (100*didl                    + divo2) / Div ),
-	 (unsigned)( (100*diow                    + divo2) / Div )
+	 (unsigned)( (100*diow                    + divo2) / Div ),
+	 (unsigned)( (100*dstl                    + divo2) / Div )
   );
 
   for(i=1;i<num_updates;i++) { /* \\\\\\\\\\\\\\\\\\\\ main loop ////////////////// */
@@ -246,7 +248,7 @@
 
     meminfo();
 
-    getstat(cpu_use+tog,cpu_nic+tog,cpu_sys+tog,cpu_idl+tog,cpu_iow+tog,cpu_xxx+tog,cpu_yyy+tog,
+    getstat(cpu_use+tog,cpu_nic+tog,cpu_sys+tog,cpu_idl+tog,cpu_iow+tog,cpu_xxx+tog,cpu_yyy+tog,cpu_zzz+tog,
 	  pgpgin+tog,pgpgout+tog,pswpin+tog,pswpout+tog,
 	  intr+tog,ctxt+tog,
 	  &running,&blocked,
@@ -256,6 +258,7 @@
     dsys= cpu_sys[tog]-cpu_sys[!tog] + cpu_xxx[tog]-cpu_xxx[!tog] + cpu_yyy[tog]-cpu_yyy[!tog];
     didl= cpu_idl[tog]-cpu_idl[!tog];
     diow= cpu_iow[tog]-cpu_iow[!tog];
+    dstl= cpu_zzz[tog]-cpu_zzz[!tog];
 
     /* idle can run backwards for a moment -- kernel "feature" */
     if(debt){
@@ -267,7 +270,7 @@
       didl = 0;
     }
 
-    Div= duse+dsys+didl+diow;
+    Div= duse+dsys+didl+diow+dstl;
     divo2= Div/2UL;
     printf(format,
            running, blocked,
@@ -283,7 +286,8 @@
 	   (unsigned)( (100*duse+divo2)/Div ), /*us*/
 	   (unsigned)( (100*dsys+divo2)/Div ), /*sy*/
 	   (unsigned)( (100*didl+divo2)/Div ), /*id*/
-	   (unsigned)( (100*diow+divo2)/Div )  /*wa*/
+	   (unsigned)( (100*diow+divo2)/Div ), /*wa*/
+	   (unsigned)( (100*dstl+divo2)/Div )  /*st*/
     );
   }
 }
@@ -490,13 +494,14 @@
 
 static void sum_format(void) {
   unsigned int running, blocked, btime, processes;
-  jiff cpu_use, cpu_nic, cpu_sys, cpu_idl, cpu_iow, cpu_xxx, cpu_yyy;
+  jiff cpu_use, cpu_nic, cpu_sys, cpu_idl, cpu_iow, cpu_xxx, cpu_yyy, cpu_zzz;
   unsigned long pgpgin, pgpgout, pswpin, pswpout;
   unsigned int intr, ctxt;
 
   meminfo();
 
-  getstat(&cpu_use, &cpu_nic, &cpu_sys, &cpu_idl, &cpu_iow, &cpu_xxx, &cpu_yyy,
+  getstat(&cpu_use, &cpu_nic, &cpu_sys, &cpu_idl,
+          &cpu_iow, &cpu_xxx, &cpu_yyy, &cpu_zzz,
 	  &pgpgin, &pgpgout, &pswpin, &pswpout,
 	  &intr, &ctxt,
 	  &running, &blocked,
@@ -519,6 +524,7 @@
   printf("%13Lu IO-wait cpu ticks\n", cpu_iow);
   printf("%13Lu IRQ cpu ticks\n", cpu_xxx);
   printf("%13Lu softirq cpu ticks\n", cpu_yyy);
+  printf("%13Lu steal cpu ticks\n", cpu_zzz);
   printf("%13lu pages paged in\n", pgpgin);
   printf("%13lu pages paged out\n", pgpgout);
   printf("%13lu pages swapped in\n", pswpin);
@@ -533,11 +539,12 @@
 
 static void fork_format(void) {
   unsigned int running, blocked, btime, processes;
-  jiff cpu_use, cpu_nic, cpu_sys, cpu_idl, cpu_iow, cpu_xxx, cpu_yyy;
+  jiff cpu_use, cpu_nic, cpu_sys, cpu_idl, cpu_iow, cpu_xxx, cpu_yyy, cpu_zzz;
   unsigned long pgpgin, pgpgout, pswpin, pswpout;
   unsigned int intr, ctxt;
 
-  getstat(&cpu_use, &cpu_nic, &cpu_sys, &cpu_idl, &cpu_iow, &cpu_xxx, &cpu_yyy,
+  getstat(&cpu_use, &cpu_nic, &cpu_sys, &cpu_idl,
+	  &cpu_iow, &cpu_xxx, &cpu_yyy, &cpu_zzz,
 	  &pgpgin, &pgpgout, &pswpin, &pswpout,
 	  &intr, &ctxt,
 	  &running, &blocked,
