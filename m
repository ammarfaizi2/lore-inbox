Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWBTQOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWBTQOF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWBTQOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:14:05 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:743 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030301AbWBTQOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:14:03 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Mishin Dmitry <dim@openvz.org>
Subject: Re: [PATCH 1/2] iptables 32bit compat layer
Date: Mon, 20 Feb 2006 16:55:26 +0100
User-Agent: KMail/1.9.1
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, rusty@rustcorp.com.au,
       akpm@osdl.org, devel@openvz.org
References: <200602201110.39092.dim@openvz.org>
In-Reply-To: <200602201110.39092.dim@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200602201655.27093.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 09:10, Mishin Dmitry wrote:
> --- ./include/linux/netfilter/x_tables.h.iptcompat      2006-02-15 16:16:02.000000000 +0300
> +++ ./include/linux/netfilter/x_tables.h        2006-02-15 18:53:09.000000000 +0300
>  struct xt_match
>  {
>         struct list_head list;
> @@ -118,6 +125,10 @@ struct xt_match
>         /* Called when entry of this type deleted. */
>         void (*destroy)(void *matchinfo, unsigned int matchinfosize);
>  
> +#ifdef CONFIG_COMPAT
> +       /* Called when userspace align differs from kernel space one */
> +       int (*compat)(void *match, void **dstptr, int *size, int convert);
> +#endif
>         /* Set this to THIS_MODULE if you are a module, otherwise NULL */
>         struct module *me;
>  };

Is CONFIG_COMPAT the right conditional here? If the code is only used
for architectures that have different aligments, it should not need be
compiled in for the other architectures.

> @@ -154,6 +165,10 @@ struct xt_target
>         /* Called when entry of this type deleted. */
>         void (*destroy)(void *targinfo, unsigned int targinfosize);
>  
> +#ifdef CONFIG_COMPAT
> +       /* Called when userspace align differs from kernel space one */
> +       int (*compat)(void *target, void **dstptr, int *size, int convert);
> +#endif
>         /* Set this to THIS_MODULE if you are a module, otherwise NULL */
>         struct module *me;
>  };
> @@ -233,6 +248,34 @@ extern void xt_proto_fini(int af);
>  extern struct xt_table_info *xt_alloc_table_info(unsigned int size);
>  extern void xt_free_table_info(struct xt_table_info *info);
>  
> +#ifdef CONFIG_COMPAT
> +#include <net/compat.h>
> +
> +/* FIXME: this works only on 32 bit tasks
> + * need to change whole approach in order to calculate align as function of
> + * current task alignment */
> +
> +struct compat_xt_counters
> +{
> +       u_int32_t cnt[4];
> +};

Hmm, maybe we should have something like

typedef u64 __attribute__((aligned(4))) compat_u64;

in order to get the right alignment on the architectures
where it makes a difference. Do all compiler versions
get that right?

> --- ./include/linux/netfilter_ipv4/ip_tables.h.iptcompat        2006-02-15 16:06:41.000000000 +0300
> +++ ./include/linux/netfilter_ipv4/ip_tables.h  2006-02-15 16:37:12.000000000 +0300
> @@ -364,5 +365,62 @@ extern unsigned int ipt_do_table(struct 
>                                  void *userdata);
>  
>  #define IPT_ALIGN(s) XT_ALIGN(s)
> +
> +#ifdef CONFIG_COMPAT
> +#include <net/compat.h>
> +
> +struct compat_ipt_getinfo
> +{
> +       char name[IPT_TABLE_MAXNAMELEN];
> +       compat_uint_t valid_hooks;
> +       compat_uint_t hook_entry[NF_IP_NUMHOOKS];
> +       compat_uint_t underflow[NF_IP_NUMHOOKS];
> +       compat_uint_t num_entries;
> +       compat_uint_t size;
> +};

This structure looks like it does not need any
conversions. You should probably just use 
struct ipt_getinfo then.

> +
> +struct compat_ipt_entry_match
> +{
> +       union {
> +               struct {
> +                       u_int16_t match_size;
> +                       char name[IPT_FUNCTION_MAXNAMELEN];
> +               } user;
> +               u_int16_t match_size;
> +       } u;
> +       unsigned char data[0];
> +};
> +
> +struct compat_ipt_entry_target
> +{
> +       union {
> +               struct {
> +                       u_int16_t target_size;
> +                       char name[IPT_FUNCTION_MAXNAMELEN];
> +               } user;
> +               u_int16_t target_size;
> +       } u;
> +       unsigned char data[0];
> +};

Dito

> +#define COMPAT_IPT_ALIGN(s)    COMPAT_XT_ALIGN(s)
> +
> +extern int ipt_match_align_compat(void *match, void **dstptr,
> +               int *size, int off, int convert);
> +extern int ipt_target_align_compat(void *target, void **dstptr,
> +               int *size, int off, int convert);
> +
> +#endif /* CONFIG_COMPAT */
>  #endif /*__KERNEL__*/
>  #endif /* _IPTABLES_H */
> --- ./include/net/compat.h.iptcompat    2006-01-03 06:21:10.000000000 +0300
> +++ ./include/net/compat.h      2006-02-15 18:45:49.000000000 +0300
> @@ -23,6 +23,14 @@ struct compat_cmsghdr {
>         compat_int_t    cmsg_type;
>  };
>  
> +#if defined(CONFIG_X86_64)
> +#define is_current_32bits() (current_thread_info()->flags & _TIF_IA32)
> +#elif defined(CONFIG_IA64)
> +#define is_current_32bits() (IS_IA32_PROCESS(ia64_task_regs(current)))
> +#else
> +#define is_current_32bits()    0
> +#endif
> +

This definition looks very wrong to me. For x86_64, the right thing to check
should be TS_COMPAT, no _TIF_IA32, since you can also call the 64 bit
syscall entry point from a i386 task running on x86_64. For most other
architectures, is_current_32bits returns something that is not reflected
in the name. I would e.g. expect the function to return '1' on i386 and
the correct task state on other compat platforms, instead of a bogus '0'.

There have been long discussions about the inclusions of the 'is_compat_task'
macro. Let's at least not define a second function that does almost the
same but gets it wrong.

I would much rather have either an extra 'compat' argument to to
sock_setsockopt and proto_ops->setsockopt than to spread the use
of is_compat_task further.

>  #else /* defined(CONFIG_COMPAT) */
>  #define compat_msghdr  msghdr          /* to avoid compiler warnings */
>  #endif /* defined(CONFIG_COMPAT) */
> --- ./net/compat.c.iptcompat    2006-01-03 06:21:10.000000000 +0300
> +++ ./net/compat.c      2006-02-15 16:38:45.000000000 +0300
> @@ -308,107 +308,6 @@ void scm_detach_fds_compat(struct msghdr
>  }
>  
>  /*
> - * For now, we assume that the compatibility and native version
> - * of struct ipt_entry are the same - sfr.  FIXME
> - */
> -struct compat_ipt_replace {
> -       char                    name[IPT_TABLE_MAXNAMELEN];
> -       u32                     valid_hooks;
> -       u32                     num_entries;
> -       u32                     size;
> -       u32                     hook_entry[NF_IP_NUMHOOKS];
> -       u32                     underflow[NF_IP_NUMHOOKS];
> -       u32                     num_counters;
> -       compat_uptr_t           counters;       /* struct ipt_counters * */
> -       struct ipt_entry        entries[0];
> -};

Is the FIXME above the only reason that the code needs to be changed?
What is the reason that you did not just address this in the 
compat_sys_setsockopt implementation?

	Arnd <><
