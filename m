Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264834AbSIQW4K>; Tue, 17 Sep 2002 18:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbSIQWxv>; Tue, 17 Sep 2002 18:53:51 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:15035 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264717AbSIQWsp>;
	Tue, 17 Sep 2002 18:48:45 -0400
Date: Tue, 17 Sep 2002 15:53:36 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC] [PATCH] 6/7 2.5.35 SCSI multi-path
Message-ID: <20020917155336.F18424@eng2.beaverton.ibm.com>
References: <20020917154940.A18401@eng2.beaverton.ibm.com> <20020917155018.A18424@eng2.beaverton.ibm.com> <20020917155041.B18424@eng2.beaverton.ibm.com> <20020917155120.C18424@eng2.beaverton.ibm.com> <20020917155201.D18424@eng2.beaverton.ibm.com> <20020917155232.E18424@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020917155232.E18424@eng2.beaverton.ibm.com>; from patman on Tue, Sep 17, 2002 at 03:52:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to add 2.5 and/or multi-path support to the qla v6b5 adapter driver.

Requires the qla source - this is _not_ a patch for the mainline kernel.

Requires the scsi base changes.

Most of this is renaming the makefile, and creating a simple makefile
(thanks mikeand) that can easily be used with kbuild 2.5.

Download the qla v6b5 tar file, untar, create a src dir, untar the qla
source (yes it is a tar file within a tar file) into a directory named
something/src, and apply this patch.

To build as a module, cd to-your-kernel-source-with-mpath-patch and run:

	make SUBDIRS=/something/src/


 makefile        |  151 ++--------------------------------------------------
 makefile-orig   |  162 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 qla2x00.c       |   45 ++++++++++++---
 qla2x00_ioctl.c |    7 ++
 4 files changed, 210 insertions(+), 155 deletions(-)

diff -urN -X /home/patman/dontdiff src-orig/makefile src/makefile
--- src-orig/makefile	Tue Aug 20 02:43:18 2002
+++ src/makefile	Thu Sep 12 15:39:54 2002
@@ -1,162 +1,10 @@
-#
-# Makefile 1.5.1   April 30, 2002
-#
-#
-# 1. To make UP version of ISP2200 driver
-#  make qla2200.o 
-#
-# 2. To make UP version of ISP2300 driver
-#  make qla2300.o 
-#
-# 3. To make UP version of ISP2200 and ISP2300 drivers
-#  make all 
-#or 
-#  make 
-#
-# To make SMP version of any of the above drivers
-# append SMP=1 to one of the (3) make command lines above. 
-#  make ... SMP=1
-#
-# To make a new firmware file (FILE must be a *.c file of the fw object)
-#  make fw FILE2=2200tp.c
-#
+# andmike's condensed makefile
+# To use cd to the kernel source and type the following.
+# make SUBDIRS=/path/to/here
 
-DRIVER=qla2200.o qla2300.o 
+CFLAGS_qla2200.o = -I$(TOPDIR)/drivers/scsi
+CFLAGS_qla2300.o = -I$(TOPDIR)/drivers/scsi
 
-FILE2=2200tp.h
-FILE3=2300tp.h
+obj-m := qla2200.o qla2300.o
 
