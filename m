Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVCYA17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVCYA17 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 19:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVCYA16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 19:27:58 -0500
Received: from mail0.lsil.com ([147.145.40.20]:8673 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261272AbVCXX5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 18:57:07 -0500
Message-ID: <91888D455306F94EBD4D168954A9457C01B70565@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] - MPT FUSION - SPLITTING SCSI HOST DRIVERS
Date: Thu, 24 Mar 2005 16:57:03 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C530CD.2D4D0B60"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C530CD.2D4D0B60
Content-Type: text/plain;
	charset="iso-8859-1"

These patches are for the mpt fusion scsi host drivers, which separate
the scsi host drivers into separate bus type kernel modules.  This was
requested
by several people on the linux-scsi@ forum, so our driver can properly
support 
the various transport layers; e.g. SPI, FC, and eventually SAS.  In these
set of patches
the Fiber Channel controllers are moved to a new driver called mptfch.ko.
The current
Parallel SCSI controllers will remain with mptscsih.ko.  Eventually we will
be adding SAS support
in the new modules that will be mptsash.ko.  

Overview of attached patch

(6) mptlinux-3.03.00-6-mptscsi-c - SPI driver, having only module_init,
module_exit, and probe.

Please apply this patch against the 3.01.20 version of the mpt driver
in http://linux-scsi.bkbits.net:8080/scsi-misc-2.6

Backup of these patches can be found at this ftp:
ftp://ftp.lsil.com/HostAdapterDrivers/linux/Fusion-MPT/2.6-kernel/3.03.00/

Signed-off-by: Eric Moore <Eric.Moore@lsil.com>






------_=_NextPart_000_01C530CD.2D4D0B60
Content-Type: application/octet-stream;
	name="mptlinux-3.03.00-6-mptscsi-c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mptlinux-3.03.00-6-mptscsi-c"

