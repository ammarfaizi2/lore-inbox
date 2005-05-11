Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVEKK5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVEKK5q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 06:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVEKK5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 06:57:46 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:44228 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261964AbVEKK5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 06:57:38 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Imre Deak <imre.deak@nokia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: arm: Inconsistent kallsyms data 
In-reply-to: Your message of "Wed, 11 May 2005 12:05:10 +0300."
             <1115802310.9757.20.camel@mammoth.research.nokia.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 11 May 2005 20:57:25 +1000
Message-ID: <6946.1115809045@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2005 12:05:10 +0300, 
Imre Deak <imre.deak@nokia.com> wrote:
>building 2.6.12-rc4 results in "Inconsistent kallsyms data". Setting
>CONFIG_KALLSYMS_EXTRA_PASS=y doesn't help.
>
>I made a diff of .tmp_kallsyms[12].S after converting them to human
>readable form with kallsyms_uncompress.pl .
>
>I noticed that the error is triggered by an __initdata definition. It is
>accessed only from an __init function, so that's ok I think. Removing
>the __initdata attribute gets rid of the error message.
>
>Let me know if you need more data to track the problem.

A better approach is this patch, it extracts the maps including the
section headers after each stage.  I sent it to lkml on Sat, 26 Feb
2005 with no response.  Apply the patch, make debug_kallsyms and send
me the .tmp_map* files.

---

Make it easier to generate maps for debugging kallsyms problems.
debug_kallsyms is only a debugging target so no help or silent mode.

Signed-off-by: Keith Owens <kaos@ocs.com.au>


Index: linux/Makefile
===================================================================
--- linux.orig/Makefile	2005-02-25 16:21:44.000000000 +1100
+++ linux/Makefile	2005-02-26 21:30:54.000000000 +1100
@@ -722,6 +722,16 @@ quiet_cmd_kallsyms = KSYM    $@
 # Needs to visit scripts/ before $(KALLSYMS) can be used.
 $(KALLSYMS): scripts ;
 
+# Generate some data for debugging strange kallsyms problems
+debug_kallsyms: .tmp_map$(last_kallsyms)
+
+.tmp_map%: .tmp_vmlinux% FORCE
+	($(OBJDUMP) -h $< | awk '/^ +[0-9]/{print $$4 " 0 " $$2}'; $(NM) $<) | sort > $@
+
+.tmp_map3: .tmp_map2
+
+.tmp_map2: .tmp_map1
+
 endif # ifdef CONFIG_KALLSYMS
 
 # vmlinux image - including updated kernel symbols


