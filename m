Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265684AbUEZNoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265684AbUEZNoP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265705AbUEZNoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:44:13 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:29674 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265684AbUEZNmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 09:42:46 -0400
Date: Wed, 26 May 2004 22:42:47 +0900
From: AKIYAMA Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com>
Subject: Re: [PATCH] NMI trigger switch support for debugging
In-reply-to: <16564.26285.431229.665902@alkaid.it.uu.se>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-id: <40B49ED7.6030200@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.6 (X11/20040516)
References: <40B1BEAC.30500@jp.fujitsu.com>
 <20040524023453.7cf5ebc2.akpm@osdl.org> <40B3F484.4030405@jp.fujitsu.com>
 <20040525184148.613b3d6e.akpm@osdl.org> <40B400D1.1080602@jp.fujitsu.com>
 <16564.26285.431229.665902@alkaid.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikael,

Thank you for reviewing.

Mikael Pettersson wrote:

>AKIYAMA Nobuyuki writes:
> > +int unknown_nmi_panic = 0;
>
>It's a kernel coding standard to _not_ explicitly initialise
>static-extent data to zero.
>
>  
>
OK, thanks.

> > +/*
> > + * proc handler for /proc/sys/kernel/unknown_nmi_panic
> > + */
> > +int proc_unknown_nmi_panic(ctl_table *table, int write,
> > +                struct file *file, void __user *buffer, size_t *length)
> > +{
> > +	int old_state;
> > +
> > +	old_state = unknown_nmi_panic;
> > +	proc_dointvec(table, write, file, buffer, length);
> > +	if (!old_state == !unknown_nmi_panic)
> > +		return 0;
>
>This conditional looks terribly obscure.
>Can you simplify it or explain your intention here?
>
>  
>
This code checks whether unknown_nmi_panic is changed to another state.
Only when state is changed, I'd like to go next step.

old_state  unknown_nmi_panic   condition
0          0                 : TRUE(no change, return)
none zero  none zero         : TRUE(no change, return)
0          none zero         : FALSE(changed, go next step)
none zero  0                 : FALSE(changed, go next step)


> > +	if (unknown_nmi_panic) {
> > +		if (reserve_lapic_nmi() < 0) {
> > +			unknown_nmi_panic = 0;
> > +			return -EBUSY;
> > +		} else {
> > +			set_nmi_callback(unknown_nmi_panic_callback);
> > +		}
> > +	} else {
> > +		release_lapic_nmi();
>
>You're invoking release_lapic_nmi() in response to user
>input, without having verified that _you_ had done a
>reserve_lapic_nmi() before.
>  
>

The only one user can obtain NMI callback.
If unknown_nmi_panic is 0 at this step, it says that I have obtained
NMI callback before.
So, I think invoking release_lapic_nmi() has no problem.


Regards,
Nobuyuki Akiyama


