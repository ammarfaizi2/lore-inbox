Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbWIZGyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWIZGyW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 02:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbWIZGyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 02:54:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:46563 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751677AbWIZGyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 02:54:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Mu9donWjUjA7TtODcoM1bYS2dA7zhwWo2jQC5b4TYd0AvTgUx0m5KqaIJDYHPA6R1V2paoeEVIngU/skiIvDVRATT56kT2V13JGNChpgV654KNyDMu9eYtTbM69SDYH42H029GdHRa6r+KdBPeBxBv0Ts8tUxy75YbzUI2Knfcw=
Message-ID: <4518CE9A.7020401@gmail.com>
Date: Tue, 26 Sep 2006 08:54:18 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: "bibo,mao" <bibo.mao@intel.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
Subject: Re: [PATCH 3/3] kretprobe spinlock deadlock patch
References: <4518B46E.3050206@intel.com>
In-Reply-To: <4518B46E.3050206@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bibo,mao wrote:
> Hi,
> Function kprobe_flush_task possibly calls kfree function during holding 
> kretprobe_lock spinlock, if kfree function is probed by kretprobe that 
> will incur spinlock deadlock. This patch moves kfree function out scope 
> of kretprobe_lock.
> 
> Signed-off-by: bibo, mao <bibo.mao@intel.com>
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> thanks
> bibo,mao
> 
> arch/i386/kernel/kprobes.c    |    9 +++++++--
> arch/ia64/kernel/kprobes.c    |    9 +++++++--
> arch/powerpc/kernel/kprobes.c |    9 +++++++--
> arch/s390/kernel/kprobes.c    |    9 +++++++--
> arch/x86_64/kernel/kprobes.c  |    9 +++++++--
> include/linux/kprobes.h       |    2 +-
> kernel/kprobes.c              |   15 +++++++++++----
> 7 files changed, 47 insertions(+), 15 deletions(-)
> diff -Nruap 2.6.18-mm1.org/arch/i386/kernel/kprobes.c 
> 2.6.18-mm1/arch/i386/kernel/kprobes.c
> --- 2.6.18-mm1.org/arch/i386/kernel/kprobes.c    2006-09-26 
> 10:49:26.000000000 +0800
> +++ 2.6.18-mm1/arch/i386/kernel/kprobes.c    2006-09-26 
> 10:53:16.000000000 +0800
> @@ -396,11 +396,12 @@ no_kprobe:
> fastcall void *__kprobes trampoline_handler(struct pt_regs *regs)
> {
>     struct kretprobe_instance *ri = NULL;
> -    struct hlist_head *head;
> +    struct hlist_head *head, empty_rp;
>     struct hlist_node *node, *tmp;
>     unsigned long flags, orig_ret_address = 0;
>     unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;
> 
> +    INIT_HLIST_HEAD(&empty_rp);
>     spin_lock_irqsave(&kretprobe_lock, flags);
>     head = kretprobe_inst_table_head(current);
> 
> @@ -429,7 +430,7 @@ fastcall void *__kprobes trampoline_hand
>         }
> 
>         orig_ret_address = (unsigned long)ri->ret_addr;
> -        recycle_rp_inst(ri);
> +        recycle_rp_inst(ri, &empty_rp);
> 
>         if (orig_ret_address != trampoline_address)
>             /*
> @@ -444,6 +445,10 @@ fastcall void *__kprobes trampoline_hand
> 
>     spin_unlock_irqrestore(&kretprobe_lock, flags);
> 
> +    hlist_for_each_entry_safe(ri, node, tmp, &empty_rp, hlist) {
> +        hlist_del(&ri->hlist);
> +        kfree(ri);
> +    }
>     return (void*)orig_ret_address;
> }
> 
> diff -Nruap 2.6.18-mm1.org/arch/ia64/kernel/kprobes.c 
> 2.6.18-mm1/arch/ia64/kernel/kprobes.c
> --- 2.6.18-mm1.org/arch/ia64/kernel/kprobes.c    2006-09-26 
> 10:49:26.000000000 +0800
> +++ 2.6.18-mm1/arch/ia64/kernel/kprobes.c    2006-09-26 
> 10:53:16.000000000 +0800
> @@ -340,12 +340,13 @@ static void kretprobe_trampoline(void)
> int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs 
> *regs)
> {
>     struct kretprobe_instance *ri = NULL;
> -    struct hlist_head *head;
> +    struct hlist_head *head, empty_rp;
>     struct hlist_node *node, *tmp;
>     unsigned long flags, orig_ret_address = 0;
>     unsigned long trampoline_address =
>         ((struct fnptr *)kretprobe_trampoline)->ip;
> 
> +    INIT_HLIST_HEAD(&empty_rp);
>     spin_lock_irqsave(&kretprobe_lock, flags);
>     head = kretprobe_inst_table_head(current);
> 
> @@ -371,7 +372,7 @@ int __kprobes trampoline_probe_handler(s
>             ri->rp->handler(ri, regs);
> 
>         orig_ret_address = (unsigned long)ri->ret_addr;
> -        recycle_rp_inst(ri);
> +        recycle_rp_inst(ri, &empty_rp);
> 
>         if (orig_ret_address != trampoline_address)
>             /*
> @@ -389,6 +390,10 @@ int __kprobes trampoline_probe_handler(s
>     spin_unlock_irqrestore(&kretprobe_lock, flags);
>     preempt_enable_no_resched();
> 
> +    hlist_for_each_entry_safe(ri, node, tmp, &empty_rp, hlist) {
> +        hlist_del(&ri->hlist);
> +        kfree(ri);
> +    }
>     /*
>      * By returning a non-zero value, we are telling
>      * kprobe_handler() that we don't want the post_handler
> diff -Nruap 2.6.18-mm1.org/arch/powerpc/kernel/kprobes.c 
> 2.6.18-mm1/arch/powerpc/kernel/kprobes.c
> --- 2.6.18-mm1.org/arch/powerpc/kernel/kprobes.c    2006-09-26 
> 10:49:26.000000000 +0800
> +++ 2.6.18-mm1/arch/powerpc/kernel/kprobes.c    2006-09-26 
> 10:53:16.000000000 +0800
> @@ -260,11 +260,12 @@ void kretprobe_trampoline_holder(void)
> int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs 
> *regs)
> {
>     struct kretprobe_instance *ri = NULL;
> -    struct hlist_head *head;
> +    struct hlist_head *head, empty_rp;
>     struct hlist_node *node, *tmp;
>     unsigned long flags, orig_ret_address = 0;
>     unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;
> 
> +    INIT_HLIST_HEAD(&empty_rp);
>     spin_lock_irqsave(&kretprobe_lock, flags);
>     head = kretprobe_inst_table_head(current);
> 
> @@ -290,7 +291,7 @@ int __kprobes trampoline_probe_handler(s
>             ri->rp->handler(ri, regs);
> 
>         orig_ret_address = (unsigned long)ri->ret_addr;
> -        recycle_rp_inst(ri);
> +        recycle_rp_inst(ri, &empty_rp);
> 
>         if (orig_ret_address != trampoline_address)
>             /*
> @@ -308,6 +309,10 @@ int __kprobes trampoline_probe_handler(s
>     spin_unlock_irqrestore(&kretprobe_lock, flags);
>     preempt_enable_no_resched();
> 
> +    hlist_for_each_entry_safe(ri, node, tmp, &empty_rp, hlist) {
> +        hlist_del(&ri->hlist);
> +        kfree(ri);
> +    }
>     /*
>      * By returning a non-zero value, we are telling
>      * kprobe_handler() that we don't want the post_handler
> diff -Nruap 2.6.18-mm1.org/arch/s390/kernel/kprobes.c 
> 2.6.18-mm1/arch/s390/kernel/kprobes.c
> --- 2.6.18-mm1.org/arch/s390/kernel/kprobes.c    2006-09-25 
> 16:11:56.000000000 +0800
> +++ 2.6.18-mm1/arch/s390/kernel/kprobes.c    2006-09-26 
> 10:53:16.000000000 +0800
> @@ -368,11 +368,12 @@ void __kprobes kretprobe_trampoline_hold
> int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs 
> *regs)
> {
>     struct kretprobe_instance *ri = NULL;
> -    struct hlist_head *head;
> +    struct hlist_head *head, empty_rp;
>     struct hlist_node *node, *tmp;
>     unsigned long flags, orig_ret_address = 0;
>     unsigned long trampoline_address = (unsigned 
> long)&kretprobe_trampoline;
> 
> +    INIT_HLIST_HEAD(&empty_rp);
>     spin_lock_irqsave(&kretprobe_lock, flags);
>     head = kretprobe_inst_table_head(current);
> 
> @@ -398,7 +399,7 @@ int __kprobes trampoline_probe_handler(s
>             ri->rp->handler(ri, regs);
> 
>         orig_ret_address = (unsigned long)ri->ret_addr;
> -        recycle_rp_inst(ri);
> +        recycle_rp_inst(ri, &empty_rp);
> 
>         if (orig_ret_address != trampoline_address) {
>             /*
> @@ -416,6 +417,10 @@ int __kprobes trampoline_probe_handler(s
>     spin_unlock_irqrestore(&kretprobe_lock, flags);
>     preempt_enable_no_resched();
> 
> +    hlist_for_each_entry_safe(ri, node, tmp, &empty_rp, hlist) {
> +        hlist_del(&ri->hlist);
> +        kfree(ri);
> +    }
>     /*
>      * By returning a non-zero value, we are telling
>      * kprobe_handler() that we don't want the post_handler
> diff -Nruap 2.6.18-mm1.org/arch/x86_64/kernel/kprobes.c 
> 2.6.18-mm1/arch/x86_64/kernel/kprobes.c
> --- 2.6.18-mm1.org/arch/x86_64/kernel/kprobes.c    2006-09-26 
> 10:49:26.000000000 +0800
> +++ 2.6.18-mm1/arch/x86_64/kernel/kprobes.c    2006-09-26 
> 10:53:16.000000000 +0800
> @@ -405,11 +405,12 @@ no_kprobe:
> int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs 
> *regs)
> {
>     struct kretprobe_instance *ri = NULL;
> -    struct hlist_head *head;
> +    struct hlist_head *head, empty_rp;
>     struct hlist_node *node, *tmp;
>     unsigned long flags, orig_ret_address = 0;
>     unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;
> 
> +    INIT_HLIST_HEAD(&empty_rp);
>     spin_lock_irqsave(&kretprobe_lock, flags);
>     head = kretprobe_inst_table_head(current);
> 
> @@ -435,7 +436,7 @@ int __kprobes trampoline_probe_handler(s
>             ri->rp->handler(ri, regs);
> 
>         orig_ret_address = (unsigned long)ri->ret_addr;
> -        recycle_rp_inst(ri);
> +        recycle_rp_inst(ri, &empty_rp);
> 
>         if (orig_ret_address != trampoline_address)
>             /*
> @@ -453,6 +454,10 @@ int __kprobes trampoline_probe_handler(s
>     spin_unlock_irqrestore(&kretprobe_lock, flags);
>     preempt_enable_no_resched();
> 
> +    hlist_for_each_entry_safe(ri, node, tmp, &empty_rp, hlist) {
> +        hlist_del(&ri->hlist);
> +        kfree(ri);
> +    }
>     /*
>      * By returning a non-zero value, we are telling
>      * kprobe_handler() that we don't want the post_handler
> diff -Nruap 2.6.18-mm1.org/include/linux/kprobes.h 
> 2.6.18-mm1/include/linux/kprobes.h
> --- 2.6.18-mm1.org/include/linux/kprobes.h    2006-09-25 
> 16:12:04.000000000 +0800
> +++ 2.6.18-mm1/include/linux/kprobes.h    2006-09-26 10:53:16.000000000 
> +0800
> @@ -202,7 +202,7 @@ void unregister_kretprobe(struct kretpro
> struct kretprobe_instance *get_free_rp_inst(struct kretprobe *rp);
> void add_rp_inst(struct kretprobe_instance *ri);
> void kprobe_flush_task(struct task_struct *tk);
> -void recycle_rp_inst(struct kretprobe_instance *ri);
> +void recycle_rp_inst(struct kretprobe_instance *ri, struct hlist_head 
> *head);
> #else /* CONFIG_KPROBES */
> 
> #define __kprobes    /**/
> diff -Nruap 2.6.18-mm1.org/kernel/kprobes.c 2.6.18-mm1/kernel/kprobes.c
> --- 2.6.18-mm1.org/kernel/kprobes.c    2006-09-26 10:49:26.000000000 +0800
> +++ 2.6.18-mm1/kernel/kprobes.c    2006-09-26 10:53:16.000000000 +0800
> @@ -319,7 +319,8 @@ void __kprobes add_rp_inst(struct kretpr
> }
> 
> /* Called with kretprobe_lock held */
> -void __kprobes recycle_rp_inst(struct kretprobe_instance *ri)
> +void __kprobes recycle_rp_inst(struct kretprobe_instance *ri,
> +                struct hlist_head *head)
> {
>     /* remove rp inst off the rprobe_inst_table */
>     hlist_del(&ri->hlist);
> @@ -331,7 +332,7 @@ void __kprobes recycle_rp_inst(struct kr
>         hlist_add_head(&ri->uflist, &ri->rp->free_instances);
>     } else
>         /* Unregistering */
> -        kfree(ri);
> +        hlist_add_head(&ri->hlist, head);
> }
> 
> struct hlist_head __kprobes *kretprobe_inst_table_head(struct 
> task_struct *tsk)
> @@ -348,17 +349,23 @@ struct hlist_head __kprobes *kretprobe_i
> void __kprobes kprobe_flush_task(struct task_struct *tk)
> {
>     struct kretprobe_instance *ri;
> -    struct hlist_head *head;
> +    struct hlist_head *head, empty_rp;
>     struct hlist_node *node, *tmp;
>     unsigned long flags = 0;
> 
> +    INIT_HLIST_HEAD(&empty_rp);

HLIST_HEAD(empty_rp); instead of that 2 changes?

>     spin_lock_irqsave(&kretprobe_lock, flags);
>     head = kretprobe_inst_table_head(tk);
>     hlist_for_each_entry_safe(ri, node, tmp, head, hlist) {
>         if (ri->task == tk)
> -            recycle_rp_inst(ri);
> +            recycle_rp_inst(ri, &empty_rp);
>     }
>     spin_unlock_irqrestore(&kretprobe_lock, flags);
> +
> +    hlist_for_each_entry_safe(ri, node, tmp, &empty_rp, hlist) {
> +        hlist_del(&ri->hlist);
> +        kfree(ri);
> +    }
> }
> 
> static inline void free_rp_inst(struct kretprobe *rp)

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
