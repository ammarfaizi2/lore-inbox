Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbVL3TcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVL3TcA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 14:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVL3Tb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 14:31:59 -0500
Received: from xenotime.net ([66.160.160.81]:27872 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751298AbVL3Tb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 14:31:56 -0500
Date: Fri, 30 Dec 2005 11:32:27 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Dax Kelson <dax@gurulabs.com>, erich@areca.com.tw
Cc: akpm@osdl.org, arjan@infradead.org, oliver@neukum.org,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: ETA for Areca RAID driver (arcmsr) in mainline?
Message-Id: <20051230113227.2b787d43.rdunlap@xenotime.net>
In-Reply-To: <1135279895.19320.24.camel@mentorng.gurulabs.com>
References: <1135228831.4122.15.camel@mentorng.gurulabs.com>
	<1135229681.439.23.camel@mindpipe>
	<200512220917.41494.oliver@neukum.org>
	<1135239601.2940.5.camel@laptopd505.fenrus.org>
	<20051222052443.57ffe6f9.akpm@osdl.org>
	<1135279895.19320.24.camel@mentorng.gurulabs.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005 12:31:34 -0700 Dax Kelson wrote:

> On Thu, 2005-12-22 at 05:24 -0800, Andrew Morton wrote:
> 
> > Yes, there are lots of stylistic and API-usage issues with the driver and
> > it needs someone to fix them all up.  Unfortunately the original
> > developer's English is very poor and he's obviously quite unfamiliar with
> > how Linux development happens.
> > 
> > This is all resolveable - it just needs someone to get down and work with
> > Erich on knocking the driver into shape.  But as yet, nobody has stepped up
> > to do that work.
> > 
> > And yes, the driver does apparently work.
> 
> I emailed Areca and got a response that indicated they didn't know about
> the remaining stylistic and API-usage issues with the driver.
> 
> If someone could spell it out to them what exactly needs to to be fixed
> for it to get merged into the Linus tree, they sound eager to do the
> work.
> 
> The current driver does indeed work. Last night I copied several hundred
> gigabytes of data using the driver.


Here's a start on some cleanups and a list of general issues.
I'm not addressing SCSI or MM/DMA API issues, if there are any.

0.  some Kconfig and Makefile cleanups
1.  fix arcmsr_device_id_table[] inits;
2.  fix return (value); -- don't use parenethese
3.  fix one-line-ifs-with-braces -- remove braces
4.  struct _XYZ & typedef XYZ, PXYZ -- convert to struct XYZ only
5.  check NULL usage
6.  no "return;" at end of func; -- removed
7.  return -ENXIO instead of ENXIO;

Patch for above items is below.

More issues, not yet patched:

8.  check sparse warnings, stack usage, init/exit sections;
9.  don't use // comments;
10. use printk levels
11. pPCI_DEV: bad naming (throughout driver; don't use mixed case)
12. some comments are unreadable (non-ASCII ?)
13. uintNN_t int types:  use kernel types except for userspace interfaces
14. use kernel-doc
15. try to fit source files into 80 columns


And Erich, you could probably benifit from reading an introduction
to Linux development tutorial that I did.  It's here:
  http://www.xenotime.net/linux/mentor/linux-mentoring.pdf

---
~Randy



From: Randy Dunlap <rdunlap@xenotime.net>

Many Linux kernel style cleanups.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/scsi/Kconfig           |   28 +-
 drivers/scsi/arcmsr/Makefile   |    4 
 drivers/scsi/arcmsr/arcmsr.c   |  574 ++++++++++++++++++-----------------------
 drivers/scsi/arcmsr/arcmsr.h   |  140 ++++------
 drivers/scsi/arcmsr/arcmsr.txt |   34 +-
 5 files changed, 354 insertions(+), 426 deletions(-)

--- linux-2615-rc7.orig/drivers/scsi/Kconfig
+++ linux-2615-rc7/drivers/scsi/Kconfig
@@ -289,20 +289,6 @@ config SCSI_DECSII
 	tristate "DEC SII Scsi Driver"
 	depends on MACH_DECSTATION && SCSI && 32BIT
 
-config SCSI_ARCMSR
-	tristate "ARECA ARC11X0[PCI-X]/ARC12X0[PCI-EXPRESS] SATA-RAID support"
-	depends on  PCI && SCSI
-	help
-	  This driver supports all of ARECA's SATA RAID controllers cards.
-	  This is an ARECA maintained driver by Erich Chen.
-	  If you have any problems, please mail to: < erich@areca.com.tw >
-	  Areca have suport Linux RAID config tools
-
-	  < http://www.areca.com.tw >
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called arcmsr (modprobe arcmsr) .
-
 config BLK_DEV_3W_XXXX_RAID
 	tristate "3ware 5/6/7/8xxx ATA-RAID support"
 	depends on PCI && SCSI
@@ -472,6 +458,20 @@ config SCSI_IN2000
 	  To compile this driver as a module, choose M here: the
 	  module will be called in2000.
 
+config SCSI_ARCMSR
+	tristate "ARECA ARC11X0[PCI-X]/ARC12X0[PCI-EXPRESS] SATA-RAID support"
+	depends on PCI && SCSI
+	help
+	  This driver supports all of ARECA's SATA RAID controller cards.
+	  This is an ARECA-maintained driver by Erich Chen.
+	  If you have any problems, please mail to: < erich@areca.com.tw >
+	  Areca supports Linux RAID config tools.
+
+	  < http://www.areca.com.tw >
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called arcmsr (modprobe arcmsr).
+
 source "drivers/scsi/megaraid/Kconfig.megaraid"
 
 config SCSI_SATA
--- linux-2615-rc7.orig/drivers/scsi/arcmsr/Makefile
+++ linux-2615-rc7/drivers/scsi/arcmsr/Makefile
@@ -2,7 +2,3 @@
 # Makefile for the ARECA PCI-X PCI-EXPRESS SATA RAID controllers SCSI driver.
 
 obj-$(CONFIG_SCSI_ARCMSR) := arcmsr.o
-
-EXTRA_CFLAGS += -I.
-
-
--- linux-2615-rc7.orig/drivers/scsi/arcmsr/arcmsr.h
+++ linux-2615-rc7/drivers/scsi/arcmsr/arcmsr.h
@@ -19,31 +19,29 @@
 ** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 ** GNU General Public License for more details.
 ************************************************************************
-** Redistribution and use in source and binary forms,with or without
-** modification,are permitted provided that the following conditions
+** Redistribution and use in source and binary forms, with or without
+** modification, are permitted provided that the following conditions
 ** are met:
 ** 1. Redistributions of source code must retain the above copyright
-**    notice,this list of conditions and the following disclaimer.
+**    notice, this list of conditions and the following disclaimer.
 ** 2. Redistributions in binary form must reproduce the above copyright
-**    notice,this list of conditions and the following disclaimer in the
+**    notice, this list of conditions and the following disclaimer in the
 **    documentation and/or other materials provided with the distribution.
 ** 3. The name of the author may not be used to endorse or promote products
 **    derived from this software without specific prior written permission.
 **
 ** THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
-** IMPLIED WARRANTIES,INCLUDING,BUT NOT LIMITED TO,THE IMPLIED WARRANTIES
+** IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 ** OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
-** IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,INDIRECT,
-** INCIDENTAL,SPECIAL,EXEMPLARY,OR CONSEQUENTIAL DAMAGES(INCLUDING,BUT
-** NOT LIMITED TO,PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-** DATA,OR PROFITS; OR BUSINESS INTERRUPTION)HOWEVER CAUSED AND ON ANY
-** THEORY OF LIABILITY,WHETHER IN CONTRACT,STRICT LIABILITY,OR TORT
+** IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+** INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES(INCLUDING, BUT
+** NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+** DATA, OR PROFITS; OR BUSINESS INTERRUPTION)HOWEVER CAUSED AND ON ANY
+** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 **(INCLUDING NEGLIGENCE OR OTHERWISE)ARISING IN ANY WAY OUT OF THE USE OF
-** THIS SOFTWARE,EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+** THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **************************************************************************
 */
-#include <linux/config.h>
-#include <linux/version.h>
 /*
 **********************************************************************************
 **
@@ -97,24 +95,24 @@
 **        IOCTL CONTROL CODE
 ************************************************************************
 */
-typedef struct _CMD_IO_CONTROL {
+struct CMD_IO_CONTROL {
 	uint32_t HeaderLength;
 	uint8_t Signature[8];
 	uint32_t Timeout;
 	uint32_t ControlCode;
 	uint32_t ReturnCode;
 	uint32_t Length;
-} CMD_IO_CONTROL, *PCMD_IO_CONTROL;
+};
 /*
 ************************************************************************************************************
 **
 ************************************************************************************************************
 */
-typedef struct _CMD_IOCTL_FIELD {
-	CMD_IO_CONTROL cmdioctl;	/*ioctl header */
+struct CMD_IOCTL_FIELD {
+	struct CMD_IO_CONTROL cmdioctl;	/*ioctl header */
 	uint8_t ioctldatabuffer[1032];	/*areca gui program does not accept more than 1031 byte */
-} CMD_IOCTL_FIELD, *PCMD_IOCTL_FIELD;
-/*error code for StorPortLogError,ScsiPortLogError*/
+};
+/*error code for StorPortLogError, ScsiPortLogError*/
 #define ARCMSR_IOP_ERROR_ILLEGALPCI            	0x0001
 #define ARCMSR_IOP_ERROR_VENDORID              	0x0002
 #define ARCMSR_IOP_ERROR_DEVICEID              	0x0002
@@ -158,36 +156,36 @@ typedef struct _CMD_IOCTL_FIELD {
 *************************************************************
 */
 #define IS_SG64_ADDR                0x01000000	/* bit24 */
-typedef struct _SG32ENTRY {	/* size 8 bytes *//* length bit 24 == 0                      */
-	uint32_t length;	/* high 8 bit == flag,low 24 bit == length */
+struct SG32ENTRY {	/* size 8 bytes *//* length bit 24 == 0                      */
+	uint32_t length;	/* high 8 bit == flag, low 24 bit == length */
 	uint32_t address;
-} SG32ENTRY, *PSG32ENTRY;
-typedef struct _SG64ENTRY {	/* size 12 bytes *//* length bit 24 == 1                      */
-	uint32_t length;	/* high 8 bit == flag,low 24 bit == length */
+};
+struct SG64ENTRY {	/* size 12 bytes *//* length bit 24 == 1                      */
+	uint32_t length;	/* high 8 bit == flag, low 24 bit == length */
 	uint32_t address;
 	uint32_t addresshigh;
-} SG64ENTRY, *PSG64ENTRY;
-typedef struct _SGENTRY_UNION {
+};
+struct SGENTRY_UNION {
 	union {
-		SG32ENTRY sg32entry;	/* 30h   Scatter gather address  */
-		SG64ENTRY sg64entry;	/* 30h                           */
+		struct SG32ENTRY sg32entry;	/* 30h   Scatter gather address  */
+		struct SG64ENTRY sg64entry;	/* 30h                           */
 	} u;
-} SGENTRY_UNION, PSGENTRY_UNION;
+};
 /*
 **********************************
 **
 **********************************
 */
-typedef struct _QBUFFER {
+struct QBUFFER {
 	uint32_t data_len;
 	uint8_t data[124];
-} QBUFFER, *PQBUFFER;
+};
 /*
 ************************************************************************************************
 **      FIRMWARE INFO
 ************************************************************************************************
 */
-typedef struct _FIRMWARE_INFO {
+struct FIRMWARE_INFO {
 	uint32_t signature;	/*0,00-03 */
 	uint32_t request_len;	/*1,04-07 */
 	uint32_t numbers_queue;	/*2,08-11 */
@@ -197,7 +195,7 @@ typedef struct _FIRMWARE_INFO {
 	char model[8];		/*15,60-67 */
 	char firmware_ver[16];	/*17,68-83 */
 	char device_map[16];	/*21,84-99 */
-} FIRMWARE_INFO, *PFIRMWARE_INFO;
+};
 /*
 ************************************************************************************************
 **                            ARECA FIRMWARE SPEC
@@ -311,7 +309,7 @@ typedef struct _FIRMWARE_INFO {
 **    size 0x1F8 (504)
 ************************************************************************************************
 */
-typedef struct _ARCMSR_CDB {
+struct ARCMSR_CDB {
 	uint8_t Bus;		/* 00h   should be 0            */
 	uint8_t TargetID;	/* 01h   should be 0--15        */
 	uint8_t LUN;		/* 02h   should be 0--7         */
@@ -323,9 +321,9 @@ typedef struct _ARCMSR_CDB {
 #define ARCMSR_CDB_FLAG_SGL_BSIZE          0x01	/* bit 0: 0(256) / 1(512) bytes         */
 #define ARCMSR_CDB_FLAG_BIOS               0x02	/* bit 1: 0(from driver) / 1(from BIOS) */
 #define ARCMSR_CDB_FLAG_WRITE              0x04	/* bit 2: 0(Data in) / 1(Data out)      */
-#define ARCMSR_CDB_FLAG_SIMPLEQ            0x00	/* bit 4/3 ,00 : simple Q,01 : head of Q,10 : ordered Q */
-#define ARCMSR_CDB_FLAG_HEADQ              0x08
-#define ARCMSR_CDB_FLAG_ORDEREDQ           0x10
+#define ARCMSR_CDB_FLAG_SIMPLEQ            0x00	/* bit 4/3: 00: simple Q */
+#define ARCMSR_CDB_FLAG_HEADQ              0x08 /*          01: head of Q */
+#define ARCMSR_CDB_FLAG_ORDEREDQ           0x10 /*          10: ordered Q */
 	uint8_t Reserved1;	/* 07h                             */
 
 	uint32_t Context;	/* 08h   Address of this request */
@@ -355,10 +353,10 @@ typedef struct _ARCMSR_CDB {
 	uint8_t SenseData[15];	/* 21h   output                  */
 
 	union {
-		SG32ENTRY sg32entry[ARCMSR_MAX_SG_ENTRIES];	/* 30h   Scatter gather address  */
-		SG64ENTRY sg64entry[ARCMSR_MAX_SG_ENTRIES];	/* 30h                           */
+		struct SG32ENTRY sg32entry[ARCMSR_MAX_SG_ENTRIES];	/* 30h   Scatter gather address  */
+		struct SG64ENTRY sg64entry[ARCMSR_MAX_SG_ENTRIES];	/* 30h                           */
 	} u;
-} ARCMSR_CDB, *PARCMSR_CDB;
+};
 /*
 ******************************************************************************************************
 **                 Messaging Unit (MU) of the Intel R 80331 I/O processor (80331)
@@ -421,7 +419,7 @@ typedef struct _ARCMSR_CDB {
 **  0FFCH                                                   ]   1004 Index Registers
 *******************************************************************************
 */
-typedef struct _MU {
+struct MU {
 	uint32_t resrved0[4];	/*0000 000F */
 	uint32_t inbound_msgaddr0;	/*0010 0013 */
 	uint32_t inbound_msgaddr1;	/*0014 0017 */
@@ -444,20 +442,20 @@ typedef struct _MU {
 	uint32_t reserved4[32];	/*0E80 0EFF                     32 */
 	uint32_t ioctl_rbuffer[32];	/*0F00 0F7F                     32 */
 	uint32_t reserved5[32];	/*0F80 0FFF                     32 */
-} MU, *PMU;
+};
 /*
 *********************************************************************
 **                 Adapter Control Block
 **
 *********************************************************************
 */
-typedef struct _ACB {
+struct ACB {
 	struct pci_dev *pPCI_DEV;
 	struct Scsi_Host *host;
 	unsigned long vir2phy_offset;	/* Offset is used in making arc cdb physical to virtual calculations */
 	uint32_t outbound_int_enable;
 
-	struct _MU *pmu;	/* message unit ATU inbound base address0 */
+	struct MU *pmu;		/* message unit ATU inbound base address0 */
 
 	uint8_t adapter_index;	/*  */
 	uint8_t irq;
@@ -471,14 +469,14 @@ typedef struct _ACB {
 #define ACB_F_BUS_RESET               0x0040
 #define ACB_F_IOP_INITED              0x0080	/* iop init */
 
-	struct _CCB *pccbwait2go[ARCMSR_MAX_OUTSTANDING_CMD];
+	struct CCB *pccbwait2go[ARCMSR_MAX_OUTSTANDING_CMD];
 	atomic_t ccbwait2gocount;
 	atomic_t ccboutstandingcount;
 
 	void *dma_coherent;	/* dma_coherent used for memory free */
 	dma_addr_t dma_coherent_handle;	/* dma_coherent_handle used for memory free */
-	struct _CCB *pccb_pool[ARCMSR_MAX_FREECCB_NUM];	/* serial ccb pointer array */
-	struct _CCB *pccbringQ[ARCMSR_MAX_FREECCB_NUM];	/* working ccb pointer array */
+	struct CCB *pccb_pool[ARCMSR_MAX_FREECCB_NUM];	/* serial ccb pointer array */
+	struct CCB *pccbringQ[ARCMSR_MAX_FREECCB_NUM];	/* working ccb pointer array */
 	int32_t ccb_doneindex;	/* done ccb array index */
 	int32_t ccb_startindex;	/* start ccb array index  */
 
@@ -495,7 +493,7 @@ typedef struct _ACB {
 	spinlock_t qbuffer_lockunlock;
 	spinlock_t ccb_doneindex_lockunlock;
 	spinlock_t ccb_startindex_lockunlock;
-	uint8_t devstate[ARCMSR_MAX_TARGETID][ARCMSR_MAX_TARGETLUN];	/* id0 ..... id15,lun0...lun7 */
+	uint8_t devstate[ARCMSR_MAX_TARGETID][ARCMSR_MAX_TARGETLUN];	/* id0 ..... id15, lun0...lun7 */
 #define ARECA_RAID_GONE               0x55
 #define ARECA_RAID_GOOD               0xaa
 	uint32_t num_resets;
@@ -506,23 +504,23 @@ typedef struct _ACB {
 	uint32_t firm_ide_channels;	/*4,16-19 */
 	char firm_model[12];	/*15,60-67 */
 	char firm_version[20];	/*17,68-83 */
-} ACB, *PACB;			/* HW_DEVICE_EXTENSION */
+};
 /*
 *********************************************************************
 **                   Command Control Block (SrbExtension)
-** CCB must be not cross page boundary,and the order from offset 0
+** CCB must be not cross page boundary, and the order from offset 0
 **         structure describing an ATA disk request
 **             this CCB length must be 32 bytes boundary
 *********************************************************************
 */
-typedef struct _CCB {
-	struct _ARCMSR_CDB arcmsr_cdb;	/* 0-503 (size of CDB=504): arcmsr messenger scsi command descriptor size 504 bytes */
+struct CCB {
+	struct ARCMSR_CDB arcmsr_cdb;	/* 0-503 (size of CDB=504): arcmsr messenger scsi command descriptor size 504 bytes */
 	uint32_t cdb_shifted_phyaddr;	/* 504-507 */
 	uint32_t reserved1;	/* 508-511 */
 	/*  ======================512+32 bytes========================  */
 #if BITS_PER_LONG == 64
 	struct scsi_cmnd *pcmd;	/* 512-515 516-519 pointer of linux scsi command */
-	struct _ACB *pACB;	/* 520-523 524-527 */
+	struct ACB *pACB;	/* 520-523 524-527 */
 
 	uint16_t ccb_flags;	/* 528-529 */
 #define		CCB_FLAG_READ		        0x0000
@@ -538,7 +536,7 @@ typedef struct _CCB {
 	uint32_t reserved2[3];	/* 532-535 536-539 540-543 */
 #else
 	struct scsi_cmnd *pcmd;	/* 512-515 pointer of linux scsi command */
-	struct _ACB *pACB;	/* 516-519 */
+	struct ACB *pACB;	/* 516-519 */
 
 	uint16_t ccb_flags;	/* 520-521 */
 #define		CCB_FLAG_READ		        0x0000
@@ -554,25 +552,25 @@ typedef struct _CCB {
 	uint32_t reserved2[5];	/* 524-527 528-531 532-535 536-539 540-543 */
 #endif
 	/*  ==========================================================  */
-} CCB, *PCCB;
+};
 /*
 *********************************************************************
 **
 *********************************************************************
 */
-typedef struct _HCBARC {
-	struct _ACB *pACB[ARCMSR_MAX_ADAPTER];
+struct HCBARC {
+	struct ACB *pACB[ARCMSR_MAX_ADAPTER];
 
 	int32_t arcmsr_major_number;
 
 	uint8_t adapterCnt;
 	uint8_t reserved[3];
-} HCBARC, *PHCBARC;
+};
 /*
 *************************************************************
 *************************************************************
 */
-typedef struct _SENSE_DATA {
+struct SENSE_DATA {
 	uint8_t ErrorCode:7;
 	uint8_t Valid:1;
 	uint8_t SegmentNumber;
@@ -588,7 +586,7 @@ typedef struct _SENSE_DATA {
 	uint8_t AdditionalSenseCodeQualifier;
 	uint8_t FieldReplaceableUnitCode;
 	uint8_t SenseKeySpecific[3];
-} SENSE_DATA, *PSENSE_DATA;
+};
 /*
 **********************************
 **  Peripheral Device Type definitions
@@ -755,7 +753,7 @@ typedef struct _SENSE_DATA {
 #define     ARCMSR_PCI2PCI_REVISIONID_REG		     0x08	/*byte */
 /*
 **==============================================================================
-**  0x0b-0x09 : 0180_00 (class code 1,native pci mode )
+**  0x0b-0x09 : 0180_00 (class code 1, native pci mode )
 ** Bit       Default                       Description
 ** 23:16       06h                     Base Class Code (BCC): Indicates that this is a bridge device.
 ** 15:08       04h                      Sub Class Code (SCC): Indicates this is of type PCI-to-PCI bridge.
@@ -796,7 +794,7 @@ typedef struct _SENSE_DATA {
 #define     ARCMSR_PCI2PCI_PRIMARY_LATENCYTIMER_REG	 0x0D	/*byte */
 /*
 **==============================================================================
-**  0x0e : (header type,single function )
+**  0x0e : (header type, single function )
 ** Bit       Default                       Description
 ** 07           0                Multi-function device (MVD): 80331 is a single-function device.
 ** 06:00       01h                       Header Type (HTYPE): Defines the layout of addresses 10h through 3Fh in configuration space.
@@ -838,12 +836,12 @@ typedef struct _SENSE_DATA {
 ** Bit       Default                       Description
 **                             Secondary Latency Timer (STV):
 ** 07:00       00h (Conventional PCI)  Conventional PCI Mode: Secondary bus Master latency timer.
-**                                                            Indicates the number of PCI clock cycles,referenced from the assertion of FRAME# to the expiration of the timer,
+**                                                            Indicates the number of PCI clock cycles, referenced from the assertion of FRAME# to the expiration of the timer,
 **                                                            when bridge may continue as master of the current transaction. All bits are writable,
 **                                                            resulting in a granularity of 1 PCI clock cycle.
 **                                                            When the timer expires (i.e., equals 00h) bridge relinquishes the bus after the first data transfer when its PCI bus grant has been deasserted.
 **          or 40h (PCI-X)                        PCI-X Mode: Secondary bus Master latency timer.
-**                                                            Indicates the number of PCI clock cycles,referenced from the assertion of FRAME# to the expiration of the timer,
+**                                                            Indicates the number of PCI clock cycles, referenced from the assertion of FRAME# to the expiration of the timer,
 **                                                            when bridge may continue as master of the current transaction. All bits are writable,
 **                                                            resulting in a granularity of 1 PCI clock cycle.
 **                                                            When the timer expires (i.e., equals 00h) bridge relinquishes the bus at the next ADB.
@@ -985,7 +983,7 @@ typedef struct _SENSE_DATA {
 **                                                            The delayed completion is then discarded.
 ** 09           0b             Secondary Discard Timer (SDT): Sets the maximum number of PCI clock cycles that bridge waits for an initiator on the secondary bus to repeat a delayed transaction request.
 **                                                            The counter starts when the delayed transaction completion is ready to be returned to the initiator.
-**                                                            When the initiator has not repeated the transaction at least once before the counter expires,bridge discards the delayed transaction from its queues.
+**                                                            When the initiator has not repeated the transaction at least once before the counter expires, bridge discards the delayed transaction from its queues.
 **                                                            0b=The secondary master time-out counter is 2 15 PCI clock cycles.
 **                                                            1b=The secondary master time-out counter is 2 10 PCI clock cycles.
 ** 08           0b               Primary Discard Timer (PDT): Sets the maximum number of PCI clock cycles that bridge waits for an initiator on the primary bus to repeat a delayed transaction request.
@@ -998,15 +996,15 @@ typedef struct _SENSE_DATA {
 **                                                            When cleared to 0b: The bridge deasserts S_RST#, when it had been asserted by writing this bit to a 1b.
 **                                                                When set to 1b: The bridge asserts S_RST#.
 ** 05           0b                   Master Abort Mode (MAM): Dictates bridge behavior on the initiator bus when a master abort termination occurs in response to a delayed transaction initiated by bridge on the target bus.
-**                                                            0b=The bridge asserts TRDY# in response to a non-locked delayed transaction,and returns FFFF FFFFh when a read.
-**                                                            1b=When the transaction had not yet been completed on the initiator bus (e.g.,delayed reads, or non-posted writes),
+**                                                            0b=The bridge asserts TRDY# in response to a non-locked delayed transaction, and returns FFFF FFFFh when a read.
+**                                                            1b=When the transaction had not yet been completed on the initiator bus (e.g., delayed reads, or non-posted writes),
 **                                                                 then bridge returns a Target Abort in response to the original requester
 **                                                                 when it returns looking for its delayed completion on the initiator bus.
 **                                                                 When the transaction had completed on the initiator bus (e.g., a PMW), then bridge asserts P_SERR# (when enabled).
 **                                   For PCI-X transactions this bit is an enable for the assertion of P_SERR# due to a master abort while attempting to deliver a posted memory write on the destination bus.
 ** 04           0b                   VGA Alias Filter Enable: This bit dictates bridge behavior in conjunction with the VGA enable bit (also of this register),
 **                                                            and the VGA Palette Snoop Enable bit (Command Register).
-**                                                            When the VGA enable, or VGA Palette Snoop enable bits are on (i.e., 1b) the VGA Aliasing bit for the corresponding enabled functionality,:
+**                                                            When the VGA enable, or VGA Palette Snoop enable bits are on (i.e., 1b) the VGA Aliasing bit for the corresponding enabled functionality:
 **                                                            0b=Ignores address bits AD[15:10] when decoding VGA I/O addresses.
 **                                                            1b=Ensures that address bits AD[15:10] equal 000000b when decoding VGA I/O addresses.
 **                                   When all VGA cycle forwarding is disabled, (i.e., VGA Enable bit =0b and VGA Palette Snoop bit =0b), then this bit has no impact on bridge behavior.
@@ -1058,7 +1056,7 @@ typedef struct _SENSE_DATA {
 **==============================================================================
 **  0x42-0x41: Secondary Arbiter Control/Status Register - SACSR
 ** Bit       Default                       Description
-** 15:12      1111b                  Grant Time-out Violator: This field indicates the agent that violated the Grant Time-out rule (PCI=16 clocks,PCI-X=6 clocks).
+** 15:12      1111b                  Grant Time-out Violator: This field indicates the agent that violated the Grant Time-out rule (PCI=16 clocks, PCI-X=6 clocks).
 **                                   Note that this field is only meaningful when:
 **                                                              # Bit[11] of this register is set to 1b, indicating that a Grant Time-out violation had occurred.
 **                                                              # bridge internal arbiter is enabled.
@@ -1617,7 +1615,7 @@ typedef struct _SENSE_DATA {
 **  07:00        00H                        Programming Interface - None defined
 ***********************************************************************************
 */
-#define     ARCMSR_ATU_CLASS_CODE_REG		         0x09	/*3bytes 0x0B,0x0A,0x09 */
+#define     ARCMSR_ATU_CLASS_CODE_REG		         0x09	/*3 bytes: 0x0B,0x0A,0x09 */
 /*
 ***********************************************************************************
 **  ATU Cacheline Size Register - ATUCLSR
@@ -4568,7 +4566,7 @@ typedef struct _SENSE_DATA {
 **    		byte 2          : command code 0x52
 **    		byte 3          : raidset#
 **    		byte 4/5/6/7    : device mask for expansion
-**    		byte 8/9/10     : (8:0 no change, 1 change, 0xff:terminate, 9:new raid level,10:new stripe size 0/1/2/3/4/5->4/8/16/32/64/128K )
+**    		byte 8/9/10     : (8:0 no change, 1 change, 0xff:terminate; 9:new raid level; 10:new stripe size 0/1/2/3/4/5->4/8/16/32/64/128K )
 **    		byte 11/12/13   : repeat for each volume in the raidset ....
 **
 **      GUI_ACTIVATE_RAIDSET : Activate incomplete raid set
--- linux-2615-rc7.orig/drivers/scsi/arcmsr/arcmsr.txt
+++ linux-2615-rc7/drivers/scsi/arcmsr/arcmsr.txt
@@ -27,9 +27,9 @@ History
      1.20.00.07    3/23/2005         Erich Chen        bug fix with arcmsr_scsi_host_template_init ocur segmentation fault,
                                                        if RAID adapter does not on PCI slot and modprobe/rmmod this driver twice.
                                                        bug fix enormous stack usage (Adrian Bunk's comment)
-     1.20.00.08    6/23/2005         Erich Chen        bug fix with abort command,in case of heavy loading when sata cable
+     1.20.00.08    6/23/2005         Erich Chen        bug fix with abort command, in case of heavy loading when sata cable
                                                        working on low quality connection
-     1.20.00.09    9/12/2005         Erich Chen        bug fix with abort command handling,firmware version check
+     1.20.00.09    9/12/2005         Erich Chen        bug fix with abort command handling, firmware version check
                                                        and firmware update notify for hardware bug fix
      1.20.00.10    9/23/2005         Erich Chen        enhance sysfs function for change driver's max tag Q number.
                                                        add DMA_64BIT_MASK for backward compatible with all 2.6.x
@@ -75,15 +75,15 @@ config SCSI_ARCMSR
 	tristate "ARECA ARC11X0[PCI-X]/ARC12X0[PCI-EXPRESS] SATA-RAID support"
 	depends on  PCI && SCSI
 	help
-	  This driver supports all of ARECA's SATA RAID controllers cards.
-	  This is an ARECA maintained driver by Erich Chen.
+	  This driver supports all of ARECA's SATA RAID controller cards.
+	  This is an ARECA-maintained driver by Erich Chen.
 	  If you have any problems, please mail to: < erich@areca.com.tw >
-	  Areca have suport Linux RAID config tools
+	  Areca supports Linux RAID config tools.
 
 	  < http://www.areca.com.tw >
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called arcmsr (modprobe arcmsr) .
+	  module will be called arcmsr (modprobe arcmsr).
 
 	  ....
 	  ...
@@ -110,25 +110,25 @@ Copyright
 ** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 ** GNU General Public License for more details.
 ************************************************************************
-** Redistribution and use in source and binary forms,with or without
-** modification,are permitted provided that the following conditions
+** Redistribution and use in source and binary forms, with or without
+** modification, are permitted provided that the following conditions
 ** are met:
 ** 1. Redistributions of source code must retain the above copyright
-**    notice,this list of conditions and the following disclaimer.
+**    notice, this list of conditions and the following disclaimer.
 ** 2. Redistributions in binary form must reproduce the above copyright
-**    notice,this list of conditions and the following disclaimer in the
+**    notice, this list of conditions and the following disclaimer in the
 **    documentation and/or other materials provided with the distribution.
 ** 3. The name of the author may not be used to endorse or promote products
 **    derived from this software without specific prior written permission.
 **
 ** THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
-** IMPLIED WARRANTIES,INCLUDING,BUT NOT LIMITED TO,THE IMPLIED WARRANTIES
+** IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 ** OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
-** IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,INDIRECT,
-** INCIDENTAL,SPECIAL,EXEMPLARY,OR CONSEQUENTIAL DAMAGES(INCLUDING,BUT
-** NOT LIMITED TO,PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-** DATA,OR PROFITS; OR BUSINESS INTERRUPTION)HOWEVER CAUSED AND ON ANY
-** THEORY OF LIABILITY,WHETHER IN CONTRACT,STRICT LIABILITY,OR TORT
+** IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+** INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES(INCLUDING, BUT
+** NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+** DATA, OR PROFITS; OR BUSINESS INTERRUPTION)HOWEVER CAUSED AND ON ANY
+** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 **(INCLUDING NEGLIGENCE OR OTHERWISE)ARISING IN ANY WAY OUT OF THE USE OF
-** THIS SOFTWARE,EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+** THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **************************************************************************
--- linux-2615-rc7.orig/drivers/scsi/arcmsr/arcmsr.c
+++ linux-2615-rc7/drivers/scsi/arcmsr/arcmsr.c
@@ -19,27 +19,27 @@
 ** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 ** GNU General Public License for more details.
 ************************************************************************
-** Redistribution and use in source and binary forms,with or without
-** modification,are permitted provided that the following conditions
+** Redistribution and use in source and binary forms, with or without
+** modification, are permitted provided that the following conditions
 ** are met:
 ** 1. Redistributions of source code must retain the above copyright
-**    notice,this list of conditions and the following disclaimer.
+**    notice, this list of conditions and the following disclaimer.
 ** 2. Redistributions in binary form must reproduce the above copyright
-**    notice,this list of conditions and the following disclaimer in the
+**    notice, this list of conditions and the following disclaimer in the
 **    documentation and/or other materials provided with the distribution.
 ** 3. The name of the author may not be used to endorse or promote products
 **    derived from this software without specific prior written permission.
 **
 ** THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
-** IMPLIED WARRANTIES,INCLUDING,BUT NOT LIMITED TO,THE IMPLIED WARRANTIES
+** IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 ** OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
-** IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,INDIRECT,
-** INCIDENTAL,SPECIAL,EXEMPLARY,OR CONSEQUENTIAL DAMAGES(INCLUDING,BUT
-** NOT LIMITED TO,PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-** DATA,OR PROFITS; OR BUSINESS INTERRUPTION)HOWEVER CAUSED AND ON ANY
-** THEORY OF LIABILITY,WHETHER IN CONTRACT,STRICT LIABILITY,OR TORT
+** IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+** INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES(INCLUDING, BUT
+** NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+** DATA, OR PROFITS; OR BUSINESS INTERRUPTION)HOWEVER CAUSED AND ON ANY
+** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 **(INCLUDING NEGLIGENCE OR OTHERWISE)ARISING IN ANY WAY OUT OF THE USE OF
-** THIS SOFTWARE,EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+** THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **************************************************************************
 ** History
 **
@@ -67,9 +67,9 @@
 **     1.20.00.07    3/23/2005         Erich Chen        bug fix with arcmsr_scsi_host_template_init ocur segmentation fault,
 **                                                       if RAID adapter does not on PCI slot and modprobe/rmmod this driver twice.
 **                                                       bug fix enormous stack usage (Adrian Bunk's comment)
-**     1.20.00.08    6/23/2005         Erich Chen        bug fix with abort command,in case of heavy loading when sata cable
+**     1.20.00.08    6/23/2005         Erich Chen        bug fix with abort command, in case of heavy loading when sata cable
 **                                                       working on low quality connection
-**     1.20.00.09    9/12/2005         Erich Chen        bug fix with abort command handling,firmware version check
+**     1.20.00.09    9/12/2005         Erich Chen        bug fix with abort command handling, firmware version check
 **                                                       and firmware update notify for hardware bug fix
 **     1.20.00.10    9/23/2005         Erich Chen        enhance sysfs function for change driver's max tag Q number.
 **                                                       add DMA_64BIT_MASK for backward compatible with all 2.6.x
@@ -82,7 +82,7 @@
 **                                                       change 64bit pci_set_consistent_dma_mask into 32bit
 **                                                       increcct adapter count if adapter initialize fail.
 **                                                       miss edit at arcmsr_build_ccb....
-**                                                       psge += sizeof(struct _SG64ENTRY *) =>  psge += sizeof(struct _SG64ENTRY)
+**                                                       psge += sizeof(struct SG64ENTRY *) =>  psge += sizeof(struct SG64ENTRY)
 **                                                       64 bits sg entry would be incorrectly calculated
 **                                                       thanks Kornel Wieliczek give me kindly notify and detail description
 ******************************************************************************************
@@ -117,7 +117,7 @@ MODULE_LICENSE("Dual BSD/GPL");
 **********************************************************************************
 */
 static u_int8_t arcmsr_adapterCnt = 0;
-static struct _HCBARC arcmsr_host_control_block;
+static struct HCBARC arcmsr_host_control_block;
 /*
 **********************************************************************************
 **********************************************************************************
@@ -128,8 +128,8 @@ static int arcmsr_fops_close(struct inod
 static int arcmsr_fops_open(struct inode *inode, struct file *filep);
 static int arcmsr_halt_notify(struct notifier_block *nb, unsigned long event,
 			      void *buf);
-static int arcmsr_initialize(struct _ACB *pACB, struct pci_dev *pPCI_DEV);
-static int arcmsr_iop_ioctlcmd(struct _ACB *pACB, int ioctl_cmd, void *arg);
+static int arcmsr_initialize(struct ACB *pACB, struct pci_dev *pPCI_DEV);
+static int arcmsr_iop_ioctlcmd(struct ACB *pACB, int ioctl_cmd, void *arg);
 static int arcmsr_proc_info(struct Scsi_Host *host, char *buffer, char **start,
 			    off_t offset, int length, int inout);
 static int arcmsr_bios_param(struct scsi_device *sdev,
@@ -144,11 +144,11 @@ static int arcmsr_ioctl(struct scsi_devi
 static int __devinit arcmsr_device_probe(struct pci_dev *pPCI_DEV,
 					 const struct pci_device_id *id);
 static void arcmsr_device_remove(struct pci_dev *pPCI_DEV);
-static void arcmsr_pcidev_disattach(struct _ACB *pACB);
-static void arcmsr_iop_init(struct _ACB *pACB);
-static void arcmsr_free_ccb_pool(struct _ACB *pACB);
-static irqreturn_t arcmsr_interrupt(struct _ACB *pACB);
-static u_int8_t arcmsr_wait_msgint_ready(struct _ACB *pACB);
+static void arcmsr_pcidev_disattach(struct ACB *pACB);
+static void arcmsr_iop_init(struct ACB *pACB);
+static void arcmsr_free_ccb_pool(struct ACB *pACB);
+static irqreturn_t arcmsr_interrupt(struct ACB *pACB);
+static u_int8_t arcmsr_wait_msgint_ready(struct ACB *pACB);
 static const char *arcmsr_info(struct Scsi_Host *);
 /*
 **********************************************************************************
@@ -158,7 +158,7 @@ static const char *arcmsr_info(struct Sc
 static ssize_t arcmsr_show_firmware_info(struct class_device *dev, char *buf)
 {
 	struct Scsi_Host *host = class_to_shost(dev);
-	struct _ACB *pACB = (struct _ACB *)host->hostdata;
+	struct ACB *pACB = (struct ACB *)host->hostdata;
 	unsigned long flags = 0;
 	ssize_t len;
 
@@ -186,7 +186,7 @@ static ssize_t arcmsr_show_firmware_info
 static ssize_t arcmsr_show_driver_state(struct class_device *dev, char *buf)
 {
 	struct Scsi_Host *host = class_to_shost(dev);
-	struct _ACB *pACB = (struct _ACB *)host->hostdata;
+	struct ACB *pACB = (struct ACB *)host->hostdata;
 	unsigned long flags = 0;
 	ssize_t len;
 
@@ -236,9 +236,8 @@ static struct class_device_attribute *ar
 static int arcmsr_adjust_disk_queue_depth(struct scsi_device *sdev,
 					  int queue_depth)
 {
-	if (queue_depth > ARCMSR_MAX_CMD_PERLUN) {
+	if (queue_depth > ARCMSR_MAX_CMD_PERLUN)
 		queue_depth = ARCMSR_MAX_CMD_PERLUN;
-	}
 	scsi_adjust_queue_depth(sdev, MSG_ORDERED_TAG, queue_depth);
 	return queue_depth;
 }
@@ -246,16 +245,13 @@ static struct scsi_host_template arcmsr_
 	.module = THIS_MODULE,
 	.proc_name = "arcmsr",
 	.proc_info = arcmsr_proc_info,
-	.name = "ARCMSR ARECA SATA RAID HOST Adapter" ARCMSR_DRIVER_VERSION,	/* *name */
+	.name = "ARCMSR ARECA SATA RAID HOST Adapter" ARCMSR_DRIVER_VERSION,
 	.release = arcmsr_release,
 	.info = arcmsr_info,
 	.ioctl = arcmsr_ioctl,
 	.queuecommand = arcmsr_queue_command,
-	.eh_strategy_handler = NULL,
 	.eh_abort_handler = arcmsr_cmd_abort,
-	.eh_device_reset_handler = NULL,
 	.eh_bus_reset_handler = arcmsr_bus_reset,
-	.eh_host_reset_handler = NULL,
 	.bios_param = arcmsr_bios_param,
 	.change_queue_depth = arcmsr_adjust_disk_queue_depth,
 	.can_queue = ARCMSR_MAX_OUTSTANDING_CMD,
@@ -274,7 +270,8 @@ static struct scsi_host_template arcmsr_
 **********************************************************************************
 */
 static struct notifier_block arcmsr_event_notifier =
-    { arcmsr_halt_notify, NULL, 0 };
+    { .notifier_call = arcmsr_halt_notify };
+
 static struct file_operations arcmsr_file_operations = {
 	.owner = THIS_MODULE,
 	.ioctl = arcmsr_fops_ioctl,
@@ -284,26 +281,16 @@ static struct file_operations arcmsr_fil
 
 /* We do our own ID filtering.  So, grab all SCSI storage class devices. */
 static struct pci_device_id arcmsr_device_id_table[] __devinitdata = {
-	{.vendor = PCIVendorIDARECA,.device = PCIDeviceIDARC1110,.subvendor =
-	 PCI_ANY_ID,.subdevice = PCI_ANY_ID,},
-	{.vendor = PCIVendorIDARECA,.device = PCIDeviceIDARC1120,.subvendor =
-	 PCI_ANY_ID,.subdevice = PCI_ANY_ID,},
-	{.vendor = PCIVendorIDARECA,.device = PCIDeviceIDARC1130,.subvendor =
-	 PCI_ANY_ID,.subdevice = PCI_ANY_ID,},
-	{.vendor = PCIVendorIDARECA,.device = PCIDeviceIDARC1160,.subvendor =
-	 PCI_ANY_ID,.subdevice = PCI_ANY_ID,},
-	{.vendor = PCIVendorIDARECA,.device = PCIDeviceIDARC1170,.subvendor =
-	 PCI_ANY_ID,.subdevice = PCI_ANY_ID,},
-	{.vendor = PCIVendorIDARECA,.device = PCIDeviceIDARC1210,.subvendor =
-	 PCI_ANY_ID,.subdevice = PCI_ANY_ID,},
-	{.vendor = PCIVendorIDARECA,.device = PCIDeviceIDARC1220,.subvendor =
-	 PCI_ANY_ID,.subdevice = PCI_ANY_ID,},
-	{.vendor = PCIVendorIDARECA,.device = PCIDeviceIDARC1230,.subvendor =
-	 PCI_ANY_ID,.subdevice = PCI_ANY_ID,},
-	{.vendor = PCIVendorIDARECA,.device = PCIDeviceIDARC1260,.subvendor =
-	 PCI_ANY_ID,.subdevice = PCI_ANY_ID,},
-	{.vendor = PCIVendorIDARECA,.device = PCIDeviceIDARC1270,.subvendor =
-	 PCI_ANY_ID,.subdevice = PCI_ANY_ID,},
+	{PCI_DEVICE(PCIVendorIDARECA, PCIDeviceIDARC1110)},
+	{PCI_DEVICE(PCIVendorIDARECA, PCIDeviceIDARC1120)},
+	{PCI_DEVICE(PCIVendorIDARECA, PCIDeviceIDARC1130)},
+	{PCI_DEVICE(PCIVendorIDARECA, PCIDeviceIDARC1160)},
+	{PCI_DEVICE(PCIVendorIDARECA, PCIDeviceIDARC1170)},
+	{PCI_DEVICE(PCIVendorIDARECA, PCIDeviceIDARC1210)},
+	{PCI_DEVICE(PCIVendorIDARECA, PCIDeviceIDARC1220)},
+	{PCI_DEVICE(PCIVendorIDARECA, PCIDeviceIDARC1230)},
+	{PCI_DEVICE(PCIVendorIDARECA, PCIDeviceIDARC1260)},
+	{PCI_DEVICE(PCIVendorIDARECA, PCIDeviceIDARC1270)},
 	{0, 0},			/* Terminating entry */
 };
 
@@ -323,24 +310,23 @@ static irqreturn_t arcmsr_do_interrupt(i
 				       struct pt_regs *regs)
 {
 	irqreturn_t handle_state;
-	struct _HCBARC *pHCBARC = &arcmsr_host_control_block;
-	struct _ACB *pACB;
-	struct _ACB *pACBtmp;
+	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
+	struct ACB *pACB;
+	struct ACB *pACBtmp;
 	int i = 0;
 
-	pACB = (struct _ACB *)dev_id;
+	pACB = (struct ACB *)dev_id;
 	pACBtmp = pHCBARC->pACB[i];
 	while ((pACB != pACBtmp) && pACBtmp && (i < ARCMSR_MAX_ADAPTER)) {
 		i++;
 		pACBtmp = pHCBARC->pACB[i];
 	}
-	if (!pACBtmp) {
+	if (!pACBtmp)
 		return IRQ_NONE;
-	}
 	spin_lock_irq(&pACB->isr_lockunlock);
 	handle_state = arcmsr_interrupt(pACB);
 	spin_unlock_irq(&pACB->isr_lockunlock);
-	return (handle_state);
+	return handle_state;
 }
 
 /*
@@ -365,7 +351,7 @@ static int arcmsr_bios_param(struct scsi
 	geom[0] = heads;
 	geom[1] = sectors;
 	geom[2] = cylinders;
-	return (0);
+	return 0;
 }
 
 /*
@@ -376,8 +362,8 @@ static int __devinit arcmsr_device_probe
 					 const struct pci_device_id *id)
 {
 	struct Scsi_Host *host;
-	struct _HCBARC *pHCBARC = &arcmsr_host_control_block;
-	struct _ACB *pACB;
+	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
+	struct ACB *pACB;
 	uint8_t bus, dev_fun;
 
 	if (pci_enable_device(pPCI_DEV)) {
@@ -388,20 +374,20 @@ static int __devinit arcmsr_device_probe
 	/* allocate scsi host information (includes out adapter) scsi_host_alloc==scsi_register */
 	if ((host =
 	     scsi_host_alloc(&arcmsr_scsi_host_template,
-			     sizeof(struct _ACB))) == 0) {
+			     sizeof(struct ACB))) == 0) {
 		printk("arcmsr%d adapter probe: scsi_host_alloc error \n",
 		       arcmsr_adapterCnt);
 		return -ENODEV;
 	}
-	if (!pci_set_dma_mask(pPCI_DEV, DMA_64BIT_MASK)) {
+	if (!pci_set_dma_mask(pPCI_DEV, DMA_64BIT_MASK))
 		printk
 		    ("ARECA RAID ADAPTER%d: 64BITS PCI BUS DMA ADDRESSING SUPPORTED\n",
 		     arcmsr_adapterCnt);
-	} else if (!pci_set_dma_mask(pPCI_DEV, DMA_32BIT_MASK)) {
+	else if (!pci_set_dma_mask(pPCI_DEV, DMA_32BIT_MASK))
 		printk
 		    ("ARECA RAID ADAPTER%d: 32BITS PCI BUS DMA ADDRESSING SUPPORTED\n",
 		     arcmsr_adapterCnt);
-	} else {
+	else {
 		printk("ARECA RAID ADAPTER%d: No suitable DMA available.\n",
 		       arcmsr_adapterCnt);
 		return -ENOMEM;
@@ -414,8 +400,8 @@ static int __devinit arcmsr_device_probe
 	}
 	bus = pPCI_DEV->bus->number;
 	dev_fun = pPCI_DEV->devfn;
-	pACB = (struct _ACB *)host->hostdata;
-	memset(pACB, 0, sizeof(struct _ACB));
+	pACB = (struct ACB *)host->hostdata;
+	memset(pACB, 0, sizeof(struct ACB));
 	spin_lock_init(&pACB->isr_lockunlock);
 	spin_lock_init(&pACB->wait2go_lockunlock);
 	spin_lock_init(&pACB->qbuffer_lockunlock);
@@ -426,7 +412,7 @@ static int __devinit arcmsr_device_probe
 	host->max_sectors = ARCMSR_MAX_XFER_SECTORS;
 	host->max_lun = ARCMSR_MAX_TARGETLUN;
 	host->max_id = ARCMSR_MAX_TARGETID;	/*16:8 */
-	host->max_cmd_len = 16;	/*this is issue of 64bit LBA ,over 2T byte */
+	host->max_cmd_len = 16;	/*this is issue of 64bit LBA, over 2T byte */
 	host->sg_tablesize = ARCMSR_MAX_SG_ENTRIES;
 	host->can_queue = ARCMSR_MAX_OUTSTANDING_CMD;	/* max simultaneous cmds */
 	host->cmd_per_lun = ARCMSR_MAX_CMD_PERLUN;
@@ -483,12 +469,12 @@ static int __devinit arcmsr_device_probe
 static void arcmsr_device_remove(struct pci_dev *pPCI_DEV)
 {
 	struct Scsi_Host *host = pci_get_drvdata(pPCI_DEV);
-	struct _HCBARC *pHCBARC = &arcmsr_host_control_block;
-	struct _ACB *pACB = (struct _ACB *)host->hostdata;
+	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
+	struct ACB *pACB = (struct ACB *)host->hostdata;
 	int i;
 
 	/* Flush cache to disk */
-	/* Free irq,otherwise extra interrupt is generated       */
+	/* Free irq, otherwise extra interrupt is generated */
 	/* Issue a blocking(interrupts disabled) command to the card */
 	arcmsr_pcidev_disattach(pACB);
 	scsi_remove_host(host);
@@ -496,13 +482,11 @@ static void arcmsr_device_remove(struct 
 	pci_set_drvdata(pPCI_DEV, NULL);
 	/*if this is last pACB */
 	for (i = 0; i < ARCMSR_MAX_ADAPTER; i++) {
-		if (pHCBARC->pACB[i] != NULL) {
+		if (pHCBARC->pACB[i])
 			return;	/* this is not last adapter's release */
-		}
 	}
 	unregister_chrdev(pHCBARC->arcmsr_major_number, "arcmsr");
 	unregister_reboot_notifier(&arcmsr_event_notifier);
-	return;
 }
 
 /*
@@ -513,14 +497,14 @@ static int arcmsr_scsi_host_template_ini
 					  *host_template)
 {
 	int error;
-	struct _HCBARC *pHCBARC = &arcmsr_host_control_block;
+	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
 
 	/*
 	 ** register as a PCI hot-plug driver module
 	 */
-	memset(pHCBARC, 0, sizeof(struct _HCBARC));
+	memset(pHCBARC, 0, sizeof(struct HCBARC));
 	error = pci_module_init(&arcmsr_pci_driver);
-	if (pHCBARC->pACB[0] != NULL) {
+	if (pHCBARC->pACB[0]) {
 		host_template->proc_name = "arcmsr";
 		register_reboot_notifier(&arcmsr_event_notifier);
 		pHCBARC->arcmsr_major_number =
@@ -528,7 +512,7 @@ static int arcmsr_scsi_host_template_ini
 		printk("arcmsr device major number %d \n",
 		       pHCBARC->arcmsr_major_number);
 	}
-	return (error);
+	return error;
 }
 
 /*
@@ -537,7 +521,7 @@ static int arcmsr_scsi_host_template_ini
 */
 static int arcmsr_module_init(void)
 {
-	return (arcmsr_scsi_host_template_init(&arcmsr_scsi_host_template));
+	return arcmsr_scsi_host_template_init(&arcmsr_scsi_host_template);
 }
 
 /*
@@ -547,7 +531,6 @@ static int arcmsr_module_init(void)
 static void arcmsr_module_exit(void)
 {
 	pci_unregister_driver(&arcmsr_pci_driver);
-	return;
 }
 
 module_init(arcmsr_module_init);
@@ -556,9 +539,9 @@ module_exit(arcmsr_module_exit);
 **********************************************************************
 **********************************************************************
 */
-static void arcmsr_pci_unmap_dma(struct _CCB *pCCB)
+static void arcmsr_pci_unmap_dma(struct CCB *pCCB)
 {
-	struct _ACB *pACB = pCCB->pACB;
+	struct ACB *pACB = pCCB->pACB;
 	struct scsi_cmnd *pcmd = pCCB->pcmd;
 
 	if (pcmd->use_sg != 0) {
@@ -573,7 +556,6 @@ static void arcmsr_pci_unmap_dma(struct 
 				 pcmd->request_bufflen,
 				 pcmd->sc_data_direction);
 	}
-	return;
 }
 
 /*
@@ -583,23 +565,19 @@ static void arcmsr_pci_unmap_dma(struct 
 static int arcmsr_fops_open(struct inode *inode, struct file *filep)
 {
 	int i, minor;
-	struct _HCBARC *pHCBARC = &arcmsr_host_control_block;
-	struct _ACB *pACB;
+	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
+	struct ACB *pACB;
 
 	minor = MINOR(inode->i_rdev);
-	if (minor >= pHCBARC->adapterCnt) {
+	if (minor >= pHCBARC->adapterCnt)
 		return -ENXIO;
-	}
 	for (i = 0; i < ARCMSR_MAX_ADAPTER; i++) {
-		if ((pACB = pHCBARC->pACB[i]) != NULL) {
-			if (pACB->adapter_index == minor) {
+		if ((pACB = pHCBARC->pACB[i]))
+			if (pACB->adapter_index == minor)
 				break;
-			}
-		}
 	}
-	if (i >= ARCMSR_MAX_ADAPTER) {
+	if (i >= ARCMSR_MAX_ADAPTER)
 		return -ENXIO;
-	}
 	return 0;		/* success */
 }
 
@@ -610,23 +588,19 @@ static int arcmsr_fops_open(struct inode
 static int arcmsr_fops_close(struct inode *inode, struct file *filep)
 {
 	int i, minor;
-	struct _HCBARC *pHCBARC = &arcmsr_host_control_block;
-	struct _ACB *pACB;
+	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
+	struct ACB *pACB;
 
 	minor = MINOR(inode->i_rdev);
-	if (minor >= pHCBARC->adapterCnt) {
+	if (minor >= pHCBARC->adapterCnt)
 		return -ENXIO;
-	}
 	for (i = 0; i < ARCMSR_MAX_ADAPTER; i++) {
-		if ((pACB = pHCBARC->pACB[i]) != NULL) {
-			if (pACB->adapter_index == minor) {
+		if ((pACB = pHCBARC->pACB[i]))
+			if (pACB->adapter_index == minor)
 				break;
-			}
-		}
 	}
-	if (i >= ARCMSR_MAX_ADAPTER) {
+	if (i >= ARCMSR_MAX_ADAPTER)
 		return -ENXIO;
-	}
 	return 0;
 }
 
@@ -638,23 +612,19 @@ static int arcmsr_fops_ioctl(struct inod
 			     unsigned int ioctl_cmd, unsigned long arg)
 {
 	int i, minor;
-	struct _HCBARC *pHCBARC = &arcmsr_host_control_block;
-	struct _ACB *pACB;
+	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
+	struct ACB *pACB;
 
 	minor = MINOR(inode->i_rdev);
-	if (minor >= pHCBARC->adapterCnt) {
+	if (minor >= pHCBARC->adapterCnt)
 		return -ENXIO;
-	}
 	for (i = 0; i < ARCMSR_MAX_ADAPTER; i++) {
-		if ((pACB = pHCBARC->pACB[i]) != NULL) {
-			if (pACB->adapter_index == minor) {
+		if ((pACB = pHCBARC->pACB[i]))
+			if (pACB->adapter_index == minor)
 				break;
-			}
-		}
 	}
-	if (i >= ARCMSR_MAX_ADAPTER) {
+	if (i >= ARCMSR_MAX_ADAPTER)
 		return -ENXIO;
-	}
 	/*
 	 ************************************************************
 	 ** We do not allow muti ioctls to the driver at the same duration.
@@ -667,10 +637,9 @@ static int arcmsr_fops_ioctl(struct inod
 ************************************************************************
 ************************************************************************
 */
-static void arcmsr_flush_adapter_cache(struct _ACB *pACB)
+static void arcmsr_flush_adapter_cache(struct ACB *pACB)
 {
 	writel(ARCMSR_INBOUND_MESG0_FLUSH_CACHE, &pACB->pmu->inbound_msgaddr0);
-	return;
 }
 
 /*
@@ -678,10 +647,10 @@ static void arcmsr_flush_adapter_cache(s
 **  Q back this CCB into ACB ArrayCCB
 **********************************************************************
 */
-static void arcmsr_ccb_complete(struct _CCB *pCCB)
+static void arcmsr_ccb_complete(struct CCB *pCCB)
 {
 	unsigned long flag;
-	struct _ACB *pACB = pCCB->pACB;
+	struct ACB *pACB = pCCB->pACB;
 	struct scsi_cmnd *pcmd = pCCB->pcmd;
 
 	arcmsr_pci_unmap_dma(pCCB);
@@ -694,7 +663,6 @@ static void arcmsr_ccb_complete(struct _
 	pACB->ccb_doneindex %= ARCMSR_MAX_FREECCB_NUM;
 	spin_unlock_irqrestore(&pACB->ccb_doneindex_lockunlock, flag);
 	pcmd->scsi_done(pcmd);
-	return;
 }
 
 /*
@@ -702,18 +670,18 @@ static void arcmsr_ccb_complete(struct _
 **       if scsi error do auto request sense
 **********************************************************************
 */
-static void arcmsr_report_sense_info(struct _CCB *pCCB)
+static void arcmsr_report_sense_info(struct CCB *pCCB)
 {
 	struct scsi_cmnd *pcmd = pCCB->pcmd;
-	struct _SENSE_DATA *psenseBuffer =
-	    (struct _SENSE_DATA *)pcmd->sense_buffer;
+	struct SENSE_DATA *psenseBuffer =
+	    (struct SENSE_DATA *)pcmd->sense_buffer;
 
 	pcmd->result = DID_OK << 16;
 	if (psenseBuffer) {
 		int sense_data_length =
-		    sizeof(struct _SENSE_DATA) <
+		    sizeof(struct SENSE_DATA) <
 		    sizeof(pcmd->
-			   sense_buffer) ? sizeof(struct _SENSE_DATA) :
+			   sense_buffer) ? sizeof(struct SENSE_DATA) :
 		    sizeof(pcmd->sense_buffer);
 		memset(psenseBuffer, 0, sizeof(pcmd->sense_buffer));
 		memcpy(psenseBuffer, pCCB->arcmsr_cdb.SenseData,
@@ -721,7 +689,6 @@ static void arcmsr_report_sense_info(str
 		psenseBuffer->ErrorCode = 0x70;
 		psenseBuffer->Valid = 1;
 	}
-	return;
 }
 
 /*
@@ -729,7 +696,7 @@ static void arcmsr_report_sense_info(str
 ** to insert pCCB into tail of pACB wait exec ccbQ
 *********************************************************************
 */
-static void arcmsr_queue_wait2go_ccb(struct _ACB *pACB, struct _CCB *pCCB)
+static void arcmsr_queue_wait2go_ccb(struct ACB *pACB, struct CCB *pCCB)
 {
 	unsigned long flag;
 	int i = 0;
@@ -745,26 +712,24 @@ static void arcmsr_queue_wait2go_ccb(str
 		i++;
 		i %= ARCMSR_MAX_OUTSTANDING_CMD;
 	}
-	return;
 }
 
 /*
 *********************************************************************
 *********************************************************************
 */
-static void arcmsr_abort_allcmd(struct _ACB *pACB)
+static void arcmsr_abort_allcmd(struct ACB *pACB)
 {
 	printk
 	    ("arcmsr_abort_allcmd: try to abort all outstanding command............\n");
 	writel(ARCMSR_INBOUND_MESG0_ABORT_CMD, &pACB->pmu->inbound_msgaddr0);
-	return;
 }
 
 /*
 **********************************************************************
 **********************************************************************
 */
-static u_int8_t arcmsr_wait_msgint_ready(struct _ACB *pACB)
+static u_int8_t arcmsr_wait_msgint_ready(struct ACB *pACB)
 {
 	uint32_t Index;
 	uint8_t Retries = 0x00;
@@ -788,9 +753,9 @@ static u_int8_t arcmsr_wait_msgint_ready
 **        Return Value: Nothing.
 ****************************************************************************
 */
-static void arcmsr_iop_reset(struct _ACB *pACB)
+static void arcmsr_iop_reset(struct ACB *pACB)
 {
-	struct _CCB *pCCB;
+	struct CCB *pCCB;
 	uint32_t intmask_org, mask;
 	int i = 0;
 
@@ -828,7 +793,7 @@ static void arcmsr_iop_reset(struct _ACB
 	i = 0;
 	while (atomic_read(&pACB->ccbwait2gocount) != 0) {
 		pCCB = pACB->pccbwait2go[i];
-		if (pCCB != NULL) {
+		if (pCCB) {
 			pACB->pccbwait2go[i] = NULL;
 			pCCB->startdone = ARCMSR_CCB_ABORTED;
 			pCCB->pcmd->result = DID_ABORT << 16;
@@ -839,24 +804,23 @@ static void arcmsr_iop_reset(struct _ACB
 		i %= ARCMSR_MAX_OUTSTANDING_CMD;
 	}
 	atomic_set(&pACB->ccboutstandingcount, 0);
-	return;
 }
 
 /*
 **********************************************************************
 **********************************************************************
 */
-static void arcmsr_build_ccb(struct _ACB *pACB, struct _CCB *pCCB,
+static void arcmsr_build_ccb(struct ACB *pACB, struct CCB *pCCB,
 			     struct scsi_cmnd *pcmd)
 {
-	struct _ARCMSR_CDB *pARCMSR_CDB =
-	    (struct _ARCMSR_CDB *)&pCCB->arcmsr_cdb;
-	int8_t *psge = (int8_t *) & pARCMSR_CDB->u;
+	struct ARCMSR_CDB *pARCMSR_CDB =
+	    (struct ARCMSR_CDB *)&pCCB->arcmsr_cdb;
+	int8_t *psge = (int8_t *)&pARCMSR_CDB->u;
 	uint32_t address_lo, address_hi;
 	int arccdbsize = 0x30;
 
 	pCCB->pcmd = pcmd;
-	memset(pARCMSR_CDB, 0, sizeof(struct _ARCMSR_CDB));
+	memset(pARCMSR_CDB, 0, sizeof(struct ARCMSR_CDB));
 	pARCMSR_CDB->Bus = 0;
 	pARCMSR_CDB->TargetID = pcmd->device->id;
 	pARCMSR_CDB->LUN = pcmd->device->lun;
@@ -882,31 +846,30 @@ static void arcmsr_build_ccb(struct _ACB
 			address_hi =
 			    cpu_to_le32(dma_addr_hi32(sg_dma_address(sl)));
 			if (address_hi == 0) {
-				struct _SG32ENTRY *pdma_sg =
-				    (struct _SG32ENTRY *)psge;
+				struct SG32ENTRY *pdma_sg =
+				    (struct SG32ENTRY *)psge;
 
 				pdma_sg->address = address_lo;
 				pdma_sg->length = length;
-				psge += sizeof(struct _SG32ENTRY);
-				arccdbsize += sizeof(struct _SG32ENTRY);
+				psge += sizeof(struct SG32ENTRY);
+				arccdbsize += sizeof(struct SG32ENTRY);
 			} else {
-				struct _SG64ENTRY *pdma_sg =
-				    (struct _SG64ENTRY *)psge;
+				struct SG64ENTRY *pdma_sg =
+				    (struct SG64ENTRY *)psge;
 
 				pdma_sg->addresshigh = address_hi;
 				pdma_sg->address = address_lo;
 				pdma_sg->length = length | IS_SG64_ADDR;
-				psge += sizeof(struct _SG64ENTRY);
-				arccdbsize += sizeof(struct _SG64ENTRY);
+				psge += sizeof(struct SG64ENTRY);
+				arccdbsize += sizeof(struct SG64ENTRY);
 			}
 			sl++;
 			cdb_sgcount++;
 		}
 		pARCMSR_CDB->sgcount = (uint8_t) cdb_sgcount;
 		pARCMSR_CDB->DataLength = pcmd->request_bufflen;
-		if (arccdbsize > 256) {
+		if (arccdbsize > 256)
 			pARCMSR_CDB->Flags |= ARCMSR_CDB_FLAG_SGL_BSIZE;
-		}
 	} else if (pcmd->request_bufflen) {
 		dma_addr_t dma_addr;
 		dma_addr =
@@ -917,11 +880,11 @@ static void arcmsr_build_ccb(struct _ACB
 		address_lo = cpu_to_le32(dma_addr_lo32(dma_addr));
 		address_hi = cpu_to_le32(dma_addr_hi32(dma_addr));
 		if (address_hi == 0) {
-			struct _SG32ENTRY *pdma_sg = (struct _SG32ENTRY *)psge;
+			struct SG32ENTRY *pdma_sg = (struct SG32ENTRY *)psge;
 			pdma_sg->address = address_lo;
 			pdma_sg->length = pcmd->request_bufflen;
 		} else {
-			struct _SG64ENTRY *pdma_sg = (struct _SG64ENTRY *)psge;
+			struct SG64ENTRY *pdma_sg = (struct SG64ENTRY *)psge;
 			pdma_sg->addresshigh = address_hi;
 			pdma_sg->address = address_lo;
 			pdma_sg->length = pcmd->request_bufflen | IS_SG64_ADDR;
@@ -933,7 +896,6 @@ static void arcmsr_build_ccb(struct _ACB
 		pARCMSR_CDB->Flags |= ARCMSR_CDB_FLAG_WRITE;
 		pCCB->ccb_flags |= CCB_FLAG_WRITE;
 	}
-	return;
 }
 
 /*
@@ -947,31 +909,29 @@ static void arcmsr_build_ccb(struct _ACB
 **	specific ARC adapter.
 **************************************************************************
 */
-static void arcmsr_post_ccb(struct _ACB *pACB, struct _CCB *pCCB)
+static void arcmsr_post_ccb(struct ACB *pACB, struct CCB *pCCB)
 {
 	uint32_t cdb_shifted_phyaddr = pCCB->cdb_shifted_phyaddr;
-	struct _ARCMSR_CDB *pARCMSR_CDB =
-	    (struct _ARCMSR_CDB *)&pCCB->arcmsr_cdb;
+	struct ARCMSR_CDB *pARCMSR_CDB =
+	    (struct ARCMSR_CDB *)&pCCB->arcmsr_cdb;
 
 	atomic_inc(&pACB->ccboutstandingcount);
 	pCCB->startdone = ARCMSR_CCB_START;
-	if (pARCMSR_CDB->Flags & ARCMSR_CDB_FLAG_SGL_BSIZE) {
+	if (pARCMSR_CDB->Flags & ARCMSR_CDB_FLAG_SGL_BSIZE)
 		writel(cdb_shifted_phyaddr | ARCMSR_CCBPOST_FLAG_SGL_BSIZE,
 		       &pACB->pmu->inbound_queueport);
-	} else {
+	else
 		writel(cdb_shifted_phyaddr, &pACB->pmu->inbound_queueport);
-	}
-	return;
 }
 
 /*
 **************************************************************************
 **************************************************************************
 */
-static void arcmsr_post_wait2go_ccb(struct _ACB *pACB)
+static void arcmsr_post_wait2go_ccb(struct ACB *pACB)
 {
 	unsigned long flag;
-	struct _CCB *pCCB;
+	struct CCB *pCCB;
 	int i = 0;
 
 	spin_lock_irqsave(&pACB->wait2go_lockunlock, flag);
@@ -979,7 +939,7 @@ static void arcmsr_post_wait2go_ccb(stru
 	       && (atomic_read(&pACB->ccboutstandingcount) <
 		   ARCMSR_MAX_OUTSTANDING_CMD)) {
 		pCCB = pACB->pccbwait2go[i];
-		if (pCCB != NULL) {
+		if (pCCB) {
 			pACB->pccbwait2go[i] = NULL;
 			arcmsr_post_ccb(pACB, pCCB);
 			atomic_dec(&pACB->ccbwait2gocount);
@@ -988,7 +948,6 @@ static void arcmsr_post_wait2go_ccb(stru
 		i %= ARCMSR_MAX_OUTSTANDING_CMD;
 	}
 	spin_unlock_irqrestore(&pACB->wait2go_lockunlock, flag);
-	return;
 }
 
 /*
@@ -997,10 +956,10 @@ static void arcmsr_post_wait2go_ccb(stru
 **     Output:
 **********************************************************************
 */
-static void arcmsr_post_Qbuffer(struct _ACB *pACB)
+static void arcmsr_post_Qbuffer(struct ACB *pACB)
 {
 	uint8_t *pQbuffer;
-	PQBUFFER pwbuffer = (PQBUFFER) & pACB->pmu->ioctl_wbuffer;
+	struct QBUFFER *pwbuffer = (struct QBUFFER *)&pACB->pmu->ioctl_wbuffer;
 	uint8_t *iop_data = (uint8_t *) pwbuffer->data;
 	int32_t allxfer_len = 0;
 
@@ -1019,31 +978,28 @@ static void arcmsr_post_Qbuffer(struct _
 	 */
 	writel(ARCMSR_INBOUND_DRIVER_DATA_WRITE_OK,
 	       &pACB->pmu->inbound_doorbell);
-	return;
 }
 
 /*
 ************************************************************************
 ************************************************************************
 */
-static void arcmsr_stop_adapter_bgrb(struct _ACB *pACB)
+static void arcmsr_stop_adapter_bgrb(struct ACB *pACB)
 {
 	pACB->acb_flags |= ACB_F_MSG_STOP_BGRB;
 	pACB->acb_flags &= ~ACB_F_MSG_START_BGRB;
 	writel(ARCMSR_INBOUND_MESG0_STOP_BGRB, &pACB->pmu->inbound_msgaddr0);
-	return;
 }
 
 /*
 ************************************************************************
 ************************************************************************
 */
-static void arcmsr_free_ccb_pool(struct _ACB *pACB)
+static void arcmsr_free_ccb_pool(struct ACB *pACB)
 {
 	dma_free_coherent(&pACB->pPCI_DEV->dev,
-			  ARCMSR_MAX_FREECCB_NUM * sizeof(struct _CCB) + 0x20,
+			  ARCMSR_MAX_FREECCB_NUM * sizeof(struct CCB) + 0x20,
 			  pACB->dma_coherent, pACB->dma_coherent_handle);
-	return;
 }
 
 /*
@@ -1065,9 +1021,9 @@ static void arcmsr_free_ccb_pool(struct 
 ** DRIVER_OK       0x00	// Driver status
 **********************************************************************
 */
-static irqreturn_t arcmsr_interrupt(struct _ACB *pACB)
+static irqreturn_t arcmsr_interrupt(struct ACB *pACB)
 {
-	struct _CCB *pCCB;
+	struct CCB *pCCB;
 	uint32_t flag_ccb, outbound_intstatus, outbound_doorbell;
 
 	/*
@@ -1087,8 +1043,8 @@ static irqreturn_t arcmsr_interrupt(stru
 		outbound_doorbell = readl(&pACB->pmu->outbound_doorbell);
 		writel(outbound_doorbell, &pACB->pmu->outbound_doorbell);	/*clear interrupt */
 		if (outbound_doorbell & ARCMSR_OUTBOUND_IOP331_DATA_WRITE_OK) {
-			PQBUFFER prbuffer =
-			    (PQBUFFER) & pACB->pmu->ioctl_rbuffer;
+			struct QBUFFER *prbuffer =
+			    (struct QBUFFER *)&pACB->pmu->ioctl_rbuffer;
 			uint8_t *iop_data = (uint8_t *) prbuffer->data;
 			uint8_t *pQbuffer;
 			int32_t my_empty_len, iop_len, rqbuf_firstindex,
@@ -1125,8 +1081,8 @@ static irqreturn_t arcmsr_interrupt(stru
 			 */
 			if (pACB->wqbuf_firstindex != pACB->wqbuf_lastindex) {
 				uint8_t *pQbuffer;
-				PQBUFFER pwbuffer =
-				    (PQBUFFER) & pACB->pmu->ioctl_wbuffer;
+				struct QBUFFER *pwbuffer =
+				    (struct QBUFFER *)&pACB->pmu->ioctl_wbuffer;
 				uint8_t *iop_data = (uint8_t *) pwbuffer->data;
 				int32_t allxfer_len = 0;
 
@@ -1167,7 +1123,7 @@ static irqreturn_t arcmsr_interrupt(stru
 				break;	/*chip FIFO no ccb for completion already */
 			}
 			/* check if command done with no error */
-			pCCB = (struct _CCB *)(pACB->vir2phy_offset + (flag_ccb << 5));	/*frame must be 32 bytes aligned */
+			pCCB = (struct CCB *)(pACB->vir2phy_offset + (flag_ccb << 5));	/*frame must be 32 bytes aligned */
 			if ((pCCB->pACB != pACB)
 			    || (pCCB->startdone != ARCMSR_CCB_START)) {
 				if (pCCB->startdone == ARCMSR_CCB_ABORTED) {
@@ -1190,10 +1146,9 @@ static irqreturn_t arcmsr_interrupt(stru
 			id = pCCB->pcmd->device->id;
 			lun = pCCB->pcmd->device->lun;
 			if ((flag_ccb & ARCMSR_CCBREPLY_FLAG_ERROR) == 0) {
-				if (pACB->devstate[id][lun] == ARECA_RAID_GONE) {
+				if (pACB->devstate[id][lun] == ARECA_RAID_GONE)
 					pACB->devstate[id][lun] =
 					    ARECA_RAID_GOOD;
-				}
 				pCCB->pcmd->result = DID_OK << 16;
 				arcmsr_ccb_complete(pCCB);
 			} else {
@@ -1240,13 +1195,11 @@ static irqreturn_t arcmsr_interrupt(stru
 			}
 		}		/*drain reply FIFO */
 	}
-	if (!(outbound_intstatus & ARCMSR_MU_OUTBOUND_HANDLE_INT)) {
+	if (!(outbound_intstatus & ARCMSR_MU_OUTBOUND_HANDLE_INT))
 		/*it must be share irq */
 		return IRQ_NONE;
-	}
-	if (atomic_read(&pACB->ccbwait2gocount) != 0) {
+	if (atomic_read(&pACB->ccbwait2gocount) != 0)
 		arcmsr_post_wait2go_ccb(pACB);	/*try to post all pending ccb */
-	}
 	return IRQ_HANDLED;
 }
 
@@ -1254,9 +1207,9 @@ static irqreturn_t arcmsr_interrupt(stru
 *******************************************************************************
 *******************************************************************************
 */
-static void arcmsr_iop_parking(struct _ACB *pACB)
+static void arcmsr_iop_parking(struct ACB *pACB)
 {
-	if (pACB != NULL) {
+	if (pACB) {
 		/* stop adapter background rebuild */
 		if (pACB->acb_flags & ACB_F_MSG_START_BGRB) {
 			pACB->acb_flags &= ~ACB_F_MSG_START_BGRB;
@@ -1280,20 +1233,19 @@ static void arcmsr_iop_parking(struct _A
 ***********************************************************************
 ************************************************************************
 */
-static int arcmsr_iop_ioctlcmd(struct _ACB *pACB, int ioctl_cmd, void *arg)
+static int arcmsr_iop_ioctlcmd(struct ACB *pACB, int ioctl_cmd, void *arg)
 {
-	struct _CMD_IOCTL_FIELD *pcmdioctlfld;
+	struct CMD_IOCTL_FIELD *pcmdioctlfld;
 	dma_addr_t cmd_handle;
 	int retvalue = 0;
 	/* Only let one of these through at a time */
 
 	pcmdioctlfld =
 	    pci_alloc_consistent(pACB->pPCI_DEV,
-				 sizeof(struct _CMD_IOCTL_FIELD), &cmd_handle);
-	if (pcmdioctlfld == NULL) {
+				 sizeof(struct CMD_IOCTL_FIELD), &cmd_handle);
+	if (pcmdioctlfld == NULL)
 		return -ENOMEM;
-	}
-	if (copy_from_user(pcmdioctlfld, arg, sizeof(struct _CMD_IOCTL_FIELD))
+	if (copy_from_user(pcmdioctlfld, arg, sizeof(struct CMD_IOCTL_FIELD))
 	    != 0) {
 		retvalue = -EFAULT;
 		goto ioctl_out;
@@ -1332,8 +1284,8 @@ static int arcmsr_iop_ioctlcmd(struct _A
 				allxfer_len++;
 			}
 			if (pACB->acb_flags & ACB_F_IOPDATA_OVERFLOW) {
-				PQBUFFER prbuffer =
-				    (PQBUFFER) & pACB->pmu->ioctl_rbuffer;
+				struct QBUFFER *prbuffer =
+				    (struct QBUFFER *)&pACB->pmu->ioctl_rbuffer;
 				uint8_t *pQbuffer;
 				uint8_t *iop_data = (uint8_t *) prbuffer->data;
 				int32_t iop_len;
@@ -1361,7 +1313,7 @@ static int arcmsr_iop_ioctlcmd(struct _A
 			    ARCMSR_IOCTL_RETURNCODE_OK;
 			if (copy_to_user
 			    (arg, pcmdioctlfld,
-			     sizeof(struct _CMD_IOCTL_FIELD)) != 0) {
+			     sizeof(struct CMD_IOCTL_FIELD)) != 0) {
 				retvalue = -EFAULT;
 			}
 			pci_free_consistent(pACB->pPCI_DEV, 1032, ver_addr,
@@ -1423,7 +1375,7 @@ static int arcmsr_iop_ioctlcmd(struct _A
 			spin_unlock_irqrestore(&pACB->qbuffer_lockunlock, flag);
 			if (copy_to_user
 			    (arg, pcmdioctlfld,
-			     sizeof(struct _CMD_IOCTL_FIELD)) != 0) {
+			     sizeof(struct CMD_IOCTL_FIELD)) != 0) {
 				retvalue = -EFAULT;
 			}
 			pci_free_consistent(pACB->pPCI_DEV, 1032, ver_addr,
@@ -1450,7 +1402,7 @@ static int arcmsr_iop_ioctlcmd(struct _A
 			    ARCMSR_IOCTL_RETURNCODE_OK;
 			if (copy_to_user
 			    (arg, pcmdioctlfld,
-			     sizeof(struct _CMD_IOCTL_FIELD)) != 0) {
+			     sizeof(struct CMD_IOCTL_FIELD)) != 0) {
 				retvalue = -EFAULT;
 			}
 		}
@@ -1475,7 +1427,7 @@ static int arcmsr_iop_ioctlcmd(struct _A
 			    ARCMSR_IOCTL_RETURNCODE_OK;
 			if (copy_to_user
 			    (arg, pcmdioctlfld,
-			     sizeof(struct _CMD_IOCTL_FIELD)) != 0) {
+			     sizeof(struct CMD_IOCTL_FIELD)) != 0) {
 				retvalue = -EFAULT;
 			}
 		}
@@ -1498,16 +1450,16 @@ static int arcmsr_iop_ioctlcmd(struct _A
 			pACB->wqbuf_firstindex = 0;
 			pACB->wqbuf_lastindex = 0;
 			pQbuffer = pACB->rqbuffer;
-			memset(pQbuffer, 0, sizeof(struct _QBUFFER));
+			memset(pQbuffer, 0, sizeof(struct QBUFFER));
 			pQbuffer = pACB->wqbuffer;
-			memset(pQbuffer, 0, sizeof(struct _QBUFFER));
+			memset(pQbuffer, 0, sizeof(struct QBUFFER));
 			spin_unlock_irqrestore(&pACB->qbuffer_lockunlock, flag);
 			/*report success */
 			pcmdioctlfld->cmdioctl.ReturnCode =
 			    ARCMSR_IOCTL_RETURNCODE_OK;
 			if (copy_to_user
 			    (arg, pcmdioctlfld,
-			     sizeof(struct _CMD_IOCTL_FIELD)) != 0) {
+			     sizeof(struct CMD_IOCTL_FIELD)) != 0) {
 				retvalue = -EFAULT;
 			}
 		}
@@ -1518,7 +1470,7 @@ static int arcmsr_iop_ioctlcmd(struct _A
 			    ARCMSR_IOCTL_RETURNCODE_3F;
 			if (copy_to_user
 			    (arg, pcmdioctlfld,
-			     sizeof(struct _CMD_IOCTL_FIELD)) != 0) {
+			     sizeof(struct CMD_IOCTL_FIELD)) != 0) {
 				retvalue = -EFAULT;
 			}
 		}
@@ -1533,7 +1485,7 @@ static int arcmsr_iop_ioctlcmd(struct _A
 			    ARCMSR_IOCTL_RETURNCODE_OK;
 			if (copy_to_user
 			    (arg, pcmdioctlfld,
-			     sizeof(struct _CMD_IOCTL_FIELD)) != 0) {
+			     sizeof(struct CMD_IOCTL_FIELD)) != 0) {
 				retvalue = -EFAULT;
 			}
 		}
@@ -1557,7 +1509,7 @@ static int arcmsr_iop_ioctlcmd(struct _A
 		retvalue = -EFAULT;
 	}
       ioctl_out:
-	pci_free_consistent(pACB->pPCI_DEV, sizeof(struct _CMD_IOCTL_FIELD),
+	pci_free_consistent(pACB->pPCI_DEV, sizeof(struct CMD_IOCTL_FIELD),
 			    pcmdioctlfld, cmd_handle);
 	return retvalue;
 }
@@ -1566,8 +1518,8 @@ static int arcmsr_iop_ioctlcmd(struct _A
 ************************************************************************
 **  arcmsr_ioctl
 ** Performs ioctl requests not satified by the upper levels.
-** copy_from_user(to,from,n)
-** copy_to_user(to,from,n)
+** copy_from_user(to, from, n)
+** copy_to_user(to, from, n)
 **
 **  The scsi_device struct contains what we know about each given scsi
 **  device.
@@ -1642,34 +1594,32 @@ static int arcmsr_iop_ioctlcmd(struct _A
 */
 static int arcmsr_ioctl(struct scsi_device *dev, int ioctl_cmd, void *arg)
 {
-	struct _ACB *pACB;
-	struct _HCBARC *pHCBARC = &arcmsr_host_control_block;
+	struct ACB *pACB;
+	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
 	int32_t match = 0x55AA, i;
 
 	for (i = 0; i < ARCMSR_MAX_ADAPTER; i++) {
-		if ((pACB = pHCBARC->pACB[i]) != NULL) {
+		if ((pACB = pHCBARC->pACB[i])) {
 			if (pACB->host == dev->host) {
 				match = i;
 				break;
 			}
 		}
 	}
-	if (match == 0x55AA) {
+	if (match == 0x55AA)
 		return -ENXIO;
-	}
-	if (!arg) {
+	if (!arg)
 		return -EINVAL;
-	}
-	return (arcmsr_iop_ioctlcmd(pACB, ioctl_cmd, arg));
+	return arcmsr_iop_ioctlcmd(pACB, ioctl_cmd, arg);
 }
 
 /*
 **************************************************************************
 **************************************************************************
 */
-static struct _CCB *arcmsr_get_freeccb(struct _ACB *pACB)
+static struct CCB *arcmsr_get_freeccb(struct ACB *pACB)
 {
-	struct _CCB *pCCB;
+	struct CCB *pCCB;
 	unsigned long flag;
 	int ccb_startindex, ccb_doneindex;
 
@@ -1679,13 +1629,12 @@ static struct _CCB *arcmsr_get_freeccb(s
 	pCCB = pACB->pccbringQ[ccb_startindex];
 	ccb_startindex++;
 	ccb_startindex %= ARCMSR_MAX_FREECCB_NUM;
-	if (ccb_doneindex != ccb_startindex) {
+	if (ccb_doneindex != ccb_startindex)
 		pACB->ccb_startindex = ccb_startindex;
-	} else {
+	else
 		pCCB = NULL;
-	}
 	spin_unlock_irqrestore(&pACB->ccb_startindex_lockunlock, flag);
-	return (pCCB);
+	return pCCB;
 }
 
 /*
@@ -1713,13 +1662,13 @@ static struct _CCB *arcmsr_get_freeccb(s
 **	           // A SCSI Command is assigned a nonzero serial_number when internal_cmnd
 **	           // passes it to the driver's queue command function. The serial_number
 **	           // is cleared when scsi_done is entered indicating that the command has
-**	           // been completed. If a timeout occurs,the serial number at the moment
+**	           // been completed. If a timeout occurs, the serial number at the moment
 **	           // of timeout is copied into serial_number_at_timeout. By subsequently
 **	           // comparing the serial_number and serial_number_at_timeout fields
-**	           // during abort or reset processing,we can detect whether the command
+**	           // during abort or reset processing, we can detect whether the command
 **	           // has already completed. This also detects cases where the command has
 **	           // completed and the SCSI Command structure has already being reused
-**	           // for another command,so that we can avoid incorrectly aborting or
+**	           // for another command, so that we can avoid incorrectly aborting or
 **	           // resetting the new command.
 **	           //
 **
@@ -1734,7 +1683,7 @@ static struct _CCB *arcmsr_get_freeccb(s
 **
 **	           //
 **	           // We handle the timeout differently if it happens when a reset,
-**	           // abort,etc are in process.
+**	           // abort, etc are in process.
 **	           //
 **	unsigned volatile char internal_timeout;
 **	struct scsi_cmnd   *bh_next;
@@ -1767,7 +1716,7 @@ static struct _CCB *arcmsr_get_freeccb(s
 **	unsigned short sglist_len;
 **            // size of malloc'd scatter-gather list
 **	unsigned short abort_reason;
-**            // If the mid-level code requests an abort,this is the reason.
+**            // If the mid-level code requests an abort, this is the reason.
 **	unsigned bufflen;
 **            // Size of data buffer
 **	void *buffer;
@@ -1779,7 +1728,7 @@ static struct _CCB *arcmsr_get_freeccb(s
 **
 **	unsigned transfersize;
 **           	 // How much we are guaranteed to transfer with each SCSI transfer
-**            // (ie,between disconnect/reconnects.  Probably==sector size
+**            // (ie, between disconnect/reconnects.  Probably==sector size
 **	int resid;
 **            // Number of bytes requested to be transferred
 **            // less actual number transferred (0 if not supported)
@@ -1813,7 +1762,7 @@ static struct _CCB *arcmsr_get_freeccb(s
 **	unsigned char tag;
 **            // SCSI-II queued command tag
 **	unsigned long pid;
-**            // Process ID,starts at 0
+**            // Process ID, starts at 0
 ** };
 **
 ** The scsi_cmnd structure is used by scsi.c internally,
@@ -1839,8 +1788,8 @@ static int arcmsr_queue_command(struct s
 				void (*done) (struct scsi_cmnd *))
 {
 	struct Scsi_Host *host = cmd->device->host;
-	struct _ACB *pACB = (struct _ACB *)host->hostdata;
-	struct _CCB *pCCB;
+	struct ACB *pACB = (struct ACB *)host->hostdata;
+	struct CCB *pCCB;
 	int target = cmd->device->id;
 	int lun = cmd->device->lun;
 
@@ -1848,18 +1797,17 @@ static int arcmsr_queue_command(struct s
 	cmd->host_scribble = NULL;
 	cmd->result = 0;
 	if (cmd->cmnd[0] == SYNCHRONIZE_CACHE) {	/* 0x35 avoid synchronizing disk cache cmd after .remove : arcmsr_device_remove (linux bug) */
-		if (pACB->devstate[target][lun] == ARECA_RAID_GONE) {
+		if (pACB->devstate[target][lun] == ARECA_RAID_GONE)
 			cmd->result = (DID_NO_CONNECT << 16);
-		}
 		cmd->scsi_done(cmd);
-		return (0);
+		return 0;
 	}
 	if (pACB->acb_flags & ACB_F_BUS_RESET) {
 		printk("arcmsr%d bus reset and return busy \n",
 		       pACB->adapter_index);
 		cmd->result = (DID_BUS_BUSY << 16);
 		cmd->scsi_done(cmd);
-		return (0);
+		return 0;
 	}
 	if (pACB->devstate[target][lun] == ARECA_RAID_GONE) {
 		uint8_t block_cmd;
@@ -1871,10 +1819,10 @@ static int arcmsr_queue_command(struct s
 			     pACB->adapter_index, cmd->cmnd[0], target, lun);
 			cmd->result = (DID_NO_CONNECT << 16);
 			cmd->scsi_done(cmd);
-			return (0);
+			return 0;
 		}
 	}
-	if ((pCCB = arcmsr_get_freeccb(pACB)) != NULL) {
+	if ((pCCB = arcmsr_get_freeccb(pACB))) {
 		arcmsr_build_ccb(pACB, pCCB, cmd);
 		if (atomic_read(&pACB->ccboutstandingcount) <
 		    ARCMSR_MAX_OUTSTANDING_CMD) {
@@ -1901,7 +1849,7 @@ static int arcmsr_queue_command(struct s
 		cmd->result = (DID_BUS_BUSY << 16);
 		cmd->scsi_done(cmd);
 	}
-	return (0);
+	return 0;
 }
 
 /*
@@ -1909,7 +1857,7 @@ static int arcmsr_queue_command(struct s
 **  get firmware miscellaneous data
 **********************************************************************
 */
-static void arcmsr_get_firmware_spec(struct _ACB *pACB)
+static void arcmsr_get_firmware_spec(struct ACB *pACB)
 {
 	char *acb_firm_model = pACB->firm_model;
 	char *acb_firm_version = pACB->firm_version;
@@ -1951,7 +1899,6 @@ static void arcmsr_get_firmware_spec(str
 	pACB->firm_numbers_queue = readl(&pACB->pmu->message_rbuffer[2]);	/*firm_numbers_queue,2,08-11 */
 	pACB->firm_sdram_size = readl(&pACB->pmu->message_rbuffer[3]);	/*firm_sdram_size,3,12-15 */
 	pACB->firm_ide_channels = readl(&pACB->pmu->message_rbuffer[4]);	/*firm_ide_channels,4,16-19 */
-	return;
 }
 
 /*
@@ -1959,21 +1906,20 @@ static void arcmsr_get_firmware_spec(str
 **  start background rebulid
 **********************************************************************
 */
-static void arcmsr_start_adapter_bgrb(struct _ACB *pACB)
+static void arcmsr_start_adapter_bgrb(struct ACB *pACB)
 {
 	pACB->acb_flags |= ACB_F_MSG_START_BGRB;
 	pACB->acb_flags &= ~ACB_F_MSG_STOP_BGRB;
 	writel(ARCMSR_INBOUND_MESG0_START_BGRB, &pACB->pmu->inbound_msgaddr0);
-	return;
 }
 
 /*
 **********************************************************************
 **********************************************************************
 */
-static void arcmsr_polling_ccbdone(struct _ACB *pACB, struct _CCB *poll_ccb)
+static void arcmsr_polling_ccbdone(struct ACB *pACB, struct CCB *poll_ccb)
 {
-	struct _CCB *pCCB;
+	struct CCB *pCCB;
 	uint32_t flag_ccb, outbound_intstatus, poll_ccb_done = 0, poll_count =
 	    0;
 	int id, lun;
@@ -1986,18 +1932,17 @@ static void arcmsr_polling_ccbdone(struc
 	while (1) {
 		if ((flag_ccb =
 		     readl(&pACB->pmu->outbound_queueport)) == 0xFFFFFFFF) {
-			if (poll_ccb_done) {
+			if (poll_ccb_done)
 				break;	/*chip FIFO no ccb for completion already */
-			} else {
+			else {
 				msleep(25);
-				if (poll_count > 100) {
+				if (poll_count > 100)
 					break;
-				}
 				goto polling_ccb_retry;
 			}
 		}
-		/* check ifcommand done with no error */
-		pCCB = (struct _CCB *)(pACB->vir2phy_offset + (flag_ccb << 5));	/*frame must be 32 bytes aligned */
+		/* check if command done with no error */
+		pCCB = (struct CCB *)(pACB->vir2phy_offset + (flag_ccb << 5));	/*frame must be 32 bytes aligned */
 		if ((pCCB->pACB != pACB)
 		    || (pCCB->startdone != ARCMSR_CCB_START)) {
 			if ((pCCB->startdone == ARCMSR_CCB_ABORTED)
@@ -2021,9 +1966,8 @@ static void arcmsr_polling_ccbdone(struc
 		id = pCCB->pcmd->device->id;
 		lun = pCCB->pcmd->device->lun;
 		if ((flag_ccb & ARCMSR_CCBREPLY_FLAG_ERROR) == 0) {
-			if (pACB->devstate[id][lun] == ARECA_RAID_GONE) {
+			if (pACB->devstate[id][lun] == ARECA_RAID_GONE)
 				pACB->devstate[id][lun] = ARECA_RAID_GOOD;
-			}
 			pCCB->pcmd->result = DID_OK << 16;
 			arcmsr_ccb_complete(pCCB);
 		} else {
@@ -2067,7 +2011,6 @@ static void arcmsr_polling_ccbdone(struc
 			}
 		}
 	}			/*drain reply FIFO */
-	return;
 }
 
 /*
@@ -2075,7 +2018,7 @@ static void arcmsr_polling_ccbdone(struc
 **  start background rebulid
 **********************************************************************
 */
-static void arcmsr_iop_init(struct _ACB *pACB)
+static void arcmsr_iop_init(struct ACB *pACB)
 {
 	uint32_t intmask_org, mask, outbound_doorbell, firmware_state = 0;
 
@@ -2098,7 +2041,7 @@ static void arcmsr_iop_init(struct _ACB 
 		writel(ARCMSR_INBOUND_DRIVER_DATA_READ_OK,
 		       &pACB->pmu->inbound_doorbell);
 	}
-	/* enable outbound Post Queue,outbound message0,outbell doorbell Interrupt */
+	/* enable outbound Post Queue, outbound message0, outbound doorbell Interrupt */
 	mask =
 	    ~(ARCMSR_MU_OUTBOUND_POSTQUEUE_INTMASKENABLE |
 	      ARCMSR_MU_OUTBOUND_DOORBELL_INTMASKENABLE |
@@ -2106,7 +2049,6 @@ static void arcmsr_iop_init(struct _ACB 
 	writel(intmask_org & mask, &pACB->pmu->outbound_intmask);
 	pACB->outbound_int_enable = ~(intmask_org & mask) & 0x000000ff;
 	pACB->acb_flags |= ACB_F_IOP_INITED;
-	return;
 }
 
 /*
@@ -2115,10 +2057,10 @@ static void arcmsr_iop_init(struct _ACB 
 */
 static int arcmsr_bus_reset(struct scsi_cmnd *cmd)
 {
-	struct _ACB *pACB;
+	struct ACB *pACB;
 	int retry = 0;
 
-	pACB = (struct _ACB *)cmd->device->host->hostdata;
+	pACB = (struct ACB *)cmd->device->host->hostdata;
 	printk("arcmsr%d bus reset ..... \n", pACB->adapter_index);
 	pACB->num_resets++;
 	pACB->acb_flags |= ACB_F_BUS_RESET;
@@ -2140,8 +2082,8 @@ static int arcmsr_bus_reset(struct scsi_
 */
 static int arcmsr_seek_cmd2abort(struct scsi_cmnd *pabortcmd)
 {
-	struct _ACB *pACB = (struct _ACB *)pabortcmd->device->host->hostdata;
-	struct _CCB *pCCB;
+	struct ACB *pACB = (struct ACB *)pabortcmd->device->host->hostdata;
+	struct CCB *pCCB;
 	uint32_t intmask_org, mask;
 	int i = 0;
 
@@ -2151,7 +2093,7 @@ static int arcmsr_seek_cmd2abort(struct 
 	 ** It is the upper layer do abort command this lock just prior to calling us.
 	 ** First determine if we currently own this command.
 	 ** Start by searching the device queue. If not found
-	 ** at all,and the system wanted us to just abort the
+	 ** at all, and the system wanted us to just abort the
 	 ** command return success.
 	 *****************************************************************************
 	 */
@@ -2174,13 +2116,13 @@ static int arcmsr_seek_cmd2abort(struct 
 	/*
 	 **********************************************************
 	 ** seek this command at our command list
-	 ** if command found then remove,abort it and free this CCB
+	 ** if command found then remove, abort it and free this CCB
 	 **********************************************************
 	 */
 	if (atomic_read(&pACB->ccbwait2gocount) != 0) {
 		for (i = 0; i < ARCMSR_MAX_OUTSTANDING_CMD; i++) {
 			pCCB = pACB->pccbwait2go[i];
-			if (pCCB != NULL) {
+			if (pCCB) {
 				if (pCCB->pcmd == pabortcmd) {
 					printk
 					    ("arcmsr%d scsi id=%d lun=%d abort ccb '0x%p' pending command \n",
@@ -2192,12 +2134,12 @@ static int arcmsr_seek_cmd2abort(struct 
 					pCCB->pcmd->result = DID_ABORT << 16;
 					arcmsr_ccb_complete(pCCB);
 					atomic_dec(&pACB->ccbwait2gocount);
-					return (SUCCESS);
+					return SUCCESS;
 				}
 			}
 		}
 	}
-	return (SUCCESS);
+	return SUCCESS;
       abort_outstanding_cmd:
 	/* disable all outbound interrupt */
 	intmask_org = readl(&pACB->pmu->outbound_intmask);
@@ -2212,7 +2154,7 @@ static int arcmsr_seek_cmd2abort(struct 
 	      ARCMSR_MU_OUTBOUND_MESSAGE0_INTMASKENABLE);
 	writel(intmask_org & mask, &pACB->pmu->outbound_intmask);
 	atomic_set(&pACB->ccboutstandingcount, 0);
-	return (SUCCESS);
+	return SUCCESS;
 }
 
 /*
@@ -2221,7 +2163,7 @@ static int arcmsr_seek_cmd2abort(struct 
 */
 static int arcmsr_cmd_abort(struct scsi_cmnd *cmd)
 {
-	struct _ACB *pACB = (struct _ACB *)cmd->device->host->hostdata;
+	struct ACB *pACB = (struct ACB *)cmd->device->host->hostdata;
 	int error;
 
 	printk("arcmsr%d abort device command of scsi id=%d lun=%d \n",
@@ -2233,11 +2175,10 @@ static int arcmsr_cmd_abort(struct scsi_
 	 ************************************************
 	 */
 	error = arcmsr_seek_cmd2abort(cmd);
-	if (error != SUCCESS) {
+	if (error != SUCCESS)
 		printk("arcmsr%d abort command failed scsi id=%d lun=%d \n",
 		       pACB->adapter_index, cmd->device->id, cmd->device->lun);
-	}
-	return (error);
+	return error;
 }
 
 /*
@@ -2293,10 +2234,10 @@ static int arcmsr_cmd_abort(struct scsi_
 static const char *arcmsr_info(struct Scsi_Host *host)
 {
 	static char buf[256];
-	struct _ACB *pACB;
+	struct ACB *pACB;
 	uint16_t device_id;
 
-	pACB = (struct _ACB *)host->hostdata;
+	pACB = (struct ACB *)host->hostdata;
 	device_id = pACB->pPCI_DEV->device;
 	switch (device_id) {
 	case PCIDeviceIDARC1110:
@@ -2377,16 +2318,16 @@ static const char *arcmsr_info(struct Sc
 ************************************************************************
 ************************************************************************
 */
-static int arcmsr_initialize(struct _ACB *pACB, struct pci_dev *pPCI_DEV)
+static int arcmsr_initialize(struct ACB *pACB, struct pci_dev *pPCI_DEV)
 {
 	uint32_t intmask_org, page_base, page_offset, mem_base_start;
 	dma_addr_t dma_coherent_handle, dma_addr;
-	struct _HCBARC *pHCBARC = &arcmsr_host_control_block;
+	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
 	uint8_t pcicmd;
 	void *dma_coherent;
 	void *page_remapped;
 	int i, j;
-	struct _CCB *pccb_tmp;
+	struct CCB *pccb_tmp;
 
 	/* Enable Busmaster/Mem */
 	pci_read_config_byte(pPCI_DEV, PCI_COMMAND, &pcicmd);
@@ -2400,9 +2341,9 @@ static int arcmsr_initialize(struct _ACB
 	if (page_remapped == NULL) {
 		printk("arcmsr%d memory mapping region fail \n",
 		       arcmsr_adapterCnt);
-		return (ENXIO);
+		return -ENXIO;
 	}
-	pACB->pmu = (struct _MU *)(page_remapped + page_offset);
+	pACB->pmu = (struct MU *)(page_remapped + page_offset);
 	pACB->acb_flags |=
 	    (ACB_F_IOCTL_WQBUFFER_CLEARED | ACB_F_IOCTL_RQBUFFER_CLEARED);
 	pACB->acb_flags &= ~ACB_F_SCSISTOPADAPTER;
@@ -2444,7 +2385,7 @@ static int arcmsr_initialize(struct _ACB
 	/* Attempt to claim larger area for request queue pCCB). */
 	dma_coherent =
 	    dma_alloc_coherent(&pPCI_DEV->dev,
-			       ARCMSR_MAX_FREECCB_NUM * sizeof(struct _CCB) +
+			       ARCMSR_MAX_FREECCB_NUM * sizeof(struct CCB) +
 			       0x20, &dma_coherent_handle, GFP_KERNEL);
 	if (dma_coherent == NULL) {
 		printk("arcmsr%d dma_alloc_coherent got error \n",
@@ -2454,7 +2395,7 @@ static int arcmsr_initialize(struct _ACB
 	pACB->dma_coherent = dma_coherent;
 	pACB->dma_coherent_handle = dma_coherent_handle;
 	memset(dma_coherent, 0,
-	       ARCMSR_MAX_FREECCB_NUM * sizeof(struct _CCB) + 0x20);
+	       ARCMSR_MAX_FREECCB_NUM * sizeof(struct CCB) + 0x20);
 	if (((unsigned long)dma_coherent & 0x1F) != 0) {	/*ccb address must 32 (0x20) boundary */
 		dma_coherent =
 		    dma_coherent + (0x20 -
@@ -2465,12 +2406,12 @@ static int arcmsr_initialize(struct _ACB
 					    0x1F));
 	}
 	dma_addr = dma_coherent_handle;
-	pccb_tmp = (struct _CCB *)dma_coherent;
+	pccb_tmp = (struct CCB *)dma_coherent;
 	for (i = 0; i < ARCMSR_MAX_FREECCB_NUM; i++) {
 		pccb_tmp->cdb_shifted_phyaddr = dma_addr >> 5;
 		pccb_tmp->pACB = pACB;
 		pACB->pccbringQ[i] = pACB->pccb_pool[i] = pccb_tmp;
-		dma_addr = dma_addr + sizeof(struct _CCB);
+		dma_addr = dma_addr + sizeof(struct CCB);
 		pccb_tmp++;
 	}
 	pACB->vir2phy_offset =
@@ -2498,7 +2439,7 @@ static int arcmsr_initialize(struct _ACB
 	writel(intmask_org | ARCMSR_MU_OUTBOUND_ALL_INTMASKENABLE,
 	       &pACB->pmu->outbound_intmask);
 	arcmsr_adapterCnt++;
-	return (0);
+	return 0;
 }
 
 /*
@@ -2507,17 +2448,17 @@ static int arcmsr_initialize(struct _ACB
 */
 static int arcmsr_set_info(char *buffer, int length)
 {
-	return (0);
+	return 0;
 }
 
 /*
 *********************************************************************
 *********************************************************************
 */
-static void arcmsr_pcidev_disattach(struct _ACB *pACB)
+static void arcmsr_pcidev_disattach(struct ACB *pACB)
 {
-	struct _CCB *pCCB;
-	struct _HCBARC *pHCBARC = &arcmsr_host_control_block;
+	struct CCB *pCCB;
+	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
 	uint32_t intmask_org, mask;
 	int i = 0;
 
@@ -2559,9 +2500,8 @@ static void arcmsr_pcidev_disattach(stru
 		}
 		for (i = 0; i < ARCMSR_MAX_FREECCB_NUM; i++) {
 			pCCB = pACB->pccb_pool[i];
-			if (pCCB->startdone == ARCMSR_CCB_START) {
+			if (pCCB->startdone == ARCMSR_CCB_START)
 				pCCB->startdone = ARCMSR_CCB_ABORTED;
-			}
 		}
 		/* enable all outbound interrupt */
 		mask =
@@ -2574,7 +2514,7 @@ static void arcmsr_pcidev_disattach(stru
 	if (atomic_read(&pACB->ccbwait2gocount) != 0) {	/*remove first wait2go ccb and abort it */
 		for (i = 0; i < ARCMSR_MAX_OUTSTANDING_CMD; i++) {
 			pCCB = pACB->pccbwait2go[i];
-			if (pCCB != NULL) {
+			if (pCCB) {
 				pACB->pccbwait2go[i] = NULL;
 				pCCB->startdone = ARCMSR_CCB_ABORTED;
 				pCCB->pcmd->result = DID_ABORT << 16;
@@ -2587,9 +2527,8 @@ static void arcmsr_pcidev_disattach(stru
 	pci_release_regions(pACB->pPCI_DEV);
 	iounmap(pACB->pmu);
 	arcmsr_free_ccb_pool(pACB);
-	pHCBARC->pACB[pACB->adapter_index] = 0;	/* clear record */
+	pHCBARC->pACB[pACB->adapter_index] = NULL; /* clear record */
 	arcmsr_adapterCnt--;
-	return;
 }
 
 /*
@@ -2599,8 +2538,8 @@ static void arcmsr_pcidev_disattach(stru
 static int arcmsr_halt_notify(struct notifier_block *nb, unsigned long event,
 			      void *buf)
 {
-	struct _ACB *pACB;
-	struct _HCBARC *pHCBARC = &arcmsr_host_control_block;
+	struct ACB *pACB;
+	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
 	struct Scsi_Host *host;
 	int i;
 
@@ -2610,11 +2549,10 @@ static int arcmsr_halt_notify(struct not
 	}
 	for (i = 0; i < ARCMSR_MAX_ADAPTER; i++) {
 		pACB = pHCBARC->pACB[i];
-		if (pACB == NULL) {
+		if (!pACB)
 			continue;
-		}
 		/* Flush cache to disk */
-		/* Free irq,otherwise extra interrupt is generated       */
+		/* Free irq, otherwise extra interrupt is generated */
 		/* Issue a blocking(interrupts disabled) command to the card */
 		host = pACB->host;
 		arcmsr_pcidev_disattach(pACB);
@@ -2640,13 +2578,13 @@ static int arcmsr_proc_info(struct Scsi_
 			    off_t offset, int length, int inout)
 {
 	uint8_t i;
-	struct _HCBARC *pHCBARC = &arcmsr_host_control_block;
+	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
 	char *pos = buffer;
-	struct _ACB *pACB;
+	struct ACB *pACB;
+
+	if (inout)
+		return arcmsr_set_info(buffer, length);
 
-	if (inout) {
-		return (arcmsr_set_info(buffer, length));
-	}
 	for (i = 0; i < ARCMSR_MAX_ADAPTER; i++) {
 		pACB = pHCBARC->pACB[i];
 		if (pACB == NULL)
@@ -2657,13 +2595,11 @@ static int arcmsr_proc_info(struct Scsi_
 		SPRINTF("===========================\n");
 	}
 	*start = buffer + offset;
-	if (pos - buffer < offset) {
+	if (pos - buffer < offset)
 		return 0;
-	} else if (pos - buffer - offset < length) {
-		return (pos - buffer - offset);
-	} else {
-		return length;
-	}
+	else if (pos - buffer - offset < length)
+		return pos - buffer - offset;
+	return length;
 }
 
 /*
@@ -2672,37 +2608,35 @@ static int arcmsr_proc_info(struct Scsi_
 */
 static int arcmsr_release(struct Scsi_Host *host)
 {
-	struct _ACB *pACB;
-	struct _HCBARC *pHCBARC = &arcmsr_host_control_block;
+	struct ACB *pACB;
+	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
 	uint8_t match = 0xff, i;
 
-	if (host == NULL) {
+	if (host == NULL)
 		return -ENXIO;
-	}
-	pACB = (struct _ACB *)host->hostdata;
-	if (pACB == NULL) {
+
+	pACB = (struct ACB *)host->hostdata;
+	if (!pACB)
 		return -ENXIO;
-	}
+
 	for (i = 0; i < ARCMSR_MAX_ADAPTER; i++) {
-		if (pHCBARC->pACB[i] == pACB) {
+		if (pHCBARC->pACB[i] == pACB)
 			match = i;
-		}
 	}
-	if (match == 0xff) {
+	if (match == 0xff)
 		return -ENXIO;
-	}
+
 	/* Flush cache to disk */
-	/* Free irq,otherwise extra interrupt is generated       */
+	/* Free irq, otherwise extra interrupt is generated */
 	/* Issue a blocking(interrupts disabled) command to the card */
 	arcmsr_pcidev_disattach(pACB);
 	scsi_unregister(host);
 	/*if this is last pACB */
 	for (i = 0; i < ARCMSR_MAX_ADAPTER; i++) {
-		if (pHCBARC->pACB[i] != NULL) {
-			return (0);	/* this is not last adapter's release */
-		}
+		if (pHCBARC->pACB[i])
+			return 0;	/* this is not last adapter's release */
 	}
 	unregister_chrdev(pHCBARC->arcmsr_major_number, "arcmsr");
 	unregister_reboot_notifier(&arcmsr_event_notifier);
-	return (0);
+	return 0;
 }
