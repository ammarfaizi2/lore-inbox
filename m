Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263324AbUEWSsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUEWSsh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 14:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUEWSsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 14:48:37 -0400
Received: from moutng.kundenserver.de ([212.227.126.173]:61657 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263324AbUEWSse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 14:48:34 -0400
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] scaled-back caps, take 4
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <40AABE49.1050401@myrealbox.com>
	<20040519003013.L21045@build.pdx.osdl.net>
	<200405230228.28418.luto@myrealbox.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sun, 23 May 2004 20:48:25 +0200
Message-ID: <87n03zq8sm.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@myrealbox.com> writes:

> You don't like my patch because it rips out a bunch of code and it's
> not clear it won't break stuff.
>
> I don't like your patch because it takes a bunch of incomprehensible
> code that does almost nothing and tweaks it slightly to do something
> useful.  (That's not to say it's does the wrong thing; I just don't
> think the code is clear.)
>
> So I decided to figure out what was going on with the original code.
>
> First, CAP_SETPCAP is never obtainable (by anything).
> Since cap_bset never has this bit set, nothing can inherit it
> from fP.  capset_check prevents it from getting set in pI.

# mv /sbin/init /sbin/init.bin
# cat >/sbin/init
#! /bin/sh

if test $$ -eq 1; then
        mount /proc
        echo -1 >/proc/sys/kernel/cap-bound
fi

exec /sbin/init.bin "$@"
^D
# chmod 755 /sbin/init
# reboot

> Second, cap_bset is broken.  For one thing, there's no way
> to remove the caps you want to restrict from already-running
> tasks.  So I don't think it matters if we break/change it.

Maybe I don't understand this, but I think this is what sys_capset()
is for.

> cap_bprm_set_security does:
> fP = fI = (new_uid == 0 || new_euid == 0)
> fE = (new_euid == 0)

Only if (!issecure (SECURE_NOROOT))

[...]
> The whole result is just
> pP' = (uid == 0 || euid==0) & X
> pE' = (euid == 0) & X
>
> This patch implements this.  It should be invisible to userspace
> (unless userspace (ab)uses cap_bset).  It also adds a secureexec
> flag, which we both need.
>
> First, did I get this right?  It seems to work :)

With this patch you effectively revert all capable() calls back to
suser() tests. If this is what you intended, your patch looks fine.

> Second, do you have any objection to both of us redoing our
> patches against this one?  It should make them nicer-looking
> at least.

I didn't scrutinize capabilities as thoroughly as you did, but I still
don't see why your patch is necessary, besides the changes in
fs/exec.c and include/binfmts.h, maybe.

$ cp commoncap.c lutocap.c
modify it to your liking
# insmod lutocap

same goes for chriscap.c

Please, don't get me wrong. For me, it's just a matter of maintaining
a slightly bigger fscaps patch. But I don't think capabilities in
Linux are really broken, only because some proponents of SELinux claim
so.

If you want a simpler - setuid like - capabilities model, throw out
the inheritable _and_ permitted set and use the effective set alone.

Regards, Olaf.
