Return-Path: <linux-kernel-owner+w=401wt.eu-S1751038AbXAQMY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbXAQMY2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 07:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbXAQMY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 07:24:28 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:42737 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbXAQMY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 07:24:27 -0500
Date: Wed, 17 Jan 2007 17:55:06 +0530
From: "S. P. Prasanna" <prasanna@in.ibm.com>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Prasanna S Panchamukhi <prasanna@in.ibm.co>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@redhat.com>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: [PATCH 0/4 update] kprobes and traps
Message-ID: <20070117122505.GA2967@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20070113054534.GA27017@Krystal> <20070116174158.GA16084@Krystal> <20070116212740.GA29492@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070116212740.GA29492@Krystal>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 04:27:40PM -0500, Mathieu Desnoyers wrote:
> Hi,
> 
> I have looked at kprobes code and have some questions for you. I would really
> like to use it to patch dynamically my marker immediate value by doing code
> patching. Using an int3 seems like the right way to handle this wrt pIII erratum
> 49.
> 
> Everything is ok, except for a limitation important to the LTTng project :
> kprobes cannot probe trap handlers. Looking at the code, I see that the kprobes
> trap notifier expects interrupts to be disabled when it is run. Looking a little
> deeper in the code, I notice that you use per-cpu data structures to keep the
> probe control information that is needed for single stepping, which clearly
> requires you to disable interrupts so no interrupt handler with a kprobe in it
> fires on top of the kprobe handler. It also forbids trap handler and NMI
> handler instrumentation, as traps can be triggered by the kprobes handler and
> NMIs can come at any point during execution.

>From i386 point of view, your understanding is correct.

> 
> Would it be possible to put these data structures on the stack or on a
> separate stack accessible through thread_info instead ?
> 

Yes, probably you can put them on per thread kernel stack.
But you need to find enough stack space to save the probe control
information. Also enough stack space should be allocated to handle
re-entrant kprobe handlers.
How will you handle the case where in nested interrupts happen while you
are in a the kprobe handler and those interrupt handlers have probes.
How many levels of nesting will you allow?
                                                                                
Regards
Prasanna

