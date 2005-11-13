Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbVKMD6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVKMD6k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 22:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVKMD6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 22:58:40 -0500
Received: from c-67-177-11-17.hsd1.ut.comcast.net ([67.177.11.17]:4736 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S1751306AbVKMD6j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 22:58:39 -0500
Message-ID: <4376B3C1.6000409@wolfmountaingroup.com>
Date: Sat, 12 Nov 2005 20:32:17 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Andi Kleen <ak@suse.de>, jmerkey <jmerkey@utah-nac.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 0/39] NLKD - Novell Linux Kernel Debugger
References: <43720DAE.76F0.0078.0@novell.com> <p73u0eh4als.fsf@verdi.suse.de> <4376AAC1.5060503@utah-nac.org> <200511130444.45468.ak@suse.de> <4376B278.2060407@wolfmountaingroup.com>
In-Reply-To: <4376B278.2060407@wolfmountaingroup.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:

> Andi Kleen wrote:
>
>> On Sunday 13 November 2005 03:53, jmerkey wrote:
>>
>>  
>>
>>> Yes. This is the way to go. Use kdb as a base and instrument an 
>>> alternate debugger interface. You need to also find a good way to
>>> allow GDB to work properly with alternate debuggers. At present, the 
>>> code in traps.c is mutually exclusive since embedded int3
>>> breakpoints trigger in the kernel for gbd. This is busted.
>>>   
>>
>>
>>
>> I don't think we'll support stacking multiple kernel debuggers (except
>> for special cases like kprobes+another debugger). It's complicated
>> and probably not worth it.
>>
>> -Andi
>>
>>
>>  
>>
> I already instrumented an alternate debugger interface in MDB.  It's 
> not complicated at all.    Here's the code.  All you
> need to do is change two places.  Add the alternate interface into 
> kdb, and fix the int3 contention problem with GDB.  GDB
> support with kdb action involves creating a callback into GDB 
> signaling the int3 POST kdb handling.  In other words, keep
> a table of breakpoints for int3 alternate debuggers they must 
> register, compare against this table and divert the int3 on this basis,
> it is matches the table, send to the registered debugger entry point, 
> if it doesn't match, call the GDB handler and send it to
> userspace.  Seems simple.  Here's part one.  Someone else can write 
> part 2.
>
> Jeff
> diff -Naur ./kdb/kdbmain.c ../linux-2.6.9-mdb/./kdb/kdbmain.c
> --- ./kdb/kdbmain.c    2004-10-18 11:46:59.439535288 -0600
> +++ ../linux-2.6.9-mdb/./kdb/kdbmain.c    2004-10-18 
> 11:44:47.000000000 -0600
> @@ -57,7 +57,12 @@
> int kdb_seqno = 2;                /* how many times kdb has been 
> entered */
>
> volatile int kdb_nextline = 1;
> +
> +#if defined(CONFIG_MDB)
> +volatile int kdb_new_cpu;        /* Which cpu to switch to */
> +#else
> static volatile int kdb_new_cpu;        /* Which cpu to switch to */
> +#endif
>
> volatile int kdb_state[NR_CPUS];        /* Per cpu state */
>
> @@ -1134,8 +1139,13 @@
>
> extern char kdb_prompt_str[];
>
> +#if defined(CONFIG_MDB)
> static int
> kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs, 
> kdb_dbtrap_t db_result)
> +#else
> +int
> +kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs, 
> kdb_dbtrap_t db_result)
> +#endif
> {
>     char *cmdbuf;
>     int diag;
> @@ -1676,6 +1686,27 @@
>     int result = 0;    /* Default is kdb did not handle it */
>     int ss_event;
>     kdb_dbtrap_t db_result=KDB_DB_NOBPT;
> +
> +#if defined(CONFIG_MDB)
> +        extern int AlternateDebuggerRoutine(kdb_reason_t reason, int 
> error,
> +                                     struct pt_regs *ef);
> +    if (!kdb_on)
> +       return 0;
> +
> +        result = AlternateDebuggerRoutine(reason, error, regs);
> +        switch (result)
> +        {
> +           case 1:  // alternate debugger handled event
> +              return 1;
> +
> +           case -1: // alternate debugger did not handle event
> +              return 0;
> +
> +           default: // drop into kdb
> +              break;
> +        }
> +#endif
> +
>     atomic_inc(&kdb_event);
>
>     switch(reason) {
> @@ -3016,6 +3047,40 @@
>  * Remarks:
>  */
>
> +#if defined (CONFIG_MDB)
> +
> +#include <linux/mdbglobals.h>
> +
> +void
> +mdb_ps1(struct task_struct *p)
> +{
> +    DBGPrint("0x%p %8d %8d  %d %4d   %c  0x%p %c%s\n",
> +           (void *)p, p->pid, p->parent->pid,
> +           kdb_task_has_cpu(p), kdb_process_cpu(p),
> +           (p->state == 0) ? 'R' :
> +             (p->state < 0) ? 'U' :
> +             (p->state & TASK_UNINTERRUPTIBLE) ? 'D' :
> +             (p->state & TASK_STOPPED || p->ptrace & PT_PTRACED) ? 'T' :
> +             (p->state & TASK_ZOMBIE) ? 'Z' :
> +             (p->state & TASK_INTERRUPTIBLE) ? 'S' : '?',
> +           (void *)(&p->thread),
> +           (p == current) ? '*': ' ',
> +           p->comm);
> +    if (kdb_task_has_cpu(p)) {
> +        struct kdb_running_process *krp = kdb_running_process + 
> kdb_process_cpu(p);
> +        if (!krp->seqno || !krp->p)
> +            DBGPrint("  Error: no saved data for this cpu\n");
> +        else {
> +            if (krp->seqno < kdb_seqno - 1)
> +                DBGPrint("  Warning: process state is stale\n");
> +            if (krp->p != p)
> +                DBGPrint("  Error: does not match running process 
> table (0x%p)\n", krp->p);
> +        }
> +    }
> +}
> +
> +#endif
> +
> void
> kdb_ps1(struct task_struct *p)
> {
> @@ -3835,6 +3900,10 @@
> void __init
> kdb_init(void)
> {
> +#if defined(CONFIG_MDB)
> +        extern void mdb_init(void);                +#endif
> +
>     kdb_initial_cpu = smp_processor_id();
>     /*
>      * This must be called before any calls to kdb_printf.
> @@ -3855,6 +3924,11 @@
>
>     kdb_cmd_init();        /* Preset commands from kdb_cmds */
>     kdb_initial_cpu = -1;    /* Avoid recursion problems */
> +
> +#if defined(CONFIG_MDB)
> +        mdb_init();                +#endif
> +
>     kdb(KDB_REASON_SILENT, 0, 0);    /* Activate any preset 
> breakpoints on boot cpu */
>     kdb_initial_cpu = smp_processor_id();
>     notifier_chain_register(&panic_notifier_list, &kdb_block);
>
>
Alternate Debuggers should register an init function called from 
kdb_init.   Calling AlternateDebuggerInterface should call all registred 
debuggers
and allow each one to report status.  NetWare has had an alternate 
debugger interface for years.  It's easy to instrument.  The only thing
in Linux that's odd at all is the way GDB int3's are handled.  All this 
other stuff they are making you put in is not the problem of Linux.

Jeff

Jeff
