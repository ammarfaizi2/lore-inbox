Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVCYArx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVCYArx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 19:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVCYArw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 19:47:52 -0500
Received: from mail0.lsil.com ([147.145.40.20]:7393 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261260AbVCXX5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 18:57:04 -0500
Message-ID: <91888D455306F94EBD4D168954A9457C01B70564@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] - MPT FUSION - SPLITTING SCSI HOST DRIVERS
Date: Thu, 24 Mar 2005 16:57:02 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C530CD.2CA16210"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C530CD.2CA16210
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

(5) mptlinux-3.03.00-5-mptscsi-h - formerly mptscsih.c

Please apply this patch against the 3.01.20 version of the mpt driver
in http://linux-scsi.bkbits.net:8080/scsi-misc-2.6

Backup of these patches can be found at this ftp:
ftp://ftp.lsil.com/HostAdapterDrivers/linux/Fusion-MPT/2.6-kernel/3.03.00/

Signed-off-by: Eric Moore <Eric.Moore@lsil.com>





------_=_NextPart_000_01C530CD.2CA16210
Content-Type: application/octet-stream;
	name="mptlinux-3.03.00-5-mptscsi-h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mptlinux-3.03.00-5-mptscsi-h"

diff -uarN drivers/message/fusion-3.01.20/mptscsi.h =
drivers/message/fusion/mptscsi.h=0A=
--- drivers/message/fusion-3.01.20/mptscsi.h	1969-12-31 =
17:00:00.000000000 -0700=0A=
+++ drivers/message/fusion/mptscsi.h	2005-03-23 10:42:57.000000000 =
-0700=0A=
@@ -0,0 +1,111 @@=0A=
+/*=0A=
+ *  linux/drivers/message/fusion/mptscsi.h=0A=
+ *      High performance SCSI / Fibre Channel SCSI Host device =
driver.=0A=
+ *      For use with PCI chip/adapter(s):=0A=
+ *          LSIFC9xx/LSI409xx Fibre Channel=0A=
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
+=0A=
+#ifndef SCSIHOST_H_INCLUDED=0A=
+#define SCSIHOST_H_INCLUDED=0A=
+=0A=
+/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
+/*=0A=
+ *	SCSI Public stuff...=0A=
+ */=0A=
+=0A=
+#define MPT_SCSI_CMD_PER_DEV_HIGH	31=0A=
+#define MPT_SCSI_CMD_PER_DEV_LOW	7=0A=
+=0A=
+#define MPT_SCSI_CMD_PER_LUN		7=0A=
+=0A=
+#define MPT_SCSI_MAX_SECTORS    8192=0A=
+=0A=
+/* To disable domain validation, uncomment the=0A=
+ * following line. No effect for FC devices.=0A=
+ * For SCSI devices, driver will negotiate to=0A=
+ * NVRAM settings (if available) or to maximum adapter=0A=
+ * capabilities.=0A=
+ */=0A=
+=0A=
+#define MPTSCSIH_ENABLE_DOMAIN_VALIDATION=0A=
+=0A=
+=0A=
+/* SCSI driver setup structure. Settings can be overridden=0A=
+ * by command line options.=0A=
+ */=0A=
+#define MPTSCSIH_DOMAIN_VALIDATION      1=0A=
+#define MPTSCSIH_MAX_WIDTH              1=0A=
+#define MPTSCSIH_MIN_SYNC               0x08=0A=
+#define MPTSCSIH_SAF_TE                 0=0A=
+=0A=
+=0A=
+#endif=0A=
+=0A=
+extern void mpt_core_remove(struct pci_dev *);=0A=
+extern void mpt_core_shutdown(struct device *);=0A=
+#ifdef CONFIG_PM=0A=
+extern int mpt_core_suspend(struct pci_dev *pdev, u32 state);=0A=
+extern int mpt_core_resume(struct pci_dev *pdev);=0A=
+#endif=0A=
+=0A=
+extern int mpt_core_proc_info(struct Scsi_Host *host, char *buffer, =
char **start, off_t offset, int length, int func);=0A=
+extern const char * mpt_core_info(struct Scsi_Host *SChost);=0A=
+extern int mpt_core_qcmd(struct scsi_cmnd *SCpnt, void (*done)(struct =
scsi_cmnd *));=0A=
+extern int mpt_core_slave_alloc(struct scsi_device *device);=0A=
+extern void mpt_core_slave_destroy(struct scsi_device *device);=0A=
+extern int mpt_core_slave_configure(struct scsi_device *device);=0A=
+extern int mpt_core_abort(struct scsi_cmnd * SCpnt);=0A=
+extern int mpt_core_dev_reset(struct scsi_cmnd * SCpnt);=0A=
+extern int mpt_core_bus_reset(struct scsi_cmnd * SCpnt);=0A=
+extern int mpt_core_host_reset(struct scsi_cmnd *SCpnt);=0A=
+extern int mpt_core_bios_param(struct scsi_device * sdev, struct =
block_device *bdev, sector_t capacity, int geom[]);=0A=
+=0A=
+=0A=
+extern int mpt_core_io_done(MPT_ADAPTER *ioc, MPT_FRAME_HDR *mf, =
MPT_FRAME_HDR *r);=0A=
+extern int mpt_core_taskmgmt_complete(MPT_ADAPTER *ioc, MPT_FRAME_HDR =
*mf, MPT_FRAME_HDR *r);=0A=
+extern int mpt_core_scandv_complete(MPT_ADAPTER *ioc, MPT_FRAME_HDR =
*mf, MPT_FRAME_HDR *r);=0A=
+extern int mpt_core_event_process(MPT_ADAPTER *ioc, =
EventNotificationReply_t *pEvReply);=0A=
+extern int mpt_core_ioc_reset(MPT_ADAPTER *ioc, int post_reset);=0A=
+=0A=
+extern ssize_t mpt_core_store_queue_depth(struct device *dev, const =
char *buf, size_t count);=0A=
+extern void mpt_core_timer_expired(unsigned long data);=0A=

------_=_NextPart_000_01C530CD.2CA16210--
