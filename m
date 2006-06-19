Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWFSKg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWFSKg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 06:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWFSKg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 06:36:57 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:11915 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932369AbWFSKg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 06:36:56 -0400
Date: Mon, 19 Jun 2006 06:31:46 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Possible spinlock recursion in search_module_extables() ?
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200606190635_MC3-1-C2D8-258F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at this code:

const struct exception_table_entry *search_exception_tables(unsigned long addr)
{
        const struct exception_table_entry *e;

        e = search_extable(__start___ex_table, __stop___ex_table-1, addr);
        if (!e)
                e = search_module_extables(addr);
        return e;
}

const struct exception_table_entry *search_module_extables(unsigned long addr)
{
        unsigned long flags;
        const struct exception_table_entry *e = NULL;
        struct module *mod;

        spin_lock_irqsave(&modlist_lock, flags);
        list_for_each_entry(mod, &modules, list) {
                if (mod->num_exentries == 0)
                        continue;

                e = search_extable(mod->extable,
                                   mod->extable + mod->num_exentries - 1,
                                   addr);
                if (e)
                        break;
        }
        spin_unlock_irqrestore(&modlist_lock, flags);

        /* Now, if we found one, we are running inside it now, hence
           we cannot unload the module, hence no refcnt needed. */
        return e;
}


search_module_extables() takes a spinlock.  If some kind of fault occurs
while it's holding that lock (module list corrupted etc.,) won't it be
re-entered while looking for its own fault handler?  If so, would this
be a possible fix?

const struct exception_table_entry *search_exception_tables(unsigned long addr)
{
        const struct exception_table_entry *e;

        if (core_kernel_text(addr))
                e = search_extable(__start___ex_table, __stop___ex_table-1, addr);
        else
                e = search_module_extables(addr);

        return e;
}
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
