Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVAJNox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVAJNox (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 08:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVAJNox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 08:44:53 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:64963 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S262250AbVAJNop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 08:44:45 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: kallsyms gate page patch breaks module lookups 
In-reply-to: Your message of "Mon, 10 Jan 2005 22:13:37 +1100."
             <20050110111337.GM14239@krispykreme.ozlabs.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 11 Jan 2005 00:44:29 +1100
Message-ID: <15034.1105364669@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2005 22:13:37 +1100, 
Anton Blanchard <anton@samba.org> wrote:
>Your recent patch looks to break module kallsyms lookups....
>It looks like if CONFIG_KALLSYMS_ALL is set then we never look up module
>addresses.

Separate lookups for kernel and modules when CONFIG_KALLSYMS_ALL=y.

Signed-off-by: Keith Owens <kaos@ocs.com.au>

Index: 2.6.10-bk13/kernel/kallsyms.c
===================================================================
--- 2.6.10-bk13.orig/kernel/kallsyms.c	2005-01-11 00:42:19.600615731 +1100
+++ 2.6.10-bk13/kernel/kallsyms.c	2005-01-11 00:42:41.520243100 +1100
@@ -53,6 +53,13 @@ static inline int is_kernel_text(unsigne
 	return in_gate_area_no_task(addr);
 }
 
+static inline int is_kernel(unsigned long addr)
+{
+	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_end)
+		return 1;
+	return in_gate_area_no_task(addr);
+}
+
 /* expand a compressed symbol data into the resulting uncompressed string,
    given the offset to where the symbol is in the compressed stream */
 static unsigned int kallsyms_expand_symbol(unsigned int off, char *result)
@@ -153,7 +160,8 @@ const char *kallsyms_lookup(unsigned lon
 	namebuf[KSYM_NAME_LEN] = 0;
 	namebuf[0] = 0;
 
-	if (all_var || is_kernel_text(addr) || is_kernel_inittext(addr)) {
+	if ((all_var && is_kernel(addr)) ||
+	    (!all_var && (is_kernel_text(addr) || is_kernel_inittext(addr)))) {
 		unsigned long symbol_end=0;
 
 		/* do a binary search on the sorted kallsyms_addresses array */

