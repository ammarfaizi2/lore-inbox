Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVC3GVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVC3GVn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 01:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVC3GVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 01:21:43 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:11359 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261744AbVC3GVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 01:21:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TVzcjllsy4iUhJxN3ut7F0sUX/2jt6QyH+0ZN00Nx1bmhq1KGmtDopWFdHNXaApqiZ1poltriuBt7glSmAq2Ut/vTjL0MFXpiCxSGq3nJA9ax/MplzQ3E/M/TJFKUXZssMtibLRwvh1hJbv8NekECgv/kUrMhLdnz4Cm71ULBmk=
Message-ID: <df35dfeb050329222132823897@mail.gmail.com>
Date: Tue, 29 Mar 2005 22:21:17 -0800
From: Yum Rayan <yum.rayan@gmail.com>
Reply-To: Yum Rayan <yum.rayan@gmail.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] Reduce stack usage in module.c
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
In-Reply-To: <424993B0.9010306@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <df35dfeb05032823137a208b46@mail.gmail.com>
	 <424993B0.9010306@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2005 09:43:12 -0800, Randy.Dunlap <rddunlap@osdl.org> wrote:
> Yum Rayan wrote:
> > Attempt to reduce stack usage in module.c (linux-2.6.12-rc1-mm3).
> > Specifically from checkstack.pl
> >
> > Before patch
> > ------------------
> > who_is_doing_it: 512
> > obsolete_params: 160
> >
> > After patch
> > ----------------
> > who_is_doing_it: none
> So all function local variables are in registers?

Yes, all function local variables of the patched who_is_doing_it(...)
are in registers.

> > Also while at it, fix following in who_is_doing_it(...)
> > - use only as much memory is needed
> > - do not write past array index for the boundary case
> 
> I don't see a boundary case problem with the current code,
> hence I don't see why the kmalloc(len + 1, GFP_KERNEL) is
> needed...

Let's consider the original code and len = 513

   1399 static void who_is_doing_it(void)
   1400 {
   1401         /* Print out all the args. */
   1402         char args[512];
   1403         unsigned long i, len = current->mm->arg_end -
current->mm->arg_start;
   1404
   1405         if (len > 512)
   1406                 len = 512;
   1407
   1408         len -= copy_from_user(args, (void
*)current->mm->arg_start, len);
   1409
   1410         for (i = 0; i < len; i++) {
   1411                 if (args[i] == '\0')
   1412                         args[i] = ' ';
   1413         }
   1414         args[i] = 0;
   1415         printk("ARGS: %s\n", args);
   1416 }

After lines 1410 thru 1413, "i" wil be 512. So line 1414 will be
"args[512] = 0". But args is 512 byte array with last legally
accessible element at 511?

> File names start one level deeper than wanted.  They should begin
> with linux/ or a/ or ./ e.g.
> There are plenty of docs on this, please let me know if you need
> references to them.

Point noted. Will post patch to linux/Documentation/SubmittingPatches,
hopefully making it more clear. Reworked patch at end of email.

> 
> > @@ -769,15 +769,25 @@
> >       struct kernel_param *kp;
> >       unsigned int i;
> >       int ret;
> > +     char *sym_name = NULL;
> > +     unsigned int sym_name_len = 0;
> >
> >       kp = kmalloc(sizeof(kp[0]) * num, GFP_KERNEL);
> >       if (!kp)
> >               return -ENOMEM;
> 
> Style thing, I guess, but since the case of num == 0 doesn't do
> anything here, I would just begin the function with:
> 
>        if (!num)
>                return;
> or              goto out;
> to maintain one return point.
> 
> and then eliminate the kmalloc()s, if (num), kfree()s, and
> parse_args().

Was attempting to preserve the call flow of the previous author. But
yes, this makes more sense. I changed code to return "0" for !num
case.

Thanks,
Rayan

Summary: Reduce stack usage in obsolete_params() and who_is_doing_it()
Target: linux-2.6.12-rc1-mm3
Signed-off-by: Yum Rayan <yum.rayan@gmail.com>

--- a/kernel/module.c	2005-03-25 22:11:06.000000000 -0800
+++ b/kernel/module.c	2005-03-29 22:16:09.000000000 -0800
@@ -767,17 +767,27 @@
 			   const char *strtab)
 {
 	struct kernel_param *kp;
-	unsigned int i;
+	char *sym_name;
+	unsigned int sym_name_len, i;
 	int ret;
 
+	if (!num)
+		return 0;
+
 	kp = kmalloc(sizeof(kp[0]) * num, GFP_KERNEL);
 	if (!kp)
 		return -ENOMEM;
 
-	for (i = 0; i < num; i++) {
-		char sym_name[128 + sizeof(MODULE_SYMBOL_PREFIX)];
+	sym_name_len = 128 + sizeof (MODULE_SYMBOL_PREFIX);
+	sym_name = kmalloc(sym_name_len, GFP_KERNEL);
+	if (!sym_name) {
+		ret = -ENOMEM;
+		goto free_kp;
+	}
 
-		snprintf(sym_name, sizeof(sym_name), "%s%s",
+	for (i = 0; i < num; i++) {
+		
+		snprintf(sym_name, sym_name_len, "%s%s",
 			 MODULE_SYMBOL_PREFIX, obsparm[i].name);
 
 		kp[i].name = obsparm[i].name;
@@ -791,13 +801,15 @@
 			printk("%s: falsely claims to have parameter %s\n",
 			       name, obsparm[i].name);
 			ret = -EINVAL;
-			goto out;
+			goto free_sym;
 		}
 		kp[i].arg = &obsparm[i];
 	}
 
 	ret = parse_args(name, args, kp, num, NULL);
- out:
+ free_sym:
+	kfree(sym_name);
+ free_kp:
 	kfree(kp);
 	return ret;
 }
@@ -1399,12 +1411,16 @@
 static void who_is_doing_it(void)
 {
 	/* Print out all the args. */
-	char args[512];
+	char *args;
 	unsigned long i, len = current->mm->arg_end - current->mm->arg_start;
 
 	if (len > 512)
 		len = 512;
 
+	args = kmalloc(len + 1, GFP_KERNEL);
+	if (!args)
+		return;
+
 	len -= copy_from_user(args, (void *)current->mm->arg_start, len);
 
 	for (i = 0; i < len; i++) {
@@ -1413,6 +1429,7 @@
 	}
 	args[i] = 0;
 	printk("ARGS: %s\n", args);
+	kfree(args);
 }
 
 /* Allocate and load the module: note that size of section 0 is always
