Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268550AbTANDMt>; Mon, 13 Jan 2003 22:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268551AbTANDMt>; Mon, 13 Jan 2003 22:12:49 -0500
Received: from dp.samba.org ([66.70.73.150]:18851 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268550AbTANDMq>;
	Mon, 13 Jan 2003 22:12:46 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [MODULES] fix weak symbol handling 
In-reply-to: Your message of "Mon, 13 Jan 2003 11:00:36 -0800."
             <20030113110036.A873@twiddle.net> 
Date: Tue, 14 Jan 2003 14:11:30 +1100
Message-Id: <20030114032138.5C1E92C2C5@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030113110036.A873@twiddle.net> you write:
> I discovered this while working on oprofile for Alpha.  I thought
> I'd avoid a whole series of nested ifdefs by marking some symbols
> weak, and so let them go undefined and resolve to null.  Except 
> that we don't handle that in the new module loader.
> 
> Fixed thus.

That part looks OK.  The second loop was only there so we placed
common symbols first: now we don't do that, your cleanup is a good
idea.  I'll extract and test that part.

> 
> I also correct a misconception in simplify_symbol.  It is pointless
> to lookup an undefined symbol in the module in which it is undefined.

<sigh>. I don't think so.

PPC64 (not in tree yet):

+		/* REL24 references to (external) .function won't
+                   resolve; deal with that below */
+		if (!sym->st_value
+		    && ELF64_R_TYPE(rela[i].r_info) != R_PPC_REL24) {
+			printk("%s: Unknown symbol %s (index %u)\n",
+			       me->name, strtab + sym->st_name,
+			       sym->st_shndx);
+			return -ENOENT;
+		}

That's *why* find_symbol_internal() is not static, and why we don't
fail in simplify_symbol() 8(

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
