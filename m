Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWB1LdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWB1LdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 06:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWB1LdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 06:33:06 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:6091 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932181AbWB1LdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 06:33:05 -0500
Date: Tue, 28 Feb 2006 17:04:31 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: "bibo,mao" <bibo.mao@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       hiramatu@sdl.hitachi.co.jp
Subject: Re: [PATCH]kprobe handler discard user space trap
Message-ID: <20060228113431.GG10512@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <4403FA60.6060701@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4403FA60.6060701@intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 03:23:12PM +0800, bibo,mao wrote:
> Currently kprobe handler traps only happen in kernel space, so function
> kprobe_exceptions_notify should skip traps which happen in user space.
> This patch modifies this, and it is based on 2.6.16-rc4.

You need to remove the code which calculates the
user space address in kprobe_handler() and also you need 
to remove the code that checks for VM86 in i386, since
your patch check if user/vm86 at the top level.

Thanks
Prasanna

> 
> Signed-off-by: bibo mao <bibo.mao@intel.com>
> 
> diff -Nruap a/arch/i386/kernel/kprobes.c b/arch/i386/kernel/kprobes.c
> --- a/arch/i386/kernel/kprobes.c    2006-02-25 17:08:52.000000000 +0800
> +++ b/arch/i386/kernel/kprobes.c    2006-03-01 10:37:50.000000000 +0800
> @@ -463,6 +463,9 @@ int __kprobes kprobe_exceptions_notify(s
>      struct die_args *args = (struct die_args *)data;
>      int ret = NOTIFY_DONE;
> 
> +    if (user_mode(args->regs))
> +        return ret;
> +
>      switch (val) {
>      case DIE_INT3:
>          if (kprobe_handler(args->regs))
> diff -Nruap a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
> --- a/arch/ia64/kernel/kprobes.c    2006-02-25 17:08:53.000000000 +0800
> +++ b/arch/ia64/kernel/kprobes.c    2006-03-01 10:39:15.000000000 +0800
> @@ -740,6 +740,9 @@ int __kprobes kprobe_exceptions_notify(s
>      struct die_args *args = (struct die_args *)data;
>      int ret = NOTIFY_DONE;
> 
> +    if (user_mode(args->regs))
> +        return ret;
> +
>      switch(val) {
>      case DIE_BREAK:
>          /* err is break number from ia64_bad_break() */
> diff -Nruap a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> --- a/arch/powerpc/kernel/kprobes.c    2006-02-25 17:08:52.000000000 +0800
> +++ b/arch/powerpc/kernel/kprobes.c    2006-03-01 10:39:53.000000000 +0800
> @@ -397,6 +397,9 @@ int __kprobes kprobe_exceptions_notify(s
>      struct die_args *args = (struct die_args *)data;
>      int ret = NOTIFY_DONE;
> 
> +    if (user_mode(args->regs))
> +        return ret;
> +
>      switch (val) {
>      case DIE_BPT:
>          if (kprobe_handler(args->regs))
> diff -Nruap a/arch/sparc64/kernel/kprobes.c b/arch/sparc64/kernel/kprobes.c
> --- a/arch/sparc64/kernel/kprobes.c    2006-02-25 17:08:52.000000000 +0800
> +++ b/arch/sparc64/kernel/kprobes.c    2006-03-01 10:40:16.000000000 +0800
> @@ -324,6 +324,9 @@ int __kprobes kprobe_exceptions_notify(s
>      struct die_args *args = (struct die_args *)data;
>      int ret = NOTIFY_DONE;
> 
> +    if (user_mode(args->regs))
> +        return ret;
> +
>      switch (val) {
>      case DIE_DEBUG:
>          if (kprobe_handler(args->regs))
> diff -Nruap a/arch/x86_64/kernel/kprobes.c b/arch/x86_64/kernel/kprobes.c
> --- a/arch/x86_64/kernel/kprobes.c    2006-02-25 17:08:52.000000000 +0800
> +++ b/arch/x86_64/kernel/kprobes.c    2006-03-01 10:38:48.000000000 +0800
> @@ -601,6 +601,9 @@ int __kprobes kprobe_exceptions_notify(s
>      struct die_args *args = (struct die_args *)data;
>      int ret = NOTIFY_DONE;
> 
> +    if (user_mode(args->regs))
> +        return ret;
> +
>      switch (val) {
>      case DIE_INT3:
>          if (kprobe_handler(args->regs))

-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
