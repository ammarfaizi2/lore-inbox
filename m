Return-Path: <linux-kernel-owner+w=401wt.eu-S1751726AbXANXzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbXANXzX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 18:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbXANXzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 18:55:23 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:36693 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726AbXANXzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 18:55:21 -0500
Date: Mon, 15 Jan 2007 10:55:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 00/12] Fix ppc64's writing to struct file_operations
Message-Id: <20070115105501.0ec8ead0.sfr@canb.auug.org.au>
In-Reply-To: <20070114145411.1fd8c985@localhost.localdomain>
References: <1168735868.3123.315.camel@laptopd505.fenrus.org>
	<1168735914.3123.317.camel@laptopd505.fenrus.org>
	<20070114145411.1fd8c985@localhost.localdomain>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jan 2007 14:54:11 +0000 Alan <alan@lxorguk.ukuu.org.uk> wrote:
>
> This doesn't appea to do the same thing at all. You need to select
> between two sets of const inode ops instead, otherwise you turn write on
> arbitarily.

Or something like below ... (compile tested on pseries, iseries and combined).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
index 41c05dc..0de5a08 100644
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -439,6 +439,10 @@ static ssize_t lparcfg_write(struct file *file, const char __user * buf,
 
 	ssize_t retval = -ENOMEM;
 
+	if (!firmware_has_feature(FW_FEATURE_SPLPAR) ||
+			firmware_has_feature(FW_FEATURE_ISERIES))
+		return -EINVAL;
+
 	kbuf = kmalloc(count, GFP_KERNEL);
 	if (!kbuf)
 		goto out;
@@ -517,7 +521,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void *v)
 static ssize_t lparcfg_write(struct file *file, const char __user * buf,
 			     size_t count, loff_t * off)
 {
-	return count;
+	return -EINVAL;
 }
 
 #endif				/* CONFIG_PPC_PSERIES */
@@ -570,6 +574,7 @@ static int lparcfg_open(struct inode *inode, struct file *file)
 struct file_operations lparcfg_fops = {
 	.owner		= THIS_MODULE,
 	.read		= seq_read,
+	.write		= lparcfg_write,
 	.open		= lparcfg_open,
 	.release	= single_release,
 };
@@ -581,10 +586,8 @@ int __init lparcfg_init(void)
 
 	/* Allow writing if we have FW_FEATURE_SPLPAR */
 	if (firmware_has_feature(FW_FEATURE_SPLPAR) &&
-			!firmware_has_feature(FW_FEATURE_ISERIES)) {
-		lparcfg_fops.write = lparcfg_write;
+			!firmware_has_feature(FW_FEATURE_ISERIES))
 		mode |= S_IWUSR;
-	}
 
 	ent = create_proc_entry("ppc64/lparcfg", mode, NULL);
 	if (ent) {
