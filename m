Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVI2BaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVI2BaY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 21:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVI2BaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 21:30:24 -0400
Received: from NS5.Sony.CO.JP ([137.153.0.45]:63915 "EHLO ns5.sony.co.jp")
	by vger.kernel.org with ESMTP id S1751297AbVI2BaY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 21:30:24 -0400
From: Samuel Masham <Samuel.Masham@jp.sony.com>
To: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Wilson Li <yongshenglee@yahoo.com>
Subject: Re: Slow loading big kernel module in 2.6 on PPC platform
Date: Thu, 29 Sep 2005 10:30:38 +0900
User-Agent: KMail/1.8.1
Cc: "Yamaguchi, Yohei" <Yohei.Yamaguchi@jp.sony.com>,
       Tim Bird <tim.bird@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509291030.39024.Samuel.Masham@jp.sony.com>
X-OriginalArrivalTime: 29 Sep 2005 01:30:20.0632 (UTC) FILETIME=[5B078D80:01C5C495]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wilson Li wrote:
> > Hi,
> > 
> > I am trying to port several third party kernel modules from
> kernel
> > 2.4 to 2.6 on a ppc (MPC824x) platform. For small size of
> modules, it
> > works perfectly in 2.6. But there's one huge kernel module which
> size
> > is about 2.7M bytes (size reported by lsmod after insmod), and it
> > takes about 90 seconds to load this module before init_module
> starts.
> > I did not notice there's such obvious delay in 2.4 kernel.

I assume you are on a slow ppc32 platform.

The time taken is a function of the number of symbols, you can work around it 
as shown in the patch below. Obviously this is just an example patch and is
NOT signed off for anything but reading :)

I would really like do some work on a pre-link for modules but don't really know 
where to start.

Any hints?

Samuel

ps Not subscribed, just  so please cc me

diff -ru src.orig/include/linux/moduleparam.h src/include/linux/moduleparam.h
--- src.orig/include/linux/moduleparam.h
+++ src/include/linux/moduleparam.h
@@ -85,6 +85,11 @@
 		      unsigned num,
 		      int (*unknown)(char *param, char *val));
 
+
+struct module;
+
+extern int parse_args_reloc(char ** args, struct module * me, int * core_size, int * init_size);
+
 /* All the helper functions */
 /* The macros to do compile-time type checking stolen from Jakub
    Jelinek, who IIRC came up with this idea for the 2.4 module init code. */
diff -ru src.orig/kernel/module.c src/kernel/module.c
--- src.orig/kernel/module.c
+++ src/kernel/module.c
@@ -1429,6 +1429,8 @@
 }
 #endif /* CONFIG_KALLSYMS */
 
+
+
 /* Allocate and load the module: note that size of section 0 is always
    zero, and we rely on this for optional sections. */
 static struct module *load_module(void __user *umod,
@@ -1446,7 +1448,9 @@
 	long err = 0;
 	void *percpu = NULL, *ptr = NULL; /* Stops spurious gcc warning */
 	struct exception_table_entry *extable;
-
+	int no_frob_arch_sections = 0;
+	int core_size=0, init_size=0;
+ 
 	DEBUGP("load_module: umod=%p, len=%lu, uargs=%p¥n",
 	       umod, len, uargs);
 	if (len < sizeof(*hdr))
@@ -1579,8 +1583,25 @@
 
 	mod->state = MODULE_STATE_COMING;
 
-	/* Allow arches to frob section contents and sizes.  */
-	err = module_frob_arch_sections(hdr, sechdrs, secstrings, mod);
+	if(strncmp("elf_plt_info=",args, strlen("elf_plt_info="))==0){
+		if(parse_args_reloc(&args, mod, &core_size, &init_size)) {
+			/* Allow passing hard coded relocation sizes. */
+			sechdrs[mod->arch.core_plt_section].sh_size = core_size;
+			sechdrs[mod->arch.init_plt_section].sh_size = init_size;
+			no_frob_arch_sections = 1;
+		} 	
+	}
+	
+	if(!no_frob_arch_sections) 
+	{
+		/* Allow arches to frob section contents and sizes.  */
+		err = module_frob_arch_sections(hdr, sechdrs, secstrings, mod);
+		printk("init_module: consider ¥"insmod %s elf_plt_info=%d,%d,%d,%d %s¥"¥n", mod->name,
+			mod->arch.core_plt_section, mod->arch.init_plt_section,
+			sechdrs[mod->arch.core_plt_section].sh_size, sechdrs[mod->arch.init_plt_section].sh_size, args);
+	}
+
+
 	if (err < 0)
 		goto free_mod;
 
diff -ru src.orig/kernel/params.c src/kernel/params.c
--- src.orig/kernel/params.c
+++ src/kernel/params.c
@@ -164,6 +164,17 @@
 	return 0;
 }
 
+
+int parse_args_reloc(char ** args, struct module *me, int* core_size, int* init_size){
+	char *param, *val;
+	int ret=0;
+	*args = next_arg(*args, &param, &val);//args pointing to next of elf_plt_info=x,y.z,v
+	ret = sscanf(val, "%d,%d,%d,%d",	
+		&me->arch.core_plt_section, &me->arch.init_plt_section, core_size, init_size);
+	if(ret!=4) return 0;  /* fail */
+        return 1;             /* success */
+}
+
 /* Lazy bastard, eh? */
 #define STANDARD_PARAM_DEF(name, type, format, tmptype, strtolfn)      	¥
 	int param_set_##name(const char *val, struct kernel_param *kp)	¥