-HOSTTYPE := $(shell uname -m)
-
-#
-# f/W include files
-FWFILE2=ql2200_fw.h
-FWFILE3=ql2300_fw.h
-FWFILE2IP=ql2200ip_fw.h
-FWFILE3IP=ql2300ip_fw.h
-
-# Comment/uncomment the following line to enable/disable debugging
-DEBUGFLAG=y
-HSG80=n
-
-QL_DEBUG=0x6
-
-OSVER=linux-2.4
-
-# Change it here or specify it on the "make" commandline
-#(new)INCLUDEDIR = /lib/modules/`uname -r`/build/include
-INCLUDEDIR = /usr/src/$(OSVER)/include
-
-ifeq ($(DEBUGFLAG),y)
-  DEBFLAGS = -O -g -DUDEBUG -DLINUX -Dlinux
-else
-  DEBFLAGS = -O2 -DLINUX -Dlinux
-endif
-
-CFLAGS = -D__KERNEL__ -DMODULE -Wall $(DEBFLAGS) -DINTAPI -DEXPORT_SYMTAB
-#CFLAGS = -D__KERNEL__ -DMODULE -Wall $(DEBFLAGS) -DEXPORT_SYMTAB
-
-ifeq ($(HSG80),y)
-CFLAGS += -DCOMPAQ
-endif
-
-
-# set MODVERSIONS if the kernel uses it
-VERSUSED = $(shell grep 'define CONFIG_MODVERSIONS' \
-           $(INCLUDEDIR)/linux/autoconf.h | wc -l | sed 's/ //g')
-VERSUSED = 1
-
-ifeq ($(VERSUSED),1)
-CFLAGS += -DMODVERSIONS -include $(INCLUDEDIR)/linux/modversions.h
-endif
-
-CFLAGS += -I$(INCLUDEDIR) -I$(INCLUDEDIR)/../drivers/scsi
-
-ifeq ($(HOSTTYPE),i386)
-CFLAGS += -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce \
--pipe -malign-loops=2 -malign-jumps=2 -malign-functions=2 \
--DCONFIG_X86_LOCAL_APIC -fno-strict-aliasing -fno-common \
--mpreferred-stack-boundary=2 -march=i386
-endif
-
-ifeq ($(HOSTTYPE),i486)
-CFLAGS += -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce \
--pipe -malign-loops=2 -malign-jumps=2 -malign-functions=2 \
--DCONFIG_X86_LOCAL_APIC -fno-strict-aliasing -fno-common \
--mpreferred-stack-boundary=2 -march=i486
-endif
-
-ifeq ($(HOSTTYPE),i586)
-CFLAGS += -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce \
--pipe -malign-loops=2 -malign-jumps=2 -malign-functions=2 \
--DCONFIG_X86_LOCAL_APIC -fno-strict-aliasing -fno-common \
--mpreferred-stack-boundary=2 -march=i586
-endif
-
-ifeq ($(HOSTTYPE),i686)
-CFLAGS += -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce \
--pipe -malign-loops=2 -malign-jumps=2 -malign-functions=2 \
--DCONFIG_X86_LOCAL_APIC -fno-strict-aliasing -fno-common \
--mpreferred-stack-boundary=2 -march=i686
-endif
-
-ifeq ($(HOSTTYPE),ia64)
-CFLAGS += -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce \
--pipe -DWORD_FW_LOAD
-endif
-
-ifeq ($(HOSTTYPE),alpha)
-CFLAGS += -D__alpha__ \
--Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce \
--pipe  -fno-strict-aliasing -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6
-endif
-
-ifeq ("1","$(IP)")
-CFLAGS += -DFC_IP_SUPPORT  
-endif
-
-ifeq ("1","$(SMP)")
-CFLAGS += -D__SMP__  -DCONFIG_SMP  
-endif
-
-COFLAGS = -kv
-
-MPATH = /lib/modules
-
-SRC_FILES=qla_settings.h qla2x00.h qla2x00.c qla_cfg.c qla_cfg.h qla_cfgln.c \
-qla_fo.h qla_fo.c qlfo.h qla2x00_ioctl.c qla_inioct.c \
-qla_mbx.c qla_mbx.h qla_debug.h	qla_version.h makefile qla_ip.c qla_ip.h
-
-#
-# Where is all starts..
-#
-# -- default is always first.
-default: $(DRIVER)
-
-all:	$(DRIVER)
-
-clean: 
-	rm -f $(DRIVER)
-
-install: $(DRIVER)
-	REL=`uname -r | \
-	  sed -e 's/.*\"\(.*\)\".*/\1/'` ; \
-	cp -p $(DRIVER) /lib/modules/$$REL/kernel/drivers/scsi
-
-fw:
-	mv $(FILE2) $(FWFILE2)
-	mv $(FILE3) $(FWFILE3)
-
-qla2100.o  : $(SRC_FILES)
-	$(CC) $(CFLAGS) -c qla2100.c -o $@
-
-qla2200.o  : $(SRC_FILES) $(FWFILE2)
-	$(CC) $(CFLAGS) -c qla2200.c -o $@
-
-qla2300.o  : $(SRC_FILES) $(FWFILE3)
-	$(CC) $(CFLAGS) -c qla2300.c -o $@
-
-# @echo "Editing file to produce -> [isp_fw.h]"
-# sh do_fw.sh $(FILE) cvtfw
-# @echo "Editing file to produce -> [isp1_fw.h]"
-# sh do_fw.sh $(FILE2) cvtfw22
+include $(TOPDIR)/Rules.make
diff -urN -X /home/patman/dontdiff src-orig/makefile-orig src/makefile-orig
--- src-orig/makefile-orig	Wed Dec 31 16:00:00 1969
+++ src/makefile-orig	Tue Aug 20 02:43:18 2002
@@ -0,0 +1,162 @@
+#
+# Makefile 1.5.1   April 30, 2002
+#
+#
+# 1. To make UP version of ISP2200 driver
+#  make qla2200.o 
+#
+# 2. To make UP version of ISP2300 driver
+#  make qla2300.o 
+#
+# 3. To make UP version of ISP2200 and ISP2300 drivers
+#  make all 
+#or 
+#  make 
+#
+# To make SMP version of any of the above drivers
+# append SMP=1 to one of the (3) make command lines above. 
+#  make ... SMP=1
+#
+# To make a new firmware file (FILE must be a *.c file of the fw object)
+#  make fw FILE2=2200tp.c
+#
+
+DRIVER=qla2200.o qla2300.o 
+
+FILE2=2200tp.h
+FILE3=2300tp.h
+
+HOSTTYPE := $(shell uname -m)
+
+#
+# f/W include files
+FWFILE2=ql2200_fw.h
+FWFILE3=ql2300_fw.h
+FWFILE2IP=ql2200ip_fw.h
+FWFILE3IP=ql2300ip_fw.h
+
+# Comment/uncomment the following line to enable/disable debugging
+DEBUGFLAG=y
+HSG80=n
+
+QL_DEBUG=0x6
+
+OSVER=linux-2.4
+
+# Change it here or specify it on the "make" commandline
+#(new)INCLUDEDIR = /lib/modules/`uname -r`/build/include
+INCLUDEDIR = /usr/src/$(OSVER)/include
+
+ifeq ($(DEBUGFLAG),y)
+  DEBFLAGS = -O -g -DUDEBUG -DLINUX -Dlinux
+else
+  DEBFLAGS = -O2 -DLINUX -Dlinux
+endif
+
+CFLAGS = -D__KERNEL__ -DMODULE -Wall $(DEBFLAGS) -DINTAPI -DEXPORT_SYMTAB
+#CFLAGS = -D__KERNEL__ -DMODULE -Wall $(DEBFLAGS) -DEXPORT_SYMTAB
+
+ifeq ($(HSG80),y)
+CFLAGS += -DCOMPAQ
+endif
+
+
+# set MODVERSIONS if the kernel uses it
+VERSUSED = $(shell grep 'define CONFIG_MODVERSIONS' \
+           $(INCLUDEDIR)/linux/autoconf.h | wc -l | sed 's/ //g')
+VERSUSED = 1
+
+ifeq ($(VERSUSED),1)
+CFLAGS += -DMODVERSIONS -include $(INCLUDEDIR)/linux/modversions.h
+endif
+
+CFLAGS += -I$(INCLUDEDIR) -I$(INCLUDEDIR)/../drivers/scsi
+
+ifeq ($(HOSTTYPE),i386)
+CFLAGS += -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce \
+-pipe -malign-loops=2 -malign-jumps=2 -malign-functions=2 \
+-DCONFIG_X86_LOCAL_APIC -fno-strict-aliasing -fno-common \
+-mpreferred-stack-boundary=2 -march=i386
+endif
+
+ifeq ($(HOSTTYPE),i486)
+CFLAGS += -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce \
+-pipe -malign-loops=2 -malign-jumps=2 -malign-functions=2 \
+-DCONFIG_X86_LOCAL_APIC -fno-strict-aliasing -fno-common \
+-mpreferred-stack-boundary=2 -march=i486
+endif
+
+ifeq ($(HOSTTYPE),i586)
+CFLAGS += -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce \
+-pipe -malign-loops=2 -malign-jumps=2 -malign-functions=2 \
+-DCONFIG_X86_LOCAL_APIC -fno-strict-aliasing -fno-common \
+-mpreferred-stack-boundary=2 -march=i586
+endif
+
+ifeq ($(HOSTTYPE),i686)
+CFLAGS += -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce \
+-pipe -malign-loops=2 -malign-jumps=2 -malign-functions=2 \
+-DCONFIG_X86_LOCAL_APIC -fno-strict-aliasing -fno-common \
+-mpreferred-stack-boundary=2 -march=i686
+endif
+
+ifeq ($(HOSTTYPE),ia64)
+CFLAGS += -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce \
+-pipe -DWORD_FW_LOAD
+endif
+
+ifeq ($(HOSTTYPE),alpha)
+CFLAGS += -D__alpha__ \
+-Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce \
+-pipe  -fno-strict-aliasing -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6
+endif
+
+ifeq ("1","$(IP)")
+CFLAGS += -DFC_IP_SUPPORT  
+endif
+
+ifeq ("1","$(SMP)")
+CFLAGS += -D__SMP__  -DCONFIG_SMP  
+endif
+
+COFLAGS = -kv
+
+MPATH = /lib/modules
+
+SRC_FILES=qla_settings.h qla2x00.h qla2x00.c qla_cfg.c qla_cfg.h qla_cfgln.c \
+qla_fo.h qla_fo.c qlfo.h qla2x00_ioctl.c qla_inioct.c \
+qla_mbx.c qla_mbx.h qla_debug.h	qla_version.h makefile qla_ip.c qla_ip.h
+
+#
+# Where is all starts..
+#
+# -- default is always first.
+default: $(DRIVER)
+
+all:	$(DRIVER)
+
+clean: 
+	rm -f $(DRIVER)
+
+install: $(DRIVER)
+	REL=`uname -r | \
+	  sed -e 's/.*\"\(.*\)\".*/\1/'` ; \
+	cp -p $(DRIVER) /lib/modules/$$REL/kernel/drivers/scsi
+
+fw:
+	mv $(FILE2) $(FWFILE2)
+	mv $(FILE3) $(FWFILE3)
+
+qla2100.o  : $(SRC_FILES)
+	$(CC) $(CFLAGS) -c qla2100.c -o $@
+
+qla2200.o  : $(SRC_FILES) $(FWFILE2)
+	$(CC) $(CFLAGS) -c qla2200.c -o $@
+
+qla2300.o  : $(SRC_FILES) $(FWFILE3)
+	$(CC) $(CFLAGS) -c qla2300.c -o $@
+
+# @echo "Editing file to produce -> [isp_fw.h]"
+# sh do_fw.sh $(FILE) cvtfw
+# @echo "Editing file to produce -> [isp1_fw.h]"
+# sh do_fw.sh $(FILE2) cvtfw22
diff -urN -X /home/patman/dontdiff src-orig/qla2x00.c src/qla2x00.c
--- src-orig/qla2x00.c	Tue Aug 20 02:43:18 2002
+++ src/qla2x00.c	Thu Sep 12 15:41:53 2002
@@ -2153,7 +2153,7 @@
 	struct Scsi_Host *host = ha->host;
 
 	host->can_queue = max_srbs;  /* default value:-MAX_SRBS(4096)  */
