Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263698AbUESBfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbUESBfE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 21:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbUESBfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 21:35:03 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:1479 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S263698AbUESBer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 21:34:47 -0400
Message-ID: <40AAB9AA.8090508@myrealbox.com>
Date: Tue, 18 May 2004 18:34:34 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Andy Lutomirski <luto@myrealbox.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       olaf+list.linux-kernel@olafdietsche.de, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] support cap inheritable (Re: [PATCH] scaled-back caps,
 take 4 (was Re: [PATCH] capabilites, take 2)
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <40A4F163.6090802@stanford.edu> <20040514110752.U21045@build.pdx.osdl.net> <200405141548.05106.luto@myrealbox.com> <20040517231912.H21045@build.pdx.osdl.net> <20040517235844.I21045@build.pdx.osdl.net>
In-Reply-To: <20040517235844.I21045@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

> * Chris Wright (chrisw@osdl.org) wrote:
> 
>>* Andy Lutomirski (luto@myrealbox.com) wrote:
>>
>>>This version throws out the inheritable mask.  There is no change in
>>>behavior with newcaps=0.
>>
>>Alright, I tried to write up my expectations for all the various modes
>>w.r.t dropping privs, keeping them, setuid apps, etc.  I then wrote some
>>tests to get a baseline, and well as a way to compare results.  Finally
>>I wrote a patch that meets the requirements I laid out, and compared it
>>against yours.  With one minor exception, the capabilities bits match
>>up.  You drop effective caps when a non-root users execs a non-root
>>setuid app, and I the caps alone.  One side note, you're changes effect
>>the user/group saved ids unexpectedly.

Disclaimer: I haven't had a chance to boot this version.

> 
> 
> The tests are available at:
>   http://developer.osdl.org/~chrisw/capabilities/testcap.tar.bz2
> 
> patch is there too and is also inline below:
>   http://developer.osdl.org/~chrisw/capabilities/2.6.6-mm2/chris_cap.patch
> 
> --- linux-2.6.6-mm2-cap/include/linux/capability.h.orig	2004-05-09 19:32:26.000000000 -0700
> +++ linux-2.6.6-mm2-cap/include/linux/capability.h	2004-05-17 23:24:08.143860096 -0700
> @@ -309,7 +309,9 @@
>  #define CAP_EMPTY_SET       to_cap_t(0)
>  #define CAP_FULL_SET        to_cap_t(~0)
>  #define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
> -#define CAP_INIT_INH_SET    to_cap_t(0)
> +#define CAP_INIT_INH_SET    to_cap_t(~0)
> +/* ~0 is legacy inheritable mode and can never be capset by user */
> +#define cap_orig_inh(_cap) (cap_t((_cap)) == ~0)

So how do you say "inherit all caps"?

[...]

> @@ -56,10 +59,13 @@
>  int cap_capset_check (struct task_struct *target, kernel_cap_t *effective,
>  		      kernel_cap_t *inheritable, kernel_cap_t *permitted)
>  {
> +	kernel_cap_t target_inheritable = target->cap_inheritable;
> +	if (cap_orig_inh(target_inheritable))
> +		target_inheritable = 0;
>  	/* Derived from kernel/capability.c:sys_capset. */
>  	/* verify restrictions on target's new Inheritable set */
>  	if (!cap_issubset (*inheritable,
> -			   cap_combine (target->cap_inheritable,
> +			   cap_combine (target_inheritable,
>  					current->cap_permitted))) {
>  		return -EPERM;
>  	}

What stops legacy mode from being reenabled?

[...]

I think you missed the case when root-but-no-caps execs setuid root -- I 
don't see anything that would enable secureexec.

--Andy
