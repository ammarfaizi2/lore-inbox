Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWHVNy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWHVNy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 09:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWHVNy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 09:54:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:27471 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932146AbWHVNyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 09:54:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=uQc7r2aXjUvpjwabR2Xr9KBm16v3DwiNxvxZjUAIkHbL12m9NrxWO1WESJqNEUPdHvXbJQbQtASb5WT8Cs/icOkTr8FQHxD1kZNzMBEDbVDdwih9nrQsglOlkVTBntdW388whoW0YCIC9Uha3j5WYzJ9UsorxfSD81Az3EBaIfA=
Message-ID: <44EB0C9C.80701@innova-card.com>
Date: Tue, 22 Aug 2006 15:54:36 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Franck <vagabon.xyz@gmail.com>, rusty@rustcorp.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] kallsyms_lookup always requires buffers
References: <44EAFDCA.1080002@innova-card.com> <1156252706.2976.51.camel@laptopd505.fenrus.org>
In-Reply-To: <1156252706.2976.51.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Arjan van de Ven wrote:
>> +}
>> +EXPORT_SYMBOL_GPL(kallsyms_lookup_gently);
> 
> 
> Hi,
> 
> there don't seem to be modular users so please don't export it since
> that export just eats up useless space. (we have way too many of those
> already)
> 

true.

> (Also I suggest you submit at least one user with your patch but that's
> another matter)
> 

mips could be one of the future users, see patch below.

thanks
		Franck

-- >8 --

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 951bf9c..eb80db5 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -344,8 +344,6 @@ static int __init frame_info_init(void)
 {
 	int i;
 #ifdef CONFIG_KALLSYMS
-	char *modname;
-	char namebuf[KSYM_NAME_LEN + 1];
 	unsigned long start, size, ofs;
 	extern char __sched_text_start[], __sched_text_end[];
 	extern char __lock_text_start[], __lock_text_end[];
@@ -354,7 +352,7 @@ #ifdef CONFIG_KALLSYMS
 	for (i = 0; i < ARRAY_SIZE(mfinfo); i++) {
 		if (start == (unsigned long)schedule)
 			schedule_frame = &mfinfo[i];
-		if (!kallsyms_lookup(start, &size, &ofs, &modname, namebuf))
+		if (!kallsyms_lookup_gently(start, &size, &ofs))
 			break;
 		mfinfo[i].func = (void *)(start + ofs);
 		mfinfo[i].func_size = size;
@@ -454,8 +452,6 @@ unsigned long unwind_stack(struct task_s
 {
 	unsigned long stack_page;
 	struct mips_frame_info info;
-	char *modname;
-	char namebuf[KSYM_NAME_LEN + 1];
 	unsigned long size, ofs;
 	int leaf;
 
@@ -463,7 +459,7 @@ unsigned long unwind_stack(struct task_s
 	if (!stack_page)
 		return 0;
 
-	if (!kallsyms_lookup(pc, &size, &ofs, &modname, namebuf))
+	if (!kallsyms_lookup_gently(pc, &size, &ofs))
 		return 0;
 	if (ofs == 0)
 		return 0;
