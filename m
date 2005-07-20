Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVGTDIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVGTDIo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 23:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVGTDIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 23:08:43 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:30896 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261384AbVGTDIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 23:08:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jtk/GWizg8DzNIlzJPZUUDFkPOo+sZVGY89vdUpG0OXJqhKfAjxNOzXhO/AaurgomPjSsv/MeelBRRfAbh8K//K9CWTH/JFvxfdBmAkQwKmkGnKFjQ+UM/+Z8nsEntt+NJGmap0LP2HlWzsmCoxnvLPm/HlhYCx///FLxs/axZc=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] QLogic SCSI driver Kconfig fixes
Date: Wed, 20 Jul 2005 05:26:01 +0200
User-Agent: KMail/1.8.1
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-scsi@vger.kernel.org,
       "James E.J. Bottomley" <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507200526.02413.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem in a nutshell is that the tristate `config SCSI_QLA2XXX' does not 
have a name and thus does not show up in menuconfig and similar. This coupled 
with the fact that it defaults to `y' when config PCI and config SCSI is 
selected results in people (like me) who need PCI and SCSI support but have no 
need of the QLogic drivers end up with the following warnings at build time 
(and a superfluous kernel .ko file), since there's no way to disable 
SCSI_QLA2XXX : 

  Building modules, stage 2.
  MODPOST
*** Warning: "request_firmware" [drivers/scsi/qla2xxx/qla2xxx.ko] undefined!
*** Warning: "release_firmware" [drivers/scsi/qla2xxx/qla2xxx.ko] undefined!

In addition to that, SCSI_QLA2XXX has no help text entry.


Below I've included 3 patches to fix the problem in various ways (yes, I know 
there should only be one patch pr email normally, but it seemed silly to send 
3 emails with 3 different suggested patches for the same problem). The third 
patch is my personal favorite, but I present all 3 to let you choose which one 
you like best.



This patch just adds a name to the option so people can at least deselect it 
if they don't need it, and it adds a help text.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/scsi/qla2xxx/Kconfig |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

--- linux-2.6.13-rc3-mm1-orig/drivers/scsi/qla2xxx/Kconfig	2005-07-17 04:39:52.000000000 +0200
+++ linux-2.6.13-rc3-mm1/drivers/scsi/qla2xxx/Kconfig	2005-07-20 04:59:47.000000000 +0200
@@ -1,8 +1,12 @@
 config SCSI_QLA2XXX
-	tristate
+	tristate "QLogic ISP2XXX SCSI host adapter family support"
 	default (SCSI && PCI)
 	depends on SCSI && PCI
 	select SCSI_FC_ATTRS
+	---help---
+	Support the QLogic 2XXX (ISP2XXX) family of host bus adapters.
+	In addition to this option you should select the specific HBAs
+	you want to support from the submenu items.
 
 config SCSI_QLA21XX
 	tristate "QLogic ISP2100 host adapter family support"



This patch adds a name to the option so it can be deselected if not needed, 
adds a help entry and also adds the selection of config FW_LOADER if this 
option is selected, so it'll build without problems for people who select it 
without them having to go hunt for config FW_LOADER themselves.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/scsi/qla2xxx/Kconfig |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

--- linux-2.6.13-rc3-mm1-orig/drivers/scsi/qla2xxx/Kconfig	2005-07-17 04:39:52.000000000 +0200
+++ linux-2.6.13-rc3-mm1/drivers/scsi/qla2xxx/Kconfig	2005-07-20 05:00:57.000000000 +0200
@@ -1,8 +1,13 @@
 config SCSI_QLA2XXX
-	tristate
+	tristate "QLogic ISP2XXX SCSI host adapter family support"
 	default (SCSI && PCI)
 	depends on SCSI && PCI
 	select SCSI_FC_ATTRS
+	select FW_LOADER
+	---help---
+	Support the QLogic 2XXX (ISP2XXX) family of host bus adapters.
+	In addition to this option you should select the specific HBAs
+	you want to support from the submenu items.
 
 config SCSI_QLA21XX
 	tristate "QLogic ISP2100 host adapter family support"



This patch adds a name to the option so it can be deselected if not needed, it 
also adds a help text and selection of config FW_LOADER if this option is 
selected, so it'll build without problems for people who select it without 
them having to go hunt for config FW_LOADER themselves, and finally it makes 
the option default to `n' since I don't see a point in having any specific 
SCSI drivers be default enabled - surely people who actually need the option 
can select it by themselves (especially now that it'll cause the automatic 
selection of FW_LOADER).

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/scsi/qla2xxx/Kconfig |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

--- linux-2.6.13-rc3-mm1-orig/drivers/scsi/qla2xxx/Kconfig	2005-07-17 04:39:52.000000000 +0200
+++ linux-2.6.13-rc3-mm1/drivers/scsi/qla2xxx/Kconfig	2005-07-20 05:02:50.000000000 +0200
@@ -1,8 +1,13 @@
 config SCSI_QLA2XXX
-	tristate
-	default (SCSI && PCI)
+	tristate "QLogic ISP2XXX SCSI host adapter family support"
+	default n
 	depends on SCSI && PCI
 	select SCSI_FC_ATTRS
+	select FW_LOADER
+	---help---
+	Support the QLogic 2XXX (ISP2XXX) family of host bus adapters.
+	In addition to this option you should select the specific HBAs
+	you want to support from the submenu items.
 
 config SCSI_QLA21XX
 	tristate "QLogic ISP2100 host adapter family support"



Feel free to pick the patch you believe fix the problem best. :-)


Kind regards,

Jesper Juhl <jesper.juhl@gmail.com>


PS. Please keep me on CC if you do not reply directly to me or to linux-kernel, 
since I'm not subscribed to linux-scsi.


