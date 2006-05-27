Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWE0BjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWE0BjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 21:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932784AbWE0BjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 21:39:05 -0400
Received: from xenotime.net ([66.160.160.81]:41169 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932782AbWE0BjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 21:39:04 -0400
Date: Fri, 26 May 2006 18:39:02 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, lkml <linux-kernel@vger.kernel.org>,
       drepper@redhat.com, akpm <akpm@osdl.org>, serue@us.ibm.com,
       sam@vilain.net, clg@fr.ibm.com, dev@sw.ru
Subject: Re: [PATCH] POSIX-hostname up to 255 characters
In-Reply-To: <m1zmh5b129.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.58.0605261758001.13225@shark.he.net>
References: <20060525204534.4068e730.rdunlap@xenotime.net>
 <m1zmh5b129.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2006, Eric W. Biederman wrote:

> "Randy.Dunlap" <rdunlap@xenotime.net> writes:
>
> > This patch is against 2.6.17-rc5, for review/comments, please.
> > It won't apply to -mm since Andrew has merged the uts-namespace patches.
> > I'll see about merging it with those patches next.
> > ---
> >
> > From: Randy Dunlap <rdunlap@xenotime.net>
> >
> > Implement POSIX-defined length for 'hostname' so that hostnames
> > can be longer than 64 characters (max. 255 characters plus
> > terminating NULL character).
> >
> > Adds sys_gethostname_long() and sys_sethostname_long().
> > Tested on i386 and x86_64.
>
> Is there any particular reason for this?
> The existing sys_gethostname and sys_sethostname interfaces
> should work for any string length.

Argh, correct, thanks.  Will fix.

> Although I do agree that we need at least one new syscall
> for the architectures that don't currently use get_hostname.

What do they do today?  Use uname(2) and extract the
<nodename> from it?
so would a sys_uname_long() be reasonable?

> > Builds on powerpc(64).
> > Test program is at http://www.xenotime.net/linux/src/hostnamelong.c .
> >
> > Consolidates many open-coded copiers of system_utsname into
> > functions in lib/utsname.c::put_oldold_uname(), put_old_uname(),
> > put_new_uname(). and put_long_uname().
> >
> > gethostname:
> > http://www.opengroup.org/onlinepubs/009695399/functions/gethostname.html
> > sysconf:
> > http://www.opengroup.org/onlinepubs/009695399/functions/sysconf.html
> > unistd.h:
> > http://www.opengroup.org/onlinepubs/009695399/basedefs/unistd.h.html
> > limits.h:
> > http://www.opengroup.org/onlinepubs/009695399/basedefs/limits.h.html
> >
> >
> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
>
> > --- linux-2617-rc5.orig/include/linux/utsname.h
> > +++ linux-2617-rc5/include/linux/utsname.h
> > @@ -30,7 +30,26 @@ struct new_utsname {
> >  	char domainname[65];
> >  };
> >
> > -extern struct new_utsname system_utsname;
> > +/* for (POSIX) IEEE Std. 1003.1, 2004 edition */
> > +#define __POSIX_HOST_NAME_MAX 255 /* not including terminating NUL char */
> >
> > +struct long_utsname {
> > +	char sysname[__NEW_UTS_LEN + 1];	/* O/S name */
> > +	char nodename[__POSIX_HOST_NAME_MAX + 1]; /* hostname, but keep field
> > +					* name same as other structs here */
> > +	char release[__NEW_UTS_LEN + 1];	/* O/S release level */
> > +	char version[__NEW_UTS_LEN + 1];	/* version level of release */
> > +	char machine[__NEW_UTS_LEN + 1];	/* machine hardware type */
> > +	char domainname[__NEW_UTS_LEN + 1];
> > +};
>
> Are there any similar issues with the NIS domainname?

Not that I can locate.

> > --- /dev/null
> > +++ linux-2617-rc5/lib/utsname.c
> > @@ -0,0 +1,188 @@
> > +#include <linux/compiler.h>
> > +#include <linux/errno.h>
> > +#include <linux/module.h>
> > +#include <linux/rwsem.h>
> > +#include <linux/utsname.h>
> > +#include <asm/uaccess.h>
> > +
...
> > +EXPORT_SYMBOL(__put_oldold_uname);
>
> Why do we need EXPORT_SYMBOL on syscall helpers?
> Is there any legitimate modular user?

Nope, don't think so.  I noticed that a few minutes after I
sent out the email... :)  Removed.

