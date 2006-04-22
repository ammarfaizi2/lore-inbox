Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWDVUmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWDVUmI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWDVUmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:42:06 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:28112 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750906AbWDVUmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:42:01 -0400
Date: Sat, 22 Apr 2006 13:13:18 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Greg KH <greg@kroah.com>, Arjan van de Ven <arjan@infradead.org>,
       James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation
 of LSM hooks)
In-Reply-To: <1145649382.21749.286.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.61.0604221244500.27942@yvahk01.tjqt.qr>
References: <200604142301.10188.edwin@gurde.com> 
 <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> 
 <20060417162345.GA9609@infradead.org>  <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
  <20060417173319.GA11506@infradead.org>  <Pine.LNX.4.64.0604171454070.17563@d.namei>
  <20060417195146.GA8875@kroah.com>  <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
  <1145462454.3085.62.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr>  <20060419201154.GB20545@kroah.com>
  <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr> 
 <1145636755.21749.165.camel@moss-spartans.epoch.ncsc.mil> 
 <Pine.LNX.4.61.0604212039100.4602@yvahk01.tjqt.qr>
 <1145649382.21749.286.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> When you grant CAP_SYS_ADMIN to a user, he can do _a lot_ of things. I wanted
>> to have the sub-admin have read rights in most places (e.g. nvram to pick a
>> random example), but not to have write rights. Unfortunately, read rights and
>> write rights for nvram both fall under CAP_SYS_ADMIN.
>> 
>> capable_x will call out to security_cap_extra(), passing it the current
>> function name as a string. An LSM module can then provide security_cap_extra
>> via the security_operations vector and decide whether to allow the request. I
>> primarily did this because it reduces the amount of recompiling needed. For
>> example, instead of having to add a ->nvram_allow_read and ->nvram_allow_write
>> hooks in include/linux/security.h -- which requires compilation of a lot of
>> parts -- I can simply use strcmp(func, "nvram_read") in the LSM. I agree that
>> this is not optimal, but having 1000 pointers in the security_ops vector is not
>> a solution either (-> code bloat).
>
>- Where is the user of the cap_extra hook?  I don't see it in multiadm.
>If you aren't using it, it isn't a requirement for multiadm, obviously;
>you should drop those diffs out and just focus on what you need for
>multiadm itself.

The subadmin gets CAP_SYS_ADMIN. This is because capable() is often done before
the LSM callout, e.g. sys_sethostname(). Even when capable() is after an LSM
call, the process needs a certain capability or the syscall/function will
return failure to userspace. The best solution I can think of is that capable()
disappears entirely from functions and that an LSM function does it all then.

>- Writing a security module based on function names in other modules is
>obviously very fragile; some kind of abstraction would be required.

Yes, but at least it returns permission denied in the default case :)
Best would probably if the caller uses a fixed string rather than __FUNCTION__
from the expanded capable_x() macro. Or an enum value...

enum {
	HK_SETHOSTNAME,
};

>> >Some of the hooks used to exist in LSM patches but didn't have a real
>> >user for merging at the time.  But it isn't clear whether you actually
>> >need separate hooks for each of them or if they are being mapped to the
>> >same check in many cases - can it be abstracted to a common hook?
>> 
>> Not without passing a handful of useless parameters (NULL or 0) to each
>> function.
>> As much as I would like to combine for example mt_sb_mount and mt_sb_pivotroot,
>> the prototypes are just too different.
>> Suggestions welcome.
>
>I wasn't suggesting passing the union of their parameters, just the ones
>that are actually used by your module (plus any parameters used by any
>other in-tree user, i.e. capability and SELinux).

static bool mt_file_alloc_override(int cur, int max) {
    /* Called when the maximum number of files is open. Only superadmins may
    override this. Return >0 for success. */
    return is_any_superadm(current->euid, current->egid);
}

I see what you mean - cur and max are unused. However, if I was to call to a
seconday module from within this function (which is not really implemented), I
would suddenly need cur and max again. I do think that the parameters have a
reason to be there - a user might wish to enforce this sort:

    return is_any_superadm(...) ||
           (is_any_subadm(...) && (max <= 2048))

E.g. "allow some more" for subadms. Multiadmin is currently extremely tailored
to one specific (call it the default :-) use case.

>And trying to abstract a higher level conceptual operation as the hook rather
>than making them per-syscall/operation.  I know that LSM currently does things
>the other way, but I'd much rather see it move toward more general permission
>checking interfaces (ala the internal SELinux ones, although I understand
>those specific interfaces aren't what you would use).  Others may have a
>different POV.
>
>> >Seems like you are duplicating a lot of the base DAC logic in the
>> >process; would be nice to encapsulate that in the core kernel, and then
>> >just use a common helper in both cases?
>> 
>> The problem is that the base DAC logic is done after security_*(). Sometimes
>> that's good, most of the times, it leads to duplicated DAC logic because the
>> "usual DAC decision" is part of how multiadm decides.
>> 
>> Suggestions welcome too.
>
>At least for common cases like permission(9) and ipcperms(9), the
>security hook call comes after the DAC checking.  But not always.
>Sounds like you want authoritative hooks, which were discussed and
>experimented with during LSM development, see archives.  You could
>attempt to revive that for the cases where you need it, moving the
>checking into the commoncap functions (defining new ones where needed,
>and making sure that existing modules call them so that they still apply
>those checks) and calling those functions rather than duplicating the
>logic in your own module.  You presumably don't want to have to maintain
>the duplicated logic in your own module.

Exactly (like above with capable(), DAC shares the same 'positional' problem).
In fact, after some thought I could come to the conclusion that the POSIX
CAPability framework is more a hindrance for this sort of LSM, since it's
mostly UID/GID-based. We only raise capabilities so the rest of the kernel
plays fine with us.


Jan Engelhardt
-- 
