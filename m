Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315264AbSELAi5>; Sat, 11 May 2002 20:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSELAi4>; Sat, 11 May 2002 20:38:56 -0400
Received: from rongage.org ([63.83.235.147]:18580 "EHLO net.rongage.org")
	by vger.kernel.org with ESMTP id <S315264AbSELAiz>;
	Sat, 11 May 2002 20:38:55 -0400
Subject: Question about module.[c,h] - kernel 2.4.18
From: Ron Gage <ron@rongage.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 11 May 2002 20:33:09 -0400
Message-Id: <1021163601.558.32.camel@portable>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks:

I am in the process of doing some compile cleanups - a la kernel
janitors project type stuff.

I came across a fairly major inconsistancy in module.c and module.h and
I was hoping someone could tell me just how whacked my view of this
is...

The code in question from module.c...

struct module kernel_module =
{
        size_of_struct:         sizeof(struct module),
        name:                   "",
        uc:                     {ATOMIC_INIT(1)},
        flags:                  MOD_RUNNING,
        syms:                   __start___ksymtab,
        ex_table_start:         __start___ex_table,
        ex_table_end:           __stop___ex_table,
        kallsyms_start:         __start___kallsyms,
        kallsyms_end:           __stop___kallsyms,

};

Looks fairly straight forward, but it is missing several elements from
the module struct.  The module struct is defined as follows:

struct module
{
        unsigned long size_of_struct;   /* == sizeof(module) */
        struct module *next;
        const char *name;
        unsigned long size;

        union
        {
                atomic_t usecount;
                long pad;
        } uc;                           /* Needs to keep its size - so
says rth */

        unsigned long flags;            /* AUTOCLEAN et al */

        unsigned nsyms;
        unsigned ndeps;

        struct module_symbol *syms;
        struct module_ref *deps;
        struct module_ref *refs;
        int (*init)(void);
        void (*cleanup)(void);
        const struct exception_table_entry *ex_table_start;
        const struct exception_table_entry *ex_table_end;
#ifdef __alpha__
        unsigned long gp;
#endif
        /* Members past this point are extensions to the basic
           module support and are optional.  Use mod_member_present()
           to examine them.  */
        const struct module_persist *persist_start;
        const struct module_persist *persist_end;
        int (*can_unload)(void);
        int runsize;                    /* In modutils, not currently
used */
        const char *kallsyms_start;     /* All symbols for kernel
debugging */
        const char *kallsyms_end;
        const char *archdata_start;     /* arch specific data for module
*/
        const char *archdata_end;
        const char *kernel_data;        /* Reserved for kernel internal
use */
};


In essence, there are 20 elements to the module struct (i386), but
module.c only initializes 9 of those elements.  This gives 11
uninitialized elements (and compile warnings).  These warnings are what
I am trying to kill off.  

Does anyone see any problems with initializing the remaining elements of
this struct?

-- 
Ron Gage - Saginaw, MI
(ron@rongage.org)


