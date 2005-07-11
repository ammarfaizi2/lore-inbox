Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVGKN2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVGKN2l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 09:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVGKN2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 09:28:41 -0400
Received: from [195.23.16.24] ([195.23.16.24]:61347 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261609AbVGKN2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 09:28:39 -0400
Message-ID: <42D27405.8070802@grupopie.com>
Date: Mon, 11 Jul 2005 14:28:37 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@infradead.org>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507081938.27815.s0348365@sms.ed.ac.uk> <20050708194827.GA22536@elte.hu> <200507082145.08877.s0348365@sms.ed.ac.uk> <20050709124105.GB4665@elte.hu>
In-Reply-To: <20050709124105.GB4665@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------050600070602070702060104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050600070602070702060104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> (gdb) ####################################
> (gdb) # c013ebf4, stack size:  388 bytes #
> (gdb) ####################################
> (gdb) 0xc013ebf4 is in __print_symbol (kernel/kallsyms.c:234).

The attached patch fixes this partially by reducing the stack usage by
128 bytes. Compile, boot and run tested and apparently it works fine.

I didn't want to use kmalloc's in there because this function is
probably called from very "hard" contexts (kernel OOPS, stack overflow
dumps, etc.).

The stack usage could be reduced even further (I can do a patch for this
if needed) by changing the function to receive a "prefix" and a "suffix"
string instead of a format string.

The function could then simply do:
    printk(prefix);
    printk(symbol);
    printk(address);
    if (module) printk(module name);
    printk(suffix);

This way it wouldn't need to allocate a buffer big enough for the whole
string, just for one symbol name (128 bytes).

This is a much more intrusive change however (there are ~65 callers that
would need changing), so I leave the decision to more experienced hackers :)

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams

--------------050600070602070702060104
Content-Type: text/x-patch;
 name="kallsyms_reduce_stack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kallsyms_reduce_stack.patch"

--- ./kernel/kallsyms.c.orig	2005-07-11 12:32:32.000000000 +0100
+++ ./kernel/kallsyms.c	2005-07-11 12:34:42.000000000 +0100
@@ -232,23 +232,21 @@ const char *kallsyms_lookup(unsigned lon
 /* Replace "%s" in format with address, or returns -errno. */
 void __print_symbol(const char *fmt, unsigned long address)
 {
-	char *modname;
+	char *modname, *bufend;
 	const char *name;
 	unsigned long offset, size;
-	char namebuf[KSYM_NAME_LEN+1];
 	char buffer[sizeof("%s+%#lx/%#lx [%s]") + KSYM_NAME_LEN +
 		    2*(BITS_PER_LONG*3/10) + MODULE_NAME_LEN + 1];

-	name = kallsyms_lookup(address, &size, &offset, &modname, namebuf);
+	name = kallsyms_lookup(address, &size, &offset, &modname, buffer);

 	if (!name)
 		sprintf(buffer, "0x%lx", address);
 	else {
+		bufend = strchr(buffer, '\0');
+		bufend += sprintf(bufend, "+%#lx/%#lx", offset, size);
 		if (modname)
-			sprintf(buffer, "%s+%#lx/%#lx [%s]", name, offset,
-				size, modname);
-		else
-			sprintf(buffer, "%s+%#lx/%#lx", name, offset, size);
+			sprintf(bufend, " [%s]", modname);
 	}
 	printk(fmt, buffer);
 }


--------------050600070602070702060104--
