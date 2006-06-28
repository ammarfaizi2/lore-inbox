Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423303AbWF1MH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423303AbWF1MH1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 08:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423298AbWF1MH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 08:07:27 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:57457 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1423304AbWF1MH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 08:07:26 -0400
Date: Wed, 28 Jun 2006 14:06:35 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockdep: special s390 print_symbol() version
Message-ID: <20060628120635.GE9452@osiris.boeblingen.de.ibm.com>
References: <20060628112435.GD9452@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628112435.GD9452@osiris.boeblingen.de.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.6.17-mm3.orig/include/linux/kallsyms.h
> +++ linux-2.6.17-mm3/include/linux/kallsyms.h
> @@ -57,11 +57,20 @@ do {						\
>  #define print_fn_descriptor_symbol(fmt, addr) print_symbol(fmt, addr)
>  #endif
>  
> +/* need to clear the most significant bit on s390 31bit */
> +#if defined(CONFIG_S390) && !defined(CONFIG_64BIT)
> +#define print_symbol(fmt, addr)			\
> +do {						\
> +	__check_printsym_format(fmt, "");	\
> +	__print_symbol(fmt, addr & 0x7fffffff);	\
> +} while(0)
> +#else
>  #define print_symbol(fmt, addr)			\
>  do {						\
>  	__check_printsym_format(fmt, "");	\
>  	__print_symbol(fmt, addr);		\
>  } while(0)
> +#endif

Martin made me just aware of __builtin_extract_return_addr() which will
do the trick as well and avoids adding yet another ifdef.
So, how about this one instead:

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Use __builtin_extract_return_addr() in print_symbol() to deal with s390 which
has the most significant bit set in instruction pointers.

Without this the output would look like:

hardirqs last  enabled at (30907): [<80018c6a>] 0x80018c6a
hardirqs last disabled at (30908): [<8001e48c>] 0x8001e48c
softirqs last  enabled at (30904): [<8001dc96>] 0x8001dc96
softirqs last disabled at (30897): [<8001dc50>] 0x8001dc50

instead of this:

hardirqs last  enabled at (19421): [<80018c72>] cpu_idle+0x176/0x1c4
hardirqs last disabled at (19422): [<8001e494>] io_no_vtime+0xa/0x1a
softirqs last  enabled at (19418): [<8001dc9e>] do_softirq+0xa6/0xe8
softirqs last disabled at (19411): [<8001dc58>] do_softirq+0x60/0xe8

Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 include/linux/kallsyms.h |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Index: linux-2.6.17-mm3/include/linux/kallsyms.h
===================================================================
--- linux-2.6.17-mm3.orig/include/linux/kallsyms.h
+++ linux-2.6.17-mm3/include/linux/kallsyms.h
@@ -57,11 +57,12 @@ do {						\
 #define print_fn_descriptor_symbol(fmt, addr) print_symbol(fmt, addr)
 #endif
 
-#define print_symbol(fmt, addr)			\
-do {						\
-	__check_printsym_format(fmt, "");	\
-	__print_symbol(fmt, addr);		\
-} while(0)
+static inline void print_symbol(const char *fmt, unsigned long addr)
+{
+	__check_printsym_format(fmt, "");
+	__print_symbol(fmt, (unsigned long)
+		       __builtin_extract_return_addr((void *)addr));
+}
 
 #ifndef CONFIG_64BIT
 #define print_ip_sym(ip)		\
