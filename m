Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVCYAWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVCYAWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 19:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVCYAWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 19:22:20 -0500
Received: from mail0.lsil.com ([147.145.40.20]:6113 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261252AbVCXX4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 18:56:55 -0500
Message-ID: <91888D455306F94EBD4D168954A9457C01B70562@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] - MPT FUSION - SPLITTING SCSI HOST DRIVERS
Date: Thu, 24 Mar 2005 16:56:53 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C530CD.27278EE0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C530CD.27278EE0
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

(3) mptlinux-3.03.00-3-mptscsih-h - delete mptscsih.h, code moved to
mptscsi.h

Please apply this patch against the 3.01.20 version of the mpt driver
in http://linux-scsi.bkbits.net:8080/scsi-misc-2.6

Backup of these patches can be found at this ftp:
ftp://ftp.lsil.com/HostAdapterDrivers/linux/Fusion-MPT/2.6-kernel/3.03.00/

Signed-off-by: Eric Moore <Eric.Moore@lsil.com>



------_=_NextPart_000_01C530CD.27278EE0
Content-Type: application/octet-stream;
	name="mptlinux-3.03.00-3-mptscsih-h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mptlinux-3.03.00-3-mptscsih-h"

diff -uarN drivers/message/fusion-3.01.20/mptscsih.h =
drivers/message/fusion/mptscsih.h=0A=
--- drivers/message/fusion-3.01.20/mptscsih.h	2005-03-22 =
10:50:14.000000000 -0700=0A=
+++ drivers/message/fusion/mptscsih.h	1969-12-31 17:00:00.000000000 =
-0700=0A=
@@ -1,94 +0,0 @@=0A=
-/*=0A=
- *  linux/drivers/message/fusion/mptscsih.h=0A=
- *      High performance SCSI / Fibre Channel SCSI Host device =
driver.=0A=
- *      For use with PCI chip/adapter(s):=0A=
- *          LSIFC9xx/LSI409xx Fibre Channel=0A=
- *      running LSI Logic Fusion MPT (Message Passing Technology) =
firmware.=0A=
- *=0A=
- *  Credits:=0A=
- *      This driver would not exist if not for Alan Cox's =
development=0A=
- *      of the linux i2o driver.=0A=
- *=0A=
- *      A huge debt of gratitude is owed to David S. Miller (DaveM)=0A=
- *      for fixing much of the stupid and broken stuff in the early=0A=
- *      driver while porting to sparc64 platform.  THANK YOU!=0A=
- *=0A=
- *      (see also mptbase.c)=0A=
- *=0A=
- *  Copyright (c) 1999-2004 LSI Logic Corporation=0A=
- *  Originally By: Steven J. Ralston=0A=
- *  (mailto:netscape.net)=0A=
- *  (mailto:mpt_linux_developer@lsil.com)=0A=
- *=0A=
- *  $Id: mptscsih.h,v 1.21 2002/12/03 21:26:35 pdelaney Exp $=0A=
- */=0A=
-/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
-/*=0A=
-    This program is free software; you can redistribute it and/or =
modify=0A=
-    it under the terms of the GNU General Public License as published =
by=0A=
-    the Free Software Foundation; version 2 of the License.=0A=
-=0A=
-    This program is distributed in the hope that it will be useful,=0A=
-    but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
-    GNU General Public License for more details.=0A=
-=0A=
-    NO WARRANTY=0A=
-    THE PROGRAM IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES =
OR=0A=
-    CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED INCLUDING, =
WITHOUT=0A=
-    LIMITATION, ANY WARRANTIES OR CONDITIONS OF TITLE, =
NON-INFRINGEMENT,=0A=
-    MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Each =
Recipient is=0A=
-    solely responsible for determining the appropriateness of using =
and=0A=
-    distributing the Program and assumes all risks associated with =
its=0A=
-    exercise of rights under this Agreement, including but not limited =
to=0A=
-    the risks and costs of program errors, damage to or loss of =
data,=0A=
-    programs or equipment, and unavailability or interruption of =
operations.=0A=
-=0A=
-    DISCLAIMER OF LIABILITY=0A=
-    NEITHER RECIPIENT NOR ANY CONTRIBUTORS SHALL HAVE ANY LIABILITY =
FOR ANY=0A=
-    DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR =
CONSEQUENTIAL=0A=
-    DAMAGES (INCLUDING WITHOUT LIMITATION LOST PROFITS), HOWEVER =
CAUSED AND=0A=
-    ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, =
OR=0A=
-    TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF =
THE=0A=
-    USE OR DISTRIBUTION OF THE PROGRAM OR THE EXERCISE OF ANY RIGHTS =
GRANTED=0A=
-    HEREUNDER, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGES=0A=
-=0A=
-    You should have received a copy of the GNU General Public =
License=0A=
-    along with this program; if not, write to the Free Software=0A=
-    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  =
02111-1307  USA=0A=
-*/=0A=
-=0A=
-#ifndef SCSIHOST_H_INCLUDED=0A=
-#define SCSIHOST_H_INCLUDED=0A=
-=0A=
-/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
-/*=0A=
- *	SCSI Public stuff...=0A=
- */=0A=
-=0A=
-#define MPT_SCSI_CMD_PER_DEV_HIGH	31=0A=
-#define MPT_SCSI_CMD_PER_DEV_LOW	7=0A=
-=0A=
-#define MPT_SCSI_CMD_PER_LUN		7=0A=
-=0A=
-#define MPT_SCSI_MAX_SECTORS    8192=0A=
-=0A=
-/* To disable domain validation, uncomment the=0A=
- * following line. No effect for FC devices.=0A=
- * For SCSI devices, driver will negotiate to=0A=
- * NVRAM settings (if available) or to maximum adapter=0A=
- * capabilities.=0A=
- */=0A=
-=0A=
-#define MPTSCSIH_ENABLE_DOMAIN_VALIDATION=0A=
-=0A=
-=0A=
-/* SCSI driver setup structure. Settings can be overridden=0A=
- * by command line options.=0A=
- */=0A=
-#define MPTSCSIH_DOMAIN_VALIDATION      1=0A=
-#define MPTSCSIH_MAX_WIDTH              1=0A=
-#define MPTSCSIH_MIN_SYNC               0x08=0A=
-#define MPTSCSIH_SAF_TE                 0=0A=
-=0A=
-#endif=0A=

------_=_NextPart_000_01C530CD.27278EE0--
