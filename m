Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbUEFU6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUEFU6X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 16:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbUEFU6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 16:58:23 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:53150 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263015AbUEFU5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 16:57:52 -0400
Date: Thu, 06 May 2004 13:55:51 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, greg@kroah.com, hannal@us.ibm.com
Subject: [PATCH 2.6.6-rc3] Lindent on arch/i386/kernel/cpuid.c
Message-ID: <48660000.1083876951@dyn318071bld.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Per Greg's request this is a patch of having run Lindent on cpuid.c.
The tabs were not the right number of spaces before.  I have verified it 
still compiles and boots with this "change".

Please consider for inclusion.

Thanks.

Hanna Linder
IBM Linux Technology Center
------
diff -Nrup -Xdontdiff linux-2.6.6-rc3/arch/i386/kernel/cpuid.c linux-2.6.6-rc3p/arch/i386/kernel/cpuid.c
--- linux-2.6.6-rc3/arch/i386/kernel/cpuid.c	2004-04-27 18:34:58.000000000 -0700
+++ linux-2.6.6-rc3p/arch/i386/kernel/cpuid.c	2004-05-06 11:46:00.000000000 -0700
@@ -10,7 +10,6 @@
  *
  * ----------------------------------------------------------------------- */
 
-
 /*
  * cpuid.c
  *
@@ -46,132 +45,133 @@
 #ifdef CONFIG_SMP
 
 struct cpuid_command {
-  int cpu;
-  u32 reg;
-  u32 *data;
+	int cpu;
+	u32 reg;
+	u32 *data;
 };
 
 static void cpuid_smp_cpuid(void *cmd_block)
 {
-  struct cpuid_command *cmd = (struct cpuid_command *) cmd_block;
-  
-  if ( cmd->cpu == smp_processor_id() )
-    cpuid(cmd->reg, &cmd->data[0], &cmd->data[1], &cmd->data[2], &cmd->data[3]);
+	struct cpuid_command *cmd = (struct cpuid_command *)cmd_block;
+
+	if (cmd->cpu == smp_processor_id())
+		cpuid(cmd->reg, &cmd->data[0], &cmd->data[1], &cmd->data[2],
+		      &cmd->data[3]);
 }
 
-static inline void do_cpuid(int cpu, u32 reg, u32 *data)
+static inline void do_cpuid(int cpu, u32 reg, u32 * data)
 {
-  struct cpuid_command cmd;
-  
-  preempt_disable();
-  if ( cpu == smp_processor_id() ) {
-    cpuid(reg, &data[0], &data[1], &data[2], &data[3]);
-  } else {
-    cmd.cpu  = cpu;
-    cmd.reg  = reg;
-    cmd.data = data;
-    
-    smp_call_function(cpuid_smp_cpuid, &cmd, 1, 1);
-  }
-  preempt_enable();
+	struct cpuid_command cmd;
+
+	preempt_disable();
+	if (cpu == smp_processor_id()) {
+		cpuid(reg, &data[0], &data[1], &data[2], &data[3]);
+	} else {
+		cmd.cpu = cpu;
+		cmd.reg = reg;
+		cmd.data = data;
+
+		smp_call_function(cpuid_smp_cpuid, &cmd, 1, 1);
+	}
+	preempt_enable();
 }
-#else /* ! CONFIG_SMP */
+#else				/* ! CONFIG_SMP */
 
-static inline void do_cpuid(int cpu, u32 reg, u32 *data)
+static inline void do_cpuid(int cpu, u32 reg, u32 * data)
 {
-  cpuid(reg, &data[0], &data[1], &data[2], &data[3]);
+	cpuid(reg, &data[0], &data[1], &data[2], &data[3]);
 }
 