> > +int __put_long_uname(struct long_utsname __user *name)
> > +{
> > +	int error;
> > +
> > +	if (!name)
> > +		return -EFAULT;
> > +	if (!access_ok(VERIFY_WRITE, name, sizeof(struct new_utsname)))
> > +		return -EFAULT;
> > +
> > +	error = __copy_to_user(&name->sysname, &system_utsname.sysname,
> > +				__NEW_UTS_LEN);
> > +	error |= __put_user(0, name->sysname + __NEW_UTS_LEN);
> > +	error |= __copy_to_user(&name->nodename, &system_utsname.nodename,
> > +				__NEW_UTS_LEN);
> > +	error |= __put_user(0, name->nodename + __NEW_UTS_LEN);
> > +	error |= __copy_to_user(&name->release, &system_utsname.release,
> > +				__NEW_UTS_LEN);
> > +	error |= __put_user(0, name->release + __NEW_UTS_LEN);
> > +	error |= __copy_to_user(&name->version, &system_utsname.version,
> > +				__NEW_UTS_LEN);
> > +	error |= __put_user(0, name->version + __NEW_UTS_LEN);
> > +	error |= __copy_to_user(&name->machine, &system_utsname.machine,
> > +				__NEW_UTS_LEN);
> > +	error |= __put_user(0, name->machine + __NEW_UTS_LEN);
> > +	error |= __copy_to_user(&name->domainname, &system_utsname.domainname,
> > +				__NEW_UTS_LEN);
> > +	error |= __put_user(0, name->domainname + __NEW_UTS_LEN);
> > +
> > +	return error;
> > +}
> > +EXPORT_SYMBOL(__put_long_uname);
> > +
> > +int put_long_uname(struct long_utsname __user *name)
> > +{
> > +	int error;
> > +
> > +	down_read(&uts_sem);
> > +	error = __put_long_uname(name);
> > +	up_read(&uts_sem);
> > +
> > +	error = error ? -EFAULT : 0;
> > +	return error;
> > +}
> > +EXPORT_SYMBOL(put_long_uname);
>
> put_long_uname is probably premature in this patch as nothing uses it yet.

You are doing a good job. :)
sys_uname_long() will use it (or it will be removed).
I'll add that and repost the patch.

> > --- linux-2617-rc5.orig/drivers/char/random.c
> > +++ linux-2617-rc5/drivers/char/random.c
> > @@ -223,7 +223,6 @@
> >   * Eastlake, Steve Crocker, and Jeff Schiller.
> >   */
> >
> > -#include <linux/utsname.h>
> >  #include <linux/config.h>
> >  #include <linux/module.h>
> >  #include <linux/kernel.h>
> > @@ -240,6 +239,7 @@
> >  #include <linux/spinlock.h>
> >  #include <linux/percpu.h>
> >  #include <linux/cryptohash.h>
> > +#include <linux/utsname.h>
> >
> >  #include <asm/processor.h>
> >  #include <asm/uaccess.h>
>
> Is this movement of utsname something other than noise?

Yes, utsname.h now uses "__user" from compiler.h (the prototypes of
the put*name helpers), so this makes __user be #defined before it
is used.  Or I can #include compiler.h in utsname.h.

> > --- linux-2617-rc5.orig/arch/x86_64/ia32/ia32entry.S
> > +++ linux-2617-rc5/arch/x86_64/ia32/ia32entry.S
> > @@ -694,6 +694,8 @@ ia32_sys_call_table:
> >  	.quad compat_sys_get_robust_list
> >  	.quad sys_splice
> >  	.quad sys_sync_file_range
> > -	.quad sys_tee
> > +	.quad sys_tee			/* 315 */
> >  	.quad compat_sys_vmsplice
> > +	.quad sys_gethostname
> > +	.quad sys_sethostname
> >  ia32_syscall_end:
>
> Huh?  Not gethostname_log?

Right again, it should have been _long, but they are now removed
since I don't need to add these new syscalls at all.

Thanks much, Eric.
-- 
~Randy
