Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318663AbSG0A1G>; Fri, 26 Jul 2002 20:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318664AbSG0A1F>; Fri, 26 Jul 2002 20:27:05 -0400
Received: from [195.223.140.120] ([195.223.140.120]:18544 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318663AbSG0A1F>; Fri, 26 Jul 2002 20:27:05 -0400
Date: Sat, 27 Jul 2002 02:31:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module oops tracking [Re: [PATCH] cheap lookup of symbol names on oops()]
Message-ID: <20020727003121.GC1177@dualathlon.random>
References: <20020726223750.GA1151@dualathlon.random> <18391.1027729171@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18391.1027729171@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 10:19:31AM +1000, Keith Owens wrote:
> On Sat, 27 Jul 2002 00:37:50 +0200, 
> Andrea Arcangeli <andrea@suse.de> wrote:
> >I implemented what I need to track down oopses with modules. ksymoops
> >should learn about it too. This will also allow us to recognize
> >immediatly the kernel image used.
> >+#define MODULE_OOPS_TRACKING_NR_LONGS 10
> >+#define MODULE_OOPS_TRACKING_NR_BITS (BITS_PER_LONG * MODULE_OOPS_TRACKING_NR_LONGS)
> >+static unsigned long module_oops_tracking[MODULE_OOPS_TRACKING_NR_LONGS];
> >+void module_oops_tracking_mark(int nr)
> >+{
> >+	if (nr < MODULE_OOPS_TRACKING_NR_BITS)
> >+		set_bit(nr, module_oops_tracking);
> >+}
> >+
> >+static void __module_oops_tracking_print(int nr)
> >+{
> >+	struct module *mod;
> >+
> >+	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
> >+		if (!nr--)
> >+			printk("	[(%s:<%p>:<%p>)]\n",
> >+			       mod->name,
> >+			       (char *) mod + mod->size_of_struct,
> >+			       (char *) mod + mod->size);
> >+	}
> >+	
> >+}
> 
> Instead of adding a separate bit map and scanning the module chain to
> convert a bit number to a module entry, add a new entry to mod->flags.
> 
>   #define MOD_OOPS_PRINTED 128
> 
> That simplifies the code and reduces the number of times you have to
> scan the module list.

ok, the prepare stage will be a bit more complicated but it seems
a worthwhile change, thanks.

> 
> Beware if Rusty's idea of discarding init code/data from modules ever
> takes off.  Then the text will not be contiguous, nor will it be at the
> start of the module.

well I assume it's not going to happen in 2.4 anyways and the module
information is really just necessary (we are lacking this needed
information for years now). Once the text won't be contigous anymore to
free init sections for modules too the same needed info on the
presistent text could be provided in a different manner. If you need
anything in the oops now to make life easier to ksymoops later just let
me know.

Andrea
