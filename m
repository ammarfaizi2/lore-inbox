Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbWHDXDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbWHDXDj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 19:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422643AbWHDXDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 19:03:39 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:47271 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1422636AbWHDXDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 19:03:39 -0400
Date: Fri, 4 Aug 2006 19:00:33 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] module interface improvement for kprobes
To: David Smith <dsmith@redhat.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       "David S. Miller" <davem@davemloft.net>
Message-ID: <200608041902_MC3-1-C71C-6FC9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1154721061.15967.31.camel@dhcp-2.hsv.redhat.com>

On Fri, 04 Aug 2006 14:51:01 -0500, David Smith wrote:

> > > I've added a new function, module_get_byname(), that looks up a module
> > > by name and returns the module reference.  Note that module_get_byname()
> > > also increments the module reference count.  It does this so that the
> > > module won't be unloaded between the time that module_get_byname() is
> > > called and register_kprobe() is called.

Your patch is word-wrapped.

Also:

> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -291,7 +291,27 @@ static struct module *find_module(const 
>       }
>       return NULL;
>  }
> +  
> +int module_get_byname(const char *mod_name, struct module **mod)
> +{
> +     *mod = NULL;
>  
> +     /* We must hold module_mutex before calling find_module(). */
> +     if (mutex_lock_interruptible(&module_mutex) != 0)
> +             return -EINTR;
> +
> +     *mod = find_module(mod_name);
> +     mutex_unlock(&module_mutex);
> +     if (*mod) {
> +             if (!strong_try_module_get(*mod)) {

What keeps the module from going away between the mutex_unlock() and
strong_try_module_get()? It needs to be something like this:

        *mod = find_module(mod_name);
        if (*mod)
                ret = strong_try_module_get(*mod);
        mutex_unlock(&module_mutex);
        if (!ret) {
                *mod = NULL;
                return -EINVAL;
        }

> +                     *mod = NULL;
> +                     return -EINVAL;
> +             }
> +     }
> +     return 0;
> +}
> +EXPORT_SYMBOL_GPL(module_get_byname);
> + 
>  #ifdef CONFIG_SMP
>  /* Number of blocks used and allocated. */
>  static unsigned int pcpu_num_used, pcpu_num_allocated;

-- 
Chuck

