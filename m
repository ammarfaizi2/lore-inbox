Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263913AbTJFAoR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 20:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263914AbTJFAoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 20:44:17 -0400
Received: from CPE-203-51-31-218.nsw.bigpond.net.au ([203.51.31.218]:19951
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S263913AbTJFAn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 20:43:59 -0400
Message-ID: <3F80BAC8.BC34D2F5@eyal.emu.id.au>
Date: Mon, 06 Oct 2003 10:43:52 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.23-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa2 - some problems [with patches]
References: <20031004105731.GA1343@velociraptor.random> <3F7EE96C.4AC99553@eyal.emu.id.au> <20031005104008.GC1561@velociraptor.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Sun, Oct 05, 2003 at 01:38:20AM +1000, Eyal Lebedinsky wrote:
> > This is most unusual as -aa patches usually apply clean, but I am
> > encountering a number of build problems.
> >
> > "PCMCIA SCSI adapter support" build is broken. I deselected the whole
> > section.
> 
> can you double check you can reproduce it in 2.4.23pre6 vanilla? It
> doesn't seem introduced by my patches.

I am reasonably sure that vanilla -pre6 built without any complaint.

> > And building i2c-2.7.0 (which I need for sensors) is failing.
> >
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.23-pre6-aa2/kernel/drivers/ie
> > ee1394/pcilynx.o
> > depmod:         i2c_bit_add_bus_Rca543f36
> > depmod:         i2c_transfer_R1dea91d1
> > depmod:         i2c_bit_del_bus_Rdf920b11
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.23-pre6-aa2/kernel/drivers/me
> > dia/video/bttv.o
> > depmod:         i2c_bit_add_bus_Rca543f36
> > depmod:         i2c_master_recv_R67b29cc4
> > depmod:         i2c_bit_del_bus_Rdf920b11
> > depmod:         i2c_master_send_Rb692cb0e
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.23-pre6-aa2/kernel/drivers/me
> > dia/video/msp3400.o
> > depmod:         i2c_probe_R4e2acbec
> > depmod:         i2c_add_driver_Racf22304
> > depmod:         i2c_transfer_R1dea91d1
> > depmod:         i2c_attach_client_Ra861362d
> > depmod:         i2c_master_send_Rb692cb0e
> > depmod:         i2c_detach_client_R0cfb40b4
> > depmod:         i2c_del_driver_R57837012
> > .... more following, all in  kernel/drivers/media/video/* ...
> 
> this looks like if you didn't compile the needed i2c (or maybe it was
> due the lack of a `make dep` first), the above modules (pcilynx bttv
> msp3400) looks innocent.

I have a script that goes into the i2c-2.7.0 tree and builds it. This
worked just fine with vanilla -pre6 (and older ones for a long time
now) but fails with -pre6-aa2.


Nevertheless, I am now building vanilla -pre6 just to confirm the
above claims... built just fine. Retry -aa2... failed.

Here is the diff in .config between my vanilla -pre6 and -aa2

@@ -44,8 +44,7 @@
 CONFIG_X86_XADD=y
 CONFIG_X86_BSWAP=y
 CONFIG_X86_POPAD_OK=y
-# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_X86_CMPXCHG8=y
 CONFIG_X86_L1_CACHE_SHIFT=6
 CONFIG_X86_HAS_TSC=y
 CONFIG_X86_GOOD_APIC=y
@@ -56,6 +55,7 @@
 CONFIG_X86_MCE=y
 CONFIG_TOSHIBA=m
 CONFIG_I8K=m
+CONFIG_THINKPAD=m
 CONFIG_MICROCODE=m
 CONFIG_X86_MSR=m
 CONFIG_X86_CPUID=m
@@ -63,6 +63,11 @@
 # CONFIG_HIGHMEM4G is not set
 # CONFIG_HIGHMEM64G is not set
 # CONFIG_HIGHMEM is not set
+CONFIG_FORCE_MAX_ZONEORDER=11
+CONFIG_1GB=y
+# CONFIG_2GB is not set
+# CONFIG_3GB is not set
+# CONFIG_05GB is not set
 # CONFIG_MATH_EMULATION is not set
 CONFIG_MTRR=y
 # CONFIG_SMP is not set
@@ -105,6 +110,8 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+CONFIG_MAX_USER_RT_PRIO=100
+CONFIG_MAX_RT_PRIO=0
 CONFIG_KCORE_ELF=y
 # CONFIG_KCORE_AOUT is not set
 CONFIG_BINFMT_AOUT=m
@@ -316,6 +323,7 @@
 CONFIG_MD_RAID5=m
 CONFIG_MD_MULTIPATH=m
 CONFIG_BLK_DEV_LVM=m
+CONFIG_BLK_DEV_DM=m
 
 #
 # Networking options
@@ -328,6 +336,10 @@
 CONFIG_FILTER=y
 CONFIG_UNIX=m
 CONFIG_INET=y
+CONFIG_TUX=m
+CONFIG_TUX_EXTCGI=y
+# CONFIG_TUX_EXTENDED_LOG is not set
+# CONFIG_TUX_DEBUG is not set
 # CONFIG_IP_MULTICAST is not set
 # CONFIG_IP_ADVANCED_ROUTER is not set
 # CONFIG_IP_PNP is not set
@@ -715,6 +727,10 @@
 CONFIG_SCSI_QLOGIC_FC=m
 # CONFIG_SCSI_QLOGIC_FC_FIRMWARE is not set
 CONFIG_SCSI_QLOGIC_1280=m
+CONFIG_SCSI_QLOGIC_QLA2XXX=y
+CONFIG_SCSI_QLOGIC_QLA2XXX_QLA2100=m
+CONFIG_SCSI_QLOGIC_QLA2XXX_QLA2200=m
+CONFIG_SCSI_QLOGIC_QLA2XXX_QLA2300=m
 CONFIG_SCSI_SEAGATE=m
 CONFIG_SCSI_SIM710=m
 CONFIG_SCSI_SYM53C416=m
@@ -731,11 +747,7 @@
 #
 # PCMCIA SCSI adapter support
 #
-CONFIG_SCSI_PCMCIA=y
-CONFIG_PCMCIA_AHA152X=m
-CONFIG_PCMCIA_FDOMAIN=m
-CONFIG_PCMCIA_NINJA_SCSI=m
-CONFIG_PCMCIA_QLOGIC=m
+# CONFIG_SCSI_PCMCIA is not set
 
 #
 # Fusion MPT device support
@@ -909,6 +921,7 @@
 CONFIG_FDDI=y
 CONFIG_DEFXX=m
 CONFIG_SKFP=m
+CONFIG_NETCONSOLE=m
 CONFIG_HIPPI=y
 CONFIG_ROADRUNNER=m
 # CONFIG_ROADRUNNER_LARGE_RINGS is not set
@@ -1479,6 +1492,7 @@
 # CONFIG_AGP_SWORKS is not set
 # CONFIG_AGP_NVIDIA is not set
 # CONFIG_AGP_ATI is not set
+CONFIG_ECC=m
 
 #
 # Direct Rendering Manager (XFree86 DRI support)
@@ -1619,6 +1633,13 @@
 # CONFIG_UDF_RW is not set
 CONFIG_UFS_FS=m
 # CONFIG_UFS_FS_WRITE is not set
+CONFIG_XFS_FS=m
+# CONFIG_XFS_POSIX_ACL is not set
+# CONFIG_XFS_RT is not set
+# CONFIG_XFS_QUOTA is not set
+# CONFIG_XFS_DMAPI is not set
+# CONFIG_XFS_DEBUG is not set
+# CONFIG_PAGEBUF_DEBUG is not set
 
 #
 # Network File Systems
@@ -2061,3 +2082,4 @@
 CONFIG_ZLIB_INFLATE=m
 CONFIG_ZLIB_DEFLATE=m
 CONFIG_FW_LOADER=m
+CONFIG_QSORT=m


--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
