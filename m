Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318657AbSG0AQ1>; Fri, 26 Jul 2002 20:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318659AbSG0AQ1>; Fri, 26 Jul 2002 20:16:27 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:63250 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S318657AbSG0AQ0>;
	Fri, 26 Jul 2002 20:16:26 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module oops tracking [Re: [PATCH] cheap lookup of symbol names on oops()] 
In-reply-to: Your message of "Sat, 27 Jul 2002 00:37:50 +0200."
             <20020726223750.GA1151@dualathlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 27 Jul 2002 10:19:31 +1000
Message-ID: <18391.1027729171@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2002 00:37:50 +0200, 
Andrea Arcangeli <andrea@suse.de> wrote:
>I implemented what I need to track down oopses with modules. ksymoops
>should learn about it too. This will also allow us to recognize
>immediatly the kernel image used.
>+#define MODULE_OOPS_TRACKING_NR_LONGS 10
>+#define MODULE_OOPS_TRACKING_NR_BITS (BITS_PER_LONG * MODULE_OOPS_TRACKING_NR_LONGS)
>+static unsigned long module_oops_tracking[MODULE_OOPS_TRACKING_NR_LONGS];
>+void module_oops_tracking_mark(int nr)
>+{
>+	if (nr < MODULE_OOPS_TRACKING_NR_BITS)
>+		set_bit(nr, module_oops_tracking);
>+}
>+
>+static void __module_oops_tracking_print(int nr)
>+{
>+	struct module *mod;
>+
>+	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
>+		if (!nr--)
>+			printk("	[(%s:<%p>:<%p>)]\n",
>+			       mod->name,
>+			       (char *) mod + mod->size_of_struct,
>+			       (char *) mod + mod->size);
>+	}
>+	
>+}

Instead of adding a separate bit map and scanning the module chain to
convert a bit number to a module entry, add a new entry to mod->flags.

  #define MOD_OOPS_PRINTED 128

That simplifies the code and reduces the number of times you have to
scan the module list.

Beware if Rusty's idea of discarding init code/data from modules ever
takes off.  Then the text will not be contiguous, nor will it be at the
start of the module.

