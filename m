Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267624AbSLSM0a>; Thu, 19 Dec 2002 07:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267626AbSLSM0a>; Thu, 19 Dec 2002 07:26:30 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:163 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267624AbSLSM03>;
	Thu, 19 Dec 2002 07:26:29 -0500
Date: Thu, 19 Dec 2002 18:19:29 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (4/5) improved notifier callback mechanism - read copy update
Message-ID: <20021219181929.A5265@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <1040249652.14364.192.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1040249652.14364.192.camel@dell_ss3.pdx.osdl.net>; from shemminger@osdl.org on Wed, Dec 18, 2002 at 11:06:08PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Dec 18, 2002 at 11:06:08PM +0000, Stephen Hemminger wrote:
> The notifier interface was only partially locked. The
> notifier_call_chain needs to be called in places where it is impossible
> to safely without having deadlocks; for example, NMI watchdog timeout.
> 
> This patch uses read-copy-update to manage the list.  One extra bit of
> safety is using a reference count on the notifier_blocks to allow for
> cases like oprofile which need to sleep in a callback.
> 
<snip>
>   
>  int notifier_call_chain(struct list_head *list, unsigned long val, void
> *v)
>  {
> -	struct list_head *p;
> +	struct list_head *p, *nxtp;
>  	int ret = NOTIFY_DONE;
>  
> -	list_for_each(p, list) {
> +	rcu_read_lock();
> +	list_for_each_safe_rcu(p, nxtp, list) {
>  		struct notifier_block *nb =
>  			list_entry(p, struct notifier_block, link);
>  
> +		atomic_inc(&nb->inuse);
>  		ret = nb->notifier_call(nb,val,v);
> +		atomic_dec(&nb->inuse);
> +

There could be a small problem here. When rcu_read_lock() is called,
it bumps the preempt_count, so when the called handler attempts
to sleep, it will oops with "Bad: scheduling in atomic region".

-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
