Return-Path: <linux-kernel-owner+w=401wt.eu-S1754939AbXABTwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939AbXABTwF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 14:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755281AbXABTwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 14:52:04 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:40776 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755336AbXABTwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 14:52:03 -0500
Subject: Re: [BUG 2.6.20-rc2-mm1] init segfaults when
	CONFIG_PROFILE_LIKELY=y
From: john stultz <johnstul@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: Fengguang Wu <fengguang.wu@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       mingo@elte.hu
In-Reply-To: <1167594309.14081.79.camel@imap.mvista.com>
References: <20061231150422.GA5285@mail.ustc.edu.cn>
	 <1167594309.14081.79.camel@imap.mvista.com>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 11:47:57 -0800
Message-Id: <1167767277.3141.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-31 at 11:45 -0800, Daniel Walker wrote:
> On Sun, 2006-12-31 at 23:04 +0800, Fengguang Wu wrote:
> > Hi,
> >
> > The following messages keeps popping up when CONFIG_PROFILE_LIKELY=y:
> >
> > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> >
> 
> 
> Does this seem like an appropriate solution? This just reconstitutes
> Ingo's patch by removing the unlikely calls that got added recently.
> 
> Maybe a comment into vsyscall.c that says to stay away from all macro's
> and possible debug code that could be added might be helpful ?
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Yep, good catch Daniel!

Acked-by: John Stultz <johnstul@us.ibm.com>

> ---
>  arch/x86_64/kernel/vsyscall.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.19/arch/x86_64/kernel/vsyscall.c
> ===================================================================
> --- linux-2.6.19.orig/arch/x86_64/kernel/vsyscall.c
> +++ linux-2.6.19/arch/x86_64/kernel/vsyscall.c
> @@ -111,7 +111,7 @@ static __always_inline void do_vgettimeo
>  		seq = read_seqbegin(&__vsyscall_gtod_data.lock);
> 
>  		vread = __vsyscall_gtod_data.clock.vread;
> -		if (unlikely(!__vsyscall_gtod_data.sysctl_enabled || !vread)) {
> +		if (!__vsyscall_gtod_data.sysctl_enabled || !vread) {
>  			gettimeofday(tv,0);
>  			return;
>  		}
> @@ -151,7 +151,7 @@ int __vsyscall(0) vgettimeofday(struct t
>   * unlikely */
>  time_t __vsyscall(1) vtime(time_t *t)
>  {
> -	if (unlikely(!__vsyscall_gtod_data.sysctl_enabled))
> +	if (!__vsyscall_gtod_data.sysctl_enabled)
>  		return time_syscall(t);
>  	else if (t)
>  		*t = __vsyscall_gtod_data.wall_time_tv.tv_sec;
> 
> 

