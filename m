Return-Path: <linux-kernel-owner+w=401wt.eu-S1751479AbXAPRCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbXAPRCH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbXAPRBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 12:01:47 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37922 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbXAPQoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:44:32 -0500
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
Subject: [PATCH 46/59] sysctl: C99 convert coda ctl_tables and remove binary sysctls.
Date: Tue, 16 Jan 2007 09:39:51 -0700
Message-Id: <11689656751225-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Will converting the coda sysctl initializers I discovered that
it is yet another user of sysctl that was stomping CTL_KERN.
So off with it's sys_sysctl support since it wasn't done
in a supportable way.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/coda/sysctl.c |   58 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/fs/coda/sysctl.c b/fs/coda/sysctl.c
index 1c82e9a..df682e2 100644
--- a/fs/coda/sysctl.c
+++ b/fs/coda/sysctl.c
@@ -32,8 +32,6 @@
 
 static struct ctl_table_header *fs_table_header;
 
-#define FS_CODA         1       /* Coda file system */
-
 #define CODA_TIMEOUT    3       /* timeout on upcalls to become intrble */
 #define CODA_HARD       5       /* mount type "hard" or "soft" */
 #define CODA_VFS 	 6       /* vfs statistics */
@@ -184,17 +182,57 @@ static int coda_cache_inv_stats_get_info( char * buffer, char ** start,
 }
 
 static ctl_table coda_table[] = {
- 	{CODA_TIMEOUT, "timeout", &coda_timeout, sizeof(int), 0644, NULL, &proc_dointvec},
- 	{CODA_HARD, "hard", &coda_hard, sizeof(int), 0644, NULL, &proc_dointvec},
- 	{CODA_VFS, "vfs_stats", NULL, 0, 0644, NULL, &do_reset_coda_vfs_stats},
- 	{CODA_CACHE_INV, "cache_inv_stats", NULL, 0, 0644, NULL, &do_reset_coda_cache_inv_stats},
- 	{CODA_FAKE_STATFS, "fake_statfs", &coda_fake_statfs, sizeof(int), 0600, NULL, &proc_dointvec},
-	{ 0 }
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "timeout",
+		.data		= &coda_timeout,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "hard",
+		.data		= &coda_hard,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "vfs_stats",
+		.data		= NULL,
+		.maxlen		= 0,
+		.mode		= 0644,
+		.proc_handler	= &do_reset_coda_vfs_stats
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "cache_inv_stats",
+		.data		= NULL,
+		.maxlen		= 0,
+		.mode		= 0644,
+		.proc_handler	= &do_reset_coda_cache_inv_stats
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "fake_statfs",
+		.data		= &coda_fake_statfs,
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= &proc_dointvec
+	},
+	{}
 };
 
 static ctl_table fs_table[] = {
-       {FS_CODA, "coda",    NULL, 0, 0555, coda_table},
-       {0}
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "coda",
+		.mode		= 0555,
+		.child		= coda_table
+	},
+	{}
 };
 
 
-- 
1.4.4.1.g278f

