Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946436AbWJ0L4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946436AbWJ0L4o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbWJ0L4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:56:44 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:25044 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751799AbWJ0L4n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:56:43 -0400
In-Reply-To: <20061027111532.GA27468@skybase>
Subject: Re: [S390] Add ipl/reipl loadparm attribute.
To: mschwid2@de.ibm.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OFD298AD6D.26BA86C4-ON42257214.0041A504-42257214.0041B155@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Fri, 27 Oct 2006 13:57:32 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 27/10/2006 13:59:27
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Der patch hat eine Abhängikeit auf den strstrip patch.

Muss man das irgendwo dokumentieren?

       Michael

------------------------------------------------------------------------
Linux for E-Server Development
Phone: +49-7031-16-2360,  Bld 71032-03-U09
Email: holzheu@de.ibm.com



                                                                           
             mschwid2@de.ltcfw                                             
             d.linux.ibm.com                                               
                                                                        To 
             10/27/2006 01:15          linux-kernel@vger.kernel.org,       
             PM                        Michael Holzheu/Germany/IBM@IBMDE   
                                                                        cc 
                                                                           
                                                                   Subject 
                                       [S390] Add ipl/reipl loadparm       
                                       attribute.                          
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




From: Michael Holzheu <holzheu@de.ibm.com>

[S390] Add ipl/reipl loadparm attribute.

If multiple kernel images are installed on one DASD, the loadparm can be
used
to select the boot configuration. This patch introduces the following two
new
sysfs attributes:

/sys/firmware/ipl/loadparm: shows loadparm of current system (ro)
/sys/firmware/reipl/ccw/loadparm: loadparm used for next reboot (rw)

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/ipl.c |   98
+++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 94 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/ipl.c
linux-2.6-patched/arch/s390/kernel/ipl.c
--- linux-2.6/arch/s390/kernel/ipl.c             2006-10-27
11:25:37.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/ipl.c           2006-10-27
11:26:13.000000000 +0200
@@ -13,12 +13,20 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
+#include <linux/ctype.h>
 #include <asm/smp.h>
 #include <asm/setup.h>
 #include <asm/cpcmd.h>
 #include <asm/cio.h>
+#include <asm/ebcdic.h>

 #define IPL_PARM_BLOCK_VERSION 0
