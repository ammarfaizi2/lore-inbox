Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWJRJUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWJRJUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 05:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWJRJUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 05:20:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:33098 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932161AbWJRJUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 05:20:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=hkYaYXjpXGD3Rv8vM1f957PpSpGu4AxkWE9mwUpYYojIaq6eg8erXcMomfvlOku5Gn4BFrdJjg+ACRxzG//A1TQz4/cMLx7S+NT8VkP8OQWrt0vnsjurbDwBQ2t293nfNOUmioJdWmPqw3/4pc5yYyg0CFKC85kc/YGng4eXTYw=
Date: Wed, 18 Oct 2006 13:19:44 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
Message-ID: <20061018091944.GA5343@martell.zuzino.mipt.ru>
References: <20061017005025.GF29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018044054.GH29920@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> module.h is trickier.  First of all, we want extern for wake_up_process().

When I came up with this to l-k, Nick and Christoph told me that duplicate
proto sucks. So module.h/sched.h is
a) uninline module_put()
b) remove #include <linux/sched.h>

> And unlike the first severed include, we *do* have files that need something
> from sched.h and rely on pulling it implicitly via module.h.  Fortunately,
> there are few of those.  For amd64 allmodconfig we only need to touch includes
> in
>  arch/i386/kernel/cpu/mcheck/therm_throt.c
>  drivers/hwmon/abituguru.c
>  drivers/leds/ledtrig-ide-disk.c
>  drivers/leds/ledtrig-timer.c
>  drivers/scsi/scsi_transport_sas.c
>  drivers/w1/slaves/w1_therm.c
>  include/linux/phy.h
>  kernel/latency.c
> and in almost all cases we are actually missing jiffies.h, not sched.h.
> However, at that point we really need to look at other targets; they
> do add several extra places, but again not much.  Below is what I've got
> from my usual mix of cross-builds; for resulting dependeny counts (again,
> amd64 allmodconfig) see ftp://ftp.linux.org.uk/pub/people/viro/counts-after.

> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -6,7 +6,6 @@ #define _LINUX_MODULE_H
>   * Rewritten by Richard Henderson <rth@tamu.edu> Dec 1996
>   * Rewritten again by Rusty Russell, 2002
>   */
> -#include <linux/sched.h>
>  #include <linux/spinlock.h>
>  #include <linux/list.h>
>  #include <linux/stat.h>
> @@ -410,6 +409,8 @@ static inline int try_module_get(struct
>  	return ret;
>  }
>
> +extern int FASTCALL(wake_up_process(struct task_struct * tsk));
> +
>  static inline void module_put(struct module *module)
>  {
>  	if (module) {

