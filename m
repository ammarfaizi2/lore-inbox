Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbVA0Oxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbVA0Oxa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 09:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVA0Oxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 09:53:30 -0500
Received: from yacht.ocn.ne.jp ([222.146.40.168]:22999 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S262646AbVA0OxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 09:53:23 -0500
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Olaf Hering <olh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] oprofile: falling back on timer interrupt mode
Date: Thu, 27 Jan 2005 23:56:10 +0900
User-Agent: KMail/1.5.4
Cc: linuxppc-dev@ozlabs.org, "Andrew Morton" <akpm@osdl.org>,
       Greg Banks <gnb@sgi.com>, John Levon <levon@movementarian.org>,
       Philippe Elie <phil.el@wanadoo.fr>
References: <200501260512.j0Q5CAhd016730@hera.kernel.org> <20050126190537.GA26349@suse.de>
In-Reply-To: <20050126190537.GA26349@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501272356.10846.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 January 2005 04:05, Olaf Hering wrote:
>  On Wed, Jan 26, Linux Kernel Mailing List wrote:
> > ChangeSet 1.2038, 2005/01/25 20:31:01-08:00, amgta@yacht.ocn.ne.jp
> >
> > 	[PATCH] oprofile: falling back on timer interrupt mode

> This misses arch/ppc


Thanks for pointing that out.

This is opofile timer-mode fallback fix for ppc.

Signed-off-by: Akinobu Mita <amgta@yacht.ocn.ne.jp>

--- 2.6-bk/arch/ppc/oprofile/common.c.orig	2005-01-27 23:28:44.000000000 +0900
+++ 2.6-bk/arch/ppc/oprofile/common.c	2005-01-27 23:32:27.000000000 +0900
@@ -124,7 +124,7 @@ static struct oprofile_operations oprof_
 	.cpu_type	= NULL		/* To be filled in below. */
 };
 
-void __init oprofile_arch_init(struct oprofile_operations *ops)
+int __init oprofile_arch_init(struct oprofile_operations *ops)
 {
 	char *name;
 	int cpu_id = smp_processor_id();
@@ -132,14 +132,13 @@ void __init oprofile_arch_init(struct op
 #ifdef CONFIG_FSL_BOOKE
 	model = &op_model_fsl_booke;
 #else
-	printk(KERN_ERR "oprofile enabled on unsupported processor!\n");
-	return;
+	return -ENODEV;
 #endif
 
 	name = kmalloc(32, GFP_KERNEL);
 
 	if (NULL == name)
-		return;
+		return -ENOMEM;
 
 	sprintf(name, "ppc/%s", cur_cpu_spec[cpu_id]->cpu_name);
 
@@ -151,6 +150,8 @@ void __init oprofile_arch_init(struct op
 
 	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
 	       oprof_ppc32_ops.cpu_type);
+
+	return 0;
 }
 
 void oprofile_arch_exit(void)