-#endif /* ! CONFIG_SMP */
+#endif				/* ! CONFIG_SMP */
 
 static loff_t cpuid_seek(struct file *file, loff_t offset, int orig)
 {
-  loff_t ret;
+	loff_t ret;
+
+	lock_kernel();
 
-  lock_kernel();
+	switch (orig) {
+	case 0:
+		file->f_pos = offset;
+		ret = file->f_pos;
+		break;
+	case 1:
+		file->f_pos += offset;
+		ret = file->f_pos;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	unlock_kernel();
+	return ret;
+}
+
+static ssize_t cpuid_read(struct file *file, char *buf,
+			  size_t count, loff_t * ppos)
+{
+	u32 *tmp = (u32 *) buf;
+	u32 data[4];
+	size_t rv;
+	u32 reg = *ppos;
+	int cpu = iminor(file->f_dentry->d_inode);
+
+	if (count % 16)
+		return -EINVAL;	/* Invalid chunk size */
+
+	for (rv = 0; count; count -= 16) {
+		do_cpuid(cpu, reg, data);
+		if (copy_to_user(tmp, &data, 16))
+			return -EFAULT;
+		tmp += 4;
+		*ppos = reg++;
+	}
 
-  switch (orig) {
-  case 0:
-    file->f_pos = offset;
-    ret = file->f_pos;
-    break;
-  case 1:
-    file->f_pos += offset;
-    ret = file->f_pos;
-    break;
-  default:
-    ret = -EINVAL;
-  }
-
-  unlock_kernel();
-  return ret;
-}
-
-static ssize_t cpuid_read(struct file * file, char * buf,
-			size_t count, loff_t *ppos)
-{
-  u32 *tmp = (u32 *)buf;
-  u32 data[4];
-  size_t rv;
-  u32 reg = *ppos;
-  int cpu = iminor(file->f_dentry->d_inode);
-  
-  if ( count % 16 )
-    return -EINVAL; /* Invalid chunk size */
-  
-  for ( rv = 0 ; count ; count -= 16 ) {
-    do_cpuid(cpu, reg, data);
-    if ( copy_to_user(tmp,&data,16) )
-      return -EFAULT;
-    tmp += 4;
-    *ppos = reg++;
-  }
-  
-  return ((char *)tmp) - buf;
+	return ((char *)tmp) - buf;
 }
 
 static int cpuid_open(struct inode *inode, struct file *file)
 {
-  int cpu = iminor(file->f_dentry->d_inode);
-  struct cpuinfo_x86 *c = &(cpu_data)[cpu];
+	int cpu = iminor(file->f_dentry->d_inode);
+	struct cpuinfo_x86 *c = &(cpu_data)[cpu];
+
+	if (!cpu_online(cpu))
+		return -ENXIO;	/* No such CPU */
+	if (c->cpuid_level < 0)
+		return -EIO;	/* CPUID not supported */
 
-  if (!cpu_online(cpu))
-    return -ENXIO;		/* No such CPU */
-  if ( c->cpuid_level < 0 )
-    return -EIO;		/* CPUID not supported */
-  
-  return 0;
+	return 0;
 }
 
 /*
  * File operations we support
  */
 static struct file_operations cpuid_fops = {
-  .owner	= THIS_MODULE,
-  .llseek	= cpuid_seek,
-  .read		= cpuid_read,
-  .open		= cpuid_open,
+	.owner = THIS_MODULE,
+	.llseek = cpuid_seek,
+	.read = cpuid_read,
+	.open = cpuid_open,
 };
 
 int __init cpuid_init(void)
 {
-  if (register_chrdev(CPUID_MAJOR, "cpu/cpuid", &cpuid_fops)) {
-    printk(KERN_ERR "cpuid: unable to get major %d for cpuid\n",
-	   CPUID_MAJOR);
-    return -EBUSY;
-  }
+	if (register_chrdev(CPUID_MAJOR, "cpu/cpuid", &cpuid_fops)) {
+		printk(KERN_ERR "cpuid: unable to get major %d for cpuid\n",
+		       CPUID_MAJOR);
+		return -EBUSY;
+	}
 
-  return 0;
+	return 0;
 }
 
 void __exit cpuid_exit(void)
 {
-  unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
+	unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
 }
 
 module_init(cpuid_init);
 module_exit(cpuid_exit)
 
-MODULE_AUTHOR("H. Peter Anvin <hpa@zytor.com>");
+    MODULE_AUTHOR("H. Peter Anvin <hpa@zytor.com>");
 MODULE_DESCRIPTION("x86 generic CPUID driver");
 MODULE_LICENSE("GPL");

