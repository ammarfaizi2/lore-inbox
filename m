Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVFHOli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVFHOli (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 10:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVFHOli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 10:41:38 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:21187 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261265AbVFHOl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 10:41:29 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00 
In-reply-to: Your message of "Wed, 08 Jun 2005 16:18:58 +0200."
             <42A6FE52.1050705@stud.feec.vutbr.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 Jun 2005 00:40:57 +1000
Message-ID: <6460.1118241657@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jun 2005 16:18:58 +0200, 
Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
>Ingo Molnar wrote:
>> i have released the -V0.7.48-00 Real-Time Preemption patch, which can be 
>> downloaded from the usual place:
>
>The build fails with inconsistent kallsyms data:
>   ...
>   LD      .tmp_vmlinux1
>   KSYM    .tmp_kallsyms1.S
>   AS      .tmp_kallsyms1.o
>   LD      .tmp_vmlinux2
>   KSYM    .tmp_kallsyms2.S
>   AS      .tmp_kallsyms2.o
>   LD      vmlinux
>   SYSMAP  System.map
>   SYSMAP  .tmp_System.map
>Inconsistent kallsyms data

Apply this patch, make debug_kallsyms, 'tar czvf map.tar.gz .tmp_map*'
and mail map.tar.gz to me, not the list.

Index: linux/Makefile
===================================================================
--- linux.orig/Makefile	2005-06-07 12:04:16.674163303 +1000
+++ linux/Makefile	2005-06-09 00:38:50.270431501 +1000
@@ -723,6 +723,16 @@ quiet_cmd_kallsyms = KSYM    $@
 # Needs to visit scripts/ before $(KALLSYMS) can be used.
 $(KALLSYMS): scripts ;
 
+# Generate some data for debugging strange kallsyms problems
+debug_kallsyms: .tmp_map$(last_kallsyms)
+
+.tmp_map%: .tmp_vmlinux% FORCE
+	($(OBJDUMP) -h $< | $(AWK) '/^ +[0-9]/{print $$4 " 0 " $$2}'; $(NM) $<) | sort > $@
+
+.tmp_map3: .tmp_map2
+
+.tmp_map2: .tmp_map1
+
 endif # ifdef CONFIG_KALLSYMS
 
 # vmlinux image - including updated kernel symbols

