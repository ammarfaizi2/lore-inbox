Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266226AbUAMXys (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUAMXyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:54:47 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:26551 "EHLO
	omta06.mta.everyone.net") by vger.kernel.org with ESMTP
	id S266226AbUAMXyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:54:08 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Tue, 13 Jan 2004 15:54:07 -0800 (PST)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: Capabilities help
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.187.247]
Message-Id: <20040113235407.EA4D7393B@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need replies CC'd to me.

Okay it seems that in my jail, when a process attatches (with the
linux_jail_attatch(pjail, p) call in do_fork() or sys_linux_jail()), I drop a bunch
of caps.  Relavent functions are below:

/*attatch a process to a jail structure.  Call this with pjail = NULL to detatch.*/
void linux_jail_attatch(struct linux_jail_struct *pjail, struct task_struct *tsk) {
        linux_jail_detatch(tsk);
        if (!pjail) /*Act as linux_jail_detatch()*/
                goto out;
        tsk->pjail = pjail;
        pjail->usagect++; /*make sure to keep tabs on usage count*/
        /*Now alter the task to match the jail*/
        /*First, set up caps to match the jail's caps*/
        lj_task_drop_caps(pjail, tsk);
out:
        return;
}

/*Drop capabilities*/
void lj_task_drop_caps(struct linux_jail_struct *pjail, struct task_struct *tsk) {
        kernel_cap_t    capstodrop = 0;
        /* build the capstodrop, then drop them*/
        /*FIXME: PLEASE PLEASE PLEASE MAKE SURE THESE CAPS DO WHAT I THINK THEY
        DO!!!*/
        if (pjail->flags & FL_JAIL_JAIL)
                capstodrop |= CAP_TO_MASK(CAP_SYS_CHROOT);
        if (pjail->flags & FL_JAIL_MODULE_LOADING)
                capstodrop |= CAP_TO_MASK(CAP_SYS_MODULE);
        if (pjail->flags & FL_JAIL_NET_CONFIG)
                capstodrop |= CAP_TO_MASK(CAP_NET_ADMIN);
        if (pjail->flags & FL_JAIL_NET_RAW_SOCKS)
                capstodrop |= CAP_TO_MASK(CAP_NET_RAW);
        if (pjail->flags & FL_JAIL_BOOT)
                capstodrop |= CAP_TO_MASK(CAP_SYS_BOOT);
        if (pjail->flags & FL_JAIL_TIME)
                capstodrop |= CAP_TO_MASK(CAP_SYS_TIME);
                                                                                                                                    
        /*now drop 'em . . .  Don't be shy ;) */
        tsk->cap_permitted =
                cap_drop(tsk->cap_permitted, capstodrop);
        tsk->cap_inheritable =
                cap_drop(tsk->cap_inheritable, capstodrop);
        tsk->cap_effective =
                cap_drop(tsk->cap_effective, capstodrop);
}


I know this is working, because I checked my code over, plus the double chroot /
fails.  I can still load modules, change the system time, and administrate the
network.  I need a bit more fine grained control than CAP_SYS_BOOT, but that's
irrelavent.  The point is, as far as I can see, CAP_SYS_MODULE at least does what
I think it should, and it's getting dropped here.  Why can my tasks still load
and unload modules?  Am I doing something wrong?

I can finalize and post up the 0.05 code now and point you at it; in fact, I will
for reference if anyone feels the need to page through my pach and see what's up.
It works alright, but a lot of things aren't implimented, and there's a few bad
hacks (notably in fs/namei.c and kernel/fork.c, both init related).  Everything
not marked "Not Implimented" or "Testing" in Security->Ssec works.

Anyway, it's just if you want to help and/or feel the need to take a look at my
code, but, the two regular files at http://foxfs.sf.net/misc/ssec are the current
patch against 2.6.1 and the changelog.

Any help is appreciated; I need to understand stuff like this so it stops getting
in my way and making me increase the garbage flow on the list and on freenode.

_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
