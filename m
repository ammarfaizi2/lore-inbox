Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132395AbRCZJzC>; Mon, 26 Mar 2001 04:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132393AbRCZJy7>; Mon, 26 Mar 2001 04:54:59 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:23046 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132395AbRCZJy2>;
	Mon, 26 Mar 2001 04:54:28 -0500
Date: Mon, 26 Mar 2001 04:55:41 -0500
Message-Id: <200103260955.f2Q9tfo14568@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        trini@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML1 cleanup patch, take 2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, since peoples' territorial instincts have started to lather up,
I guess I'm going to have to do this the hard way...

This file is a patch expressed in two ways.  First, procedurally, as a
way to duplicate its effects on any kernel source tree.  Secondly, as
an explicit patch against 2.4.3-pre8.  It replaces my previous patch
against 2.4.3-pre6.

This patch is the first result of a consistency audit of the configuration 
system.  I have been building analysis tools to check the correctness of
my CML2 rules file, and the processs of testing them turned up some problems.

The purpose of this patch is threefold:

(1) Clean up two errors in the CML1 corpus that could lead to subtle bugs.
    This is a BUG FIX in CML1.

(2) Fix up 20 cris-architecture configuration symbols lacking a CONFIG_
    prefix, so they obey CML1/CML2 conventions and can be detected by
    `make dep', also static-analysis tools and consistency checkers.
    This is a BUG FIX in CML1.

(3) Fix up 10 configuration symbols of the form CONFIG_[0-9]*; specific 
    changes are those suggested 8 Jan 2001 by PPC port maintainer Tom Rini.
    This change has been APPROVED by an authorized maintainer.

This leaves ten symbols in a form that breaks CML2.  I'll go after
the other individual maintainers about those.  Sigh....

No actual object code will be changed by this patch; it merely does
one-to-one substitutions on some configuration symbols.

Let me repeat that.  This patch changes *no* object code.  None.
However, merging it before the 2.5 fork will save me (and probably
Alan) some nasty large headaches later on...

For the procedural form, you will require the following Python 2.0 script:

-------------------------------- SCRIPT BEGINS HERE ---------------------------
#!/usr/bin/env python
#
# symbolreplace -- replace symbols in the current Linux source tree

import sys, os, re, getopt

renamings = {}	# Dictionary of translations
dobackup = 1
verbose = 0

#
# This is the only bit of knowledge in this script that knows anything
# about the lexical rules of the symbols we're looking for.  It's used as a
# guard expression on either side of each old symbol name -- matches
# must begin either with this guard or with a beginning-of-line, and end
# either with this guard or an end-of-line.  The purpose is to prevent false
# matches on FOO in FOOBAR and BARFOO.
#
guard = "[^A-Za-z0-9_]"

def backup(file):
    "Create a backup for the given file."
    # Compute where the RCS directory for this file should live.
    # Create it if necessary.
    rcs_dir = os.path.join(os.path.dirname(file), "RCS")
    if not os.path.exists(rcs_dir):
	os.mkdir(rcs_dir)

    # If there is no RCS master corresponding to the file, create one,
    rcs_file = os.path.join(rcs_dir, os.path.basename(file) + ",v")
    if not os.path.exists(rcs_file):
	os.system("ci -u -t- " + file + " >/dev/null 2>&1")

    # Check out a working copy if needed.
    if not os.access(file, os.W_OK):
	os.system("co -l " + file + " >/dev/null 2>&1")

def treevisit(root, visitor):
    "Apply the visitor function to every file under the given root path."
    def treewalker(hook, dirname, files):
        for file in files:
            here = os.path.join(dirname, file)
            if os.path.isfile(here) and here.find("RCS") == -1:
                hook(here)
    os.path.walk(root, treewalker, visitor)

def replacer(file):
    if verbose:
        print file

    # Suck the entire file into core as a list of lines.
    ifp = open(file, "r")
    contents = ifp.read()
    ifp.close()

    # Now perform the substitution on each line.
    substitutions = 0
    for pattern in renamings.keys():
        new_contents = pattern.sub(r"\1"+renamings[pattern]+r"\2", contents)
        if new_contents != contents:
            substitutions = substitutions + 1
            contents = new_contents

    # Spew the results.
    if substitutions:
        if dobackup:
            backup(file)
        ofp = open(file, "w")
        ofp.write(contents)
        ofp.close()

def read_translations(fp):
    "Read translation requests from the given file object, ignoring comments."
    while 1:
        line = fp.readline()
        if not line:
            break
        elif line[0] == '#' or line[0] == '\n':
            continue
        else:
            (old, new) = line.split()
            regexp = re.compile("(^|" + guard +")" + old + "(" + guard + "|$)")
            renamings[regexp] = new

# Main sequence

if __name__ == '__main__': 
    # Main sequence

    # Process options
    (options, arguments) = getopt.getopt(sys.argv[1:], "d:nv")
    topdir = "."
    for (switch, val) in options:
        if (switch == '-d'):
            topdir = val
        elif (switch == '-n'):
            dobackup = 0
        elif (switch == '-v'):
            verbose = 1

    read_translations(sys.stdin)
    treevisit(topdir, replacer)

# That's all, folks!
-------------------------------- SCRIPT ENDS HERE -----------------------------

Here is the instructions I used to generate the bulk of the patch.  A note on
the one manual change follows.

-------------------------------- SCRIPT BEGINS END ----------------------------
#!/bin/sh
symbolreplace -v -d ~/src/linux <<EOF
# Old names still lingering -- these could cause configuration bugs
CONFIG_PRINTER_READBACK		CONFIG_PARPORT_1284
CONFIG_AIC7XXX_TAGGED_QUEUEING	CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT
#
# PPC symbol cleanup as approved by Tom Rini <trini@kernel.crashing.org>
#
CONFIG_6xx			CONFIG_CPU_PPC_6xx
CONFIG_4xx			CONFIG_CPU_PPC_4xx
CONFIG_PPC64BRIDGE		CONFIG_PPC_64BRIDGE
CONFIG_8260			CONFIG_CPU_PPC_8260
CONFIG_8xx			CONFIG_CPU_PPC_88xx
CONFIG_8xxSMC2			CONFIG_SMC2_UART
CONFIG_8xxSCC			CONFIG_USE_SCC_IO
CONFIG_8xx_ALTSMC2		CONFIG_ALTSMC2
CONFIG_8xx_COPYBACK		CONFIG_CPU_PPC_8xx_COPYBACK
CONFIG_8xx_CPU6			CONFIG_CPU_PPC_8xx_CPU6
#
# These need to be fixed too, but hackers are territorial creatures...
#
#CONFIG_060_WRITETHROUGH	CONFIG_M68060_WRITETHROUGH
#CONFIG_21285_WATCHDOG		CONFIG_DC21285_WATCHDOG
#CONFIG_3C515			CONFIG_ISA3C515
#CONFIG_8139TOO			CONFIG_RTL8139TOO
#CONFIG_8139TOO_PIO		CONFIG_RTL8139TOO_PIO
#CONFIG_8139TOO_TUNE_TWISTER	CONFIG_RTL8139TOO_TUNE_TWISTER
#CONFIG_82C710_MOUSE		CONFIG_CT82C710_MOUSE
#CONFIG_977_WATCHDOG		CONFIG_WB83C977_WATCHDOG
#CONFIG_3215			CONFIG_IBM3215
#CONFIG_3215_CONSOLE		CONFIG_IBM3215_CONSOLE
#CONFIG_60XX_WDT		CONFIG_SBC60XX_WDT
#
# Fix configuration symbols lacking a CONFIG_ prefix.  This makes it
# possible for make dep to see these and avoids inconsistent builds.
# It also makes it possible to write static analysis tools to examine
# the configuration-symbol namespace without tripping over anything else.
#
ETRAX_DRAM_BASE			CONFIG_ETRAX_DRAM_BASE
ETRAX_DRAM_SIZE			CONFIG_ETRAX_DRAM_SIZE
DEF_R_WAITSTATES		CONFIG_DEF_R_WAITSTATES
DEF_R_BUS_CONFIG		CONFIG_DEF_R_BUS_CONFIG
DEF_R_DRAM_CONFIG		CONFIG_DEF_R_DRAM_CONFIG
DEF_R_DRAM_TIMING		CONFIG_DEF_R_DRAM_TIMING
DEF_R_PORT_PA_DIR		CONFIG_DEF_R_PORT_PA_DIR
DEF_R_PORT_PA_DATA		CONFIG_DEF_R_PORT_PA_DATA
DEF_R_PORT_PB_CONFIG		CONFIG_DEF_R_PORT_PB_CONFIG
DEF_R_PORT_PB_DIR		CONFIG_DEF_R_PORT_PB_DIR
DEF_R_PORT_PB_DATA		CONFIG_DEF_R_PORT_PB_DATA
ELTEST_IPADR			CONFIG_ELTEST_IPADR
ELTEST_NETWORK			CONFIG_ELTEST_NETWORK
ELTEST_NETMASK			CONFIG_ELTEST_NETMASK
ELTEST_BROADCAST		CONFIG_ELTEST_BROADCAST
ELTEST_GATEWAY			CONFIG_ELTEST_GATEWAY
ELTEST_ETHADR			CONFIG_ELTEST_ETHADR
EOF
-------------------------------- SCRIPT ENDS HERE -----------------------------

After this, I manually removed the former PRINTER_READBACK entry in the
configuration-help file.

Finally, here is the generated patch:

Diffs between last version checked in and current workfile(s):

--- Documentation/Configure.help	2001/03/26 09:16:57	1.1
+++ Documentation/Configure.help	2001/03/26 09:47:51
@@ -3724,12 +3724,6 @@
   This code is also available as a module (say M), called
   parport_mfc3.o. If in doubt, saying N is the safe plan.
 
-Support IEEE1284 status readback
-CONFIG_PRINTER_READBACK
-  If you have a device on your parallel port that support this
-  protocol, this option will allow the device to report its status. It
-  is safe to say Y.
-
 IEEE1284 transfer modes
 CONFIG_PARPORT_1284
   If you have a printer that supports status readback or device ID, or
@@ -15979,7 +15973,7 @@
   want this.
 
 Processor Type
-CONFIG_6xx
+CONFIG_CPU_PPC_6xx
   There are four types of PowerPC chips supported. The more common
   types (601, 603, 604, 740, 750), the Motorola embedded versions
   (821, 823, 850, 855, 860), the IBM embedded versions (403 and
--- Documentation/video4linux/CQcam.txt	2001/03/26 09:18:06	1.1
+++ Documentation/video4linux/CQcam.txt	2001/03/26 09:18:06
@@ -43,7 +43,7 @@
 
     CONFIG_PRINTER       M    for lp.o, parport.o parport_pc.o modules
     CONFIG_PNP_PARPORT   M for autoprobe.o IEEE1284 readback module
-    CONFIG_PRINTER_READBACK M for parport_probe.o IEEE1284 readback module
+    CONFIG_PARPORT_1284 M for parport_probe.o IEEE1284 readback module
     CONFIG_VIDEO_DEV     M    for videodev.o video4linux module
     CONFIG_VIDEO_CQCAM   M    for c-qcam.o  Color Quickcam module 
 
@@ -127,7 +127,7 @@
 
   The c-qcam is IEEE1284 compatible, so if you are using the proc file
 system (CONFIG_PROC_FS), the parallel printer support
-(CONFIG_PRINTER), the IEEE 1284 system,(CONFIG_PRINTER_READBACK), you
+(CONFIG_PRINTER), the IEEE 1284 system,(CONFIG_PARPORT_1284), you
 should be able to read some identification from your quickcam with
 
          modprobe -v parport
--- arch/cris/Makefile	2001/03/26 09:15:51	1.1
+++ arch/cris/Makefile	2001/03/26 09:15:51
@@ -1,4 +1,4 @@
-# $Id: Makefile,v 1.1 2001/03/26 09:15:51 esr Exp esr $
+# $Id: Makefile,v 1.11 2000/11/27 17:58:30 bjornw Exp $
 # cris/Makefile
 #
 # This file is included by the global makefile so that you can add your own
@@ -25,8 +25,8 @@
 # regenerating stuff (even for incremental linking of subsystems!) is
 # even more nauseating.
 LD = if [ ! -e $(LD_SCRIPT).tmp -o $(LD_SCRIPT) -nt $(LD_SCRIPT).tmp ]; then \
-          sed -e s/@ETRAX_DRAM_BASE@/0x$(ETRAX_DRAM_BASE)/ \
-              -e s/@ETRAX_DRAM_SIZE_M@/$(ETRAX_DRAM_SIZE)/ \
+          sed -e s/@CONFIG_ETRAX_DRAM_BASE@/0x$(CONFIG_ETRAX_DRAM_BASE)/ \
+              -e s/@ETRAX_DRAM_SIZE_M@/$(CONFIG_ETRAX_DRAM_SIZE)/ \
               < $(LD_SCRIPT) > $(LD_SCRIPT).tmp; \
      else true; \
      fi && $(CROSS_COMPILE)ld -mcriself
--- arch/cris/boot/compressed/head.S	2001/03/26 09:15:52	1.1
+++ arch/cris/boot/compressed/head.S	2001/03/26 09:15:52
@@ -26,16 +26,16 @@
 
 	;; We need to setup the bus registers before we start using the DRAM
 
-	move.d   DEF_R_WAITSTATES, r0
+	move.d   CONFIG_DEF_R_WAITSTATES, r0
 	move.d   r0, [R_WAITSTATES]
 
-	move.d   DEF_R_BUS_CONFIG, r0
+	move.d   CONFIG_DEF_R_BUS_CONFIG, r0
 	move.d   r0, [R_BUS_CONFIG]
   
-	move.d   DEF_R_DRAM_CONFIG, r0
+	move.d   CONFIG_DEF_R_DRAM_CONFIG, r0
 	move.d   r0, [R_DRAM_CONFIG]
 
-	move.d   DEF_R_DRAM_TIMING, r0
+	move.d   CONFIG_DEF_R_DRAM_TIMING, r0
 	move.d   r0, [R_DRAM_TIMING]
 
 #endif
--- arch/cris/config.in	2001/03/26 09:15:51	1.1
+++ arch/cris/config.in	2001/03/26 09:15:51
@@ -44,8 +44,8 @@
 
 define_bool CONFIG_CRIS_LOW_MAP y
 
-hex 'DRAM base (hex)' ETRAX_DRAM_BASE 40000000
-int 'DRAM size (dec, in MB)' ETRAX_DRAM_SIZE 8
+hex 'DRAM base (hex)' CONFIG_ETRAX_DRAM_BASE 40000000
+int 'DRAM size (dec, in MB)' CONFIG_ETRAX_DRAM_SIZE 8
 
 int 'Max possible flash size (dec, in MB)' CONFIG_ETRAX_FLASH_LENGTH 2
 int 'Buswidth of flash in bytes' CONFIG_ETRAX_FLASH_BUSWIDTH 2
@@ -71,15 +71,15 @@
 	 Serial-2	CONFIG_DEBUG_PORT2	\
 	 Serial-3	CONFIG_DEBUG_PORT3" Serial-0
 
-hex 'R_WAITSTATES' DEF_R_WAITSTATES 95a6
-hex 'R_BUS_CONFIG' DEF_R_BUS_CONFIG 104
-hex 'R_DRAM_CONFIG' DEF_R_DRAM_CONFIG 1a200040
-hex 'R_DRAM_TIMING' DEF_R_DRAM_TIMING 5611
-hex 'R_PORT_PA_DIR' DEF_R_PORT_PA_DIR 1c
-hex 'R_PORT_PA_DATA' DEF_R_PORT_PA_DATA 00
-hex 'R_PORT_PB_CONFIG' DEF_R_PORT_PB_CONFIG 00
-hex 'R_PORT_PB_DIR' DEF_R_PORT_PB_DIR 00
-hex 'R_PORT_PB_DATA' DEF_R_PORT_PB_DATA ff
+hex 'R_WAITSTATES' CONFIG_DEF_R_WAITSTATES 95a6
+hex 'R_BUS_CONFIG' CONFIG_DEF_R_BUS_CONFIG 104
+hex 'R_DRAM_CONFIG' CONFIG_DEF_R_DRAM_CONFIG 1a200040
+hex 'R_DRAM_TIMING' CONFIG_DEF_R_DRAM_TIMING 5611
+hex 'R_PORT_PA_DIR' CONFIG_DEF_R_PORT_PA_DIR 1c
+hex 'R_PORT_PA_DATA' CONFIG_DEF_R_PORT_PA_DATA 00
+hex 'R_PORT_PB_CONFIG' CONFIG_DEF_R_PORT_PB_CONFIG 00
+hex 'R_PORT_PB_DIR' CONFIG_DEF_R_PORT_PB_DIR 00
+hex 'R_PORT_PB_DATA' CONFIG_DEF_R_PORT_PB_DATA ff
 
 endmenu
 
@@ -91,12 +91,12 @@
 
   comment 'All addresses are in hexadecimal form without 0x prefix'
 
-  hex 'IP address' ELTEST_IPADR ab1005af
-  hex 'Network' ELTEST_NETWORK ab100000
-  hex 'Netmask' ELTEST_NETMASK ffff0000
-  hex 'Broadcast' ELTEST_BROADCAST ab10ffff
-  hex 'Gateway' ELTEST_GATEWAY ab100101
-  hwaddr 'Ethernet address' ELTEST_ETHADR 00408ccd0000
+  hex 'IP address' CONFIG_ELTEST_IPADR ab1005af
+  hex 'Network' CONFIG_ELTEST_NETWORK ab100000
+  hex 'Netmask' CONFIG_ELTEST_NETMASK ffff0000
+  hex 'Broadcast' CONFIG_ELTEST_BROADCAST ab10ffff
+  hex 'Gateway' CONFIG_ELTEST_GATEWAY ab100101
+  hwaddr 'Ethernet address' CONFIG_ELTEST_ETHADR 00408ccd0000
 
   endmenu
 fi
--- arch/cris/defconfig	2001/03/26 09:15:52	1.1
+++ arch/cris/defconfig	2001/03/26 09:15:52
@@ -26,8 +26,8 @@
 CONFIG_ETRAX100LX=y
 # CONFIG_SVINTO_SIM is not set
 CONFIG_CRIS_LOW_MAP=y
-ETRAX_DRAM_BASE=40000000
-ETRAX_DRAM_SIZE=8
+CONFIG_ETRAX_DRAM_BASE=40000000
+CONFIG_ETRAX_DRAM_SIZE=8
 CONFIG_ETRAX_PA_LEDS=y
 # CONFIG_ETRAX_PB_LEDS is not set
 # CONFIG_ETRAX_90000000_LEDS is not set
@@ -40,15 +40,15 @@
 # CONFIG_DEBUG_PORT1 is not set
 # CONFIG_DEBUG_PORT2 is not set
 # CONFIG_DEBUG_PORT3 is not set
-DEF_R_WAITSTATES=95a6
-DEF_R_BUS_CONFIG=104
-DEF_R_DRAM_CONFIG=1a200040
-DEF_R_DRAM_TIMING=5611
-DEF_R_PORT_PA_DIR=1d
-DEF_R_PORT_PA_DATA=f0
-DEF_R_PORT_PB_CONFIG=00
-DEF_R_PORT_PB_DIR=1e
-DEF_R_PORT_PB_DATA=f3
+CONFIG_DEF_R_WAITSTATES=95a6
+CONFIG_DEF_R_BUS_CONFIG=104
+CONFIG_DEF_R_DRAM_CONFIG=1a200040
+CONFIG_DEF_R_DRAM_TIMING=5611
+CONFIG_DEF_R_PORT_PA_DIR=1d
+CONFIG_DEF_R_PORT_PA_DATA=f0
+CONFIG_DEF_R_PORT_PB_CONFIG=00
+CONFIG_DEF_R_PORT_PB_DIR=1e
+CONFIG_DEF_R_PORT_PB_DATA=f3
 
 #
 # Drivers for Etrax built-in interfaces
--- arch/cris/kernel/head.S	2001/03/26 09:15:58	1.1
+++ arch/cris/kernel/head.S	2001/03/26 09:15:58
@@ -1,4 +1,4 @@
-	;; $Id: head.S,v 1.1 2001/03/26 09:15:58 esr Exp esr $
+	;; $Id: head.S,v 1.11 2001/01/16 16:31:38 bjornw Exp $
 	;; 
 	;; Head of the kernel - alter with care
 	;;
@@ -7,9 +7,6 @@
 	;; Authors:	Bjorn Wesen (bjornw@axis.com)
 	;; 
 	;; $Log: head.S,v $
-	;; Revision 1.1  2001/03/26 09:15:58  esr
-	;; Initial revision
-	;;
 	;; Revision 1.11  2001/01/16 16:31:38  bjornw
 	;; * Changed name and semantics of running_from_flash to romfs_in_flash,
 	;;   set by head.S to indicate to setup.c whether there is a cramfs image
@@ -139,16 +136,16 @@
 
 	;; We need to setup the bus registers before we start using the DRAM
 
-	move.d   DEF_R_WAITSTATES, r0
+	move.d   CONFIG_DEF_R_WAITSTATES, r0
 	move.d   r0, [R_WAITSTATES]
 
-	move.d   DEF_R_BUS_CONFIG, r0
+	move.d   CONFIG_DEF_R_BUS_CONFIG, r0
 	move.d   r0, [R_BUS_CONFIG]
   
-	move.d   DEF_R_DRAM_CONFIG, r0
+	move.d   CONFIG_DEF_R_DRAM_CONFIG, r0
 	move.d   r0, [R_DRAM_CONFIG]
 
-	move.d   DEF_R_DRAM_TIMING, r0
+	move.d   CONFIG_DEF_R_DRAM_TIMING, r0
 	move.d   r0, [R_DRAM_TIMING]
 
 #endif
@@ -425,20 +422,20 @@
 	;; setup port PA and PB default initial directions and data
 	;; including their shadow registers
 		
-	move.b	DEF_R_PORT_PA_DIR,r0
+	move.b	CONFIG_DEF_R_PORT_PA_DIR,r0
 	move.b	r0,[_port_pa_dir_shadow]
 	move.b	r0,[R_PORT_PA_DIR]
-	move.b	DEF_R_PORT_PA_DATA,r0
+	move.b	CONFIG_DEF_R_PORT_PA_DATA,r0
 	move.b	r0,[_port_pa_data_shadow]
 	move.b	r0,[R_PORT_PA_DATA]
 	
-	move.b	DEF_R_PORT_PB_CONFIG,r0
+	move.b	CONFIG_DEF_R_PORT_PB_CONFIG,r0
 	move.b	r0,[_port_pb_config_shadow]
 	move.b	r0,[R_PORT_PB_CONFIG]
-	move.b	DEF_R_PORT_PB_DIR,r0
+	move.b	CONFIG_DEF_R_PORT_PB_DIR,r0
 	move.b	r0,[_port_pb_dir_shadow]
 	move.b	r0,[R_PORT_PB_DIR]
-	move.b	DEF_R_PORT_PB_DATA,r0
+	move.b	CONFIG_DEF_R_PORT_PB_DATA,r0
 	move.b	r0,[_port_pb_data_shadow]
 	move.b	r0,[R_PORT_PB_DATA]
 
--- arch/m68k/config.in	2001/03/26 09:10:39	1.1
+++ arch/m68k/config.in	2001/03/26 09:10:39
@@ -140,7 +140,7 @@
    fi
    dep_tristate '  Parallel printer support' CONFIG_PRINTER $CONFIG_PARPORT
    if [ "$CONFIG_PRINTER" != "n" ]; then
-      bool '    Support IEEE1284 status readback' CONFIG_PRINTER_READBACK
+      bool '    Support IEEE1284 status readback' CONFIG_PARPORT_1284
    fi
 fi
 
--- arch/ppc/8xx_io/Config.in	2001/03/26 09:10:14	1.1
+++ arch/ppc/8xx_io/Config.in	2001/03/26 09:10:14
@@ -18,19 +18,19 @@
   fi
   bool 'Use Big CPM Ethernet Buffers' CONFIG_ENET_BIG_BUFFERS
 fi
-bool 'Use SMC2 for UART' CONFIG_8xxSMC2
-if [ "$CONFIG_8xxSMC2" = "y" ]; then
-  bool 'Use Alternate SMC2 I/O (823/850)' CONFIG_8xx_ALTSMC2
+bool 'Use SMC2 for UART' CONFIG_SMC2_UART
+if [ "$CONFIG_SMC2_UART" = "y" ]; then
+  bool 'Use Alternate SMC2 I/O (823/850)' CONFIG_ALTSMC2
   bool 'Use SMC2 for Console' CONFIG_8xx_CONS_SMC2
 fi
-bool 'Enable SCC2 and SCC3 for UART' CONFIG_8xxSCC
+bool 'Enable SCC2 and SCC3 for UART' CONFIG_USE_SCC_IO
 
 # This doesn't really belong here, but it is convenient to ask
 # 8xx specific questions.
 
 comment 'Generic MPC8xx Options'
-bool 'Copy-Back Data Cache (else Writethrough)' CONFIG_8xx_COPYBACK
-bool 'CPU6 Silicon Errata (860 Pre Rev. C)' CONFIG_8xx_CPU6
+bool 'Copy-Back Data Cache (else Writethrough)' CONFIG_CPU_PPC_8xx_COPYBACK
+bool 'CPU6 Silicon Errata (860 Pre Rev. C)' CONFIG_CPU_PPC_8xx_CPU6
 
 if [ "$CONFIG_IDE" = "y" ]; then
 	bool 'MPC8xx direct IDE support on PCMCIA port' CONFIG_BLK_DEV_MPC8xx_IDE
--- arch/ppc/8xx_io/uart.c	2001/03/26 09:10:12	1.1
+++ arch/ppc/8xx_io/uart.c	2001/03/26 09:10:12
@@ -134,15 +134,15 @@
   	{ 0,     0, PROFF_SMC1, CPMVEC_SMC1,   0,    0 },    /* SMC1 ttyS0 */
 #endif
 #if !defined(CONFIG_USB_MPC8xx) && !defined(CONFIG_USB_CLIENT_MPC8xx)
-# ifdef CONFIG_8xxSMC2
+# ifdef CONFIG_SMC2_UART
   	{ 0,     0, PROFF_SMC2, CPMVEC_SMC2,   0,    1 },    /* SMC2 ttyS1 */
 # endif
-# ifdef CONFIG_8xxSCC
+# ifdef CONFIG_USE_SCC_IO
   	{ 0,     0, PROFF_SCC2, CPMVEC_SCC2,   0,    (NUM_IS_SCC | 1) },    /* SCC2 ttyS2 */
   	{ 0,     0, PROFF_SCC3, CPMVEC_SCC3,   0,    (NUM_IS_SCC | 2) },    /* SCC3 ttyS3 */
 # endif
   #else /* CONFIG_USB_xxx */
-# ifdef CONFIG_8xxSCC
+# ifdef CONFIG_USE_SCC_IO
   	{ 0,     0, PROFF_SCC3, CPMVEC_SCC3,   0,    (NUM_IS_SCC | 2) },    /* SCC3 ttyS3 */
 # endif
 #endif	/* CONFIG_USB_xxx */
@@ -2533,7 +2533,7 @@
 
 	/* Configure SCC2, SCC3, and SCC4 instead of port A parallel I/O.
 	 */
-#ifdef CONFIG_8xxSCC
+#ifdef CONFIG_USE_SCC_IO
 #ifndef CONFIG_MBX
 	/* The "standard" configuration through the 860.
 	*/
@@ -2747,7 +2747,7 @@
 				 * parallel I/O.  On 823/850 these are on
 				 * port A for SMC2.
 				 */
-#ifndef CONFIG_8xx_ALTSMC2
+#ifndef CONFIG_ALTSMC2
 				iobits = 0xc0 << (idx * 4);
 				cp->cp_pbpar |= iobits;
 				cp->cp_pbdir &= ~iobits;
--- arch/ppc/Makefile	2001/03/26 09:09:29	1.1
+++ arch/ppc/Makefile	2001/03/26 09:09:29
@@ -26,22 +26,22 @@
 		-mmultiple -mstring
 CPP		= $(CC) -E $(CFLAGS)
 
-ifdef CONFIG_4xx
+ifdef CONFIG_CPU_PPC_4xx
 CFLAGS := $(CFLAGS) -mcpu=403
 endif
 
-ifdef CONFIG_8xx
+ifdef CONFIG_CPU_PPC_88xx
 CFLAGS := $(CFLAGS) -mcpu=860 -I../8xx_io
 endif
 
-ifdef CONFIG_PPC64BRIDGE
+ifdef CONFIG_PPC_64BRIDGE
 CFLAGS := $(CFLAGS) -Wa,-mppc64bridge
 endif
 
-ifdef CONFIG_4xx
+ifdef CONFIG_CPU_PPC_4xx
   HEAD := arch/ppc/kernel/head_4xx.o
 else
-  ifdef CONFIG_8xx
+  ifdef CONFIG_CPU_PPC_88xx
     HEAD := arch/ppc/kernel/head_8xx.o
   else
     HEAD := arch/ppc/kernel/head.o
@@ -70,12 +70,12 @@
 MAKEMBXBOOT = $(MAKE) -C arch/$(ARCH)/mbxboot
 MAKETREEBOOT = $(MAKE) -C arch/$(ARCH)/treeboot
 
-ifdef CONFIG_8xx
+ifdef CONFIG_CPU_PPC_88xx
 SUBDIRS += arch/ppc/8xx_io
 DRIVERS += arch/ppc/8xx_io/8xx_io.o
 endif
 
-ifdef CONFIG_8260
+ifdef CONFIG_CPU_PPC_8260
 SUBDIRS += arch/ppc/8260_io
 DRIVERS += arch/ppc/8260_io/8260_io.o
 endif
@@ -91,19 +91,19 @@
 
 BOOT_TARGETS = zImage znetboot.initrd zImage.initrd
 
-ifdef CONFIG_4xx
+ifdef CONFIG_CPU_PPC_4xx
 $(BOOT_TARGETS): $(CHECKS) vmlinux
 	@$(MAKETREEBOOT) $@
 endif
 
-ifdef CONFIG_8xx
+ifdef CONFIG_CPU_PPC_88xx
 $(BOOT_TARGETS): $(CHECKS) vmlinux
 	@$(MAKECOFFBOOT) $@
 	@$(MAKEMBXBOOT) $@
 endif
 
-ifdef CONFIG_6xx
-ifndef CONFIG_8260
+ifdef CONFIG_CPU_PPC_6xx
+ifndef CONFIG_CPU_PPC_8260
 $(BOOT_TARGETS): $(CHECKS) vmlinux
 	@$(MAKECOFFBOOT) $@
 	@$(MAKEBOOT) $@
@@ -128,7 +128,7 @@
 endif
 endif
 
-ifdef CONFIG_PPC64BRIDGE
+ifdef CONFIG_PPC_64BRIDGE
 $(BOOT_TARGETS): $(CHECKS) vmlinux
 	@$(MAKECOFFBOOT) $@
 	@$(MAKEBOOT) $@
--- arch/ppc/boot/Makefile	2001/03/26 09:10:00	1.1
+++ arch/ppc/boot/Makefile	2001/03/26 09:10:00
@@ -31,7 +31,7 @@
 TFTPIMAGE=/tftpboot/zImage.prep$(MSIZE)
 endif
 
-ifeq ($(CONFIG_PPC64BRIDGE),y)
+ifeq ($(CONFIG_PPC_64BRIDGE),y)
 MSIZE=.64
 else
 MSIZE=
--- arch/ppc/chrpboot/Makefile	2001/03/26 09:10:25	1.1
+++ arch/ppc/chrpboot/Makefile	2001/03/26 09:10:25
@@ -5,7 +5,7 @@
 #
 # Based on coffboot by Paul Mackerras
 
-ifeq ($(CONFIG_PPC64BRIDGE),y)
+ifeq ($(CONFIG_PPC_64BRIDGE),y)
 MSIZE=.64
 AFLAGS += -Wa,-mppc64bridge
 else
--- arch/ppc/coffboot/Makefile	2001/03/26 09:10:03	1.1
+++ arch/ppc/coffboot/Makefile	2001/03/26 09:10:03
@@ -14,7 +14,7 @@
 CHRPOBJS = crt0.o start.o chrpmain.o misc.o string.o zlib.o image.o
 LIBS = $(TOPDIR)/lib/lib.a
 
-ifeq ($(CONFIG_PPC64BRIDGE),y)
+ifeq ($(CONFIG_PPC_64BRIDGE),y)
 MSIZE=.64
 else
 MSIZE=
--- arch/ppc/config.in	2001/03/26 09:09:29	1.1
+++ arch/ppc/config.in	2001/03/26 09:09:29
@@ -1,4 +1,4 @@
-# $Id: config.in,v 1.1 2001/03/26 09:09:29 esr Exp esr $
+# $Id: config.in,v 1.106 1999/09/14 19:21:18 cort Exp $
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/config-language.txt.
 #
@@ -24,33 +24,33 @@
 comment 'Platform support'
 define_bool CONFIG_PPC y
 choice 'Processor Type'	\
-	"6xx/7xx/74xx/8260	CONFIG_6xx	\
-	 4xx			CONFIG_4xx	\
+	"6xx/7xx/74xx/8260	CONFIG_CPU_PPC_6xx	\
+	 4xx			CONFIG_CPU_PPC_4xx	\
 	 POWER3               	CONFIG_POWER3	\
 	 POWER4        	        CONFIG_POWER4	\
-	 8xx			CONFIG_8xx"	6xx
+	 8xx			CONFIG_CPU_PPC_88xx"	6xx
 
-if [ "$CONFIG_6xx" = "y" ]; then
-  bool 'MPC8260 CPM Support' CONFIG_8260
+if [ "$CONFIG_CPU_PPC_6xx" = "y" ]; then
+  bool 'MPC8260 CPM Support' CONFIG_CPU_PPC_8260
 fi
 
 if [ "$CONFIG_POWER3" = "y" -o "$CONFIG_POWER4" = "y" ]; then
-  define_bool CONFIG_PPC64BRIDGE y
+  define_bool CONFIG_PPC_64BRIDGE y
   define_bool CONFIG_ALL_PPC y
 fi
 
-if [ "$CONFIG_8260" = "y" ]; then
+if [ "$CONFIG_CPU_PPC_8260" = "y" ]; then
   define_bool CONFIG_SERIAL_CONSOLE y
   bool 'Support for EST8260' CONFIG_EST8260
 fi
 
-if [ "$CONFIG_4xx" = "y" ]; then
+if [ "$CONFIG_CPU_PPC_4xx" = "y" ]; then
     choice 'Machine Type'			\
 	"Oak			CONFIG_OAK 	\
 	 Walnut			CONFIG_WALNUT"	Oak
 fi
 
-if [ "$CONFIG_8xx" = "y" ]; then
+if [ "$CONFIG_CPU_PPC_88xx" = "y" ]; then
   define_bool CONFIG_SERIAL_CONSOLE y
 
   choice 'Machine Type'		\
@@ -79,17 +79,17 @@
   fi
 fi
 
-if [ "$CONFIG_6xx" = "y" -a "$CONFIG_8260" = "n" ]; then
+if [ "$CONFIG_CPU_PPC_6xx" = "y" -a "$CONFIG_CPU_PPC_8260" = "n" ]; then
   choice 'Machine Type'		\
 	"PowerMac/PReP/MTX/CHRP	CONFIG_ALL_PPC	\
 	 APUS		CONFIG_APUS"		PowerMac/PReP/MTX/CHRP
 fi
 
-if [ "$CONFIG_PPC64BRIDGE" != "y" ]; then
+if [ "$CONFIG_PPC_64BRIDGE" != "y" ]; then
   bool 'Workarounds for PPC601 bugs' CONFIG_PPC601_SYNC_FIX
 fi
 
-if [ "$CONFIG_8xx" = "y" -o "$CONFIG_8260" = "y" ]; then
+if [ "$CONFIG_CPU_PPC_88xx" = "y" -o "$CONFIG_CPU_PPC_8260" = "y" ]; then
   define_bool CONFIG_ALL_PPC n
 fi
 
@@ -98,7 +98,7 @@
   bool '  Distribute interrupts on all CPUs by default' CONFIG_IRQ_ALL_CPUS
 fi
 
-if [ "$CONFIG_6xx" = "y" -a "$CONFIG_8260" = "n" ];then
+if [ "$CONFIG_CPU_PPC_6xx" = "y" -a "$CONFIG_CPU_PPC_8260" = "n" ];then
   bool 'AltiVec Support' CONFIG_ALTIVEC
 fi
 
@@ -106,7 +106,7 @@
   define_bool CONFIG_MACH_SPECIFIC y
 fi
 
-if [ "$CONFIG_4xx" = "y" -o "$CONFIG_8xx" = "y" ]; then
+if [ "$CONFIG_CPU_PPC_4xx" = "y" -o "$CONFIG_CPU_PPC_88xx" = "y" ]; then
   bool 'Math emulation' CONFIG_MATH_EMULATION
 fi
 
@@ -125,11 +125,11 @@
 # Yes MCA RS/6000s exist but Linux-PPC does not currently support any
 define_bool CONFIG_MCA n
 
-if [ "$CONFIG_APUS" = "y" -o "$CONFIG_4xx" = "y" -o \
-     "$CONFIG_8260" = "y" ]; then
+if [ "$CONFIG_APUS" = "y" -o "$CONFIG_CPU_PPC_4xx" = "y" -o \
+     "$CONFIG_CPU_PPC_8260" = "y" ]; then
   define_bool CONFIG_PCI n
 else
-  if [ "$CONFIG_8xx" = "y" ]; then
+  if [ "$CONFIG_CPU_PPC_88xx" = "y" ]; then
      bool 'QSpan PCI' CONFIG_PCI_QSPAN
      define_bool CONFIG_PCI $CONFIG_PCI_QSPAN
   else
@@ -162,7 +162,7 @@
 
 source drivers/parport/Config.in
 
-if [ "$CONFIG_4xx" != "y" -a "$CONFIG_8xx" != "y" ]; then
+if [ "$CONFIG_CPU_PPC_4xx" != "y" -a "$CONFIG_CPU_PPC_88xx" != "y" ]; then
   tristate 'Support for /dev/rtc' CONFIG_PPC_RTC
 fi
 
@@ -270,7 +270,7 @@
 
 mainmenu_option next_comment
 comment 'Console drivers'
-if [ "$CONFIG_4xx" != "y" -a "$CONFIG_8xx" != "y" ]; then
+if [ "$CONFIG_CPU_PPC_4xx" != "y" -a "$CONFIG_CPU_PPC_88xx" != "y" ]; then
   bool 'Support for VGA Console' CONFIG_VGA_CONSOLE
 fi
  source drivers/video/Config.in
@@ -334,11 +334,11 @@
 
 endmenu
 
-if [ "$CONFIG_8xx" = "y" ]; then
+if [ "$CONFIG_CPU_PPC_88xx" = "y" ]; then
 source arch/ppc/8xx_io/Config.in
 fi
 
-if [ "$CONFIG_8260" = "y" ]; then
+if [ "$CONFIG_CPU_PPC_8260" = "y" ]; then
 source arch/ppc/8260_io/Config.in
 fi
 
--- arch/ppc/configs/IVMS8_defconfig	2001/03/26 09:10:18	1.1
+++ arch/ppc/configs/IVMS8_defconfig	2001/03/26 09:10:18
@@ -19,12 +19,12 @@
 # Platform support
 #
 CONFIG_PPC=y
-# CONFIG_6xx is not set
-# CONFIG_4xx is not set
+# CONFIG_CPU_PPC_6xx is not set
+# CONFIG_CPU_PPC_4xx is not set
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
-# CONFIG_8260 is not set
-CONFIG_8xx=y
+# CONFIG_CPU_PPC_8260 is not set
+CONFIG_CPU_PPC_88xx=y
 CONFIG_SERIAL_CONSOLE=y
 # CONFIG_RPXLITE is not set
 # CONFIG_RPXCLASSIC is not set
@@ -430,14 +430,14 @@
 CONFIG_FEC_ENET=y
 CONFIG_USE_MDIO=y
 CONFIG_ENET_BIG_BUFFERS=y
-# CONFIG_8xxSMC2 is not set
-# CONFIG_8xxSCC is not set
+# CONFIG_SMC2_UART is not set
+# CONFIG_USE_SCC_IO is not set
 
 #
 # Generic MPC8xx Options
 #
-CONFIG_8xx_COPYBACK=y
-# CONFIG_8xx_CPU6 is not set
+CONFIG_CPU_PPC_8xx_COPYBACK=y
+# CONFIG_CPU_PPC_8xx_CPU6 is not set
 
 #
 # USB support
--- arch/ppc/configs/SM850_defconfig	2001/03/26 09:10:18	1.1
+++ arch/ppc/configs/SM850_defconfig	2001/03/26 09:10:18
@@ -19,12 +19,12 @@
 # Platform support
 #
 CONFIG_PPC=y
-# CONFIG_6xx is not set
-# CONFIG_4xx is not set
+# CONFIG_CPU_PPC_6xx is not set
+# CONFIG_CPU_PPC_4xx is not set
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
-# CONFIG_8260 is not set
-CONFIG_8xx=y
+# CONFIG_CPU_PPC_8260 is not set
+CONFIG_CPU_PPC_88xx=y
 CONFIG_SERIAL_CONSOLE=y
 # CONFIG_RPXLITE is not set
 # CONFIG_RPXCLASSIC is not set
@@ -396,16 +396,16 @@
 CONFIG_SCC3_ENET=y
 # CONFIG_FEC_ENET is not set
 CONFIG_ENET_BIG_BUFFERS=y
-CONFIG_8xxSMC2=y
-CONFIG_8xx_ALTSMC2=y
+CONFIG_SMC2_UART=y
+CONFIG_ALTSMC2=y
 CONFIG_8xx_CONS_SMC2=y
-# CONFIG_8xxSCC is not set
+# CONFIG_USE_SCC_IO is not set
 
 #
 # Generic MPC8xx Options
 #
-CONFIG_8xx_COPYBACK=y
-CONFIG_8xx_CPU6=y
+CONFIG_CPU_PPC_8xx_COPYBACK=y
+CONFIG_CPU_PPC_8xx_CPU6=y
 
 #
 # USB support
--- arch/ppc/configs/SPD823TS_defconfig	2001/03/26 09:10:18	1.1
+++ arch/ppc/configs/SPD823TS_defconfig	2001/03/26 09:10:18
@@ -19,12 +19,12 @@
 # Platform support
 #
 CONFIG_PPC=y
-# CONFIG_6xx is not set
-# CONFIG_4xx is not set
+# CONFIG_CPU_PPC_6xx is not set
+# CONFIG_CPU_PPC_4xx is not set
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
-# CONFIG_8260 is not set
-CONFIG_8xx=y
+# CONFIG_CPU_PPC_8260 is not set
+CONFIG_CPU_PPC_88xx=y
 CONFIG_SERIAL_CONSOLE=y
 # CONFIG_RPXLITE is not set
 # CONFIG_RPXCLASSIC is not set
@@ -392,16 +392,16 @@
 CONFIG_SCC2_ENET=y
 # CONFIG_FEC_ENET is not set
 CONFIG_ENET_BIG_BUFFERS=y
-CONFIG_8xxSMC2=y
-CONFIG_8xx_ALTSMC2=y
+CONFIG_SMC2_UART=y
+CONFIG_ALTSMC2=y
 # CONFIG_8xx_CONS_SMC2 is not set
-# CONFIG_8xxSCC is not set
+# CONFIG_USE_SCC_IO is not set
 
 #
 # Generic MPC8xx Options
 #
-CONFIG_8xx_COPYBACK=y
-# CONFIG_8xx_CPU6 is not set
+CONFIG_CPU_PPC_8xx_COPYBACK=y
+# CONFIG_CPU_PPC_8xx_CPU6 is not set
 
 #
 # USB support
--- arch/ppc/configs/TQM823L_defconfig	2001/03/26 09:10:19	1.1
+++ arch/ppc/configs/TQM823L_defconfig	2001/03/26 09:10:19
@@ -19,12 +19,12 @@
 # Platform support
 #
 CONFIG_PPC=y
-# CONFIG_6xx is not set
-# CONFIG_4xx is not set
+# CONFIG_CPU_PPC_6xx is not set
+# CONFIG_CPU_PPC_4xx is not set
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
-# CONFIG_8260 is not set
-CONFIG_8xx=y
+# CONFIG_CPU_PPC_8260 is not set
+CONFIG_CPU_PPC_88xx=y
 CONFIG_SERIAL_CONSOLE=y
 # CONFIG_RPXLITE is not set
 # CONFIG_RPXCLASSIC is not set
@@ -395,16 +395,16 @@
 # CONFIG_SCC3_ENET is not set
 # CONFIG_FEC_ENET is not set
 CONFIG_ENET_BIG_BUFFERS=y
-CONFIG_8xxSMC2=y
-CONFIG_8xx_ALTSMC2=y
+CONFIG_SMC2_UART=y
+CONFIG_ALTSMC2=y
 # CONFIG_8xx_CONS_SMC2 is not set
-# CONFIG_8xxSCC is not set
+# CONFIG_USE_SCC_IO is not set
 
 #
 # Generic MPC8xx Options
 #
-CONFIG_8xx_COPYBACK=y
-# CONFIG_8xx_CPU6 is not set
+CONFIG_CPU_PPC_8xx_COPYBACK=y
+# CONFIG_CPU_PPC_8xx_CPU6 is not set
 
 #
 # USB support
--- arch/ppc/configs/TQM850L_defconfig	2001/03/26 09:10:19	1.1
+++ arch/ppc/configs/TQM850L_defconfig	2001/03/26 09:10:19
@@ -19,12 +19,12 @@
 # Platform support
 #
 CONFIG_PPC=y
-# CONFIG_6xx is not set
-# CONFIG_4xx is not set
+# CONFIG_CPU_PPC_6xx is not set
+# CONFIG_CPU_PPC_4xx is not set
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
-# CONFIG_8260 is not set
-CONFIG_8xx=y
+# CONFIG_CPU_PPC_8260 is not set
+CONFIG_CPU_PPC_88xx=y
 CONFIG_SERIAL_CONSOLE=y
 # CONFIG_RPXLITE is not set
 # CONFIG_RPXCLASSIC is not set
@@ -395,16 +395,16 @@
 # CONFIG_SCC3_ENET is not set
 # CONFIG_FEC_ENET is not set
 CONFIG_ENET_BIG_BUFFERS=y
-CONFIG_8xxSMC2=y
-CONFIG_8xx_ALTSMC2=y
+CONFIG_SMC2_UART=y
+CONFIG_ALTSMC2=y
 # CONFIG_8xx_CONS_SMC2 is not set
-# CONFIG_8xxSCC is not set
+# CONFIG_USE_SCC_IO is not set
 
 #
 # Generic MPC8xx Options
 #
-CONFIG_8xx_COPYBACK=y
-CONFIG_8xx_CPU6=y
+CONFIG_CPU_PPC_8xx_COPYBACK=y
+CONFIG_CPU_PPC_8xx_CPU6=y
 
 #
 # USB support
--- arch/ppc/configs/TQM860L_defconfig	2001/03/26 09:10:19	1.1
+++ arch/ppc/configs/TQM860L_defconfig	2001/03/26 09:10:19
@@ -19,12 +19,12 @@
 # Platform support
 #
 CONFIG_PPC=y
-# CONFIG_6xx is not set
-# CONFIG_4xx is not set
+# CONFIG_CPU_PPC_6xx is not set
+# CONFIG_CPU_PPC_4xx is not set
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
-# CONFIG_8260 is not set
-CONFIG_8xx=y
+# CONFIG_CPU_PPC_8260 is not set
+CONFIG_CPU_PPC_88xx=y
 CONFIG_SERIAL_CONSOLE=y
 # CONFIG_RPXLITE is not set
 # CONFIG_RPXCLASSIC is not set
@@ -395,16 +395,16 @@
 # CONFIG_SCC3_ENET is not set
 # CONFIG_FEC_ENET is not set
 CONFIG_ENET_BIG_BUFFERS=y
-CONFIG_8xxSMC2=y
-# CONFIG_8xx_ALTSMC2 is not set
+CONFIG_SMC2_UART=y
+# CONFIG_ALTSMC2 is not set
 # CONFIG_8xx_CONS_SMC2 is not set
-# CONFIG_8xxSCC is not set
+# CONFIG_USE_SCC_IO is not set
 
 #
 # Generic MPC8xx Options
 #
-CONFIG_8xx_COPYBACK=y
-# CONFIG_8xx_CPU6 is not set
+CONFIG_CPU_PPC_8xx_COPYBACK=y
+# CONFIG_CPU_PPC_8xx_CPU6 is not set
 
 #
 # USB support
--- arch/ppc/configs/apus_defconfig	2001/03/26 09:10:14	1.1
+++ arch/ppc/configs/apus_defconfig	2001/03/26 09:10:14
@@ -17,12 +17,12 @@
 # Platform support
 #
 CONFIG_PPC=y
-CONFIG_6xx=y
-# CONFIG_4xx is not set
+CONFIG_CPU_PPC_6xx=y
+# CONFIG_CPU_PPC_4xx is not set
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
-# CONFIG_8xx is not set
-# CONFIG_8260 is not set
+# CONFIG_CPU_PPC_88xx is not set
+# CONFIG_CPU_PPC_8260 is not set
 # CONFIG_ALL_PPC is not set
 CONFIG_APUS=y
 CONFIG_PPC601_SYNC_FIX=y
--- arch/ppc/configs/bseip_defconfig	2001/03/26 09:10:15	1.1
+++ arch/ppc/configs/bseip_defconfig	2001/03/26 09:10:15
@@ -17,11 +17,11 @@
 # Platform support
 #
 CONFIG_PPC=y
-# CONFIG_6xx is not set
-# CONFIG_4xx is not set
+# CONFIG_CPU_PPC_6xx is not set
+# CONFIG_CPU_PPC_4xx is not set
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
-CONFIG_8xx=y
+CONFIG_CPU_PPC_88xx=y
 CONFIG_SERIAL_CONSOLE=y
 # CONFIG_RPXLITE is not set
 # CONFIG_RPXCLASSIC is not set
@@ -409,15 +409,15 @@
 CONFIG_SCC2_ENET=y
 # CONFIG_FEC_ENET is not set
 # CONFIG_ENET_BIG_BUFFERS is not set
-CONFIG_8xxSMC2=y
-# CONFIG_8xx_ALTSMC2 is not set
-# CONFIG_8xxSCC is not set
+CONFIG_SMC2_UART=y
+# CONFIG_ALTSMC2 is not set
+# CONFIG_USE_SCC_IO is not set
 
 #
 # Generic MPC8xx Options
 #
-CONFIG_8xx_COPYBACK=y
-# CONFIG_8xx_CPU6 is not set
+CONFIG_CPU_PPC_8xx_COPYBACK=y
+# CONFIG_CPU_PPC_8xx_CPU6 is not set
 
 #
 # USB support
--- arch/ppc/configs/common_defconfig	2001/03/26 09:10:15	1.1
+++ arch/ppc/configs/common_defconfig	2001/03/26 09:10:15
@@ -19,12 +19,12 @@
 # Platform support
 #
 CONFIG_PPC=y
-CONFIG_6xx=y
-# CONFIG_4xx is not set
+CONFIG_CPU_PPC_6xx=y
+# CONFIG_CPU_PPC_4xx is not set
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
-# CONFIG_8xx is not set
-# CONFIG_8260 is not set
+# CONFIG_CPU_PPC_88xx is not set
+# CONFIG_CPU_PPC_8260 is not set
 CONFIG_ALL_PPC=y
 # CONFIG_APUS is not set
 CONFIG_PPC601_SYNC_FIX=y
--- arch/ppc/configs/est8260_defconfig	2001/03/26 09:10:16	1.1
+++ arch/ppc/configs/est8260_defconfig	2001/03/26 09:10:16
@@ -17,12 +17,12 @@
 # Platform support
 #
 CONFIG_PPC=y
-CONFIG_6xx=y
-# CONFIG_4xx is not set
+CONFIG_CPU_PPC_6xx=y
+# CONFIG_CPU_PPC_4xx is not set
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
-# CONFIG_8xx is not set
-CONFIG_8260=y
+# CONFIG_CPU_PPC_88xx is not set
+CONFIG_CPU_PPC_8260=y
 CONFIG_SERIAL_CONSOLE=y
 CONFIG_EST8260=y
 CONFIG_PPC601_SYNC_FIX=y
--- arch/ppc/configs/ibmchrp_defconfig	2001/03/26 09:10:17	1.1
+++ arch/ppc/configs/ibmchrp_defconfig	2001/03/26 09:10:18
@@ -19,12 +19,12 @@
 # Platform support
 #
 CONFIG_PPC=y
-CONFIG_6xx=y
-# CONFIG_4xx is not set
+CONFIG_CPU_PPC_6xx=y
+# CONFIG_CPU_PPC_4xx is not set
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
-# CONFIG_8260 is not set
-# CONFIG_8xx is not set
+# CONFIG_CPU_PPC_8260 is not set
+# CONFIG_CPU_PPC_88xx is not set
 CONFIG_ALL_PPC=y
 # CONFIG_GEMINI is not set
 # CONFIG_APUS is not set
--- arch/ppc/configs/mbx_defconfig	2001/03/26 09:10:15	1.1
+++ arch/ppc/configs/mbx_defconfig	2001/03/26 09:10:15
@@ -17,11 +17,11 @@
 # Platform support
 #
 CONFIG_PPC=y
-# CONFIG_6xx is not set
-# CONFIG_4xx is not set
+# CONFIG_CPU_PPC_6xx is not set
+# CONFIG_CPU_PPC_4xx is not set
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
-CONFIG_8xx=y
+CONFIG_CPU_PPC_88xx=y
 CONFIG_SERIAL_CONSOLE=y
 # CONFIG_RPXLITE is not set
 # CONFIG_RPXCLASSIC is not set
@@ -401,15 +401,15 @@
 CONFIG_SCC1_ENET=y
 # CONFIG_FEC_ENET is not set
 CONFIG_ENET_BIG_BUFFERS=y
-CONFIG_8xxSMC2=y
-# CONFIG_8xx_ALTSMC2 is not set
-CONFIG_8xxSCC=y
+CONFIG_SMC2_UART=y
+# CONFIG_ALTSMC2 is not set
+CONFIG_USE_SCC_IO=y
 
 #
 # Generic MPC8xx Options
 #
-CONFIG_8xx_COPYBACK=y
-CONFIG_8xx_CPU6=y
+CONFIG_CPU_PPC_8xx_COPYBACK=y
+CONFIG_CPU_PPC_8xx_CPU6=y
 
 #
 # USB support
--- arch/ppc/configs/oak_defconfig	2001/03/26 09:10:16	1.1
+++ arch/ppc/configs/oak_defconfig	2001/03/26 09:10:16
@@ -19,11 +19,11 @@
 # Platform support
 #
 CONFIG_PPC=y
-# CONFIG_6xx is not set
-CONFIG_4xx=y
+# CONFIG_CPU_PPC_6xx is not set
+CONFIG_CPU_PPC_4xx=y
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
-# CONFIG_8xx is not set
+# CONFIG_CPU_PPC_88xx is not set
 CONFIG_OAK=y
 # CONFIG_WALNUT is not set
 CONFIG_PPC601_SYNC_FIX=y
--- arch/ppc/configs/power3_defconfig	2001/03/26 09:10:16	1.1
+++ arch/ppc/configs/power3_defconfig	2001/03/26 09:10:16
@@ -19,12 +19,12 @@
 # Platform support
 #
 CONFIG_PPC=y
-# CONFIG_6xx is not set
-# CONFIG_4xx is not set
+# CONFIG_CPU_PPC_6xx is not set
+# CONFIG_CPU_PPC_4xx is not set
 CONFIG_POWER3=y
 # CONFIG_POWER4 is not set
-# CONFIG_8xx is not set
-CONFIG_PPC64BRIDGE=y
+# CONFIG_CPU_PPC_88xx is not set
+CONFIG_PPC_64BRIDGE=y
 CONFIG_ALL_PPC=y
 CONFIG_SMP=y
 
--- arch/ppc/configs/rpxcllf_defconfig	2001/03/26 09:10:17	1.1
+++ arch/ppc/configs/rpxcllf_defconfig	2001/03/26 09:10:17
@@ -17,11 +17,11 @@
 # Platform support
 #
 CONFIG_PPC=y
-# CONFIG_6xx is not set
-# CONFIG_4xx is not set
+# CONFIG_CPU_PPC_6xx is not set
+# CONFIG_CPU_PPC_4xx is not set
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
-CONFIG_8xx=y
+CONFIG_CPU_PPC_88xx=y
 CONFIG_SERIAL_CONSOLE=y
 # CONFIG_RPXLITE is not set
 CONFIG_RPXCLASSIC=y
@@ -408,15 +408,15 @@
 CONFIG_SCC1_ENET=y
 CONFIG_FEC_ENET=y
 CONFIG_ENET_BIG_BUFFERS=y
-CONFIG_8xxSMC2=y
-# CONFIG_8xx_ALTSMC2 is not set
-CONFIG_8xxSCC=y
+CONFIG_SMC2_UART=y
+# CONFIG_ALTSMC2 is not set
+CONFIG_USE_SCC_IO=y
 
 #
 # Generic MPC8xx Options
 #
-CONFIG_8xx_COPYBACK=y
-# CONFIG_8xx_CPU6 is not set
+CONFIG_CPU_PPC_8xx_COPYBACK=y
+# CONFIG_CPU_PPC_8xx_CPU6 is not set
 
 #
 # USB support
--- arch/ppc/configs/rpxlite_defconfig	2001/03/26 09:10:17	1.1
+++ arch/ppc/configs/rpxlite_defconfig	2001/03/26 09:10:17
@@ -17,11 +17,11 @@
 # Platform support
 #
 CONFIG_PPC=y
-# CONFIG_6xx is not set
-# CONFIG_4xx is not set
+# CONFIG_CPU_PPC_6xx is not set
+# CONFIG_CPU_PPC_4xx is not set
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
-CONFIG_8xx=y
+CONFIG_CPU_PPC_88xx=y
 CONFIG_SERIAL_CONSOLE=y
 CONFIG_RPXLITE=y
 # CONFIG_RPXCLASSIC is not set
@@ -409,14 +409,14 @@
 CONFIG_SCC2_ENET=y
 # CONFIG_FEC_ENET is not set
 # CONFIG_ENET_BIG_BUFFERS is not set
-# CONFIG_8xxSMC2 is not set
-# CONFIG_8xxSCC is not set
+# CONFIG_SMC2_UART is not set
+# CONFIG_USE_SCC_IO is not set
 
 #
 # Generic MPC8xx Options
 #
-CONFIG_8xx_COPYBACK=y
-# CONFIG_8xx_CPU6 is not set
+CONFIG_CPU_PPC_8xx_COPYBACK=y
+# CONFIG_CPU_PPC_8xx_CPU6 is not set
 
 #
 # USB support
--- arch/ppc/configs/walnut_defconfig	2001/03/26 09:10:17	1.1
+++ arch/ppc/configs/walnut_defconfig	2001/03/26 09:10:17
@@ -19,11 +19,11 @@
 # Platform support
 #
 CONFIG_PPC=y
-# CONFIG_6xx is not set
-CONFIG_4xx=y
+# CONFIG_CPU_PPC_6xx is not set
+CONFIG_CPU_PPC_4xx=y
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
-# CONFIG_8xx is not set
+# CONFIG_CPU_PPC_88xx is not set
 # CONFIG_OAK is not set
 CONFIG_WALNUT=y
 CONFIG_PPC601_SYNC_FIX=y
--- arch/ppc/defconfig	2001/03/26 09:09:30	1.1
+++ arch/ppc/defconfig	2001/03/26 09:09:30
@@ -19,12 +19,12 @@
 # Platform support
 #
 CONFIG_PPC=y
-CONFIG_6xx=y
-# CONFIG_4xx is not set
+CONFIG_CPU_PPC_6xx=y
+# CONFIG_CPU_PPC_4xx is not set
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
-# CONFIG_8xx is not set
-# CONFIG_8260 is not set
+# CONFIG_CPU_PPC_88xx is not set
+# CONFIG_CPU_PPC_8260 is not set
 CONFIG_ALL_PPC=y
 # CONFIG_APUS is not set
 CONFIG_PPC601_SYNC_FIX=y
--- arch/ppc/kernel/Makefile	2001/03/26 09:09:32	1.1
+++ arch/ppc/kernel/Makefile	2001/03/26 09:09:32
@@ -7,7 +7,7 @@
 #
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
-ifdef CONFIG_PPC64BRIDGE
+ifdef CONFIG_PPC_64BRIDGE
 .S.o:
 	$(CC) $(CFLAGS) -D__ASSEMBLY__ -mppc64bridge -c $< -o $*.o
 else
@@ -15,10 +15,10 @@
 	$(CC) $(CFLAGS) -D__ASSEMBLY__ -c $< -o $*.o
 endif
 
-ifeq ($(CONFIG_4xx),y)
+ifeq ($(CONFIG_CPU_PPC_4xx),y)
   KHEAD := head_4xx.o
 else
-  ifeq ($(CONFIG_8xx),y)
+  ifeq ($(CONFIG_CPU_PPC_88xx),y)
     KHEAD := head_8xx.o
   else
     KHEAD := head.o
@@ -44,14 +44,14 @@
 obj-$(CONFIG_PPC_RTAS)		+= error_log.o proc_rtas.o
 obj-$(CONFIG_NVRAM)		+= pmac_nvram.o
 obj-$(CONFIG_PREP_RESIDUAL)	+= residual.o
-obj-$(CONFIG_4xx)		+= ppc4xx_pic.o
+obj-$(CONFIG_CPU_PPC_4xx)		+= ppc4xx_pic.o
 obj-$(CONFIG_OAK)		+= oak_setup.o
 obj-$(CONFIG_WALNUT)		+= walnut_setup.o
 ifeq ($(CONFIG_WALNUT),y)
 obj-$(CONFIG_PCI)		+= galaxy_pci.o
 endif
-obj-$(CONFIG_8xx)		+= m8xx_setup.o ppc8xx_pic.o
-ifeq ($(CONFIG_8xx),y)
+obj-$(CONFIG_CPU_PPC_88xx)		+= m8xx_setup.o ppc8xx_pic.o
+ifeq ($(CONFIG_CPU_PPC_88xx),y)
 obj-$(CONFIG_PCI)		+= qspan_pci.c
 else
 obj-$(CONFIG_PPC)		+= hashtable.o
@@ -65,7 +65,7 @@
 					indirect_pci.o i8259.o prep_pci.o \
 					prep_time.o prep_nvram.o prep_setup.o
 obj-$(CONFIG_PMAC_BACKLIGHT)	+= pmac_backlight.o
-obj-$(CONFIG_8260)		+= m8260_setup.o ppc8260_pic.o
+obj-$(CONFIG_CPU_PPC_8260)		+= m8260_setup.o ppc8260_pic.o
 
 
 include $(TOPDIR)/Rules.make
--- arch/ppc/kernel/align.c	2001/03/26 09:09:43	1.1
+++ arch/ppc/kernel/align.c	2001/03/26 09:09:43
@@ -21,7 +21,7 @@
 	unsigned char flags;
 };
 
-#if defined(CONFIG_4xx) || defined(CONFIG_POWER4)
+#if defined(CONFIG_CPU_PPC_4xx) || defined(CONFIG_POWER4)
 #define	OPCD(inst)	(((inst) & 0xFC000000) >> 26)
 #define	RS(inst)	(((inst) & 0x03E00000) >> 21)
 #define	RA(inst)	(((inst) & 0x001F0000) >> 16)
@@ -184,7 +184,7 @@
 fix_alignment(struct pt_regs *regs)
 {
 	int instr, nb, flags;
-#if defined(CONFIG_4xx) || defined(CONFIG_POWER4)
+#if defined(CONFIG_CPU_PPC_4xx) || defined(CONFIG_POWER4)
 	int opcode, f1, f2, f3;
 #endif
 	int i, t;
@@ -197,7 +197,7 @@
 		unsigned char v[8];
 	} data;
 
-#if defined(CONFIG_4xx) || defined(CONFIG_POWER4)
+#if defined(CONFIG_CPU_PPC_4xx) || defined(CONFIG_POWER4)
 	/* The 4xx-family processors have no DSISR register,
 	 * so we emulate it.
 	 * The POWER4 has a DSISR register but doesn't set it on
--- arch/ppc/kernel/chrp_pci.c	2001/03/26 09:09:35	1.1
+++ arch/ppc/kernel/chrp_pci.c	2001/03/26 09:09:35
@@ -507,7 +507,7 @@
 #endif /* CONFIG_POWER4 */
 }
 
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 #ifdef CONFIG_POWER4
 /*
  * Hack alert!!!
@@ -534,4 +534,4 @@
 	return offset;
 }
 #endif /* CONFIG_POWER4 */
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
--- arch/ppc/kernel/chrp_setup.c	2001/03/26 09:09:42	1.1
+++ arch/ppc/kernel/chrp_setup.c	2001/03/26 09:09:42
@@ -255,7 +255,7 @@
 	/* Lookup PCI host bridges */
 	chrp_find_bridges();
 
-#ifndef CONFIG_PPC64BRIDGE
+#ifndef CONFIG_PPC_64BRIDGE
 	/* PCI bridge config space access area -
 	 * appears to be not in devtree on longtrail. */
 	ioremap(GG2_PCI_CONFIG_BASE, 0x80000);
@@ -265,7 +265,7 @@
 	 */
 	hydra_init();		/* Mac I/O */
 
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 
 #ifndef CONFIG_POWER4
 	/* Some IBM machines don't have the hydra -- Cort */
--- arch/ppc/kernel/entry.S	2001/03/26 09:09:49	1.1
+++ arch/ppc/kernel/entry.S	2001/03/26 09:09:49
@@ -1,7 +1,7 @@
 /*
  *  arch/ppc/kernel/entry.S
  *
- *  $Id: entry.S,v 1.1 2001/03/26 09:09:49 esr Exp esr $
+ *  $Id: entry.S,v 1.4 1999/09/14 05:18:14 dmalek Exp $
  *
  *  PowerPC version 
  *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
@@ -237,11 +237,11 @@
 	tophys(r0,r4)
 	CLR_TOP32(r0)
 	mtspr	SPRG3,r0	/* Update current THREAD phys addr */
-#ifdef CONFIG_8xx
+#ifdef CONFIG_CPU_PPC_88xx
 	/* XXX it would be nice to find a SPRGx for this on 6xx,7xx too */
 	lwz	r9,PGDIR(r4)	/* cache the page table root */
         tophys(r9,r9)		/* convert to phys addr */
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	lis	r6, cpu6_errata_word@h
 	ori	r6, r6, cpu6_errata_word@l
 	li	r5, 0x3980
@@ -251,7 +251,7 @@
         mtspr   M_TWB,r9	/* Update MMU base address */
 	tlbia
 	sync
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_88xx */
 	lwz	r1,KSP(r4)	/* Load new stack pointer */
 	/* save the old current 'last' for return value */
 	mr	r3,r2
--- arch/ppc/kernel/hashtable.S	2001/03/26 09:09:55	1.1
+++ arch/ppc/kernel/hashtable.S	2001/03/26 09:09:55
@@ -1,7 +1,7 @@
 /*
  *  arch/ppc/kernel/hashtable.S
  *
- *  $Id: hashtable.S,v 1.1 2001/03/26 09:09:55 esr Exp esr $
+ *  $Id: hashtable.S,v 1.6 1999/10/08 01:56:15 paulus Exp $
  *
  *  PowerPC version 
  *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
@@ -53,7 +53,7 @@
 	
 	.globl	hash_page
 hash_page:
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 	mfmsr	r0
 	clrldi	r0,r0,1		/* make sure it's in 32-bit mode */
 	MTMSRD(r0)
@@ -159,7 +159,7 @@
 57:
 #endif
 
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 	/* Construct the high word of the PPC-style PTE */
 	mfsrin	r5,r3			/* get segment reg for segment */
 	rlwinm	r5,r5,0,5,31
@@ -307,7 +307,7 @@
 	std	r5,0(r3)	/* finally set V bit in PTE */
 #endif /* CONFIG_SMP */
 
-#else /* CONFIG_PPC64BRIDGE */
+#else /* CONFIG_PPC_64BRIDGE */
 
 	/* Construct the high word of the PPC-style PTE */
 	mfsrin	r5,r3			/* get segment reg for segment */
@@ -439,7 +439,7 @@
 	oris	r5,r5,0x8000
 	stw	r5,0(r3)	/* finally set V bit in PTE */
 #endif /* CONFIG_SMP */
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 
 	sync		/* make sure pte updates get to memory */
 
@@ -527,7 +527,7 @@
 #endif
 	blr
 99:
-#if defined(CONFIG_SMP) || defined(CONFIG_PPC64BRIDGE)
+#if defined(CONFIG_SMP) || defined(CONFIG_PPC_64BRIDGE)
 	/* Note - we had better not do anything which could generate
 	   a hash table miss while we have the hash table locked,
 	   or we'll get a deadlock.  -paulus */
@@ -549,7 +549,7 @@
 	bne-	10b
 	eieio
 #endif
-#ifndef CONFIG_PPC64BRIDGE
+#ifndef CONFIG_PPC_64BRIDGE
 	rlwinm	r3,r3,7,1,24		/* put VSID lower limit in position */
 	oris	r3,r3,0x8000		/* set V bit */
 	rlwinm	r4,r4,7,1,24		/* put VSID upper limit in position */
@@ -568,7 +568,7 @@
 	blt	2f			/* branch if out of range */
 	stw	r0,0(r5)		/* invalidate entry */
 2:	bdnz	1b			/* continue with loop */
-#else /* CONFIG_PPC64BRIDGE */
+#else /* CONFIG_PPC_64BRIDGE */
 	rldic	r3,r3,12,20		/* put VSID lower limit in position */
 	ori	r3,r3,1			/* set V bit */
 	rldic	r4,r4,12,20		/* put VSID upper limit in position */
@@ -586,7 +586,7 @@
 	blt	2f			/* branch if out of range */
 	std	r0,0(r5)		/* invalidate entry */
 2:	bdnz	1b			/* continue with loop */
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 
 	sync
 	tlbia
@@ -597,7 +597,7 @@
 	lis	r3,hash_table_lock@ha
 	stw	r0,hash_table_lock@l(r3)
 #endif
-#if defined(CONFIG_SMP) || defined(CONFIG_PPC64BRIDGE)
+#if defined(CONFIG_SMP) || defined(CONFIG_PPC_64BRIDGE)
 	mtmsr	r10
 	SYNC
 #endif
@@ -626,7 +626,7 @@
 #endif
 	blr
 99:
-#if defined(CONFIG_SMP) || defined(CONFIG_PPC64BRIDGE)
+#if defined(CONFIG_SMP) || defined(CONFIG_PPC_64BRIDGE)
 	/* Note - we had better not do anything which could generate
 	   a hash table miss while we have the hash table locked,
 	   or we'll get a deadlock.  -paulus */
@@ -652,7 +652,7 @@
 	b	11b
 12:	eieio
 #endif
-#ifndef CONFIG_PPC64BRIDGE
+#ifndef CONFIG_PPC_64BRIDGE
 	rlwinm	r3,r3,11,1,20		/* put context into vsid */
 	rlwimi	r3,r4,11,21,24		/* put top 4 bits of va into vsid */
 	oris	r3,r3,0x8000		/* set V (valid) bit */
@@ -682,7 +682,7 @@
 	bne	4f			/* if we didn't find it */
 3:	li	r0,0
 	stw	r0,0(r7)		/* invalidate entry */
-#else /* CONFIG_PPC64BRIDGE */
+#else /* CONFIG_PPC_64BRIDGE */
 	rldic	r3,r3,16,16		/* put context into vsid (<< 12) */
 	rlwimi	r3,r4,16,16,24		/* top 4 bits of va and API */
 	ori	r3,r3,1			/* set V (valid) bit */
@@ -712,7 +712,7 @@
 	bne	4f			/* if we didn't find it */
 3:	li	r0,0
 	std	r0,0(r7)		/* invalidate entry */
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 4:	sync
 	tlbie	r4			/* in hw tlb too */
 	sync
@@ -722,7 +722,7 @@
 	li	r0,0
 	stw	r0,0(r9)		/* clear hash_table_lock */
 #endif
-#if defined(CONFIG_SMP) || defined(CONFIG_PPC64BRIDGE)
+#if defined(CONFIG_SMP) || defined(CONFIG_PPC_64BRIDGE)
 	mtmsr	r10
 	SYNC
 #endif
--- arch/ppc/kernel/head.S	2001/03/26 09:09:34	1.1
+++ arch/ppc/kernel/head.S	2001/03/26 09:09:34
@@ -1,7 +1,7 @@
 /*
  *  arch/ppc/kernel/head.S
  *
- *  $Id: head.S,v 1.1 2001/03/26 09:09:34 esr Exp esr $
+ *  $Id: head.S,v 1.154 1999/10/12 00:33:31 cort Exp $
  *
  *  PowerPC version 
  *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
@@ -37,7 +37,7 @@
 #include <asm/amigappc.h>
 #endif
 
-#ifndef CONFIG_PPC64BRIDGE
+#ifndef CONFIG_PPC_64BRIDGE
 CACHELINE_BYTES = 32
 LG_CACHELINE_BYTES = 5
 CACHELINE_MASK = 0x1f
@@ -47,9 +47,9 @@
 LG_CACHELINE_BYTES = 7
 CACHELINE_MASK = 0x7f
 CACHELINE_WORDS = 32
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 #define LOAD_BAT(n, reg, RA, RB)	\
 	ld	RA,(n*32)+0(reg);	\
 	ld	RB,(n*32)+8(reg);	\
@@ -60,7 +60,7 @@
 	mtspr	DBAT##n##U,RA;		\
 	mtspr	DBAT##n##L,RB;		\
 	
-#else /* CONFIG_PPC64BRIDGE */
+#else /* CONFIG_PPC_64BRIDGE */
 	
 /* 601 only have IBAT; cr0.eq is set on 601 when using this macro */
 #define LOAD_BAT(n, reg, RA, RB)	\
@@ -78,7 +78,7 @@
 	mtspr	DBAT##n##U,RA;		\
 	mtspr	DBAT##n##L,RB;		\
 1:	
-#endif /* CONFIG_PPC64BRIDGE */	 
+#endif /* CONFIG_PPC_64BRIDGE */	 
 
 	.text
 	.globl	_stext
@@ -318,13 +318,13 @@
 
 /* Data access exception. */
 	. = 0x300
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 	b	DataAccess
 DataAccessCont:
 #else
 DataAccess:
 	EXCEPTION_PROLOG
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 	MOL_HOOK(0)
 	mfspr	r20,DSISR
 	andis.	r0,r20,0xa470		/* weird error? */
@@ -345,7 +345,7 @@
 	.long	do_page_fault
 	.long	ret_from_except
 
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 /* SLB fault on data access. */
 	. = 0x380
 	b	DataSegment
@@ -358,17 +358,17 @@
 	bl	transfer_to_handler
 	.long	UnknownException
 	.long	ret_from_except
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 
 /* Instruction access exception. */
 	. = 0x400
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 	b	InstructionAccess
 InstructionAccessCont:
 #else
 InstructionAccess:
 	EXCEPTION_PROLOG
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 	MOL_HOOK(1)
 	andis.	r0,r23,0x4000		/* no pte found? */
 	beq	1f			/* if so, try to put a PTE */
@@ -386,7 +386,7 @@
 	.long	do_page_fault
 	.long	ret_from_except
 
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 /* SLB fault on instruction access. */
 	. = 0x480
 	b	InstructionSegment
@@ -397,7 +397,7 @@
 	bl	transfer_to_handler
 	.long	UnknownException
 	.long	ret_from_except
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 
 /* External interrupt */
 	. = 0x500;
@@ -747,7 +747,7 @@
 	.long	ret_from_except
 #endif /* CONFIG_ALTIVEC */
 
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 DataAccess:
 	EXCEPTION_PROLOG
 	b	DataAccessCont
@@ -760,7 +760,7 @@
 InstructionSegment:
 	EXCEPTION_PROLOG
 	b	InstructionSegmentCont
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 
 /*
  * This code finishes saving the registers to the exception frame
@@ -840,9 +840,9 @@
 load_up_fpu:
 	mfmsr	r5
 	ori	r5,r5,MSR_FP
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 	clrldi	r5,r5,1			/* turn off 64-bit mode */
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 	SYNC
 	MTMSRD(r5)			/* enable use of fpu now */
 	isync
@@ -1289,7 +1289,7 @@
 
 	.globl	__secondary_start
 __secondary_start:
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 	mfmsr	r0
 	clrldi	r0,r0,1		/* make sure it's in 32-bit mode */
 	SYNC
@@ -1395,11 +1395,11 @@
 	tophys(r6,r6)
 	lwz	r6,_SDR1@l(r6)
 	mtspr	SDR1,r6
-#ifdef CONFIG_PPC64BRIDGE	
+#ifdef CONFIG_PPC_64BRIDGE	
 	/* clear the ASR so we only use the pseudo-segment registers. */
 	li	r6,0
 	mtasr	r6
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 	li	r0,16		/* load up segment register values */
 	mtctr	r0		/* for context 0 */
 	lis	r3,0x2000	/* Ku = 1, VSID = 0 */
@@ -1428,7 +1428,7 @@
  * This is where the main kernel code starts.
  */
 start_here:
-#ifndef CONFIG_PPC64BRIDGE
+#ifndef CONFIG_PPC_64BRIDGE
 	bl	enable_caches
 #endif
 
@@ -1517,9 +1517,9 @@
 	mtctr	r0
 	li	r4,0
 3:
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 	slbie	r4
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 	mtsrin	r3,r4
 	addi	r3,r3,1		/* next VSID */
 	addis	r4,r4,0x1000	/* address of next segment */
@@ -1588,7 +1588,7 @@
  */
 initial_bats:
 	lis	r11,KERNELBASE@h
-#ifndef CONFIG_PPC64BRIDGE
+#ifndef CONFIG_PPC_64BRIDGE
 	mfspr	r9,PVR
 	rlwinm	r9,r9,16,16,31		/* r9 = 1 for 601, 4 for 604 */
 	cmpi	0,r9,1
@@ -1603,7 +1603,7 @@
 	mtspr	IBAT1L,r10
 	isync
 	blr
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 
 4:	tophys(r8,r11)
 #ifdef CONFIG_SMP
@@ -1617,11 +1617,11 @@
 	ori	r11,r11,BL_256M<<2|0x2	/* set up BAT registers for 604 */
 #endif /* CONFIG_APUS */
 	
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 	/* clear out the high 32 bits in the BAT */
 	clrldi	r11,r11,32
 	clrldi	r8,r8,32
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 	mtspr	DBAT0L,r8		/* N.B. 6xx (not 601) have valid */
 	mtspr	DBAT0U,r11		/* bit in upper BAT register */
 	mtspr	IBAT0L,r8
@@ -1655,7 +1655,7 @@
 #endif /* !defined(CONFIG_APUS) && defined(CONFIG_BOOTX_TEXT) */
 #endif /* CONFIG_POWER4 */
 
-#ifdef CONFIG_8260
+#ifdef CONFIG_CPU_PPC_8260
 /* Jump into the system reset for the rom.
  * We first disable the MMU, and then jump to the ROM reset address.
  *
--- arch/ppc/kernel/head_4xx.S	2001/03/26 09:09:59	1.1
+++ arch/ppc/kernel/head_4xx.S	2001/03/26 09:09:59
@@ -43,7 +43,7 @@
 ### Check to make sure the right processor has been defined.
 ###
 
-#if !defined(CONFIG_4xx)
+#if !defined(CONFIG_CPU_PPC_4xx)
 #error "This file is only appropriate for kernels supporting the PPC4xx."
 #endif
 
--- arch/ppc/kernel/head_8xx.S	2001/03/26 09:09:57	1.1
+++ arch/ppc/kernel/head_8xx.S	2001/03/26 09:09:57
@@ -1,7 +1,7 @@
 /*
  *  arch/ppc/kernel/except_8xx.S
  *
- *  $Id: head_8xx.S,v 1.1 2001/03/26 09:09:57 esr Exp esr $
+ *  $Id: head_8xx.S,v 1.4 1999/09/18 18:43:19 dmalek Exp $
  *
  *  PowerPC version 
  *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
@@ -97,7 +97,7 @@
 	li	r8, 0
 	mtspr	MI_CTR, r8	/* Set instruction control to zero */
 	lis	r8, MD_RESETVAL@h
-#ifndef CONFIG_8xx_COPYBACK
+#ifndef CONFIG_CPU_PPC_8xx_COPYBACK
 	oris	r8, r8, MD_WTDEF@h
 #endif
 	mtspr	MD_CTR, r8	/* Set data TLB control */
@@ -146,7 +146,7 @@
 	mtspr	DC_CST, r8
 	lis	r8, IDC_ENABLE@h
 	mtspr	IC_CST, r8
-#ifdef CONFIG_8xx_COPYBACK
+#ifdef CONFIG_CPU_PPC_8xx_COPYBACK
 	mtspr	DC_CST, r8
 #else
 	/* For a debug option, I left this here to easily enable
@@ -366,7 +366,7 @@
  * only perform the attribute functions.
  */
 InstructionTLBMiss:
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	stw	r3, 8(r0)
 	li	r3, 0x3f80
 	stw	r3, 12(r0)
@@ -377,7 +377,7 @@
 	stw	r20, 0(r0)
 	stw	r21, 4(r0)
 	mfspr	r20, SRR0	/* Get effective address of fault */
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	li	r3, 0x3780
 	stw	r3, 12(r0)
 	lwz	r3, 12(r0)
@@ -403,13 +403,13 @@
 	 */
 	tophys(r21,r21)
 	ori	r21,r21,1		/* Set valid bit */
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	li	r3, 0x2b80
 	stw	r3, 12(r0)
 	lwz	r3, 12(r0)
 #endif
 	mtspr	MI_TWC, r21	/* Set page attributes */
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	li	r3, 0x3b80
 	stw	r3, 12(r0)
 	lwz	r3, 12(r0)
@@ -427,7 +427,7 @@
 	 */
 	li	r21, 0x00f0
 	rlwimi	r20, r21, 0, 24, 28
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	li	r3, 0x2d80
 	stw	r3, 12(r0)
 	lwz	r3, 12(r0)
@@ -438,7 +438,7 @@
 	lwz	r21, 0(r0)
 	mtcr	r21
 	lwz	r21, 4(r0)
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	lwz	r3, 8(r0)
 #endif
 	rfi
@@ -447,14 +447,14 @@
 	lwz	r21, 0(r0)
 	mtcr	r21
 	lwz	r21, 4(r0)
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	lwz	r3, 8(r0)
 #endif
 	b	InstructionAccess
 
 	. = 0x1200
 DataStoreTLBMiss:
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	stw	r3, 8(r0)
 	li	r3, 0x3f80
 	stw	r3, 12(r0)
@@ -483,7 +483,7 @@
 	 */
 	tophys(r21, r21)
 	ori	r21, r21, 1	/* Set valid bit in physical L2 page */
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	li	r3, 0x3b80
 	stw	r3, 12(r0)
 	lwz	r3, 12(r0)
@@ -499,7 +499,7 @@
 	 * above.
 	 */
 	rlwimi	r21, r20, 0, 27, 27
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	li	r3, 0x3b80
 	stw	r3, 12(r0)
 	lwz	r3, 12(r0)
@@ -515,7 +515,7 @@
 	li	r21, 0x00f0
 	rlwimi	r20, r21, 0, 24, 28
 #endif
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	li	r3, 0x3d80
 	stw	r3, 12(r0)
 	lwz	r3, 12(r0)
@@ -526,7 +526,7 @@
 	lwz	r21, 0(r0)
 	mtcr	r21
 	lwz	r21, 4(r0)
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	lwz	r3, 8(r0)
 #endif
 	rfi
@@ -535,7 +535,7 @@
 	lwz	r21, 0(r0)
 	mtcr	r21
 	lwz	r21, 4(r0)
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	lwz	r3, 8(r0)
 #endif
 	b	DataAccess
@@ -558,7 +558,7 @@
  */
 	. = 0x1400
 DataTLBError:
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	stw	r3, 8(r0)
 	li	r3, 0x3f80
 	stw	r3, 12(r0)
@@ -594,7 +594,7 @@
 	 */
 	tophys(r21, r21)
 	ori	r21, r21, 1		/* Set valid bit in physical L2 page */
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	li	r3, 0x3b80
 	stw	r3, 12(r0)
 	lwz	r3, 12(r0)
@@ -617,7 +617,7 @@
 	 */
 	li	r21, 0x00f0
 	rlwimi	r20, r21, 0, 24, 28
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	li	r3, 0x3d80
 	stw	r3, 12(r0)
 	lwz	r3, 12(r0)
@@ -628,7 +628,7 @@
 	lwz	r21, 0(r0)
 	mtcr	r21
 	lwz	r21, 4(r0)
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	lwz	r3, 8(r0)
 #endif
 	rfi
@@ -637,7 +637,7 @@
 	lwz	r21, 0(r0)
 	mtcr	r21
 	lwz	r21, 4(r0)
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	lwz	r3, 8(r0)
 #endif
 	b	DataAccess
@@ -874,7 +874,7 @@
 	lis	r6, swapper_pg_dir@h
 	tophys(r6,r6)
 	ori	r6, r6, swapper_pg_dir@l
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	lis	r4, cpu6_errata_word@h
 	ori	r4, r4, cpu6_errata_word@l
 	li	r3, 0x3980
@@ -947,7 +947,7 @@
  * ASID compare register with the new "context".
  */
 _GLOBAL(set_context)
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	lis	r6, cpu6_errata_word@h
 	ori	r6, r6, cpu6_errata_word@l
 	tophys	(r4, r4)
@@ -968,7 +968,7 @@
 	SYNC
 	blr
 
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 /* It's here because it is unique to the 8xx.
  * It is important we get called with interrupts disabled.  I used to
  * do that, but it appears that all code that calls this already had
@@ -1010,7 +1010,7 @@
 cmd_line:
 	.space	512
 
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	.globl	cpu6_errata_word
 cpu6_errata_word:
 	.space	16
--- arch/ppc/kernel/idle.c	2001/03/26 09:09:37	1.1
+++ arch/ppc/kernel/idle.c	2001/03/26 09:09:37
@@ -1,5 +1,5 @@
 /*
- * $Id: idle.c,v 1.1 2001/03/26 09:09:37 esr Exp esr $
+ * $Id: idle.c,v 1.68 1999/10/15 18:16:03 cort Exp $
  *
  * Idle daemon for PowerPC.  Idle daemon will handle any action
  * that needs to be taken when the system becomes idle.
@@ -99,7 +99,7 @@
 PTE *reclaim_ptr = 0;
 void inline htab_reclaim(void)
 {
-#ifndef CONFIG_8xx		
+#ifndef CONFIG_CPU_PPC_88xx		
 #if 0	
 	PTE *ptr, *start;
 	static int dir = 1;
@@ -149,7 +149,7 @@
 	}
 out:
 	if ( current->need_resched ) printk("need_resched: %lx\n", current->need_resched);
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_88xx */
 }
 
 #if 0
--- arch/ppc/kernel/irq.c	2001/03/26 09:09:36	1.1
+++ arch/ppc/kernel/irq.c	2001/03/26 09:09:36
@@ -1,5 +1,5 @@
 /*
- * $Id: irq.c,v 1.1 2001/03/26 09:09:36 esr Exp esr $
+ * $Id: irq.c,v 1.113 1999/09/17 17:22:56 cort Exp $
  *
  *  arch/ppc/kernel/irq.c
  *
@@ -24,7 +24,7 @@
  * mask register (of which only 16 are defined), hence the weird shifting
  * and compliment of the cached_irq_mask.  I want to be able to stuff
  * this right into the SIU SMASK register.
- * Many of the prep/chrp functions are conditional compiled on CONFIG_8xx
+ * Many of the prep/chrp functions are conditional compiled on CONFIG_CPU_PPC_88xx
  * to reduce code space and undefined function references.
  */
 
@@ -218,7 +218,7 @@
 	return -ENOENT;
 }
 
-#if (defined(CONFIG_8xx) || defined(CONFIG_8260))
+#if (defined(CONFIG_CPU_PPC_88xx) || defined(CONFIG_CPU_PPC_8260))
 /* Name change so we can catch standard drivers that potentially mess up
  * the internal interrupt controller on 8xx and 8260.  Just bear with me,
  * I don't like this either and I am searching a better solution.  For
--- arch/ppc/kernel/misc.S	2001/03/26 09:09:35	1.1
+++ arch/ppc/kernel/misc.S	2001/03/26 09:09:35
@@ -21,11 +21,11 @@
 #include <asm/cache.h>
 #include "ppc_asm.h"
 
-#if defined(CONFIG_4xx) || defined(CONFIG_8xx)
+#if defined(CONFIG_CPU_PPC_4xx) || defined(CONFIG_CPU_PPC_88xx)
 #define CACHE_LINE_SIZE		16
 #define LG_CACHE_LINE_SIZE	4
 #define MAX_COPY_PREFETCH	1
-#elif !defined(CONFIG_PPC64BRIDGE)
+#elif !defined(CONFIG_PPC_64BRIDGE)
 #define CACHE_LINE_SIZE		32
 #define LG_CACHE_LINE_SIZE	5
 #define MAX_COPY_PREFETCH	4
@@ -33,7 +33,7 @@
 #define CACHE_LINE_SIZE		128
 #define LG_CACHE_LINE_SIZE	7
 #define MAX_COPY_PREFETCH	1
-#endif /* CONFIG_4xx || CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_4xx || CONFIG_CPU_PPC_88xx */
 
 	.text
 
@@ -222,7 +222,7 @@
  * This is a no-op on the 601.
  */
 _GLOBAL(flush_instruction_cache)
-#ifdef CONFIG_8xx
+#ifdef CONFIG_CPU_PPC_88xx
 	isync
 	lis	r5, IDC_INVALL@h
 	mtspr	IC_CST, r5
@@ -235,7 +235,7 @@
 	mfspr	r3,HID0
 	ori	r3,r3,HID0_ICFI
 	mtspr	HID0,r3
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_88xx */
 	isync
 	blr
 
@@ -349,7 +349,7 @@
 _GLOBAL(clear_page)
 	li	r0,4096/CACHE_LINE_SIZE
 	mtctr	r0
-#ifdef CONFIG_8xx
+#ifdef CONFIG_CPU_PPC_88xx
 	li	r4, 0
 1:	stw	r4, 0(r3)
 	stw	r4, 4(r3)
@@ -383,7 +383,7 @@
 	addi	r4,r4,-4
 	li	r5,4
 
-#ifndef CONFIG_8xx
+#ifndef CONFIG_CPU_PPC_88xx
 #if MAX_COPY_PREFETCH > 1
 	li	r0,MAX_COPY_PREFETCH
 	li	r11,4
@@ -395,12 +395,12 @@
 	dcbt	r5,r4
 	li	r11,CACHE_LINE_SIZE+4
 #endif /* MAX_COPY_PREFETCH */
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_88xx */
 
 	li	r0,4096/CACHE_LINE_SIZE
 	mtctr	r0
 1:
-#ifndef CONFIG_8xx
+#ifndef CONFIG_CPU_PPC_88xx
 	dcbt	r11,r4
 	dcbz	r5,r3
 #endif
@@ -755,7 +755,7 @@
 	mfspr	r3,PVR
 	blr
 
-#ifdef CONFIG_8xx
+#ifdef CONFIG_CPU_PPC_88xx
 _GLOBAL(_get_IMMR)
 	mfspr	r3, 638
 	blr
@@ -1005,7 +1005,7 @@
  * and exceptions as if the cpu had performed the load or store.
  */
 
-#if defined(CONFIG_4xx)
+#if defined(CONFIG_CPU_PPC_4xx)
 _GLOBAL(cvt_fd)
 	lfs	0,0(r3)
 	stfd	0,0(r4)
--- arch/ppc/kernel/ppc-stub.c	2001/03/26 09:09:51	1.1
+++ arch/ppc/kernel/ppc-stub.c	2001/03/26 09:09:51
@@ -1,4 +1,4 @@
-/* $Id: ppc-stub.c,v 1.1 2001/03/26 09:09:51 esr Exp esr $
+/* $Id: ppc-stub.c,v 1.6 1999/08/12 22:18:11 cort Exp $
  * ppc-stub.c:  KGDB support for the Linux kernel.
  *
  * adapted from arch/sparc/kernel/sparc-stub.c for the PowerPC
@@ -749,7 +749,7 @@
         return 1;
  }
 
-#ifndef CONFIG_8xx
+#ifndef CONFIG_CPU_PPC_88xx
 
 /* I don't know why other platforms don't need this.  The function for
  * the 8xx is found in arch/ppc/8xx_io/uart.c.  -- Dan
--- arch/ppc/kernel/ppc_asm.h	2001/03/26 09:09:44	1.1
+++ arch/ppc/kernel/ppc_asm.h	2001/03/26 09:09:44
@@ -81,7 +81,7 @@
  * and they must be used.
  */
 
-#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
+#if !defined(CONFIG_CPU_PPC_4xx) && !defined(CONFIG_CPU_PPC_88xx)
 #define tlbia					\
 	li	r4,1024;			\
 	mtctr	r4;				\
@@ -114,7 +114,7 @@
  * we then have to make sure we preserve the top 32 bits except for
  * the 64-bit mode bit, which we clear.
  */
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 #define	FIX_SRR1(ra, rb)	\
 	mr	rb,ra;		\
 	mfmsr	ra;		\
@@ -129,4 +129,4 @@
 #define	RFI		rfi
 #define MTMSRD(r)	mtmsr	r
 #define CLR_TOP32(r)
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
--- arch/ppc/kernel/ppc_htab.c	2001/03/26 09:09:46	1.1
+++ arch/ppc/kernel/ppc_htab.c	2001/03/26 09:09:46
@@ -1,5 +1,5 @@
 /*
- * $Id: ppc_htab.c,v 1.1 2001/03/26 09:09:46 esr Exp esr $
+ * $Id: ppc_htab.c,v 1.29 1999/09/10 05:05:50 paulus Exp $
  *
  * PowerPC hash table management proc entry.  Will show information
  * about the current hash table and will allow changes to it.
@@ -235,7 +235,7 @@
 static ssize_t ppc_htab_write(struct file * file, const char * buffer,
 			      size_t count, loff_t *ppos)
 {
-#ifndef CONFIG_8xx
+#ifndef CONFIG_CPU_PPC_88xx
 	unsigned long tmp;
 	if ( current->uid != 0 )
 		return -EACCES;
@@ -472,9 +472,9 @@
 	reset_SDR1();
 #endif	
 	return count;
-#else /* CONFIG_8xx */
+#else /* CONFIG_CPU_PPC_88xx */
 	return 0;
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_88xx */
 }
 
 
--- arch/ppc/kernel/ppc_ksyms.c	2001/03/26 09:09:48	1.1
+++ arch/ppc/kernel/ppc_ksyms.c	2001/03/26 09:09:48
@@ -46,7 +46,7 @@
 #endif /* CONFIG_SMP */
 #include <asm/time.h>
 
-#ifdef  CONFIG_8xx
+#ifdef  CONFIG_CPU_PPC_88xx
 #include "../8xx_io/commproc.h"
 #endif
 
@@ -92,7 +92,7 @@
 EXPORT_SYMBOL(kernel_flag);
 #endif /* CONFIG_SMP */
 
-#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
+#if !defined(CONFIG_CPU_PPC_4xx) && !defined(CONFIG_CPU_PPC_88xx)
 EXPORT_SYMBOL_NOVERS(isa_io_base);
 EXPORT_SYMBOL_NOVERS(isa_mem_base);
 EXPORT_SYMBOL_NOVERS(pci_dram_offset);
@@ -100,7 +100,7 @@
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
 EXPORT_SYMBOL_NOVERS(DMA_MODE_READ);
 EXPORT_SYMBOL(DMA_MODE_WRITE);
-#ifndef CONFIG_8xx
+#ifndef CONFIG_CPU_PPC_88xx
 #if defined(CONFIG_ALL_PPC)
 EXPORT_SYMBOL(_prep_type);
 EXPORT_SYMBOL(ucSystemType);
@@ -351,11 +351,11 @@
 EXPORT_SYMBOL(debugger_fault_handler);
 #endif
 
-#ifdef  CONFIG_8xx
+#ifdef  CONFIG_CPU_PPC_88xx
 EXPORT_SYMBOL(request_8xxirq);
 EXPORT_SYMBOL(cpm_install_handler);
 EXPORT_SYMBOL(cpm_free_handler);
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_88xx */
 
 EXPORT_SYMBOL(ret_to_user_hook);
 EXPORT_SYMBOL(do_softirq);
@@ -363,7 +363,7 @@
 EXPORT_SYMBOL(set_context);
 EXPORT_SYMBOL(mmu_context_overflow);
 EXPORT_SYMBOL_NOVERS(disarm_decr);
-#if !defined(CONFIG_8xx) && !defined(CONFIG_4xx)
+#if !defined(CONFIG_CPU_PPC_88xx) && !defined(CONFIG_CPU_PPC_4xx)
 extern long *intercept_table;
 EXPORT_SYMBOL(intercept_table);
 #endif
--- arch/ppc/kernel/prom.c	2001/03/26 09:09:41	1.1
+++ arch/ppc/kernel/prom.c	2001/03/26 09:09:41
@@ -1,5 +1,5 @@
 /*
- * $Id: prom.c,v 1.1 2001/03/26 09:09:41 esr Exp esr $
+ * $Id: prom.c,v 1.79 1999/10/08 01:56:32 paulus Exp $
  *
  * Procedures for interfacing to the Open Firmware PROM on
  * Power Macintosh computers.
@@ -485,7 +485,7 @@
 #endif
 }
 
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 /*
  * Set up a hash table with a set of entries in it to map the
  * first 64MB of RAM.  This is used on 64-bit machines since
@@ -550,7 +550,7 @@
 		make_pte(htab, hsize, addr + KERNELBASE, addr,
 			 _PAGE_ACCESSED | _PAGE_COHERENT | PP_RWXX);
 }
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 
 static __init void
 prom_instantiate_rtas(void)
@@ -701,7 +701,7 @@
 
 	prom_instantiate_rtas();
 
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 	/*
 	 * Find out how much memory we have and allocate a
 	 * suitably-sized hash table.
--- arch/ppc/kernel/setup.c	2001/03/26 09:09:44	1.1
+++ arch/ppc/kernel/setup.c	2001/03/26 09:09:44
@@ -1,5 +1,5 @@
 /*
- * $Id: setup.c,v 1.1 2001/03/26 09:09:44 esr Exp esr $
+ * $Id: setup.c,v 1.160 1999/10/08 01:56:38 paulus Exp $
  * Common prep/pmac/chrp boot and setup code.
  */
 
@@ -26,11 +26,11 @@
 #include <asm/amigappc.h>
 #include <asm/smp.h>
 #include <asm/elf.h>
-#ifdef CONFIG_8xx
+#ifdef CONFIG_CPU_PPC_88xx
 #include <asm/mpc8xx.h>
 #include <asm/8xx_immap.h>
 #endif
-#ifdef CONFIG_8260
+#ifdef CONFIG_CPU_PPC_8260
 #include <asm/mpc8260.h>
 #include <asm/immap_8260.h>
 #endif
@@ -124,7 +124,7 @@
  * Maybe tie it to serial consoles, since this is really what
  * these processors use on existing boards.  -- Dan
  */ 
-#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx) && !defined(CONFIG_8260)
+#if !defined(CONFIG_CPU_PPC_4xx) && !defined(CONFIG_CPU_PPC_88xx) && !defined(CONFIG_CPU_PPC_8260)
 struct screen_info screen_info = {
 	0, 25,			/* orig-x, orig-y */
 	0,			/* unused */
@@ -148,7 +148,7 @@
 {
 }
 
-#else /* CONFIG_4xx || CONFIG_8xx */
+#else /* CONFIG_CPU_PPC_4xx || CONFIG_CPU_PPC_88xx */
 
 /* We need this to satisfy some external references until we can
  * strip the kernel down.
@@ -164,7 +164,7 @@
 	0,			/* orig-video-isVGA */
 	16			/* orig-video-points */
 };
-#endif /* !CONFIG_4xx && !CONFIG_8xx */
+#endif /* !CONFIG_CPU_PPC_4xx && !CONFIG_CPU_PPC_88xx */
 
 void machine_restart(char *cmd)
 {
@@ -327,7 +327,7 @@
 		 * Assume here that all clock rates are the same in a
 		 * smp system.  -- Cort
 		 */
-#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx) && !defined(CONFIG_8260)
+#if !defined(CONFIG_CPU_PPC_4xx) && !defined(CONFIG_CPU_PPC_88xx) && !defined(CONFIG_CPU_PPC_8260)
 		if ( have_of )
 		{
 			struct device_node *cpu_node;
@@ -351,7 +351,7 @@
 			len += sprintf(len+buffer, "clock\t\t: %dMHz\n",
 				       *fp / 1000000);
 		}
-#endif /* !CONFIG_4xx && !CONFIG_8xx */
+#endif /* !CONFIG_CPU_PPC_4xx && !CONFIG_CPU_PPC_88xx */
 
 		if (ppc_md.setup_residual != NULL)
 		{
@@ -448,7 +448,7 @@
 
 	if ( ppc_md.progress ) ppc_md.progress("id mach(): start", 0x100);
 	
-#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx) && !defined(CONFIG_8260)
+#if !defined(CONFIG_CPU_PPC_4xx) && !defined(CONFIG_CPU_PPC_88xx) && !defined(CONFIG_CPU_PPC_8260)
 #ifndef CONFIG_MACH_SPECIFIC
 	/* if we didn't get any bootinfo telling us what we are... */
 	if ( _machine == 0 )
@@ -559,16 +559,16 @@
 		__map_without_bats = 1;
 	}
 #else
-#if defined(CONFIG_4xx)
+#if defined(CONFIG_CPU_PPC_4xx)
 	oak_init(r3, r4, r5, r6, r7);
-#elif defined(CONFIG_8xx)
+#elif defined(CONFIG_CPU_PPC_88xx)
         m8xx_init(r3, r4, r5, r6, r7);
-#elif defined(CONFIG_8260)
+#elif defined(CONFIG_CPU_PPC_8260)
         m8260_init(r3, r4, r5, r6, r7);
 #else
 #error "No board type has been defined for identify_machine()!"
-#endif /* CONFIG_4xx */
-#endif /* !CONFIG_4xx && !CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_4xx */
+#endif /* !CONFIG_CPU_PPC_4xx && !CONFIG_CPU_PPC_88xx */
 
 	/* Look for mem= option on command line */
 	if (strstr(cmd_line, "mem=")) {
--- arch/ppc/kernel/traps.c	2001/03/26 09:09:37	1.1
+++ arch/ppc/kernel/traps.c	2001/03/26 09:09:37
@@ -112,7 +112,7 @@
 		return;
 	}
 
-#if defined(CONFIG_8xx) && defined(CONFIG_PCI)
+#if defined(CONFIG_CPU_PPC_88xx) && defined(CONFIG_PCI)
 	/* the qspan pci read routines can cause machine checks -- Cort */
 	bad_page_fault(regs, regs->dar, SIGBUS);
 	return;
@@ -254,7 +254,7 @@
 void
 ProgramCheckException(struct pt_regs *regs)
 {
-#if defined(CONFIG_4xx)
+#if defined(CONFIG_CPU_PPC_4xx)
 	unsigned int esr = mfspr(SPRN_ESR);
 
 	if (esr & ESR_PTR) {
@@ -343,7 +343,7 @@
 	       regs->ccr&0x10000000?"Error=":"", regs->gpr[3]);
 }
 
-#ifdef CONFIG_8xx
+#ifdef CONFIG_CPU_PPC_88xx
 void
 SoftwareEmulation(struct pt_regs *regs)
 {
--- arch/ppc/lib/string.S	2001/03/26 09:10:03	1.1
+++ arch/ppc/lib/string.S	2001/03/26 09:10:03
@@ -13,11 +13,11 @@
 #include <asm/processor.h>
 #include <asm/errno.h>
 
-#if defined(CONFIG_4xx) || defined(CONFIG_8xx)
+#if defined(CONFIG_CPU_PPC_4xx) || defined(CONFIG_CPU_PPC_88xx)
 #define CACHE_LINE_SIZE		16
 #define LG_CACHE_LINE_SIZE	4
 #define MAX_COPY_PREFETCH	1
-#elif !defined(CONFIG_PPC64BRIDGE)
+#elif !defined(CONFIG_PPC_64BRIDGE)
 #define CACHE_LINE_SIZE		32
 #define LG_CACHE_LINE_SIZE	5
 #define MAX_COPY_PREFETCH	4
@@ -25,7 +25,7 @@
 #define CACHE_LINE_SIZE		128
 #define LG_CACHE_LINE_SIZE	7
 #define MAX_COPY_PREFETCH	1
-#endif /* CONFIG_4xx || CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_4xx || CONFIG_CPU_PPC_88xx */
 
 #define COPY_16_BYTES		\
 	lwz	r7,4(r4);	\
@@ -166,7 +166,7 @@
 	bdnz	4b
 3:	mtctr	r9
 	li	r7,4
-#if !defined(CONFIG_8xx)
+#if !defined(CONFIG_CPU_PPC_88xx)
 10:	dcbz	r7,r6
 #else
 10:	stw	r4, 4(r6)
@@ -271,7 +271,7 @@
 	mtctr	r0
 	beq	63f
 53:
-#if !defined(CONFIG_8xx)
+#if !defined(CONFIG_CPU_PPC_88xx)
 	dcbz	r11,r6
 #endif
 	COPY_16_BYTES
@@ -451,7 +451,7 @@
 	li	r11,4
 	beq	63f
 
-#if !defined(CONFIG_8xx)
+#if !defined(CONFIG_CPU_PPC_88xx)
 	/* Here we decide how far ahead to prefetch the source */
 #if MAX_COPY_PREFETCH > 1
 	/* Heuristically, for large transfers we prefetch
@@ -470,11 +470,11 @@
 	li	r3,CACHELINE_BYTES + 4
 	dcbt	r11,r4
 #endif /* MAX_COPY_PREFETCH */
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_88xx */
 
 	mtctr	r0
 53:
-#if !defined(CONFIG_8xx)
+#if !defined(CONFIG_CPU_PPC_88xx)
 	dcbt	r3,r4
 	dcbz	r11,r6
 #endif
--- arch/ppc/mbxboot/Makefile	2001/03/26 09:10:26	1.1
+++ arch/ppc/mbxboot/Makefile	2001/03/26 09:10:26
@@ -27,13 +27,13 @@
 
 TFTPIMAGE=/tftpboot/zImage.embedded
 
-ifdef CONFIG_8xx
+ifdef CONFIG_CPU_PPC_88xx
 ZLINKFLAGS = -T ../vmlinux.lds -Ttext 0x00180000
 OBJECTS := head.o misc.o ../coffboot/zlib.o m8xx_tty.o
 CFLAGS = $(CPPFLAGS) -O2 -DSTDC_HEADERS -fno-builtin -DCONFIG_8xx
 endif
 
-ifdef CONFIG_8260
+ifdef CONFIG_CPU_PPC_8260
 ZLINKFLAGS = -T ../vmlinux.lds -Ttext 0x00400000
 OBJECTS := head_8260.o misc.o ../coffboot/zlib.o m8260_tty.o embed_config.o
 CFLAGS = $(CPPFLAGS) -O2 -DSTDC_HEADERS -fno-builtin -DCONFIG_8260
--- arch/ppc/mbxboot/embed_config.c	2001/03/26 09:10:27	1.1
+++ arch/ppc/mbxboot/embed_config.c	2001/03/26 09:10:27
@@ -4,10 +4,10 @@
  */
 #include <sys/types.h>
 #include <linux/config.h>
-#ifdef CONFIG_8xx
+#ifdef CONFIG_CPU_PPC_88xx
 #include <asm/mpc8xx.h>
 #endif
-#ifdef CONFIG_8260
+#ifdef CONFIG_CPU_PPC_8260
 #include <asm/mpc8260.h>
 #endif
 
--- arch/ppc/mbxboot/misc.c	2001/03/26 09:10:27	1.1
+++ arch/ppc/mbxboot/misc.c	2001/03/26 09:10:27
@@ -1,7 +1,7 @@
 /*
  * misc.c
  *
- * $Id: misc.c,v 1.1 2001/03/26 09:10:27 esr Exp esr $
+ * $Id: misc.c,v 1.2 1999/09/14 05:55:29 dmalek Exp $
  * 
  * Adapted for PowerPC by Gary Thomas
  *
@@ -17,10 +17,10 @@
 #include <asm/page.h>
 #include <asm/processor.h>
 #include <asm/mmu.h>
-#ifdef CONFIG_8xx
+#ifdef CONFIG_CPU_PPC_88xx
 #include <asm/mpc8xx.h>
 #endif
-#ifdef CONFIG_8260
+#ifdef CONFIG_CPU_PPC_8260
 #include <asm/mpc8260.h>
 #endif
 
@@ -245,7 +245,7 @@
 	unsigned long i;
 	char	*dp;
 
-#ifdef CONFIG_8260
+#ifdef CONFIG_CPU_PPC_8260
 	/* I don't know why I didn't do it this way on the 8xx.......
 	*/
 	embed_config(bp);
--- arch/ppc/mm/Makefile	2001/03/26 09:09:30	1.1
+++ arch/ppc/mm/Makefile	2001/03/26 09:09:30
@@ -10,6 +10,6 @@
 O_TARGET		:= mm.o
 obj-y			:= fault.o init.o mem_pieces.o extable.o
 
-obj-$(CONFIG_4xx)	+= 4xx_tlb.o
+obj-$(CONFIG_CPU_PPC_4xx)	+= 4xx_tlb.o
 
 include $(TOPDIR)/Rules.make
--- arch/ppc/mm/fault.c	2001/03/26 09:09:31	1.1
+++ arch/ppc/mm/fault.c	2001/03/26 09:09:31
@@ -64,7 +64,7 @@
 	struct mm_struct *mm = current->mm;
 	siginfo_t info;
 	int code = SEGV_MAPERR;
-#if defined(CONFIG_4xx)
+#if defined(CONFIG_CPU_PPC_4xx)
 	int is_write = error_code & ESR_DST;
 #else
 	int is_write = 0;
@@ -79,20 +79,20 @@
 		error_code &= 0x48200000;
 	else
 		is_write = error_code & 0x02000000;
-#endif /* CONFIG_4xx */
+#endif /* CONFIG_CPU_PPC_4xx */
 
 #if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
 	if (debugger_fault_handler && regs->trap == 0x300) {
 		debugger_fault_handler(regs);
 		return;
 	}
-#if !defined(CONFIG_4xx)
+#if !defined(CONFIG_CPU_PPC_4xx)
 	if (error_code & 0x00400000) {
 		/* DABR match */
 		if (debugger_dabr_match(regs))
 			return;
 	}
-#endif /* !CONFIG_4xx */
+#endif /* !CONFIG_CPU_PPC_4xx */
 #endif /* CONFIG_XMON || CONFIG_KGDB */
 
 	if (in_interrupt() || mm == NULL) {
@@ -112,13 +112,13 @@
 
 good_area:
 	code = SEGV_ACCERR;
-#if defined(CONFIG_6xx)
+#if defined(CONFIG_CPU_PPC_6xx)
 	if (error_code & 0x95700000)
 		/* an error such as lwarx to I/O controller space,
 		   address matching DABR, eciwx, etc. */
 		goto bad_area;
-#endif /* CONFIG_6xx */
-#if defined(CONFIG_8xx)
+#endif /* CONFIG_CPU_PPC_6xx */
+#if defined(CONFIG_CPU_PPC_88xx)
         /* The MPC8xx seems to always set 0x80000000, which is
          * "undefined".  Of those that can be set, this is the only
          * one which seems bad.
@@ -126,7 +126,7 @@
 	if (error_code & 0x10000000)
                 /* Guarded storage error. */
 		goto bad_area;
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_88xx */
 	
 	/* a write */
 	if (is_write) {
@@ -234,7 +234,7 @@
 	die("kernel access of bad area", regs, sig);
 }
 
-#ifdef CONFIG_8xx
+#ifdef CONFIG_CPU_PPC_88xx
 
 /* The pgtable.h claims some functions generically exist, but I
  * can't find them......
@@ -341,7 +341,7 @@
         }
         return(retval);
 }
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_88xx */
 
 #if 0
 /*
--- arch/ppc/mm/init.c	2001/03/26 09:09:32	1.1
+++ arch/ppc/mm/init.c	2001/03/26 09:09:32
@@ -1,5 +1,5 @@
 /*
- *  $Id: init.c,v 1.1 2001/03/26 09:09:32 esr Exp esr $
+ *  $Id: init.c,v 1.195 1999/10/15 16:39:39 cort Exp $
  *
  *  PowerPC version 
  *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
@@ -48,11 +48,11 @@
 #include <asm/mmu.h>
 #include <asm/residual.h>
 #include <asm/uaccess.h>
-#ifdef CONFIG_8xx
+#ifdef CONFIG_CPU_PPC_88xx
 #include <asm/8xx_immap.h>
 #include <asm/mpc8xx.h>
 #endif
-#ifdef CONFIG_8260
+#ifdef CONFIG_CPU_PPC_8260
 #include <asm/immap_8260.h>
 #include <asm/mpc8260.h>
 #endif
@@ -64,7 +64,7 @@
 
 #include "mem_pieces.h"
 
-#if defined(CONFIG_4xx)
+#if defined(CONFIG_CPU_PPC_4xx)
 #include "4xx_tlb.h"
 #endif
 
@@ -115,15 +115,15 @@
 unsigned long pmac_find_end_of_memory(void);
 unsigned long apus_find_end_of_memory(void);
 extern unsigned long find_end_of_memory(void);
-#ifdef CONFIG_8xx
+#ifdef CONFIG_CPU_PPC_88xx
 unsigned long m8xx_find_end_of_memory(void);
-#endif /* CONFIG_8xx */
-#ifdef CONFIG_4xx
+#endif /* CONFIG_CPU_PPC_88xx */
+#ifdef CONFIG_CPU_PPC_4xx
 unsigned long oak_find_end_of_memory(void);
 #endif
-#ifdef CONFIG_8260
+#ifdef CONFIG_CPU_PPC_8260
 unsigned long m8260_find_end_of_memory(void);
-#endif /* CONFIG_8260 */
+#endif /* CONFIG_CPU_PPC_8260 */
 static void mapin_ram(void);
 int map_page(unsigned long va, unsigned long pa, int flags);
 void set_phys_avail(unsigned long total_ram);
@@ -138,13 +138,13 @@
 
 PTE *Hash, *Hash_end;
 unsigned long Hash_size, Hash_mask;
-#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
+#if !defined(CONFIG_CPU_PPC_4xx) && !defined(CONFIG_CPU_PPC_88xx)
 unsigned long _SDR1;
 static void hash_init(void);
 
 union ubat {			/* BAT register values to be loaded */
 	BAT	bat;
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 	u64	word[2];
 #else
 	u32	word[2];
@@ -183,10 +183,10 @@
 	return 0;
 }
 
-#else /* CONFIG_4xx || CONFIG_8xx */
+#else /* CONFIG_CPU_PPC_4xx || CONFIG_CPU_PPC_88xx */
 #define v_mapped_by_bats(x)	(0UL)
 #define p_mapped_by_bats(x)	(0UL)
-#endif /* !CONFIG_4xx && !CONFIG_8xx */
+#endif /* !CONFIG_CPU_PPC_4xx && !CONFIG_CPU_PPC_88xx */
 
 /*
  * this tells the system to map all of ram with the segregs
@@ -500,7 +500,7 @@
 	return 0;
 }
 
-#ifndef CONFIG_8xx
+#ifndef CONFIG_CPU_PPC_88xx
 /*
  * TLB flushing:
  *
@@ -521,7 +521,7 @@
 void
 local_flush_tlb_all(void)
 {
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 	/* XXX this assumes that the vmalloc arena starts no lower than
 	 * 0xd0000000 on 64-bit machines. */
 	flush_hash_segments(0xd, 0xffffff);
@@ -533,7 +533,7 @@
 #ifdef CONFIG_SMP
 	smp_send_tlb_invalidate(0);
 #endif /* CONFIG_SMP */
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 }
 
 /*
@@ -557,11 +557,11 @@
 		 * do all hash-table manipulation with the MMU off.
 		 *  -- paulus.
 		 */
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 		flush_hash_segments(0xd, 0xf);
 #else
 		flush_hash_segments(0xc, 0xf);
-#endif CONFIG_PPC64BRIDGE
+#endif CONFIG_PPC_64BRIDGE
 		_tlbia();
 		return;
 	}
@@ -652,13 +652,13 @@
 		set_context(current->mm->context, current->mm->pgd);
 	}
 }
-#else /* CONFIG_8xx */
+#else /* CONFIG_CPU_PPC_88xx */
 void
 mmu_context_overflow(void)
 {
 	atomic_set(&next_mmu_context, -1);
 }
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_88xx */
 
 void flush_page_to_ram(struct page *page)
 {
@@ -667,7 +667,7 @@
 	kunmap(page);
 }
 
-#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
+#if !defined(CONFIG_CPU_PPC_4xx) && !defined(CONFIG_CPU_PPC_88xx)
 static void get_mem_prop(char *, struct mem_pieces *);
 
 #if defined(CONFIG_ALL_PPC)
@@ -750,7 +750,7 @@
 #else
 #define RAM_PAGE (_PAGE_RW)
 #endif
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_88xx */
 
 /*
  * Map in all of physical memory starting at KERNELBASE.
@@ -761,7 +761,7 @@
 {
 	unsigned long v, p, s, f;
 
-#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx) && !defined(CONFIG_POWER4)
+#if !defined(CONFIG_CPU_PPC_4xx) && !defined(CONFIG_CPU_PPC_88xx) && !defined(CONFIG_POWER4)
 	if (!__map_without_bats) {
 		unsigned long tot, bl, done;
 		unsigned long max_size = (256<<20);
@@ -795,7 +795,7 @@
 			       RAM_PAGE);
 		}
 	}
-#endif /* !CONFIG_4xx && !CONFIG_8xx && !CONFIG_POWER4 */
+#endif /* !CONFIG_CPU_PPC_4xx && !CONFIG_CPU_PPC_88xx && !CONFIG_POWER4 */
 
 	v = KERNELBASE;
 	p = ram_phys_base;
@@ -810,12 +810,12 @@
 #else
 		if ((char *) v < _stext || (char *) v >= etext)
 			f |= _PAGE_RW | _PAGE_DIRTY | _PAGE_HWWRITE;
-#ifndef CONFIG_8xx
+#ifndef CONFIG_CPU_PPC_88xx
 		else
 			/* On the powerpc (not 8xx), no user access
 			   forces R/W kernel access */
 			f |= _PAGE_USER;
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_88xx */
 #endif /* CONFIG_KGDB */
 		map_page(v, p, f);
 		v += PAGE_SIZE;
@@ -897,7 +897,7 @@
  * still be merged.
  * -- Cort
  */
-#if defined(CONFIG_4xx)
+#if defined(CONFIG_CPU_PPC_4xx)
 void __init
 MMU_init(void)
 {
@@ -943,7 +943,7 @@
         mtspr(SPRN_ICCR, 0x80000000);	/* 128 MB of instr. space at 0x0. */
 }
 
-#elif defined(CONFIG_8xx)
+#elif defined(CONFIG_CPU_PPC_88xx)
 void __init MMU_init(void)
 {
 	if ( ppc_md.progress ) ppc_md.progress("MMU:enter", 0x111);
@@ -1000,7 +1000,7 @@
 	else if (_machine == _MACH_apus )
 		total_memory = apus_find_end_of_memory();
 #endif
-#if defined(CONFIG_8260)
+#if defined(CONFIG_CPU_PPC_8260)
 	else
 		total_memory = m8260_find_end_of_memory();
 #else
@@ -1021,7 +1021,7 @@
 
 	if ( ppc_md.progress ) ppc_md.progress("MMU:hash init", 0x300);
         hash_init();
-#ifndef CONFIG_PPC64BRIDGE
+#ifndef CONFIG_PPC_64BRIDGE
         _SDR1 = __pa(Hash) | (Hash_mask >> 10);
 #endif
 	
@@ -1090,7 +1090,7 @@
 		map_bootx_text();
 #endif
 }
-#endif /* CONFIG_4xx */
+#endif /* CONFIG_CPU_PPC_4xx */
 
 /*
  * Initialize the bootmem system and give it all the memory we
@@ -1256,7 +1256,7 @@
 	mem_init_done = 1;
 }
 
-#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
+#if !defined(CONFIG_CPU_PPC_4xx) && !defined(CONFIG_CPU_PPC_88xx)
 #if defined(CONFIG_ALL_PPC)
 /*
  * On systems with Open Firmware, collect information about
@@ -1335,7 +1335,7 @@
 }
 #endif /* defined(CONFIG_ALL_PPC) */
 
-#ifdef CONFIG_8260
+#ifdef CONFIG_CPU_PPC_8260
 /*
  * Same hack as 8xx.
  */
@@ -1348,7 +1348,7 @@
 
 	return binfo->bi_memsize;
 }
-#endif /* CONFIG_8260 */
+#endif /* CONFIG_CPU_PPC_8260 */
 
 #ifdef CONFIG_APUS
 #define HARDWARE_MAPPED_SIZE (512*1024)
@@ -1417,7 +1417,7 @@
 	extern unsigned int hash_page_patch_A[], hash_page_patch_B[],
 		hash_page_patch_C[], hash_page[];
 
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 	/* The hash table has already been allocated and initialized
 	   in prom.c */
 	Hash_mask = (Hash_size >> 7) - 1;
@@ -1428,7 +1428,7 @@
 		Hash_bits = 16;
 	mb2 = 25 - Hash_bits;
 
-#else /* CONFIG_PPC64BRIDGE */
+#else /* CONFIG_PPC_64BRIDGE */
 
 	if ( ppc_md.progress ) ppc_md.progress("hash:enter", 0x105);
 	/*
@@ -1467,7 +1467,7 @@
 		cacheable_memzero(Hash, Hash_size);
 	} else
 		Hash = 0;
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 
 	printk("Total memory = %ldMB; using %ldkB for hash table (at %p)\n",
 	       total_memory >> 20, Hash_size >> 10, Hash);
@@ -1514,7 +1514,7 @@
 	}
 	if ( ppc_md.progress ) ppc_md.progress("hash:done", 0x205);
 }
-#elif defined(CONFIG_8xx)
+#elif defined(CONFIG_CPU_PPC_88xx)
 /*
  * This is a big hack right now, but it may turn into something real
  * someday.
@@ -1533,7 +1533,7 @@
 
 	return binfo->bi_memsize;
 }
-#endif /* !CONFIG_4xx && !CONFIG_8xx */
+#endif /* !CONFIG_CPU_PPC_4xx && !CONFIG_CPU_PPC_88xx */
 
 #ifdef CONFIG_OAK
 /*
@@ -1593,9 +1593,9 @@
 	if (rtas_data)
 		mem_pieces_remove(&phys_avail, rtas_data, rtas_size, 1);
 #endif /* CONFIG_ALL_PPC */
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 	/* Remove the hash table from the available memory */
 	if (Hash)
 		mem_pieces_remove(&phys_avail, __pa(Hash), Hash_size, 1);
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 }
--- arch/ppc/xmon/Makefile	2001/03/26 09:10:28	1.1
+++ arch/ppc/xmon/Makefile	2001/03/26 09:10:28
@@ -2,7 +2,7 @@
 
 O_TARGET	:= x.o
 
-ifeq ($(CONFIG_8xx),y)
+ifeq ($(CONFIG_CPU_PPC_88xx),y)
 obj-y		:= start_8xx.o xmon.o ppc-dis.o ppc-opc.o subr_prf.o setjmp.o
 else
 obj-y		:= start.o xmon.o ppc-dis.o ppc-opc.o subr_prf.o setjmp.o
--- arch/ppc/xmon/privinst.h	2001/03/26 09:10:33	1.1
+++ arch/ppc/xmon/privinst.h	2001/03/26 09:10:33
@@ -39,7 +39,7 @@
 GSETSPR(275, sprg3)
 GSETSPR(282, ear)
 GSETSPR(287, pvr)
-#ifndef CONFIG_8xx
+#ifndef CONFIG_CPU_PPC_88xx
 GSETSPR(528, bat0u)
 GSETSPR(529, bat0l)
 GSETSPR(530, bat1u)
--- arch/ppc/xmon/xmon.c	2001/03/26 09:10:34	1.1
+++ arch/ppc/xmon/xmon.c	2001/03/26 09:10:34
@@ -314,7 +314,7 @@
 		}
 		store_inst((void *) bp->address);
 	}
-#if !defined(CONFIG_8xx) && !defined(CONFIG_POWER4)
+#if !defined(CONFIG_CPU_PPC_88xx) && !defined(CONFIG_POWER4)
 	if (dabr.enabled)
 		set_dabr(dabr.address);
 	if (iabr.enabled)
@@ -329,7 +329,7 @@
 	struct bpt *bp;
 	unsigned instr;
 
-#if !defined(CONFIG_8xx) && !defined(CONFIG_POWER4)
+#if !defined(CONFIG_CPU_PPC_88xx) && !defined(CONFIG_POWER4)
 	set_dabr(0);
 	set_iabr(0);
 #endif
@@ -566,7 +566,7 @@
 
 	cmd = inchar();
 	switch (cmd) {
-#if !defined(CONFIG_8xx) && !defined(CONFIG_POWER4)
+#if !defined(CONFIG_CPU_PPC_88xx) && !defined(CONFIG_POWER4)
 	case 'd':
 		mode = 7;
 		cmd = inchar();
@@ -875,7 +875,7 @@
 }
 #endif
 
-#ifndef CONFIG_PPC64BRIDGE
+#ifndef CONFIG_PPC_64BRIDGE
 static void
 dump_hash_table_seg(unsigned seg, unsigned start, unsigned end)
 {
@@ -934,7 +934,7 @@
 		printf(" ... %x\n", last_va);
 }
 
-#else /* CONFIG_PPC64BRIDGE */
+#else /* CONFIG_PPC_64BRIDGE */
 static void
 dump_hash_table_seg(unsigned seg, unsigned start, unsigned end)
 {
@@ -992,7 +992,7 @@
 	if (last_found)
 		printf(" ... %x\n", last_va);
 }
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 
 static unsigned hash_ctx;
 static unsigned hash_start;
--- drivers/char/tty_io.c	2001/03/26 08:46:32	1.1
+++ drivers/char/tty_io.c	2001/03/26 08:46:33
@@ -2178,11 +2178,11 @@
 	con_init();
 #endif
 #ifdef CONFIG_SERIAL_CONSOLE
-#if (defined(CONFIG_8xx) || defined(CONFIG_8260))
+#if (defined(CONFIG_CPU_PPC_88xx) || defined(CONFIG_CPU_PPC_8260))
 	console_8xx_init();
 #elif defined(CONFIG_SERIAL)
 	serial_console_init();
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_88xx */
 #ifdef CONFIG_SGI_SERIAL
 	sgi_serial_console_init();
 #endif
@@ -2330,9 +2330,9 @@
 #ifdef CONFIG_RIO
 	rio_init();
 #endif
-#if (defined(CONFIG_8xx) || defined(CONFIG_8260))
+#if (defined(CONFIG_CPU_PPC_88xx) || defined(CONFIG_CPU_PPC_8260))
 	rs_8xx_init();
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_88xx */
 	pty_init();
 #ifdef CONFIG_MOXA_SMARTIO
 	mxser_init();
--- include/asm-ppc/cache.h	2001/03/26 08:33:52	1.1
+++ include/asm-ppc/cache.h	2001/03/26 08:33:52
@@ -9,8 +9,8 @@
 #include <asm/processor.h>
 
 /* bytes per L1 cache line */
-#if !defined(CONFIG_8xx) || defined(CONFIG_8260)
-#if defined(CONFIG_PPC64BRIDGE)
+#if !defined(CONFIG_CPU_PPC_88xx) || defined(CONFIG_CPU_PPC_8260)
+#if defined(CONFIG_PPC_64BRIDGE)
 #define L1_CACHE_BYTES	128
 #else
 #define	L1_CACHE_BYTES  32
@@ -46,7 +46,7 @@
 #define L2CACHE_NONE	0x03	/* NONE */
 #define L2CACHE_PARITY  0x08    /* Mask for L2 Cache Parity Protected bit */
 
-#ifdef CONFIG_8xx
+#ifdef CONFIG_CPU_PPC_88xx
 /* Cache control on the MPC8xx is provided through some additional
  * special purpose registers.
  */
@@ -81,7 +81,7 @@
 
 #define DC_DFWT		0x40000000	/* Data cache is forced write through */
 #define DC_LES		0x20000000	/* Caches are little endian mode */
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_88xx */
 
 #endif
 #endif /* __KERNEL__ */
--- include/asm-ppc/io.h	2001/03/26 08:33:48	1.1
+++ include/asm-ppc/io.h	2001/03/26 08:33:48
@@ -20,11 +20,11 @@
 #define PREP_ISA_MEM_BASE 	0xc0000000
 #define PREP_PCI_DRAM_OFFSET 	0x80000000
 
-#if defined(CONFIG_4xx)
+#if defined(CONFIG_CPU_PPC_4xx)
 #include <asm/board.h>
-#elif defined(CONFIG_8xx)
+#elif defined(CONFIG_CPU_PPC_88xx)
 #include <asm/mpc8xx.h>
-#elif defined(CONFIG_8260)
+#elif defined(CONFIG_CPU_PPC_8260)
 #include <asm/mpc8260.h>
 #else /* 4xx/8xx/8260 */
 #ifdef CONFIG_APUS
--- include/asm-ppc/irq.h	2001/03/26 08:33:48	1.1
+++ include/asm-ppc/irq.h	2001/03/26 08:33:48
@@ -10,7 +10,7 @@
 extern void disable_irq_nosync(unsigned int);
 extern void enable_irq(unsigned int);
 
-#if defined(CONFIG_4xx)
+#if defined(CONFIG_CPU_PPC_4xx)
 
 /*
  * The PowerPC 403 cores' Asynchronous Interrupt Controller (AIC) has
@@ -50,7 +50,7 @@
 	return (irq);
 }
 
-#elif defined(CONFIG_8xx)
+#elif defined(CONFIG_CPU_PPC_88xx)
 
 /* The MPC8xx cores have 16 possible interrupts.  There are eight
  * possible level sensitive interrupts assigned and generated internally
@@ -120,7 +120,7 @@
 	return irq;
 }
 
-#else /* CONFIG_4xx + CONFIG_8xx */
+#else /* CONFIG_CPU_PPC_4xx + CONFIG_CPU_PPC_88xx */
 
 #if defined(CONFIG_APUS)
 /*
@@ -169,11 +169,11 @@
  */
 #define NR_IRQS			256
 
-#ifndef CONFIG_8260
+#ifndef CONFIG_CPU_PPC_8260
 
 #define NUM_8259_INTERRUPTS	16
 
-#else /* CONFIG_8260 */
+#else /* CONFIG_CPU_PPC_8260 */
 
 /* The 8260 has an internal interrupt controller with a maximum of
  * 64 IRQs.  We will use NR_IRQs from above since it is large enough.
@@ -198,7 +198,7 @@
 #define	SIU_INT_SCC3		((uint)0x2a)
 #define	SIU_INT_SCC4		((uint)0x2b)
 
-#endif /* CONFIG_8260 */
+#endif /* CONFIG_CPU_PPC_8260 */
 
 /*
  * This gets called from serial.c, which is now used on
--- include/asm-ppc/mmu.h	2001/03/26 08:33:48	1.1
+++ include/asm-ppc/mmu.h	2001/03/26 08:33:49
@@ -15,20 +15,20 @@
 
 /* Hardware Page Table Entry */
 typedef struct _PTE {
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 	unsigned long long vsid:52;
 	unsigned long api:5;
 	unsigned long :5;
 	unsigned long h:1;
 	unsigned long v:1;
 	unsigned long long rpn:52;
-#else /* CONFIG_PPC64BRIDGE */
+#else /* CONFIG_PPC_64BRIDGE */
 	unsigned long v:1;	/* Entry is valid */
 	unsigned long vsid:24;	/* Virtual segment identifier */
 	unsigned long h:1;	/* Hash algorithm indicator */
 	unsigned long api:6;	/* Abbreviated page index */
 	unsigned long rpn:20;	/* Real (physical) page number */
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 	unsigned long    :3;	/* Unused */
 	unsigned long r:1;	/* Referenced */
 	unsigned long c:1;	/* Changed */
@@ -69,11 +69,11 @@
 } P601_BATU;
 
 typedef struct _BATU {		/* Upper part of BAT (all except 601) */
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 	unsigned long long bepi:47;
-#else /* CONFIG_PPC64BRIDGE */
+#else /* CONFIG_PPC_64BRIDGE */
 	unsigned long bepi:15;	/* Effective page index (virtual address) */
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 	unsigned long :4;	/* Unused */
 	unsigned long bl:11;	/* Block size mask */
 	unsigned long vs:1;	/* Supervisor valid */
@@ -88,11 +88,11 @@
 } P601_BATL;
 
 typedef struct _BATL {		/* Lower part of BAT (all except 601) */
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 	unsigned long long brpn:47;
-#else /* CONFIG_PPC64BRIDGE */
+#else /* CONFIG_PPC_64BRIDGE */
 	unsigned long brpn:15;	/* Real page index (physical address) */
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 	unsigned long :10;	/* Unused */
 	unsigned long w:1;	/* Write-thru cache */
 	unsigned long i:1;	/* Cache inhibit */
--- include/asm-ppc/mmu_context.h	2001/03/26 08:33:52	1.1
+++ include/asm-ppc/mmu_context.h	2001/03/26 08:33:52
@@ -23,7 +23,7 @@
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
 {
 }
-#ifdef CONFIG_8xx
+#ifdef CONFIG_CPU_PPC_88xx
 #define NO_CONTEXT      	16
 #define LAST_CONTEXT    	15
 #define MUNGE_CONTEXT(n)        (n)
--- include/asm-ppc/mpc8260.h	2001/03/26 08:33:59	1.1
+++ include/asm-ppc/mpc8260.h	2001/03/26 08:33:59
@@ -11,7 +11,7 @@
 
 #include <linux/config.h>
 
-#ifdef CONFIG_8260
+#ifdef CONFIG_CPU_PPC_8260
 
 #ifdef CONFIG_EST8260
 #include <asm/est8260.h>
@@ -39,6 +39,6 @@
 		       const char *device,
 		       void *dev_id);
 
-#endif /* CONFIG_8260 */
+#endif /* CONFIG_CPU_PPC_8260 */
 #endif
 #endif /* __KERNEL__ */
--- include/asm-ppc/mpc8xx.h	2001/03/26 08:33:56	1.1
+++ include/asm-ppc/mpc8xx.h	2001/03/26 08:33:56
@@ -11,7 +11,7 @@
 
 #include <linux/config.h>
 
-#ifdef CONFIG_8xx
+#ifdef CONFIG_CPU_PPC_88xx
 
 #ifdef CONFIG_MBX
 #include <asm/mbx.h>
@@ -82,6 +82,6 @@
 		       unsigned long flags, 
 		       const char *device,
 		       void *dev_id);
-#endif /* CONFIG_8xx */
+#endif /* CONFIG_CPU_PPC_88xx */
 #endif
 #endif /* __KERNEL__ */
--- include/asm-ppc/pgtable.h	2001/03/26 08:33:49	1.1
+++ include/asm-ppc/pgtable.h	2001/03/26 08:33:49
@@ -11,7 +11,7 @@
 #include <asm/mmu.h>
 #include <asm/page.h>
 
-#if defined(CONFIG_4xx)
+#if defined(CONFIG_CPU_PPC_4xx)
 extern void local_flush_tlb_all(void);
 extern void local_flush_tlb_mm(struct mm_struct *mm);
 extern void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
@@ -19,7 +19,7 @@
 				  unsigned long end);
 static inline void flush_hash_page(unsigned context, unsigned long va)
 	{ }
-#elif defined(CONFIG_8xx)
+#elif defined(CONFIG_CPU_PPC_88xx)
 #define __tlbia()	asm volatile ("tlbia" : : )
 
 static inline void local_flush_tlb_all(void)
@@ -179,7 +179,7 @@
  * (hardware-defined) PowerPC PTE as closely as possible.
  */
 
-#if defined(CONFIG_4xx)
+#if defined(CONFIG_CPU_PPC_4xx)
 /* Definitions for 4xx embedded chips. */
 #define	_PAGE_GUARDED	0x001	/* G: page is guarded from prefetch */
 #define	_PAGE_COHERENT	0x002	/* M: enforece memory coherence */
@@ -193,7 +193,7 @@
 #define _PAGE_HWWRITE	0x800	/* software: _PAGE_RW & _PAGE_DIRTY */
 #define	_PAGE_SHARED	0
 
-#elif defined(CONFIG_8xx)
+#elif defined(CONFIG_CPU_PPC_88xx)
 /* Definitions for 8xx embedded chips. */
 #define _PAGE_PRESENT	0x0001	/* Page is valid */
 #define _PAGE_NO_CACHE	0x0002	/* I: cache inhibit */
@@ -211,7 +211,7 @@
 #define _PAGE_HWWRITE	0x0100	/* C: page changed (write protect) */
 #define _PAGE_USER	0x0800	/* One of the PP bits, the other must be 0 */
 
-#else /* CONFIG_6xx */
+#else /* CONFIG_CPU_PPC_6xx */
 /* Definitions for 60x, 740/750, etc. */
 #define _PAGE_PRESENT	0x001	/* software: pte contains a translation */
 #define _PAGE_USER	0x002	/* matches one of the PP bits */
--- include/asm-ppc/processor.h	2001/03/26 08:33:50	1.1
+++ include/asm-ppc/processor.h	2001/03/26 08:33:50
@@ -15,10 +15,10 @@
 
 /* Machine State Register (MSR) Fields */
 
-#ifdef CONFIG_PPC64BRIDGE
+#ifdef CONFIG_PPC_64BRIDGE
 #define MSR_SF		(1<<63)
 #define MSR_ISF		(1<<61)
-#endif /* CONFIG_PPC64BRIDGE */
+#endif /* CONFIG_PPC_64BRIDGE */
 #define MSR_VEC		(1<<25)		/* Enable AltiVec */
 #define MSR_POW		(1<<18)		/* Enable Power Management */
 #define MSR_WE		(1<<18)		/* Wait State Enable */
@@ -700,7 +700,7 @@
 #endif /* ndef ASSEMBLY*/
 
 #ifdef CONFIG_MACH_SPECIFIC
-#if defined(CONFIG_8xx)
+#if defined(CONFIG_CPU_PPC_88xx)
 #define _machine _MACH_8xx
 #define have_of 0
 #elif defined(CONFIG_OAK)
@@ -712,7 +712,7 @@
 #elif defined(CONFIG_APUS)
 #define _machine _MACH_apus
 #define have_of 0
-#elif defined(CONFIG_8260)
+#elif defined(CONFIG_CPU_PPC_8260)
 #define _machine _MACH_8260
 #define have_of 0
 #else
--- include/asm-ppc/time.h	2001/03/26 08:33:59	1.1
+++ include/asm-ppc/time.h	2001/03/26 08:33:59
@@ -1,5 +1,5 @@
 /*
- * $Id: time.h,v 1.1 2001/03/26 08:33:59 esr Exp esr $
+ * $Id: time.h,v 1.12 1999/08/27 04:21:23 cort Exp $
  * Common time prototypes and such for all ppc machines.
  *
  * Written by Cort Dougan (cort@fsmlabs.com) to merge
@@ -26,7 +26,7 @@
 /* Accessor functions for the decrementer register. */
 static __inline__ unsigned int get_dec(void)
 {
-#if defined(CONFIG_4xx)
+#if defined(CONFIG_CPU_PPC_4xx)
 	return (mfspr(SPRN_PIT));
 #else
 	return (mfspr(SPRN_DEC));
@@ -35,10 +35,10 @@
 
 static __inline__ void set_dec(unsigned int val)
 {
-#if defined(CONFIG_4xx)
+#if defined(CONFIG_CPU_PPC_4xx)
 	mtspr(SPRN_PIT, val);
 #else
-#ifdef CONFIG_8xx_CPU6
+#ifdef CONFIG_CPU_PPC_8xx_CPU6
 	set_dec_cpu6(val);
 #else
 	mtspr(SPRN_DEC, val);
@@ -48,7 +48,7 @@
 
 /* Accessor functions for the timebase (RTC on 601) registers. */
 /* If one day CONFIG_POWER is added just define __USE_RTC as 1 */
-#ifdef CONFIG_6xx
+#ifdef CONFIG_CPU_PPC_6xx
 extern __inline__ int const __USE_RTC(void) {
 	return (mfspr(SPRN_PVR)>>16) == 1;
 }

End of diffs.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

In every country and in every age, the priest has been hostile to
liberty. He is always in alliance with the despot, abetting his abuses
in return for protection to his own.
	-- Thomas Jefferson, 1814
