Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262423AbSJDURP>; Fri, 4 Oct 2002 16:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262422AbSJDURP>; Fri, 4 Oct 2002 16:17:15 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:5763 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262412AbSJDUPU>;
	Fri, 4 Oct 2002 16:15:20 -0400
Date: Fri, 4 Oct 2002 13:22:01 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi host cleanup 3/3 (driver changes)
Message-ID: <20021004202201.GC15055@beaverton.ibm.com>
Mail-Followup-To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20021004200413.GA15055@beaverton.ibm.com> <20021004201421.GB15055@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021004201421.GB15055@beaverton.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you read my previous post on this patch I indicated that few of the
driver changes I was only able to compile test ( block/cciss_scsi.c,
scsi/53c700.c, scsi/pcmcia/*, scsi/wd33c93.c). The changes to the
drivers are to remove the old interfaces and possibly extra NULL inits
of struct members. These changes will need to be ok'd by there
respective maintainers.

This is a resend of my previous patch clean ups to the scsi_host lists.

        * Fixed a regression in my previous patch that the scsi_host
          list was not sorted by host number. When we get some device
          naming this hack can be removed.
        * Switch scsi host template, name, host lists to struct
          list_head's.
        * Moved all scsi_host related register / unregister functions
          into hosts.c
        * Added list accessor interface and created a function similar
          to driverfs bus_for_each_dev.

The full patch is available at:
http://www-124.ibm.com/storageio/patches/2.5/scsi-host

-andmike
--
Michael Anderson
andmike@us.ibm.com

 acorn/scsi/acornscsi.c            |    6 ++----
 acorn/scsi/arxescsi.c             |    8 ++------
 acorn/scsi/cumana_2.c             |    8 ++------
 acorn/scsi/eesox.c                |    8 ++------
 acorn/scsi/powertec.c             |    8 ++------
 block/cciss_scsi.c                |   21 ++-------------------
 scsi/53c700.c                     |    6 ++----
 scsi/aic7xxx/aic7xxx_linux_host.h |    1 -
 scsi/cpqfcTSinit.c                |    4 +---
 scsi/fcal.c                       |    4 +---
 scsi/ips.h                        |    3 ---
 scsi/pcmcia/aha152x_stub.c        |    3 ++-
 scsi/pcmcia/fdomain_stub.c        |    3 ++-
 scsi/pcmcia/nsp_cs.c              |    3 ++-
 scsi/pcmcia/qlogic_stub.c         |    3 ++-
 scsi/wd33c93.c                    |    5 +----
 16 files changed, 25 insertions(+), 69 deletions(-)
------

diff -Nru a/drivers/acorn/scsi/acornscsi.c b/drivers/acorn/scsi/acornscsi.c
--- a/drivers/acorn/scsi/acornscsi.c	Fri Oct  4 08:05:55 2002
+++ b/drivers/acorn/scsi/acornscsi.c	Fri Oct  4 08:05:55 2002
@@ -3005,14 +3005,12 @@
 			int length, int host_no, int inout)
 {
     int pos, begin = 0, devidx;
-    struct Scsi_Host *instance = scsi_hostlist;
+    struct Scsi_Host *instance;
     Scsi_Device *scd;
     AS_Host *host;
     char *p = buffer;
 
-    for (instance = scsi_hostlist;
-	    instance && instance->host_no != host_no;
-		instance = instance->next);
+    instance = scsi_shost_hn_get(host_no);
 
     if (inout == 1 || !instance)
 	return -EINVAL;
diff -Nru a/drivers/acorn/scsi/arxescsi.c b/drivers/acorn/scsi/arxescsi.c
--- a/drivers/acorn/scsi/arxescsi.c	Fri Oct  4 08:05:56 2002
+++ b/drivers/acorn/scsi/arxescsi.c	Fri Oct  4 08:05:56 2002
@@ -384,15 +384,11 @@
 			    int length, int host_no, int inout)
 {
 	int pos, begin;
-	struct Scsi_Host *host = scsi_hostlist;
+	struct Scsi_Host *host;
 	ARXEScsi_Info *info;
 	Scsi_Device *scd;
 
-	while (host) {
-		if (host->host_no == host_no)
-			break;
-		host = host->next;
-	}
+	host = scsi_shost_hn_get(host_no);
 	if (!host)
 		return 0;
 
diff -Nru a/drivers/acorn/scsi/cumana_2.c b/drivers/acorn/scsi/cumana_2.c
--- a/drivers/acorn/scsi/cumana_2.c	Fri Oct  4 08:05:55 2002
+++ b/drivers/acorn/scsi/cumana_2.c	Fri Oct  4 08:05:55 2002
@@ -498,15 +498,11 @@
 			    int length, int host_no, int inout)
 {
 	int pos, begin;
-	struct Scsi_Host *host = scsi_hostlist;
+	struct Scsi_Host *host;
 	CumanaScsi2_Info *info;
 	Scsi_Device *scd;
 
-	while (host) {
-		if (host->host_no == host_no)
-			break;
-		host = host->next;
-	}
+	host = scsi_shost_hn_get(host_no);
 	if (!host)
 		return 0;
 
diff -Nru a/drivers/acorn/scsi/eesox.c b/drivers/acorn/scsi/eesox.c
--- a/drivers/acorn/scsi/eesox.c	Fri Oct  4 08:05:56 2002
+++ b/drivers/acorn/scsi/eesox.c	Fri Oct  4 08:05:56 2002
@@ -499,15 +499,11 @@
 			    int length, int host_no, int inout)
 {
 	int pos, begin;
-	struct Scsi_Host *host = scsi_hostlist;
+	struct Scsi_Host *host;
 	EESOXScsi_Info *info;
 	Scsi_Device *scd;
 
-	while (host) {
-		if (host->host_no == host_no)
-			break;
-		host = host->next;
-	}
+	host = scsi_shost_hn_get(host_no);
 	if (!host)
 		return 0;
 
diff -Nru a/drivers/acorn/scsi/powertec.c b/drivers/acorn/scsi/powertec.c
--- a/drivers/acorn/scsi/powertec.c	Fri Oct  4 08:05:55 2002
+++ b/drivers/acorn/scsi/powertec.c	Fri Oct  4 08:05:55 2002
@@ -404,15 +404,11 @@
 			    int length, int host_no, int inout)
 {
 	int pos, begin;
-	struct Scsi_Host *host = scsi_hostlist;
+	struct Scsi_Host *host;
 	PowerTecScsi_Info *info;
 	Scsi_Device *scd;
 
-	while (host) {
-		if (host->host_no == host_no)
-			break;
-		host = host->next;
-	}
+	host = scsi_shost_hn_get(host_no);
 	if (!host)
 		return 0;
 
diff -Nru a/drivers/block/cciss_scsi.c b/drivers/block/cciss_scsi.c
--- a/drivers/block/cciss_scsi.c	Fri Oct  4 08:05:55 2002
+++ b/drivers/block/cciss_scsi.c	Fri Oct  4 08:05:55 2002
@@ -1250,8 +1250,6 @@
 	return length;
 }
 
-/* It's a pity that we need this, but, we do... */
-extern struct Scsi_Host *scsi_hostlist;  /* from ../scsi/hosts.c */
 
 int
 cciss_scsi_proc_info(char *buffer, /* data buffer */
@@ -1268,24 +1266,9 @@
 	ctlr_info_t *ci;
 	int cntl_num;
 
-	/* Lets see if we can find our Scsi_Host... 
-	   this might be kind of "bad", searching scis_hostlist this way
-	   but how else can we find the scsi host?  I think I've seen
-	   this coded both ways, (circular list and null terminated list)
-	   I coded it to work either way, since I wasn't sure.  */
 
-	sh = scsi_hostlist;
-	found=0;
-	do {
-		if (sh == NULL) break;
-		if (sh->host_no == hostnum) {
-			found++;
-			break;
-		}
-		sh = sh->next;
-	} while (sh != scsi_hostlist && sh != NULL);
-
-	if (sh == NULL || found == 0) /* This really shouldn't ever happen. */
+	sh = scsi_shost_hn_get(hostnum);
+	if (sh == NULL) /* This really shouldn't ever happen. */
 		return -EINVAL;
 
 	ci = (ctlr_info_t *) sh->hostdata[0];
diff -Nru a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
--- a/drivers/scsi/53c700.c	Fri Oct  4 08:05:56 2002
+++ b/drivers/scsi/53c700.c	Fri Oct  4 08:05:56 2002
@@ -1719,13 +1719,11 @@
 {
 	static char buf[4096];	/* 1 page should be sufficient */
 	int len = 0;
-	struct Scsi_Host *host = scsi_hostlist;
+	struct Scsi_Host *host;
 	struct NCR_700_Host_Parameters *hostdata;
 	Scsi_Device *SDp;
 
-	while(host != NULL && host->host_no != host_no)
-		host = host->next;
-
+	host = scsi_shost_hn_get(host_no);
 	if(host == NULL)
 		return 0;
 
diff -Nru a/drivers/scsi/aic7xxx/aic7xxx_linux_host.h b/drivers/scsi/aic7xxx/aic7xxx_linux_host.h
--- a/drivers/scsi/aic7xxx/aic7xxx_linux_host.h	Fri Oct  4 08:05:55 2002
+++ b/drivers/scsi/aic7xxx/aic7xxx_linux_host.h	Fri Oct  4 08:05:55 2002
@@ -63,7 +63,6 @@
  * to do with card config are filled in after the card is detected.
  */
 #define AIC7XXX	{						\
-	next: NULL,						\
 	module: NULL,						\
 	proc_dir: NULL,						\
 	proc_info: ahc_linux_proc_info,				\
diff -Nru a/drivers/scsi/cpqfcTSinit.c b/drivers/scsi/cpqfcTSinit.c
--- a/drivers/scsi/cpqfcTSinit.c	Fri Oct  4 08:05:55 2002
+++ b/drivers/scsi/cpqfcTSinit.c	Fri Oct  4 08:05:55 2002
@@ -934,9 +934,7 @@
   char buf[81];
 
   // Search the Scsi host list for our controller
-  for (host=scsi_hostlist; host; host=host->next)
-    if (host->host_no == hostno)
-      break;
+  host = scsi_shost_hn_get(hostno);
 
   if (!host) return -ESRCH;
 
diff -Nru a/drivers/scsi/fcal.c b/drivers/scsi/fcal.c
--- a/drivers/scsi/fcal.c	Fri Oct  4 08:05:56 2002
+++ b/drivers/scsi/fcal.c	Fri Oct  4 08:05:56 2002
@@ -210,9 +210,7 @@
 	char *pos = buffer;
 	int i, j;
 
-	for (host=scsi_hostlist; host; host=host->next)
-		if (host->host_no == hostno)
-                      break;
+	host = scsi_shost_hn_get(hostno);
 
 	if (!host) return -ESRCH;
 
diff -Nru a/drivers/scsi/ips.h b/drivers/scsi/ips.h
--- a/drivers/scsi/ips.h	Fri Oct  4 08:05:55 2002
+++ b/drivers/scsi/ips.h	Fri Oct  4 08:05:55 2002
@@ -425,7 +425,6 @@
     */
 #if LINUX_VERSION_CODE < LinuxVersionCode(2,4,0)
  #define IPS {                            \
-    next : NULL,                          \
     module : NULL,                        \
     proc_info : NULL,                     \
     proc_dir : NULL,                      \
@@ -455,7 +454,6 @@
 }
 #elif LINUX_VERSION_CODE < LinuxVersionCode(2,5,0)
  #define IPS {                            \
-    next : NULL,                          \
     module : NULL,                        \
     proc_info : NULL,                     \
     name : NULL,                          \
@@ -484,7 +482,6 @@
 }
 #else
  #define IPS {                            \
-    next : NULL,                          \
     module : NULL,                        \
     proc_info : NULL,                     \
     name : NULL,                          \
diff -Nru a/drivers/scsi/pcmcia/aha152x_stub.c b/drivers/scsi/pcmcia/aha152x_stub.c
--- a/drivers/scsi/pcmcia/aha152x_stub.c	Fri Oct  4 08:05:55 2002
+++ b/drivers/scsi/pcmcia/aha152x_stub.c	Fri Oct  4 08:05:55 2002
@@ -294,7 +294,8 @@
 
     tail = &link->dev;
     info->ndev = 0;
-    for (host = scsi_hostlist; host; host = host->next)
+    for (host = scsi_shost_get_next(NULL); host;
+	 host = scsi_shost_get_next(host))
 	if (host->hostt == &driver_template)
 	    for (dev = host->host_queue; dev; dev = dev->next) {
 	    u_long arg[2], id;
diff -Nru a/drivers/scsi/pcmcia/fdomain_stub.c b/drivers/scsi/pcmcia/fdomain_stub.c
--- a/drivers/scsi/pcmcia/fdomain_stub.c	Fri Oct  4 08:05:55 2002
+++ b/drivers/scsi/pcmcia/fdomain_stub.c	Fri Oct  4 08:05:55 2002
@@ -258,7 +258,8 @@
 
     tail = &link->dev;
     info->ndev = 0;
-    for (host = scsi_hostlist; host; host = host->next)
+    for (host = scsi_shost_get_next(NULL); host;
+	 host = scsi_shost_get_next(host))
 	if (host->hostt == &driver_template)
 	    for (dev = host->host_queue; dev; dev = dev->next) {
 	    u_long arg[2], id;
diff -Nru a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
--- a/drivers/scsi/pcmcia/nsp_cs.c	Fri Oct  4 08:05:55 2002
+++ b/drivers/scsi/pcmcia/nsp_cs.c	Fri Oct  4 08:05:55 2002
@@ -1520,7 +1520,8 @@
 	DEBUG(0, "GET_SCSI_INFO\n");
 	tail = &link->dev;
 	info->ndev = 0;
-	for (host = scsi_hostlist; host != NULL; host = host->next) {
+	for (host = scsi_shost_get_next(NULL); host;
+	     host = scsi_shost_get_next(host))
 		if (host->hostt == &driver_template) {
 			for (dev = host->host_queue; dev != NULL; dev = dev->next) {
 				u_long arg[2], id;
diff -Nru a/drivers/scsi/pcmcia/qlogic_stub.c b/drivers/scsi/pcmcia/qlogic_stub.c
--- a/drivers/scsi/pcmcia/qlogic_stub.c	Fri Oct  4 08:05:56 2002
+++ b/drivers/scsi/pcmcia/qlogic_stub.c	Fri Oct  4 08:05:56 2002
@@ -281,7 +281,8 @@
 
     tail = &link->dev;
     info->ndev = 0;
-    for (host = scsi_hostlist; host; host = host->next)
+	for (host = scsi_shost_get_next(NULL); host;
+	     host = scsi_shost_get_next(host))
 	if (host->hostt == &driver_template)
 	    for (dev = host->host_queue; dev; dev = dev->next) {
 	    u_long arg[2], id;
diff -Nru a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
--- a/drivers/scsi/wd33c93.c	Fri Oct  4 08:05:56 2002
+++ b/drivers/scsi/wd33c93.c	Fri Oct  4 08:05:56 2002
@@ -1871,10 +1871,7 @@
 int x,i;
 static int stop = 0;
 
-   for (instance=scsi_hostlist; instance; instance=instance->next) {
-      if (instance->host_no == hn)
-         break;
-      }
+   instance = scsi_shost_hn_get(hn);
    if (!instance) {
       printk("*** Hmm... Can't find host #%d!\n",hn);
       return (-ESRCH);