> 
> 
> * Mathieu Desnoyers (compudj@krystal.dyndns.org) wrote:
> > Hi Richard,
> >
> > * Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca) wrote:
> > > > You've got the same optimizations for x86 by modifying an instruction's
> > > > immediate operand and thus avoiding a d-cache hit. The only real caveat is
> > > > the need to avoid the unsynchronised cross modification erratum. Which
> > > > means that all processors will need to issue a serializing operation before
> > > > executing a Marker whose state is changed. How is that handled?
> > > >
> > >
> > > Good catch. I thought that modifying only 1 byte would spare us from this
> > > errata, but looking at it in detail tells me than it's not the case.
> > >
> > > I see three different ways to address the problem :
> > [...]
> > > 3 - First write an int3 instead of the instruction's first byte. The handler
> > >     would do the following :
> > >     int3_handler :
> > >       single-step the original instruction.
> > >       iret
> > >
> > >     Secondly, we call an IPI that does a smp_processor_id() on each CPU and
> > >     wait for them to complete. It will make sure we execute a synchronizing
> > >     instruction on every CPU even if we do not execute the trap handler.
> > >
> > >     Then, we write the new 2 bytes instruction atomically instead of the int3
> > >     and immediate value.
> > >
> > >
> >
> > Here is the implementation of my proposal using a slightly enhanced kprobes. I
> > add the ability to single step a different instruction than the original one,
> > and then put the new instruction instead of the original one when removing the
> > kprobe. It is an improvement on the djprobes design : AFAIK, djprobes required
> > the int3 to be executed by _every_ CPU before the instruction could be
> > replaced. It was problematic with rarely used code paths (error handling) and
> > with thread CPU affinity. Comments are welcome.
> >
> > I noticed that it restrains LTTng by removing the ability to probe
> > do_general_protection, do_nmi, do_trap, do_debug and do_page_fault.
> > hardirq on/off in lockdep.c must also be tweaked to allow
> > local_irq_enable/disable usage within the debug trap handler.
> >
> > It would be nice to push the study of the kprobes debug trap handler so it can
> > become possible to use it to put breakpoints in trap handlers. For now, kprobes
> > refuses to insert breakpoints in __kprobes marked functions. However, as we
> > instrument specific spots of the functions (not necessarily the function entry),
> > it is sometimes correct to use kprobes on a marker within the function even if
> > it is not correct to use it in the prologue. Insight from the SystemTAP team
> > would be welcome on this kprobe limitation.
> >
> > Mathieu
> >
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> >
> > --- a/arch/i386/kernel/kprobes.c
> > +++ b/arch/i386/kernel/kprobes.c
> > @@ -31,6 +31,7 @@
> >  #include <linux/kprobes.h>
> >  #include <linux/ptrace.h>
> >  #include <linux/preempt.h>
> > +#include <linux/kallsyms.h>
> >  #include <asm/cacheflush.h>
> >  #include <asm/kdebug.h>
> >  #include <asm/desc.h>
> > @@ -753,6 +754,73 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
> >  	return 0;
> >  }
> >
> > +static struct kprobe xmc_kp;
> > +DEFINE_MUTEX(kprobe_xmc_mutex);
> > +
> > +static int xmc_handler_pre(struct kprobe *p, struct pt_regs *regs)
> > +{
> > +	return 0;
> > +}
> > +
> > +static void xmc_handler_post(struct kprobe *p, struct pt_regs *regs,
> > +	unsigned long flags)
> > +{
> > +}
> > +
> > +static int xmc_handler_fault(struct kprobe *p, struct pt_regs *regs, int trapnr)
> > +{
> > +	return 0;
> > +}
> > +
> > +static void xmc_synchronize_cpu(void *info)
> > +{
> > +	smp_processor_id();
> > +}
> > +
> > +/* Think of it as a memcpy of new into address with safety with regard to
> > + * Intel PIII errata 49. Only valid for modifying a single instruction with
> > + * an instruction of the same size or in smaller instructions of the total
> > + * same size as the original instruction. */
> > +int arch_xmc(void *address, char *newi, int size)
> > +{
> > +	int ret = 0;
> > +	char *dest = (char*)address;
> > +	char str[KSYM_NAME_LEN + 1];
> > +	unsigned long sym_offs, sym_size;
> > +	char *modname;
> > +	const char *sym_name;
> > +
> > +	mutex_lock(&kprobe_xmc_mutex);
> > +	xmc_kp.pre_handler = xmc_handler_pre;
> > +	xmc_kp.post_handler = xmc_handler_post;
> > +	xmc_kp.fault_handler = xmc_handler_fault;
> > +	xmc_kp.addr = address;
> > +	xmc_kp.symbol_name = NULL;
> > +	xmc_kp.offset = 0;
> > +
> > +	ret = register_kprobe_swapi(&xmc_kp, newi, size);
> > +	if (ret < 0) {
> > +		sym_name = kallsyms_lookup((unsigned long)address,
> > +				&sym_size, &sym_offs,
> > +				&modname, str);
> > +		printk("register_kprobe failed for %p in %s:%s returned %d\n",
> > +			address, modname?modname:"kernel", sym_name, ret);
> > +		goto end;
> > +	}
> > +	/* Copy every bytes of the new instruction except the first one */
> > +	memcpy(dest+1, newi+1, size-1);
> > +	flush_icache_range(dest, size);
> > +	/* Execute serializing instruction on each CPU */
> > +	ret = on_each_cpu(xmc_synchronize_cpu, NULL, 1, 1);
> > +	BUG_ON(ret != 0);
> > +
> > +	unregister_kprobe(&xmc_kp);
> > +end:
> > +	mutex_unlock(&kprobe_xmc_mutex);
> > +
> > +	return ret;
> > +}
> > +
> >  int __init arch_init_kprobes(void)
> >  {
> >  	return 0;
> > --- a/include/asm-generic/marker.h
> > +++ b/include/asm-generic/marker.h
> > @@ -18,7 +18,7 @@ struct __mark_marker_c {
> >
> >  struct __mark_marker {
> >  	const struct __mark_marker_c *cmark;
> > -	volatile char *enable;
> > +	char *enable;
> >  } __attribute__((packed));
> >
> >  #ifdef CONFIG_MARKERS
> > --- a/include/asm-i386/kprobes.h
> > +++ b/include/asm-i386/kprobes.h
> > @@ -90,4 +90,7 @@ static inline void restore_interrupts(struct pt_regs *regs)
> >
> >  extern int kprobe_exceptions_notify(struct notifier_block *self,
> >  				    unsigned long val, void *data);
> > +/* pIII code cross modification which follows erratum 49. */
> > +#define ARCH_HAS_XMC
> > +int arch_xmc(void *address, char *newi, int size);
> >  #endif				/* _ASM_KPROBES_H */
> > --- a/include/asm-i386/marker.h
> > +++ b/include/asm-i386/marker.h
> > @@ -18,7 +18,7 @@ struct __mark_marker_c {
> >
> >  struct __mark_marker {
> >  	struct __mark_marker_c *cmark;
> > -	volatile char *enable;
> > +	char *enable;
> >  } __attribute__((packed));
> >
> >  #ifdef CONFIG_MARKERS
> > --- a/include/asm-powerpc/marker.h
> > +++ b/include/asm-powerpc/marker.h
> > @@ -20,7 +20,7 @@ struct __mark_marker_c {
> >
> >  struct __mark_marker {
> >  	struct __mark_marker_c *cmark;
> > -	volatile short *enable;
> > +	short *enable;
> >  } __attribute__((packed));
> >
> >  #ifdef CONFIG_MARKERS
> > --- a/include/linux/kprobes.h
> > +++ b/include/linux/kprobes.h
> > @@ -189,6 +189,7 @@ static inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)
> >  }
> >
> >  int register_kprobe(struct kprobe *p);
> > +int register_kprobe_swapi(struct kprobe *p, char *newi, int size);
> >  void unregister_kprobe(struct kprobe *p);
> >  int setjmp_pre_handler(struct kprobe *, struct pt_regs *);
> >  int longjmp_break_handler(struct kprobe *, struct pt_regs *);
> > @@ -203,6 +204,9 @@ struct kretprobe_instance *get_free_rp_inst(struct kretprobe *rp);
> >  void add_rp_inst(struct kretprobe_instance *ri);
> >  void kprobe_flush_task(struct task_struct *tk);
> >  void recycle_rp_inst(struct kretprobe_instance *ri, struct hlist_head *head);
> > +/* Architecture specific code cross-modification. Valid for overwriting
> > + * a single instruction. Safe for Intel PIII erratum 49. */
> > +int kprobe_xmc(void *address, char *newi, int size);
> >  #else /* CONFIG_KPROBES */
> >
> >  #define __kprobes	/**/
> > --- a/include/linux/marker.h
> > +++ b/include/linux/marker.h
> > @@ -40,7 +40,7 @@
> >
> >  typedef void marker_probe_func(const char *fmt, ...);
> >
> > -#ifndef CONFIG_MARKERS_DISABLE_OPTIMIZATION
> > +#ifdef CONFIG_MARKERS_ENABLE_OPTIMIZATION
> >  #include <asm/marker.h>
> >  #else
> >  #include <asm-generic/marker.h>
> > --- a/kernel/Kconfig.marker
> > +++ b/kernel/Kconfig.marker
> > @@ -8,9 +8,10 @@ config MARKERS
> >  	  Place an empty function call at each marker site. Can be
> >  	  dynamically changed for a probe function.
> >
> > -config MARKERS_DISABLE_OPTIMIZATION
> > -	bool "Disable architecture specific marker optimization"
> > -	depends EMBEDDED
> > +config MARKERS_ENABLE_OPTIMIZATION
> > +	bool "Enable marker optimization (EXPERIMENTAL)"
> > +	depends MARKERS
> > +	select KPROBES
> >  	default n
> >  	help
> >  	  Disable code replacement jump optimisations. Especially useful if your
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -534,7 +534,7 @@ static int __kprobes in_kprobes_functions(unsigned long addr)
> >  }
> >
> >  static int __kprobes __register_kprobe(struct kprobe *p,
> > -	unsigned long called_from)
> > +	unsigned long called_from, char *newi, int size)
> >  {
> >  	int ret = 0;
> >  	struct kprobe *old_p;
> > @@ -587,6 +587,10 @@ static int __kprobes __register_kprobe(struct kprobe *p,
> >
> >  	if ((ret = arch_prepare_kprobe(p)) != 0)
> >  		goto out;
> > +	if (newi) {
> > +		memcpy(p->ainsn.insn, newi, size);
> > +		p->opcode = *newi;
> > +	}
> >
> >  	INIT_HLIST_NODE(&p->hlist);
> >  	hlist_add_head_rcu(&p->hlist,
> > @@ -609,7 +613,14 @@ out:
> >  int __kprobes register_kprobe(struct kprobe *p)
> >  {
> >  	return __register_kprobe(p,
> > -		(unsigned long)__builtin_return_address(0));
> > +		(unsigned long)__builtin_return_address(0),
> > +		NULL, 0);
> > +}
> > +
> > +int __kprobes register_kprobe_swapi(struct kprobe *p, char *newi, int size)
> > +{
> > +	return __register_kprobe(p,
> > +		(unsigned long)__builtin_return_address(0), newi, size);
> >  }
> >
> >  void __kprobes unregister_kprobe(struct kprobe *p)
> > @@ -699,7 +710,8 @@ int __kprobes register_jprobe(struct jprobe *jp)
> >  	jp->kp.break_handler = longjmp_break_handler;
> >
> >  	return __register_kprobe(&jp->kp,
> > -		(unsigned long)__builtin_return_address(0));
> > +		(unsigned long)__builtin_return_address(0),
> > +		NULL, 0);
> >  }
> >
> >  void __kprobes unregister_jprobe(struct jprobe *jp)
> > @@ -760,7 +772,8 @@ int __kprobes register_kretprobe(struct kretprobe *rp)
> >  	rp->nmissed = 0;
> >  	/* Establish function entry probe point */
> >  	if ((ret = __register_kprobe(&rp->kp,
> > -		(unsigned long)__builtin_return_address(0))) != 0)
> > +		(unsigned long)__builtin_return_address(0),
> > +		NULL, 0)) != 0)
> >  		free_rp_inst(rp);
> >  	return ret;
> >  }
> > @@ -790,6 +803,33 @@ void __kprobes unregister_kretprobe(struct kretprobe *rp)
> >  	free_rp_inst(rp);
> >  }
> >
> > +#ifdef ARCH_HAS_XMC
> > +int kprobe_xmc(void *address, char *newi, int size)
> > +{
> > +	return arch_xmc(address, newi, size);
> > +}
> > +#else
> > +/* Limited XMC : only overwrite an instruction with an atomic operation
> > + * (writing at most an aligned long). */
> > +int kprobe_xmc(void *address, char *newi, int size)
> > +{
> > +	if (size > sizeof(long)) {
> > +		printk("Limited XMC : cannot overwrite instructions bigger "\
> > +			"than %d. XMC of size %d fails.\n", sizeof(long),
> > +			size);
> > +		return -EPERM;
> > +	}
> > +	if (hweight32(size) != 1 || address % size != 0) {
> > +		printk("Limited XMC : cannot write %d bytes unaligned "\
> > +			"instruction. XMC fails.\n", size);
> > +		return -EPERM;
> > +	}
> > +	memcpy(address, newi, size);
> > +	flush_icache_range(address, size);
> > +}
> > +#endif /* HAS_ARCH_XMC */
> > +EXPORT_SYMBOL(kprobe_xmc);
> > +
> >  static int __init init_kprobes(void)
> >  {
> >  	int i, err = 0;
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -40,6 +40,7 @@
> >  #include <linux/string.h>
> >  #include <linux/mutex.h>
> >  #include <linux/unwind.h>
> > +#include <linux/kprobes.h>
> >  #include <asm/uaccess.h>
> >  #include <asm/semaphore.h>
> >  #include <asm/cacheflush.h>
> > @@ -309,6 +310,26 @@ EXPORT_SYMBOL(__mark_empty_function);
> >  #define MARK_ENABLE_OFFSET(a) \
> >  	(typeof(a))((char*)a+MARK_ENABLE_IMMEDIATE_OFFSET)
> >
> > +/* wmb() stay ordered. State will be ok for interrupts/other CPUs. */
> > +#ifdef MARK_POLYMORPHIC
> > +static int marker_set_enable(char *address, char enable)
> > +{
> > +	char newi[MARK_ENABLE_IMMEDIATE_OFFSET+1];
> > +
> > +	memcpy(newi, address, MARK_ENABLE_IMMEDIATE_OFFSET+1);
> > +	*MARK_ENABLE_OFFSET(&newi[0]) = enable;
> > +	return kprobe_xmc(address, newi, MARK_ENABLE_IMMEDIATE_OFFSET+1);
> > +}
> > +#else
> > +static int marker_set_enable(char *address, char enable)
> > +{
> > +	*MARK_ENABLE_OFFSET(address) = enable;
> > +	return 0;
> > +}
> > +#endif /* MARK_POLYMORPHIC */
> > +
> > +/* enable and function address are set out of order, and it's ok :
> > + * the state is always coherent. */
> >  static int marker_set_probe_range(const char *name,
> >  	const char *format,
> >  	marker_probe_func *probe,
> > @@ -336,13 +357,7 @@ static int marker_set_probe_range(const char *name,
> >  					*iter->cmark->call =
> >  						__mark_empty_function;
> >  				}
> > -				/* Can have many enables for one function */
> > -				*MARK_ENABLE_OFFSET(iter->enable) = 0;
> > -#ifdef MARK_POLYMORPHIC
> > -				flush_icache_range(
> > -					MARK_ENABLE_OFFSET(iter->enable),
> > -					sizeof(*(iter->enable)));
> > -#endif
> > +				marker_set_enable(iter->enable, 0);
> >  			} else {
> >  				if (*iter->cmark->call
> >  					!= __mark_empty_function) {
> > @@ -360,12 +375,7 @@ static int marker_set_probe_range(const char *name,
> >  					*iter->cmark->call = probe;
> >  				}
> >  				/* Can have many enables for one function */
> > -				*MARK_ENABLE_OFFSET(iter->enable) = 1;
> > -#ifdef MARK_POLYMORPHIC
> > -				flush_icache_range(
> > -					MARK_ENABLE_OFFSET(iter->enable),
> > -					sizeof(*(iter->enable)));
> > -#endif
> > +				marker_set_enable(iter->enable, 1);
> >  			}
> >  			found++;
> >  		}
> > @@ -382,12 +392,7 @@ static int marker_remove_probe_range(marker_probe_func *probe,
> >
> >  	for (iter = begin; iter < end; iter++) {
> >  		if (*iter->cmark->call == probe) {
> > -			*MARK_ENABLE_OFFSET(iter->enable) = 0;
> > -#ifdef MARK_POLYMORPHIC
> > -				flush_icache_range(
> > -					MARK_ENABLE_OFFSET(iter->enable),
> > -					sizeof(*(iter->enable)));
> > -#endif
> > +			marker_set_enable(iter->enable, 0);
> >  			*iter->cmark->call = __mark_empty_function;
> >  			found++;
> >  		}
> > @@ -419,9 +424,8 @@ int marker_set_probe(const char *name, const char *format,
> >  {
> >  	struct module *mod;
> >  	int found = 0;
> > -	unsigned long flags;
> >
> > -	spin_lock_irqsave(&modlist_lock, flags);
> > +	mutex_lock(&module_mutex);
> >  	/* Core kernel markers */
> >  	found += marker_set_probe_range(name, format, probe,
> >  			__start___markers, __stop___markers);
> > @@ -431,7 +435,7 @@ int marker_set_probe(const char *name, const char *format,
> >  			found += marker_set_probe_range(name, format, probe,
> >  				mod->markers, mod->markers+mod->num_markers);
> >  	}
> > -	spin_unlock_irqrestore(&modlist_lock, flags);
> > +	mutex_unlock(&module_mutex);
> >  	return found;
> >  }
> >  EXPORT_SYMBOL(marker_set_probe);
> > @@ -440,9 +444,8 @@ int marker_remove_probe(marker_probe_func *probe)
> >  {
> >  	struct module *mod;
> >  	int found = 0;
> > -	unsigned long flags;
> >
> > -	spin_lock_irqsave(&modlist_lock, flags);
> > +	mutex_lock(&module_mutex);
> >  	/* Core kernel markers */
> >  	found += marker_remove_probe_range(probe,
> >  			__start___markers, __stop___markers);
> > @@ -452,7 +455,7 @@ int marker_remove_probe(marker_probe_func *probe)
> >  			found += marker_remove_probe_range(probe,
> >  				mod->markers, mod->markers+mod->num_markers);
> >  	}
> > -	spin_unlock_irqrestore(&modlist_lock, flags);
> > +	mutex_unlock(&module_mutex);
> >  	return found;
> >  }
> >  EXPORT_SYMBOL(marker_remove_probe);
> > @@ -461,9 +464,8 @@ int marker_list_probe(marker_probe_func *probe)
> >  {
> >  	struct module *mod;
> >  	int found = 0;
> > -	unsigned long flags;
> >
> > -	spin_lock_irqsave(&modlist_lock, flags);
> > +	mutex_lock(&module_mutex);
> >  	/* Core kernel markers */
> >  	printk("Listing kernel markers\n");
> >  	found += marker_list_probe_range(probe,
> > @@ -477,7 +479,7 @@ int marker_list_probe(marker_probe_func *probe)
> >  				mod->markers, mod->markers+mod->num_markers);
> >  		}
> >  	}
> > -	spin_unlock_irqrestore(&modlist_lock, flags);
> > +	mutex_unlock(&module_mutex);
> >  	return found;
> >  }
> >  EXPORT_SYMBOL(marker_list_probe);
> >
> > --
> > OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
> > Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
> > _______________________________________________
> > Ltt-dev mailing list
> > Ltt-dev@listserv.shafik.org
> > http://listserv.shafik.org/mailman/listinfo/ltt-dev
> >
> 
> --
> OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
> Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68

-- 
Prasanna S.P.
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-41776329
