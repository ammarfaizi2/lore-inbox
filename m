Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932765AbWCQU7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765AbWCQU7t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932770AbWCQU7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:59:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63446 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932765AbWCQU7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:59:24 -0500
Date: Fri, 17 Mar 2006 12:56:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: ebiederm@xmission.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       janak@us.ibm.com, viro@ftp.linux.org.uk, hch@lst.de,
       mtk-manpages@gmx.net, ak@muc.de, paulus@samba.org
Subject: Re: [PATCH] unshare: Use rcu_assign_pointer when setting sighand
Message-Id: <20060317125607.78a5dbe4.akpm@osdl.org>
In-Reply-To: <441AF596.F6E66BC9@tv-sign.ru>
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com>
	<m1pskm9tz9.fsf@ebiederm.dsl.xmission.com>
	<441AF596.F6E66BC9@tv-sign.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> "Eric W. Biederman" wrote:
> > 
> > @@ -1573,7 +1573,7 @@ asmlinkage long sys_unshare(unsigned lon
> > 
> >                 if (new_sigh) {
> >                         sigh = current->sighand;
> > -                       current->sighand = new_sigh;
> > +                       rcu_assign_pointer(current->sighand, new_sigh);
> >                         new_sigh = sigh;
> >                 }
> 
> Isn't it better to just replace this code with
> 'BUG_ON(new_sigh != NULL)' ?
> 
> It is never executed, but totally broken, afaics.
> task_lock() has nothing to do with ->sighand changing.
> 

/*
 * Unsharing of sighand for tasks created with CLONE_SIGHAND is not
 * supported yet
 */
static int unshare_sighand(unsigned long unshare_flags, struct sighand_struct **new_sighp)

It's all just a place-holder at present.

If we don't plan on ever supporting unshare(CLONE_SIGHAND) we should take
that code out and make it return EINVAL.  Right now.

And because we don't presently support CLONE_SIGHAND we should return
EINVAL if it's set.  Right now.

And we should change sys_unshare() to reject not-understood flags.  Right
now.

If we don't do these things we'll silently break 2.6.16-back-compatibility
of applications which are coded for future kernels.

