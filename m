Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUGFHby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUGFHby (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 03:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUGFHby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 03:31:54 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:56207 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263555AbUGFHbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 03:31:51 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: jhf@rivenstone.net (Joseph Fannin)
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       paulus@samba.org, benh@kernel.crashing.org, rusty@rustcorp.com.au
Subject: Re: 2.6.7-mm6 - ppc32 inconsistent kallsyms data 
In-reply-to: Your message of "Tue, 06 Jul 2004 12:06:08 +1000."
             <2970.1089079568@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Jul 2004 17:31:22 +1000
Message-ID: <13859.1089099082@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jul 2004 12:06:08 +1000, 
Keith Owens <kaos@sgi.com> wrote:
>On Mon, 5 Jul 2004 16:38:18 -0400, 
>jhf@rivenstone.net (Joseph Fannin) wrote:
>>On Mon, Jul 05, 2004 at 02:31:20AM -0700, Andrew Morton wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm6/
>>
>>  I'm getting this while building for ppc32:
>>    Inconsistent kallsyms data, try setting CONFIG_KALLSYMS_EXTRA_PASS
>>
>>  This didn't happen with -mm6.
>>
>>  The help text for CONFIG_KALLSYMS_EXTRA_PASS says I should report a
>>bug, and reads like kallsyms is a utility or part of the toolchain;
>>I think it's talking about the kernel feature though, so I guess
>>I'll report it here.  I'll keep this tree around in case any more
>>information is needed.
>
>Run these commands on the tree that needed CONFIG_KALLSYMS_EXTRA_PASS=y
>(assumes Bourne shell)
>
>for i in 1 2 3; do nm .tmp_kallsyms$i.o > .tmp_mapk$i; nm .tmp_vmlinux$i > .tmp_mapv$i; done
>tar cjvf /var/tmp/kallsyms.tar.bz2 .tmp_kallsyms* .tmp_vmlinux* .tmp_map*
>
>Send the tarball to me, not the list.

This is a real linker problem on ppc32.  The linker automatically adds
_SDA_BASE_ and _SDA2_BASE_ symbols, these symbols are not defined in
vmlinux.lds.S.  The SDA symbols move around as kallsyms data is added
between phases 1 and 2.  That movement, together with the stem
compression (which depends on the immediately previous symbol) means
that the compressed symbol table changes size between phases 1 and 2,
which it is not supposed to do.

This problem has been there all along.  It showed up now because I
added a test to verify that the kallsyms data is consistent after phase
2, instead of blindly assuming that it is stable.  jhf, can you verify
that this patch removes the need for an extra kallsyms pass?

--- kallsyms-ppc32 ---

PPC small data area base symbols shift between kallsyms phases 1 and 2,
which makes the kallsyms data unstable.  Exclude them from the kallsyms
list.

Signed-off-by: Keith Owens <kaos@sgi.com>

Index: 2.6.7-mm6/scripts/kallsyms.c
===================================================================
--- 2.6.7-mm6.orig/scripts/kallsyms.c	2004-07-06 17:26:14.000000000 +1000
+++ 2.6.7-mm6/scripts/kallsyms.c	2004-07-06 17:26:33.000000000 +1000
@@ -83,6 +83,11 @@ symbol_valid(struct sym_entry *s)
 	    strcmp(s->sym, "kallsyms_names") == 0)
 		return 0;
 
+	/* Exclude linker generated symbols which vary between passes */
+	if (strstr(s->sym, "_SDA_BASE_") ||		/* ppc */
+	    strcmp(s->sym, "_SDA2_BASE_") == 0)		/* ppc */
+		return 0;
+
 	return 1;
 }
 