+#define LOADPARM_LEN 8
+
+extern char s390_readinfo_sccb[];
+#define SCCB_VALID (*((__u16*)&s390_readinfo_sccb[6]) == 0x0010)
+#define SCCB_LOADPARM (&s390_readinfo_sccb[24])
+#define SCCB_FLAG (s390_readinfo_sccb[91])

 enum ipl_type {
             IPL_TYPE_NONE            = 1,
@@ -289,9 +297,25 @@ static struct attribute_group ipl_fcp_at

 /* CCW ipl device attributes */

+static ssize_t ipl_ccw_loadparm_show(struct subsystem *subsys, char *page)
+{
+            char loadparm[LOADPARM_LEN + 1] = {};
+
+            if (!SCCB_VALID)
+                        return sprintf(page, "#unknown#\n");
+            memcpy(loadparm, SCCB_LOADPARM, LOADPARM_LEN);
+            EBCASC(loadparm, LOADPARM_LEN);
+            strstrip(loadparm);
+            return sprintf(page, "%s\n", loadparm);
+}
+
+static struct subsys_attribute sys_ipl_ccw_loadparm_attr =
+            __ATTR(loadparm, 0444, ipl_ccw_loadparm_show, NULL);
+
 static struct attribute *ipl_ccw_attrs[] = {
             &sys_ipl_type_attr.attr,
             &sys_ipl_device_attr.attr,
+            &sys_ipl_ccw_loadparm_attr.attr,
             NULL,
 };

@@ -348,8 +372,57 @@ static struct attribute_group reipl_fcp_
 DEFINE_IPL_ATTR_RW(reipl_ccw, device, "0.0.%04llx\n", "0.0.%llx\n",
             reipl_block_ccw->ipl_info.ccw.devno);

+static void reipl_get_ascii_loadparm(char *loadparm)
+{
+            memcpy(loadparm, &reipl_block_ccw->ipl_info.ccw.load_param,
+                   LOADPARM_LEN);
+            EBCASC(loadparm, LOADPARM_LEN);
+            loadparm[LOADPARM_LEN] = 0;
+            strstrip(loadparm);
+}
+
+static ssize_t reipl_ccw_loadparm_show(struct subsystem *subsys, char
*page)
+{
+            char buf[LOADPARM_LEN + 1];
+
+            reipl_get_ascii_loadparm(buf);
+            return sprintf(page, "%s\n", buf);
+}
+
+static ssize_t reipl_ccw_loadparm_store(struct subsystem *subsys,
+                                                            const char
*buf, size_t len)
+{
+            int i, lp_len;
+
+            /* ignore trailing newline */
+            lp_len = len;
+            if ((len > 0) && (buf[len - 1] == '\n'))
+                        lp_len--;
+            /* loadparm can have max 8 characters and must not start with
a blank */
+            if ((lp_len > LOADPARM_LEN) || ((lp_len > 0) && (buf[0] == '
')))
+                        return -EINVAL;
+            /* loadparm can only contain "a-z,A-Z,0-9,SP,." */
+            for (i = 0; i < lp_len; i++) {
+                        if (isalpha(buf[i]) || isdigit(buf[i]) || (buf[i]
== ' ') ||
+                            (buf[i] == '.'))
+                                    continue;
+                        return -EINVAL;
+            }
+            /* initialize loadparm with blanks */
+            memset(&reipl_block_ccw->ipl_info.ccw.load_param, ' ',
LOADPARM_LEN);
+            /* copy and convert to ebcdic */
+            memcpy(&reipl_block_ccw->ipl_info.ccw.load_param, buf,
lp_len);
+            ASCEBC(reipl_block_ccw->ipl_info.ccw.load_param,
LOADPARM_LEN);
+            return len;
+}
+
+static struct subsys_attribute sys_reipl_ccw_loadparm_attr =
+            __ATTR(loadparm, 0644, reipl_ccw_loadparm_show,
+                   reipl_ccw_loadparm_store);
+
 static struct attribute *reipl_ccw_attrs[] = {
             &sys_reipl_ccw_device_attr.attr,
+            &sys_reipl_ccw_loadparm_attr.attr,
             NULL,
 };

@@ -571,11 +644,14 @@ void do_reipl(void)
 {
             struct ccw_dev_id devid;
             static char buf[100];
+            char loadparm[LOADPARM_LEN + 1];

             switch (reipl_type) {
             case IPL_TYPE_CCW:
+                        reipl_get_ascii_loadparm(loadparm);
                         printk(KERN_EMERG "reboot on ccw device:
0.0.%04x\n",
                                     reipl_block_ccw->ipl_info.ccw.devno);
+                        printk(KERN_EMERG "loadparm = '%s'\n", loadparm);
                         break;
             case IPL_TYPE_FCP:
                         printk(KERN_EMERG "reboot on fcp device:\n");
@@ -592,7 +668,12 @@ void do_reipl(void)
                         reipl_ccw_dev(&devid);
                         break;
             case IPL_METHOD_CCW_VM:
-                        sprintf(buf, "IPL %X",
reipl_block_ccw->ipl_info.ccw.devno);
+                        if (strlen(loadparm) == 0)
+                                    sprintf(buf, "IPL %X",
+
reipl_block_ccw->ipl_info.ccw.devno);
+                        else
+                                    sprintf(buf, "IPL %X LOADPARM '%s'",
+
reipl_block_ccw->ipl_info.ccw.devno, loadparm);
                         cpcmd(buf, NULL, 0, NULL);
                         break;
             case IPL_METHOD_CCW_DIAG:
@@ -746,6 +827,17 @@ static int __init reipl_ccw_init(void)
             reipl_block_ccw->hdr.version = IPL_PARM_BLOCK_VERSION;
             reipl_block_ccw->hdr.blk0_len =
sizeof(reipl_block_ccw->ipl_info.ccw);
             reipl_block_ccw->hdr.pbt = DIAG308_IPL_TYPE_CCW;
+            /* check if read scp info worked and set loadparm */
+            if (SCCB_VALID)
+                        memcpy(reipl_block_ccw->ipl_info.ccw.load_param,
+                               SCCB_LOADPARM, LOADPARM_LEN);
+            else
+                        /* read scp info failed: set empty loadparm
(EBCDIC blanks) */
+                        memset(reipl_block_ccw->ipl_info.ccw.load_param,
0x40,
+                               LOADPARM_LEN);
+            /* FIXME: check for diag308_set_works when enabling diag ccw
reipl */
+            if (!MACHINE_IS_VM)
+                        sys_reipl_ccw_loadparm_attr.attr.mode = S_IRUGO;
             if (ipl_get_type() == IPL_TYPE_CCW)
                         reipl_block_ccw->ipl_info.ccw.devno = ipl_devno;
             reipl_capabilities |= IPL_TYPE_CCW;
@@ -827,13 +919,11 @@ static int __init dump_ccw_init(void)
             return 0;
 }

-extern char s390_readinfo_sccb[];
-
 static int __init dump_fcp_init(void)
 {
             int rc;

-            if(!(s390_readinfo_sccb[91] & 0x2))
+            if(!(SCCB_FLAG & 0x2) || !SCCB_VALID)
                         return 0; /* LDIPL DUMP is not installed */
             if (!diag308_set_works)
                         return 0;


