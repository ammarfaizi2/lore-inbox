Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263014AbSJBNRf>; Wed, 2 Oct 2002 09:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263025AbSJBNRf>; Wed, 2 Oct 2002 09:17:35 -0400
Received: from crack.them.org ([65.125.64.184]:17159 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S263014AbSJBNRe>;
	Wed, 2 Oct 2002 09:17:34 -0400
Date: Wed, 2 Oct 2002 09:23:31 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Capabilities-related change in 2.5.40
Message-ID: <20021002132331.GA17376@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021001164907.GA25307@nevyn.them.org> <20021001134552.A26557@figure1.int.wirex.com> <20021001211210.GA8784@nevyn.them.org> <20021002003817.B26557@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021002003817.B26557@figure1.int.wirex.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 12:38:17AM -0700, Chris Wright wrote:
> * Daniel Jacobowitz (dan@debian.org) wrote:
> > 
> > Yes.  It was pointed out to me that libcap2 snapshots behave correctly.
> 
> Ah, thanks for the info.  Hmm, libcap2 still looks like it sets up the
> header with pid == 0.  Maybe I'm missing something.

Look at cap_proc.c:_libcap_cappid :

#if (_LINUX_CAPABILITY_VERSION == 0x19980330)

    if (_libcap_kernel_version == 0x19980330) {
        cap_d->head.pid = pid;
    }
    _cap_debug("pid: %d\n", cap_d->head.pid);

> 
> > Not init: swapper.
> 
> Yes, although INIT_TASK sets up the task_struct for swapper.

Oh, right.

> > Try it on 2.4:
> > drow@nevyn:~% getpcaps 0
> > Capabilities for `0': =
> > 
> > 2.5.40 gives me a very different answer :)
> 
> Heh, you're right.  However, 2.5.20 behaves the same as 2.4.  Looking
> back this appears to be caused by 2.5.21 locking cleanups done by rml.
> The older code interpreted pid == 0 to mean current, whereas the new
> code unconditionally does find_task_by_pid(0).  This patch fixes that,
> and then pid == 0 from libcap should work again.

How very odd.  I have been running 2.5 on that machine for a while, and
the bug only showed up somewhere between 2.5.36 and 2.5.40.  Maybe a
coincidence triggered by the PID hashing... your tabbing is a little
odd but the patch looks right to me.  Thanks!

> 
> --- 1.5/kernel/capability.c	Sun Sep 15 12:19:29 2002
> +++ edited/kernel/capability.c	Wed Oct  2 00:28:32 2002
> @@ -33,7 +33,7 @@
>       int ret = 0;
>       pid_t pid;
>       __u32 version;
> -     task_t *target;
> +     task_t *target = current;
>       struct __user_cap_data_struct data;
>  
>       if (get_user(version, &header->version))
> @@ -52,21 +52,20 @@
>               return -EINVAL;
>  
>       spin_lock(&task_capability_lock);
> -     read_lock(&tasklist_lock); 
>  
> -     target = find_task_by_pid(pid);
> -     if (!target) {
> -          ret = -ESRCH;
> -          goto out;
> +     if (pid && pid != current->pid) {
> +     	read_lock(&tasklist_lock); 
> +     	target = find_task_by_pid(pid);
> +     	read_unlock(&tasklist_lock); 
> +     	if (!target) {
> +          	ret = -ESRCH;
> +          	goto out;
> +	}
>       }
>  
> -     data.permitted = cap_t(target->cap_permitted);
> -     data.inheritable = cap_t(target->cap_inheritable); 
> -     data.effective = cap_t(target->cap_effective);
>       ret = security_ops->capget(target, &data.effective, &data.inheritable, &data.permitted);
>  
>  out:
> -     read_unlock(&tasklist_lock); 
>       spin_unlock(&task_capability_lock);
>  
>       if (!ret && copy_to_user(dataptr, &data, sizeof data))
> 
> thanks,
> -chris
> -- 
> Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
