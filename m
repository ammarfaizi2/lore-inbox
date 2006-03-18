Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWCRR1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWCRR1z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 12:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWCRR1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 12:27:55 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:36554 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750757AbWCRR1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 12:27:54 -0500
Message-ID: <441C4263.B779CDA8@tv-sign.ru>
Date: Sat, 18 Mar 2006 20:24:51 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Janak Desai <janak@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk, hch@lst.de,
       mtk-manpages@gmx.net, ak@muc.de, paulus@samba.org
Subject: Re: [PATCH] unshare: Use rcu_assign_pointer when setting sighand
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com>		<m1pskm9tz9.fsf@ebiederm.dsl.xmission.com>		<441AF596.F6E66BC9@tv-sign.ru> <20060317125607.78a5dbe4.akpm@osdl.org> <441C0741.3BC25010@tv-sign.ru> <441C2AA0.3080200@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janak Desai wrote:
> 
> Oleg Nesterov wrote:
> >
> >Btw, copy_process() forbids CLONE_SIGHAND without CLONE_VM (is there a
> >good reason for that?), but one can do unshare(CLONE_VM). This is odd.
> >
> >
> Yes, copy_process forbids cloning of signal handlers without cloning of vm.
> However, it does allow cloning of vm without cloning of signal handlers. For
> those processes, that are sharing vm but not signal handlers, unsharing
> of vm
> is allowed.

Yes, I was wrong, I missed check_unshare_flags(),

	/*
	 * If unsharing vm, must also unshare signal handlers.
	 */
	if (*flags_ptr & CLONE_VM)
		*flags_ptr |= CLONE_SIGHAND;

Looking below,

	/*
	 * If unsharing signal handlers and the task was created
	 * using CLONE_THREAD, then must unshare the thread
	 */
	if ((*flags_ptr & CLONE_SIGHAND) &&
	    (atomic_read(&current->signal->count) > 1))
		*flags_ptr |= CLONE_THREAD;

Shouldn't this be:

		*flags_ptr |= (CLONE_THREAD | CLONE_VM)

? Currently it doesn't matter, but still.


However, I stronly beleive unshare(CLONE_VM) is buggy.

sys_unshare:


		if (new_mm) {
			...
			new_mm = mm;
		}

	...

	bad_unshare_cleanup_vm:
		if (new_mm)
			mmput(new_mm);


mmput() ignores mm->core_waiters.

No?

Oleg.
