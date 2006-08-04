Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161270AbWHDP5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161270AbWHDP5m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 11:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161265AbWHDP5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 11:57:42 -0400
Received: from xenotime.net ([66.160.160.81]:20101 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161272AbWHDP5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 11:57:37 -0400
Date: Fri, 4 Aug 2006 09:00:18 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: David Smith <dsmith@redhat.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, prasanna@in.ibm.com,
       ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net
Subject: Re: [PATCH] module interface improvement for kprobes
Message-Id: <20060804090018.0bd4020d.rdunlap@xenotime.net>
In-Reply-To: <1154704652.15967.7.camel@dhcp-2.hsv.redhat.com>
References: <1154704652.15967.7.camel@dhcp-2.hsv.redhat.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Aug 2006 10:17:32 -0500 David Smith wrote:

> When inserting a kprobes probe into a loadable module, there isn't a way
> for the kprobes module to get a module reference (in order to find the
> base address of the module among perhaps other things).
> 
> A kprobes probe needs the base address of the module in order to
> "relocate" the addresses of probe points (since the load address of the
> module can change from run to run of the kprobe).
> 
> I've added a new function, module_get_byname(), that looks up a module
> by name and returns the module reference.  Note that module_get_byname()
> also increments the module reference count.  It does this so that the
> module won't be unloaded between the time that module_get_byname() is
> called and register_kprobe() is called.
> 
> Here's an example of how it would be used from a kprobe:
> 
> ====
> static struct module *mod = NULL;
> 
> int init_module(void)
> {
> 	/* grab the module, making sure it won't get unloaded until
> 	 * we're done */
> 	const char *mod_name = "joydev";
> 	if (module_get_byname(mod_name, &mod) != 0)
> 		return 1;
> 
> 	/* Specify the address/offset where you want to insert
> 	 * probe.  If this were a real kprobe module, we'd "relocate"
> 	 * our probe address based on the load address of the module
> 	 * we're interested in. */
> 	kp.addr = (kprobe_opcode_t *) mod->module_core + 0;
> 
> 	/* All set to register with Kprobes */
>         register_kprobe(&kp);
> 	return 0;
> }
> 
> void cleanup_module(void)
> {
> 	if (kp.addr != NULL)
> 		unregister_kprobe(&kp);
> 
> 	/* allow the module to get unloaded, if needed */
> 	if (mod != NULL)
> 		module_put(mod);
> }
> ====
> 
> I've included a patch that implements the new function. 
> 
> Signed-off-by: David Smith <dsmith@redhat.com>
> ---
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 0dfb794..7464e29 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -374,6 +374,8 @@ extern void __module_put_and_exit(struct
>  	__attribute__((noreturn));
>  #define module_put_and_exit(code) __module_put_and_exit(THIS_MODULE,
> code);
>  
> +long module_get_byname(const char *mod_name, struct module **mod);

Why long instead of int?

> +
>  #ifdef CONFIG_MODULE_UNLOAD
>  unsigned int module_refcount(struct module *mod);
>  void __symbol_put(const char *symbol);
> @@ -549,6 +551,11 @@ static inline int is_exported(const char
>  	return 0;
>  }
>  
> +static inline long module_get_byname(const char *mod_name, struct
> module **mod)
> +{
> +	return 1;
> +}
> +
>  static inline int register_module_notifier(struct notifier_block * nb)
>  {
>  	/* no events will happen anyway, so this can always succeed */
> diff --git a/kernel/module.c b/kernel/module.c
> index 2a19cd4..30449ce 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -291,7 +291,27 @@ static struct module *find_module(const 
>  	}
>  	return NULL;
>  }
> +  
> +long module_get_byname(const char *mod_name, struct module **mod)
> +{
> +	*mod = NULL;
>  
> +	/* We must hold module_mutex before calling find_module(). */
> +	if (mutex_lock_interruptible(&module_mutex) != 0)
> +		return -EINTR;
> +
> +	*mod = find_module(mod_name);
> +	mutex_unlock(&module_mutex);
> +	if (*mod) {
> +		if (! strong_try_module_get(*mod)) {

no space following the '!'.

> +			*mod = NULL;
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(module_get_byname);
> + 
>  #ifdef CONFIG_SMP
>  /* Number of blocks used and allocated. */
>  static unsigned int pcpu_num_used, pcpu_num_allocated;


---
~Randy
