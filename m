Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbULaSQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbULaSQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 13:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbULaSQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 13:16:13 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:60357 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S262129AbULaSQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 13:16:07 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: sh: inconsistent kallsyms data 
In-reply-to: Your message of "Fri, 31 Dec 2004 19:25:50 +0200."
             <20041231172549.GA18211@linux-sh.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 01 Jan 2005 05:15:43 +1100
Message-ID: <3512.1104516943@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2004 19:25:50 +0200, 
Paul Mundt <lethal@linux-sh.org> wrote:
>Building 2.6.10 for sh results in inconsistent kallsyms data. Turning on
>CONFIG_KALLSYMS_ALL fixes it, as does CONFIG_KALLSYMS_EXTRA_PASS.
>
>The symbols that seem to be problematic between the second and third
>pass are all kallsyms special symbols. With only CONFIG_KALLSYMS set we
>see:
>
>--- System.map  2004-12-31 10:53:10.278567522 -0600
>+++ .tmp_System.map     2004-12-31 10:53:10.347558024 -0600
>@@ -6868,9 +6868,9 @@
> 8817c4d0 D kallsyms_addresses
> 88182660 D kallsyms_num_syms
> 88182670 D kallsyms_names
>-88190630 D kallsyms_markers
>-881906a0 D kallsyms_token_table
>-88190b50 D kallsyms_token_index
>+881906a0 D kallsyms_markers
>+88190710 D kallsyms_token_table
>+88190bc0 D kallsyms_token_index
> 88191000 D irq_desc
> 88191000 A __per_cpu_end
> 88191000 A __per_cpu_start
>
>So for some reason we have a 0x70 variance between these, and only
>these. Running with --all-symbols this seems to work fine.

I suspect the change in the kallsyms compression algorithm between
2.6.9 and 2.6.10.  It added 3 new symbols and I am not convinced that
they are being processed correctly by scripts/kallsyms.c.  Apply this
debug patch, tar .tmp_kallsyms* and send the tarball to me.

Index: 2.6.10-pristine/Makefile
===================================================================
--- 2.6.10-pristine.orig/Makefile	2004-12-25 10:25:19.000000000 +1100
+++ 2.6.10-pristine/Makefile	2005-01-01 05:13:25.714459901 +1100
@@ -680,7 +680,7 @@ define verify_kallsyms
 	$(Q)cmp -s System.map .tmp_System.map ||              \
 		(echo Inconsistent kallsyms data;             \
 		 echo Try setting CONFIG_KALLSYMS_EXTRA_PASS; \
-		 rm .tmp_kallsyms* ; /bin/false )
+		 /bin/false )
 endef
 
 # Update vmlinux version before link