diff -uarN drivers/message/fusion-3.01.20/mptscsi.c =
drivers/message/fusion/mptscsi.c=0A=
--- drivers/message/fusion-3.01.20/mptscsi.c	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ drivers/message/fusion/mptscsi.c	2005-03-24 09:29:50.000000000 =
-0700=0A=
@@ -0,0 +1,478 @@=0A=
+/*=0A=
+ *  linux/drivers/message/fusion/mptscsi.c=0A=
+ *      For use with LSI Logic PCI chip/adapter(s)=0A=
+ *      running LSI Logic Fusion MPT (Message Passing Technology) =
firmware.=0A=
+ *=0A=
+ *  Copyright (c) 1999-2005 LSI Logic Corporation=0A=
+ *  (mailto:mpt_linux_developer@lsil.com)=0A=
+ *=0A=
+ */=0A=
+/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
+/*=0A=
+    This program is free software; you can redistribute it and/or =
modify=0A=
+    it under the terms of the GNU General Public License as published =
by=0A=
+    the Free Software Foundation; version 2 of the License.=0A=
+=0A=
+    This program is distributed in the hope that it will be useful,=0A=
+    but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
+    GNU General Public License for more details.=0A=
+=0A=
+    NO WARRANTY=0A=
+    THE PROGRAM IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES =
OR=0A=
+    CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED INCLUDING, =
WITHOUT=0A=
+    LIMITATION, ANY WARRANTIES OR CONDITIONS OF TITLE, =
NON-INFRINGEMENT,=0A=
+    MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Each =
Recipient is=0A=
+    solely responsible for determining the appropriateness of using =
and=0A=
+    distributing the Program and assumes all risks associated with =
its=0A=
+    exercise of rights under this Agreement, including but not limited =
to=0A=
+    the risks and costs of program errors, damage to or loss of =
data,=0A=
+    programs or equipment, and unavailability or interruption of =
operations.=0A=
+=0A=
+    DISCLAIMER OF LIABILITY=0A=
+    NEITHER RECIPIENT NOR ANY CONTRIBUTORS SHALL HAVE ANY LIABILITY =
FOR ANY=0A=
+    DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR =
CONSEQUENTIAL=0A=
+    DAMAGES (INCLUDING WITHOUT LIMITATION LOST PROFITS), HOWEVER =
CAUSED AND=0A=
+    ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, =
OR=0A=
+    TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF =
THE=0A=
+    USE OR DISTRIBUTION OF THE PROGRAM OR THE EXERCISE OF ANY RIGHTS =
GRANTED=0A=
+    HEREUNDER, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGES=0A=
+=0A=
+    You should have received a copy of the GNU General Public =
License=0A=
+    along with this program; if not, write to the Free Software=0A=
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  =
02111-1307  USA=0A=
+*/=0A=
+/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
+=0A=
+#include "linux_compat.h"	/* linux-2.6 tweaks */=0A=
+#include <linux/module.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/errno.h>=0A=
+#include <linux/kdev_t.h>=0A=
+#include <linux/blkdev.h>=0A=
+#include <linux/delay.h>	/* for mdelay */=0A=
+#include <linux/interrupt.h>	/* needed for in_interrupt() proto */=0A=
+#include <linux/reboot.h>	/* notifier code */=0A=
+#include <linux/sched.h>=0A=
+#include <linux/workqueue.h>=0A=
+=0A=
+#include <scsi/scsi.h>=0A=
+#include <scsi/scsi_cmnd.h>=0A=
+#include <scsi/scsi_device.h>=0A=
+#include <scsi/scsi_host.h>=0A=
+#include <scsi/scsi_tcq.h>=0A=
+=0A=
+#include "mptbase.h"=0A=
+#include "mptscsi.h"=0A=
+=0A=
+/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
+#define my_NAME		"Fusion MPT SCSI Host driver"=0A=
+#define my_VERSION	MPT_LINUX_VERSION_COMMON=0A=
+#define MYNAM		"mptscsih"=0A=
+=0A=
+MODULE_AUTHOR(MODULEAUTHOR);=0A=
+MODULE_DESCRIPTION(my_NAME);=0A=
+MODULE_LICENSE("GPL");=0A=
+=0A=
+/* Command line args */=0A=
+#ifdef MPTSCSIH_ENABLE_DOMAIN_VALIDATION=0A=
+static int mpt_dv =3D MPTSCSIH_DOMAIN_VALIDATION;=0A=
+MODULE_PARM(mpt_dv, "i");=0A=
+MODULE_PARM_DESC(mpt_dv, " DV Algorithm: enhanced=3D1, basic=3D0 =
(default=3DMPTSCSIH_DOMAIN_VALIDATION=3D1)");=0A=
+=0A=
+static int mpt_width =3D MPTSCSIH_MAX_WIDTH;=0A=
+MODULE_PARM(mpt_width, "i");=0A=
+MODULE_PARM_DESC(mpt_width, " Max Bus Width: wide=3D1, narrow=3D0 =
(default=3DMPTSCSIH_MAX_WIDTH=3D1)");=0A=
+=0A=
+static int mpt_factor =3D MPTSCSIH_MIN_SYNC;=0A=
+MODULE_PARM(mpt_factor, "h");=0A=
+MODULE_PARM_DESC(mpt_factor, " Min Sync Factor (default=3DMPTSCSIH_MIN_=
SYNC=3D0x08)");=0A=
+#endif=0A=
+=0A=
+static int mpt_saf_te =3D MPTSCSIH_SAF_TE;=0A=
+MODULE_PARM(mpt_saf_te, "i");=0A=
+MODULE_PARM_DESC(mpt_saf_te, " Force enabling SEP Processor: =
enable=3D1  (default=3DMPTSCSIH_SAF_TE=3D0)");=0A=
+=0A=
+static int mpt_pq_filter =3D 0;=0A=
+MODULE_PARM(mpt_pq_filter, "i");=0A=
+MODULE_PARM_DESC(mpt_pq_filter, " Enable peripheral qualifier filter: =
enable=3D1  (default=3D0)");=0A=
+=0A=
+/* module entry point */=0A=
+static int  __init   mptscsih_init  (void);=0A=
+static void __exit   mptscsih_exit  (void);=0A=
+=0A=
+=0A=
+static int	mptscsihDoneCtx =3D -1;=0A=
+static int	mptscsihTaskCtx =3D -1;=0A=
+static int	mptscsihInternalCtx =3D -1; /* Used only for internal =
commands */=0A=
+=0A=
+=0A=
+static struct device_attribute mptscsih_queue_depth_attr =3D {=0A=
+	.attr =3D {=0A=
+		.name =3D 	"queue_depth",=0A=
+		.mode =3D		S_IWUSR,=0A=
+	},=0A=
+	.store =3D mpt_core_store_queue_depth,=0A=
+};=0A=
+=0A=
+static struct device_attribute *mptscsih_dev_attrs[] =3D {=0A=
+	&mptscsih_queue_depth_attr,=0A=
+	NULL,=0A=
+};=0A=
+=0A=
+static struct scsi_host_template mptscsih_driver_template =3D {=0A=
+	.proc_name			=3D "mptscsih",=0A=
+	.proc_info			=3D mpt_core_proc_info,=0A=
+	.name				=3D "MPT SCSI Host",=0A=
+	.info				=3D mpt_core_info,=0A=
+	.queuecommand			=3D mpt_core_qcmd,=0A=
+	.slave_alloc			=3D mpt_core_slave_alloc,=0A=
+	.slave_configure		=3D mpt_core_slave_configure,=0A=
+	.slave_destroy			=3D mpt_core_slave_destroy,=0A=
+	.eh_abort_handler		=3D mpt_core_abort,=0A=
+	.eh_device_reset_handler	=3D mpt_core_dev_reset,=0A=
+	.eh_bus_reset_handler		=3D mpt_core_bus_reset,=0A=
+	.eh_host_reset_handler		=3D mpt_core_host_reset,=0A=
+	.bios_param			=3D mpt_core_bios_param,=0A=
+	.can_queue			=3D MPT_SCSI_CAN_QUEUE,=0A=
+	.this_id			=3D -1,=0A=
+	.sg_tablesize			=3D MPT_SCSI_SG_DEPTH,=0A=
+	.max_sectors			=3D 8192,=0A=
+	.cmd_per_lun			=3D 7,=0A=
+	.use_clustering			=3D ENABLE_CLUSTERING,=0A=
+	.sdev_attrs			=3D mptscsih_dev_attrs,=0A=
+};=0A=
+=0A=
+/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
+/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
+/*=0A=
+ *	mptscsih_probe - Installs scsi devices per bus.=0A=
+ *	@pdev: Pointer to pci_dev structure=0A=
+ *=0A=
+ *	Returns 0 for success, non-zero for failure.=0A=
+ *=0A=
+ */=0A=
+static int=0A=
+mptscsih_probe(struct pci_dev *pdev, const struct pci_device_id =
*id)=0A=
+{=0A=
+	struct Scsi_Host	*sh;=0A=
+	MPT_SCSI_HOST		*hd;=0A=
+	MPT_ADAPTER 		*ioc =3D pci_get_drvdata(pdev);=0A=
+	unsigned long		 flags;=0A=
+	int			 sz, ii;=0A=
+	int			 numSGE =3D 0;=0A=
+	int			 scale;=0A=
+	int			 ioc_cap;=0A=
+	u8			*mem;=0A=
+	int			error=3D0;=0A=
+=0A=
+	/*  Added sanity check on readiness of the MPT adapter.=0A=
+	 */=0A=
+	if (ioc->last_state !=3D MPI_IOC_STATE_OPERATIONAL) {=0A=
+		printk(MYIOC_s_WARN_FMT=0A=
+		  "Skipping because it's not operational!\n",=0A=
+		  ioc->name);=0A=
+		return -ENODEV;=0A=
+	}=0A=
+=0A=
+	if (!ioc->active) {=0A=
+		printk(MYIOC_s_WARN_FMT "Skipping because it's disabled!\n",=0A=
+		  ioc->name);=0A=
+		return -ENODEV;=0A=
+	}=0A=
+=0A=
+	/*  Sanity check - ensure at least 1 port is INITIATOR capable=0A=
+	 */=0A=
+	ioc_cap =3D 0;=0A=
+	for (ii=3D0; ii < ioc->facts.NumberOfPorts; ii++) {=0A=
+		if (ioc->pfacts[ii].ProtocolFlags &=0A=
+		    MPI_PORTFACTS_PROTOCOL_INITIATOR)=0A=
+			ioc_cap ++;=0A=
+	}=0A=
+=0A=
+	if (!ioc_cap) {=0A=
+		printk(MYIOC_s_WARN_FMT=0A=
+			"Skipping ioc=3D%p because SCSI Initiator mode is NOT =
enabled!\n",=0A=
+			ioc->name, ioc);=0A=
+		return -ENODEV;=0A=
+	}=0A=
+=0A=
+	sh =3D scsi_host_alloc(&mptscsih_driver_template, =
sizeof(MPT_SCSI_HOST));=0A=
+=0A=
+	if (!sh) {=0A=
+		printk(MYIOC_s_WARN_FMT=0A=
+			"Unable to register controller with SCSI subsystem\n",=0A=
+			ioc->name);=0A=
+                return -1;=0A=
+        }=0A=
+=0A=
+	spin_lock_irqsave(&ioc->FreeQlock, flags);=0A=
+=0A=
+	/* Attach the SCSI Host to the IOC structure=0A=
+	 */=0A=
+	ioc->sh =3D sh;=0A=
+=0A=
+	sh->io_port =3D 0;=0A=
+	sh->n_io_port =3D 0;=0A=
+	sh->irq =3D 0;=0A=
+=0A=
+	/* set 16 byte cdb's */=0A=
+	sh->max_cmd_len =3D 16;=0A=
+=0A=
+	/* Yikes!  This is important!=0A=
+	 * Otherwise, by default, linux=0A=
+	 * only scans target IDs 0-7!=0A=
+	 * pfactsN->MaxDevices unreliable=0A=
+	 * (not supported in early=0A=
+	 *	versions of the FW).=0A=
+	 * max_id =3D 1 + actual max id,=0A=
+	 * max_lun =3D 1 + actual last lun,=0A=
+	 *	see hosts.h :o(=0A=
+	 */=0A=
+	sh->max_id =3D MPT_MAX_SCSI_DEVICES;=0A=
+=0A=
+	sh->max_lun =3D MPT_LAST_LUN + 1;=0A=
+	sh->max_channel =3D 0;=0A=
+	sh->this_id =3D ioc->pfacts[0].PortSCSIID;=0A=
+=0A=
+	/* Required entry.=0A=
+	 */=0A=
+	sh->unique_id =3D ioc->id;=0A=
+=0A=
+	/* Verify that we won't exceed the maximum=0A=
+	 * number of chain buffers=0A=
+	 * We can optimize:  ZZ =3D req_sz/sizeof(SGE)=0A=
+	 * For 32bit SGE's:=0A=
+	 *  numSGE =3D 1 + (ZZ-1)*(maxChain -1) + ZZ=0A=
+	 *               + (req_sz - 64)/sizeof(SGE)=0A=
+	 * A slightly different algorithm is required for=0A=
+	 * 64bit SGEs.=0A=
+	 */=0A=
+	scale =3D ioc->req_sz/(sizeof(dma_addr_t) + sizeof(u32));=0A=
+	if (sizeof(dma_addr_t) =3D=3D sizeof(u64)) {=0A=
+		numSGE =3D (scale - 1) *=0A=
+		  (ioc->facts.MaxChainDepth-1) + scale +=0A=
+		  (ioc->req_sz - 60) / (sizeof(dma_addr_t) +=0A=
+		  sizeof(u32));=0A=
+	} else {=0A=
+		numSGE =3D 1 + (scale - 1) *=0A=
+		  (ioc->facts.MaxChainDepth-1) + scale +=0A=
+		  (ioc->req_sz - 64) / (sizeof(dma_addr_t) +=0A=
+		  sizeof(u32));=0A=
+	}=0A=
+=0A=
+	if (numSGE < sh->sg_tablesize) {=0A=
+		/* Reset this value */=0A=
+		dprintk((MYIOC_s_INFO_FMT=0A=
+		  "Resetting sg_tablesize to %d from %d\n",=0A=
+		  ioc->name, numSGE, sh->sg_tablesize));=0A=
+		sh->sg_tablesize =3D numSGE;=0A=
+	}=0A=
+=0A=
+	/* Set the pci device pointer in Scsi_Host structure.=0A=
+	 */=0A=
+	scsi_set_device(sh, &ioc->pcidev->dev);=0A=
+=0A=
+	spin_unlock_irqrestore(&ioc->FreeQlock, flags);=0A=
+=0A=
+	hd =3D (MPT_SCSI_HOST *) sh->hostdata;=0A=
+	hd->ioc =3D ioc;=0A=
+=0A=
+	/* SCSI needs scsi_cmnd lookup table!=0A=
+	 * (with size equal to req_depth*PtrSz!)=0A=
+	 */=0A=
+	sz =3D ioc->req_depth * sizeof(void *);=0A=
+	mem =3D kmalloc(sz, GFP_ATOMIC);=0A=
+	if (mem =3D=3D NULL) {=0A=
+		error =3D -ENOMEM;=0A=
+		goto mptscsih_probe_failed;=0A=
+	}=0A=
+=0A=
+	memset(mem, 0, sz);=0A=
+	hd->ScsiLookup =3D (struct scsi_cmnd **) mem;=0A=
+=0A=
+	dprintk((MYIOC_s_INFO_FMT "ScsiLookup @ %p, sz=3D%d\n",=0A=
+		 ioc->name, hd->ScsiLookup, sz));=0A=
+=0A=
+	/* Allocate memory for the device structures.=0A=
+	 * A non-Null pointer at an offset=0A=
+	 * indicates a device exists.=0A=
+	 * max_id =3D 1 + maximum id (hosts.h)=0A=
+	 */=0A=
+	sz =3D sh->max_id * sizeof(void *);=0A=
+	mem =3D kmalloc(sz, GFP_ATOMIC);=0A=
+	if (mem =3D=3D NULL) {=0A=
+		error =3D -ENOMEM;=0A=
+		goto mptscsih_probe_failed;=0A=
+	}=0A=
+=0A=
+	memset(mem, 0, sz);=0A=
+	hd->Targets =3D (VirtDevice **) mem;=0A=
+=0A=
+	dprintk((KERN_INFO=0A=
+	  "  Targets @ %p, sz=3D%d\n", hd->Targets, sz));=0A=
+=0A=
+	/* Clear the TM flags=0A=
+	 */=0A=
+	hd->tmPending =3D 0;=0A=
+	hd->tmState =3D TM_STATE_NONE;=0A=
+	hd->resetPending =3D 0;=0A=
+	hd->abortSCpnt =3D NULL;=0A=
+=0A=
+	/* Clear the pointer used to store=0A=
+	 * single-threaded commands, i.e., those=0A=
+	 * issued during a bus scan, dv and=0A=
+	 * configuration pages.=0A=
+	 */=0A=
+	hd->cmdPtr =3D NULL;=0A=
+=0A=
+	/* Initialize this SCSI Hosts' timers=0A=
+	 * To use, set the timer expires field=0A=
+	 * and add_timer=0A=
+	 */=0A=
+	init_timer(&hd->timer);=0A=
+	hd->timer.data =3D (unsigned long) hd;=0A=
+	hd->timer.function =3D mpt_core_timer_expired;=0A=
+=0A=
+	ioc->spi_data.Saf_Te =3D mpt_saf_te;=0A=
+	ioc->spi_data.mpt_pq_filter =3D mpt_pq_filter;=0A=
+=0A=
+#ifdef MPTSCSIH_ENABLE_DOMAIN_VALIDATION=0A=
+	if (ioc->spi_data.maxBusWidth > mpt_width)=0A=
+		ioc->spi_data.maxBusWidth =3D mpt_width;=0A=
+	if (ioc->spi_data.minSyncFactor < mpt_factor)=0A=
+		ioc->spi_data.minSyncFactor =3D mpt_factor;=0A=
+	if (ioc->spi_data.minSyncFactor =3D=3D MPT_ASYNC) {=0A=
+		ioc->spi_data.maxSyncOffset =3D 0;=0A=
+	}=0A=
+	ioc->spi_data.mpt_dv =3D mpt_dv;=0A=
+	hd->negoNvram =3D 0;=0A=
+=0A=
+	ddvprintk((MYIOC_s_INFO_FMT=0A=
+		"dv %x width %x factor %x saf_te %x mpt_pq_filter %x\n",=0A=
+		ioc->name,=0A=
+		mpt_dv,=0A=
+		mpt_width,=0A=
+		mpt_factor,=0A=
+		mpt_saf_te,=0A=
+		mpt_pq_filter));=0A=
+#else=0A=
+	hd->negoNvram =3D MPT_SCSICFG_USE_NVRAM;=0A=
+	ddvprintk((MYIOC_s_INFO_FMT=0A=
+		"saf_te %x mpt_pq_filter %x\n",=0A=
+		ioc->name,=0A=
+		mpt_saf_te,=0A=
+		mpt_pq_filter));=0A=
+#endif=0A=
+=0A=
+	ioc->spi_data.forceDv =3D 0;=0A=
+	ioc->spi_data.noQas =3D 0;=0A=
+=0A=
+	for (ii=3D0; ii < MPT_MAX_SCSI_DEVICES; ii++)=0A=
+		ioc->spi_data.dvStatus[ii] =3D=0A=
+		  MPT_SCSICFG_NEGOTIATE;=0A=
+=0A=
+	for (ii=3D0; ii < MPT_MAX_SCSI_DEVICES; ii++)=0A=
+		ioc->spi_data.dvStatus[ii] |=3D=0A=
+		  MPT_SCSICFG_DV_NOT_DONE;=0A=
+=0A=
+	init_waitqueue_head(&hd->scandv_waitq);=0A=
+	hd->scandv_wait_done =3D 0;=0A=
+	hd->last_queue_full =3D 0;=0A=
+=0A=
+	ioc->DoneCtx =3D mptscsihDoneCtx;=0A=
+	ioc->TaskCtx =3D mptscsihTaskCtx;=0A=
+	ioc->InternalCtx =3D mptscsihInternalCtx;=0A=
+=0A=
+	error =3D scsi_add_host (sh, &ioc->pcidev->dev);=0A=
+	if(error) {=0A=
+		dprintk((KERN_ERR MYNAM=0A=
+		  "scsi_add_host failed\n"));=0A=
+		goto mptscsih_probe_failed;=0A=
+	}=0A=
+=0A=
+	scsi_scan_host(sh);=0A=
+	return 0;=0A=
+=0A=
+mptscsih_probe_failed:=0A=
+=0A=
+	mpt_core_remove(pdev);=0A=
+	return error;=0A=
+}=0A=
+=0A=
+static struct mpt_pci_driver mptscsih_driver =3D {=0A=
+	.probe		=3D mptscsih_probe,=0A=
+	.remove		=3D mpt_core_remove,=0A=
+	.shutdown	=3D mpt_core_shutdown,=0A=
+#ifdef CONFIG_PM=0A=
+	.suspend	=3D mpt_core_suspend,=0A=
+	.resume		=3D mpt_core_resume,=0A=
+#endif=0A=
+};=0A=
+=0A=
+/*  SCSI host fops start here...  */=0A=
+/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
+/**=0A=
+ *	mptscsih_init - Register MPT adapter(s) as SCSI host(s) with=0A=
+ *	linux scsi mid-layer.=0A=
+ *=0A=
+ *	Returns 0 for success, non-zero for failure.=0A=
+ */=0A=
+static int __init=0A=
+mptscsih_init(void)=0A=
+{=0A=
+=0A=
+	show_mptmod_ver(my_NAME, my_VERSION);=0A=
+=0A=
+	mptscsihDoneCtx =3D mpt_register(mpt_core_io_done, =
MPTSCSIH_DRIVER);=0A=
+	mptscsihTaskCtx =3D mpt_register(mpt_core_taskmgmt_complete, =
MPTSCSIH_DRIVER);=0A=
+	mptscsihInternalCtx =3D mpt_register(mpt_core_scandv_complete, =
MPTSCSIH_DRIVER);=0A=
+=0A=
+	if (mpt_event_register(mptscsihDoneCtx, mpt_core_event_process) =
=3D=3D 0) {=0A=
+		devtprintk((KERN_INFO MYNAM=0A=
+		  ": Registered for IOC event notifications\n"));=0A=
+	}=0A=
+=0A=
+	if (mpt_reset_register(mptscsihDoneCtx, mpt_core_ioc_reset) =3D=3D 0) =
{=0A=
+		dprintk((KERN_INFO MYNAM=0A=
+		  ": Registered for IOC reset notifications\n"));=0A=
+	}=0A=
+=0A=
+	if(mpt_device_driver_register(&mptscsih_driver,=0A=
+	  MPTSCSIH_DRIVER) !=3D 0 ) {=0A=
+		dprintk((KERN_INFO MYNAM=0A=
+		": failed to register dd callbacks\n"));=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
+/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
+/**=0A=
+ *	mptscsih_exit - Unregisters MPT adapter(s)=0A=
+ *=0A=
+ */=0A=
+static void __exit=0A=
+mptscsih_exit(void)=0A=
+{=0A=
+	mpt_device_driver_deregister(MPTSCSIH_DRIVER);=0A=
+=0A=
+	mpt_reset_deregister(mptscsihDoneCtx);=0A=
+	dprintk((KERN_INFO MYNAM=0A=
+	  ": Deregistered for IOC reset notifications\n"));=0A=
+=0A=
+	mpt_event_deregister(mptscsihDoneCtx);=0A=
+	dprintk((KERN_INFO MYNAM=0A=
+	  ": Deregistered for IOC event notifications\n"));=0A=
+=0A=
+	mpt_deregister(mptscsihInternalCtx);=0A=
+	mpt_deregister(mptscsihTaskCtx);=0A=
+	mpt_deregister(mptscsihDoneCtx);=0A=
+}=0A=
+=0A=
+=0A=
+=0A=
+module_init(mptscsih_init);=0A=
+module_exit(mptscsih_exit);=0A=

------_=_NextPart_000_01C530CD.2D4D0B60--
