Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVFNDyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVFNDyn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 23:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVFNDxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 23:53:39 -0400
Received: from [143.106.24.129] ([143.106.24.129]:11742 "EHLO
	emilia.lsd.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S261432AbVFNDwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 23:52:14 -0400
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: sbp2 slab corruption
From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Date: 14 Jun 2005 00:49:59 -0300
Message-ID: <orhdg161i0.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Sorry for taking so long to post this patch.  I fixed this bug just
before two weeks in which I've been mostly away and disconnected.

This fixed a problem that showed up in the Fedora development tree a
few weeks before the Fedora Core 4 release, initially as slab
corruption, later as hard crashes on boot up, when slab debugging
was disabled for the release.  More details on the history at
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=158424

The problem is caused by sbp2's use of scsi_host->hostdata[0] to hold
a scsi_id, without explicitly requesting space for it.  Since hostdata
is declared as a zero-sized array, we don't get any such space by
default, so it must be explicitly requested.  The patch below
implements just that.

Signed-off-by: Alexandre Oliva <aoliva@redhat.com>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
  filename=firewire-scsi-host-slab-corruption.patch

--- drivers/ieee1394/sbp2.c~	2005-05-29 14:00:06.000000000 -0300
+++ drivers/ieee1394/sbp2.c	2005-05-29 20:04:07.000000000 -0300
@@ -745,7 +745,8 @@
 	list_add_tail(&scsi_id->scsi_list, &hi->scsi_ids);
 
 	/* Register our host with the SCSI stack. */
-	scsi_host = scsi_host_alloc(&scsi_driver_template, 0);
+	scsi_host = scsi_host_alloc(&scsi_driver_template,
+				    sizeof (unsigned long));
 	if (!scsi_host) {
 		SBP2_ERR("failed to register scsi host");
 		goto failed_alloc;

--=-=-=


-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}

--=-=-=--
