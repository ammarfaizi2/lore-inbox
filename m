Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVEZBRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVEZBRz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 21:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVEZBRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 21:17:55 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:62358 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261645AbVEZBRv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 21:17:51 -0400
Message-ID: <429523BC.1010209@us.ibm.com>
Date: Wed, 25 May 2005 18:17:48 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1
References: <20050525134933.5c22234a.akpm@osdl.org>
In-Reply-To: <20050525134933.5c22234a.akpm@osdl.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030105040205080801050103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030105040205080801050103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I get the following when trying to build rc5-mm1:

arch/i386/kernel/setup.c:99: error: parse error before "acpi_sci_flags"
arch/i386/kernel/setup.c:99: warning: type defaults to `int' in declaration
of `acpi_sci_flags'
arch/i386/kernel/setup.c:99: warning: data definition has no type or
storage class
arch/i386/kernel/setup.c: In function `parse_cmdline_early':
arch/i386/kernel/setup.c:836: error: request for member `trigger' in
something not a structure or union
arch/i386/kernel/setup.c:839: error: request for member `trigger' in
something not a structure or union
arch/i386/kernel/setup.c:842: error: request for member `polarity' in
something not a structure or union
arch/i386/kernel/setup.c:845: error: request for member `polarity' in
something not a structure or union
make[1]: *** [arch/i386/kernel/setup.o] Error 1
make[1]: *** Waiting for unfinished jobs....

Looks like when #ifdef CONFIG_ACPI was added to include/linux/acpi.h it
broke things b/c acpi_sci_flags is needed for CONFIG_ACPI_BOOT, which
depends on X86_HT || ACPI.  Thus, you can have ACPI=n, and X86_HT=y &
ACPI_BOOT=y and it won't build.  This patch at least gets it to build for me...

-Matt

--------------030105040205080801050103
Content-Type: text/x-patch;
 name="fix_acpi_breakage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_acpi_breakage.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.12-rc5-mm1/include/linux/acpi.h linux-2.6.12-rc5-mm1+fix_acpi_error/include/linux/acpi.h
--- linux-2.6.12-rc5-mm1/include/linux/acpi.h	2005-05-25 15:25:56.000000000 -0700
+++ linux-2.6.12-rc5-mm1+fix_acpi_error/include/linux/acpi.h	2005-05-25 17:59:30.439404520 -0700
@@ -25,7 +25,7 @@
 #ifndef _LINUX_ACPI_H
 #define _LINUX_ACPI_H
 
-#ifdef CONFIG_ACPI
+#if defined(CONFIG_ACPI) || defined(CONFIG_ACPI_BOOT)
 
 #ifndef _LINUX
 #define _LINUX
@@ -543,6 +543,6 @@ static inline int acpi_boot_table_init(v
 	return 0;
 }
 
-#endif	/* CONFIG_ACPI */
+#endif	/* CONFIG_ACPI || CONFIG_ACPI_BOOT */
 
 #endif	/* _LINUX_ACPI_H */

--------------030105040205080801050103--
