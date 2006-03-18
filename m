Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWCRNPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWCRNPm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 08:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWCRNPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 08:15:42 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:45239 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932127AbWCRNPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 08:15:41 -0500
Message-ID: <441C0741.3BC25010@tv-sign.ru>
Date: Sat, 18 Mar 2006 16:12:33 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: ebiederm@xmission.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       janak@us.ibm.com, viro@ftp.linux.org.uk, hch@lst.de,
       mtk-manpages@gmx.net, ak@muc.de, paulus@samba.org
Subject: Re: [PATCH] unshare: Use rcu_assign_pointer when setting sighand
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com>
		<m1pskm9tz9.fsf@ebiederm.dsl.xmission.com>
		<441AF596.F6E66BC9@tv-sign.ru> <20060317125607.78a5dbe4.akpm@osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Oleg Nesterov <oleg@tv-sign.ru> wrote:
> >
> > Isn't it better to just replace this code with
> > 'BUG_ON(new_sigh != NULL)' ?
> >
> > It is never executed, but totally broken, afaics.
> > task_lock() has nothing to do with ->sighand changing.
> >
> 
> /*
>  * Unsharing of sighand for tasks created with CLONE_SIGHAND is not
>  * supported yet
>  */
> static int unshare_sighand(unsigned long unshare_flags, struct sighand_struct **new_sighp)
> 
> It's all just a place-holder at present.
> 
> If we don't plan on ever supporting unshare(CLONE_SIGHAND) we should take
> that code out and make it return EINVAL.  Right now.
> 
> And because we don't presently support CLONE_SIGHAND we should return
> EINVAL if it's set.  Right now.
> 
> And we should change sys_unshare() to reject not-understood flags.  Right
> now.
> 
> If we don't do these things we'll silently break 2.6.16-back-compatibility
> of applications which are coded for future kernels.

unshare_sighand() is ok, it never populates *new_sighp, it just returns
errror code: 0 when ->sighand is not shared, EINVAL otherwise.

I argued about 'if (new_sigh)' code in sys_unshare() because it lies about
locking rules.

Btw, copy_process() forbids CLONE_SIGHAND without CLONE_VM (is there a
good reason for that?), but one can do unshare(CLONE_VM). This is odd.

Oleg.
