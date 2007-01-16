Return-Path: <linux-kernel-owner+w=401wt.eu-S1751565AbXAPQr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbXAPQr0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbXAPQqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:46:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38154 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbXAPQqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:46:23 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       <netdev@vger.kernel.org>, xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
       linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
       minyard@acm.org, openipmi-developer@lists.sourceforge.net,
       <tony.luck@intel.com>, linux-mips@linux-mips.org, ralf@linux-mips.org,
       schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com,
       linux-390@vm.marist.edu, paulus@samba.org, linuxppc-dev@ozlabs.org,
       lethal@linux-sh.org, linuxsh-shmedia-dev@lists.sourceforge.net,
       <ak@suse.de>, vojtech@suse.cz, clemens@ladisch.de, a.zummo@towertech.it,
       rtc-linux@googlegroups.com, linux-parport@lists.infradead.org,
       andrea@suse.de, tim@cyberelk.net, philb@gnu.org, aharkes@cs.cmu.edu,
       coda@cs.cmu.edu, codalist@TELEMANN.coda.cs.cmu.edu, aia21@cantab.net,
       linux-ntfs-dev@lists.sourceforge.net, mark.fasheh@oracle.com,
       kurt.hackel@oracle.com, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 20/59] sysctl: cdrom Don't set de->owner
Date: Tue, 16 Jan 2007 09:39:25 -0700
Message-Id: <11689656373737-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

There is no need for open files in /proc/sys/XXX to hold
a reference count on the module that provides the file
to prevent module unload races.  While there is code active
in the module p->used in the sysctl_table_header is incremented,
preventing the sysctl from being unregisted.  Once the
sysctl is unregistered it cannot be found.  Open files
are also not a problem as they revalidate the sysctl information
and bump p->used before accessing module code.

So setting de->owner is unnecessary, makes for a bad example
and gets in my way of removing ctl_table->de.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/cdrom/cdrom.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index f0a6801..14f72c4 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3554,8 +3554,6 @@ static void cdrom_sysctl_register(void)
 		return;
 
 	cdrom_sysctl_header = register_sysctl_table(cdrom_root_table, 0);
-	if (cdrom_root_table->ctl_name && cdrom_root_table->child->de)
-		cdrom_root_table->child->de->owner = THIS_MODULE;
 
 	/* set the defaults */
 	cdrom_sysctl_settings.autoclose = autoclose;
-- 
1.4.4.1.g278f