-	host->cmd_per_lun = 1;
+	host->cmd_per_lun = 16;
 	host->select_queue_depths = qla2x00_select_queue_depth;
 	host->n_io_port = 0xFF;
 
@@ -3785,6 +3785,7 @@
 	 */
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,9)
+#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,33)
 	/* As mentioned in kernel/sched.c(RA).....
 	 * Reparent the calling kernel thread to the init task.
 	 * 
@@ -3801,6 +3802,7 @@
 	 */
 	reparent_to_init();
 #endif
+#endif
 
 	/*
 	 * Set the name of this process.
@@ -4235,7 +4237,12 @@
 		if (!(ql2xmaxqdepth == 0 || ql2xmaxqdepth > 256))
 			device->queue_depth = ql2xmaxqdepth;
 #endif
-
+#ifdef CONFIG_SCSI_MULTI_PATH_IO
+		printk(KERN_INFO "Enabled tagged queuing, queue depth %d for ",
+			device->queue_depth);
+		scsi_paths_printk(device, " ", "<%d:%d:%d:%d>");
+		printk("\n");
+#else
 		printk(KERN_INFO
 			"scsi(%d:%d:%d:%d): Enabled tagged queuing, "
 			"queue depth %d.\n",
@@ -4244,6 +4251,7 @@
 			device->id,
 			device->lun, 
 			device->queue_depth);
+#endif
 	}
 
 }
@@ -4260,15 +4268,18 @@
 qla2x00_select_queue_depth(struct Scsi_Host *host, Scsi_Device *scsi_devs)
 {
 	Scsi_Device *device;
+#ifdef CONFIG_SCSI_MULTI_PATH_IO
+	scsi_traverse_hndl_t strav_hndl;
+#endif
 	scsi_qla_host_t  *p = (scsi_qla_host_t *) host->hostdata;
 
 	ENTER("qla2x00_select_queue_depth");
-
-	for (device = scsi_devs; device != NULL; device = device->next) {
-		if (device->host == host)
-			qla2x00_device_queue_depth(p, device);
-	}
-
+#ifdef CONFIG_SCSI_MULTI_PATH_IO
+	scsi_for_each_host_sdev(&strav_hndl, device, host->host_no)
+#else
+	for (device = scsi_devs; device != NULL; device = device->sdev_next)
+#endif
+		qla2x00_device_queue_depth(p, device);
 	LEAVE("qla2x00_select_queue_depth");
 }
 
@@ -15502,9 +15513,23 @@
 		unsigned int cmd, unsigned long arg) 
 {
 	Scsi_Device fake_scsi_device;
+	int ret;
+
+#ifdef CONFIG_SCSI_MULTI_PATH_IO
+	if (scsi_add_path(&fake_scsi_device, apidev_host, 0,
+		apidev_host->this_id, 0))
+	return -ENODEV;
+#else
 	fake_scsi_device.host = apidev_host;
+#endif
 
-	return (qla2x00_ioctl(&fake_scsi_device, (int)cmd, (void*)arg));
+	ret = qla2x00_ioctl(&fake_scsi_device, (int)cmd, (void*)arg);
+#ifdef CONFIG_SCSI_MULTI_PATH_IO
+	scsi_remove_path(&fake_scsi_device, SCSI_FIND_ALL_HOST_NO,
+			 SCSI_FIND_ALL_CHANNEL, SCSI_FIND_ALL_ID,
+			 SCSI_FIND_ALL_LUN);
+#endif
+	return ret;
 }
 
 static struct file_operations apidev_fops = {
@@ -15540,7 +15565,7 @@
 			APIDEV_NODE, apidev_major);)
 
 	proc_mknod(APIDEV_NODE, 0777+S_IFCHR, host->hostt->proc_dir,
-			(kdev_t)MKDEV(apidev_major, 0));
+			(kdev_t)mk_kdev(apidev_major, 0));
 
 	return 0;
 }
diff -urN -X /home/patman/dontdiff src-orig/qla2x00_ioctl.c src/qla2x00_ioctl.c
--- src-orig/qla2x00_ioctl.c	Tue Aug 20 02:43:18 2002
+++ src/qla2x00_ioctl.c	Wed Sep  4 17:19:14 2002
@@ -237,8 +237,13 @@
 	if (_IOC_TYPE(cmd) != QLMULTIPATH_MAGIC) {
 		return (-EINVAL);
 	}
-
+#ifdef CONFIG_SCSI_MULTI_PATH_IO
+	host = scsi_get_host(dev);
+	if (host == NULL) 
+		return EXT_STATUS_ERR;
+#else
 	host = dev->host;
+#endif
 	ha = (scsi_qla_host_t *) host->hostdata; /* midlayer chosen instance */
 
 	ret = verify_area(VERIFY_READ, (void *)arg, sizeof(EXT_IOCTL));
