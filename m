Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbWJJHDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWJJHDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 03:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWJJHDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 03:03:36 -0400
Received: from havoc.gtf.org ([69.61.125.42]:13966 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965055AbWJJHDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 03:03:35 -0400
Date: Tue, 10 Oct 2006 03:03:34 -0400
From: Jeff Garzik <jeff@garzik.org>
To: tigran@veritas.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/microcode: handle sysfs errors
Message-ID: <20061010070334.GA22084@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

Note that the driver code API must be fixed to actually check the return
code of the ->add() hook, for this patch to be of any real use.

 arch/i386/kernel/microcode.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

a95aa9d762b6571bf52b50e47b4d2793eb649b1c
diff --git a/arch/i386/kernel/microcode.c b/arch/i386/kernel/microcode.c
index bca92be..441f140 100644
--- a/arch/i386/kernel/microcode.c
+++ b/arch/i386/kernel/microcode.c
@@ -656,14 +656,18 @@ static struct attribute_group mc_attr_gr
 
 static int mc_sysdev_add(struct sys_device *sys_dev)
 {
-	int cpu = sys_dev->id;
+	int err, cpu = sys_dev->id;
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 
 	if (!cpu_online(cpu))
 		return 0;
+
 	pr_debug("Microcode:CPU %d added\n", cpu);
 	memset(uci, 0, sizeof(*uci));
-	sysfs_create_group(&sys_dev->kobj, &mc_attr_group);
+
+	err = sysfs_create_group(&sys_dev->kobj, &mc_attr_group);
+	if (err)
+		return err;
 
 	microcode_init_cpu(cpu);
 	return 0;
