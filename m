Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWD2QeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWD2QeQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 12:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWD2QeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 12:34:16 -0400
Received: from master.altlinux.org ([62.118.250.235]:36614 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1750754AbWD2QeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 12:34:15 -0400
Date: Sat, 29 Apr 2006 20:34:05 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Jason Baron <jbaron@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [patch 03/24] make vm86 call audit_syscall_exit
Message-Id: <20060429203405.1cc6f2b6.vsu@altlinux.ru>
In-Reply-To: <20060428001652.GD18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
	<20060428001652.GD18750@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__29_Apr_2006_20_34_05_+0400_uXALaUxGVLg5Lo.r"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__29_Apr_2006_20_34_05_+0400_uXALaUxGVLg5Lo.r
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Apr 2006 17:16:52 -0700 Greg KH wrote:

> -stable review patch.  If anyone has any objections, please let us know.
>=20
> ------------------
> hi,
>=20
> The motivation behind the patch below was to address messages in
> /var/log/messages such as:
>=20
> Jan 31 10:54:15 mets kernel: audit(:0): major=3D252 name_count=3D0: freei=
ng
> multiple contexts (1)
> Jan 31 10:54:15 mets kernel: audit(:0): major=3D113 name_count=3D0: freei=
ng
> multiple contexts (2)
>=20
> I can reproduce by running 'get-edid' from:
> http://john.fremlin.de/programs/linux/read-edid/.
>=20
> These messages come about in the log b/c the vm86 calls do not exit via
> the normal system call exit paths and thus do not call
> 'audit_syscall_exit'. The next system call will then free the context for
> itself and for the vm86 context, thus generating the above messages. This
> patch addresses the issue by simply adding a call to 'audit_syscall_exit'
> from the vm86 code.
>=20
> Besides fixing the above error messages the patch also now allows vm86
> system calls to become auditable. This is useful since strace does not
> appear to properly record the return values from sys_vm86.

I don't understand how this is supposed to log the sys_vm86 return value
properly - the return value for userspace would be known only in
return_to_32bit(), and here audit_syscall_exit() is called in
do_sys_vm86(), before the VM86-mode code has even started to run.

> I think this patch is also a step in the right direction in terms of
> cleaning up some core auditing code. If we can correct any other paths
> that do not properly call the audit exit and entries points, then we can
> also eliminate the notion of context chaining.
>=20
> I've tested this patch by verifying that the log messages no longer
> appear, and that the audit records for sys_vm86 appear to be correct.

And what return values are logged?

> Also, 'read_edid' produces itentical output.
>=20
> thanks,
>=20
> -Jason
>=20
> Signed-off-by: Jason Baron <jbaron@redhat.com>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>=20
> ---
> ---
>  arch/i386/kernel/vm86.c |   12 ++++++++++--
>  kernel/auditsc.c        |    5 -----
>  2 files changed, 10 insertions(+), 7 deletions(-)
>=20
> --- linux-2.6.16.11.orig/arch/i386/kernel/vm86.c
> +++ linux-2.6.16.11/arch/i386/kernel/vm86.c
> @@ -43,6 +43,7 @@
>  #include <linux/smp_lock.h>
>  #include <linux/highmem.h>
>  #include <linux/ptrace.h>
> +#include <linux/audit.h>
> =20
>  #include <asm/uaccess.h>
>  #include <asm/io.h>
> @@ -252,6 +253,7 @@ out:
>  static void do_sys_vm86(struct kernel_vm86_struct *info, struct task_str=
uct *tsk)
>  {
>  	struct tss_struct *tss;
> +	long eax;
>  /*
>   * make sure the vm86() system call doesn't try to do anything silly
>   */
> @@ -305,13 +307,19 @@ static void do_sys_vm86(struct kernel_vm
>  	tsk->thread.screen_bitmap =3D info->screen_bitmap;
>  	if (info->flags & VM86_SCREEN_BITMAP)
>  		mark_screen_rdonly(tsk->mm);
> +	__asm__ __volatile__("xorl %eax,%eax; movl %eax,%fs; movl %eax,%gs\n\t"=
);
> +	__asm__ __volatile__("movl %%eax, %0\n" :"=3Dr"(eax));

This fetches whatever value happened to be in the EAX register at this
point, and stuffs it into the eax variable.  Most likely EAX will
contain 0 from the previous asm commands.  I'm not sure whether gcc
could insert some code of its own between two "asm volatile" statements,
but this asm statement looks like a bug by itself.

> +
> +	/*call audit_syscall_exit since we do not exit via the normal paths */
> +	if (unlikely(current->audit_context))
> +		audit_syscall_exit(current, AUDITSC_RESULT(eax), eax);

Then this probably always records 0 as the syscall result.

However, looks like moving audit_syscall_exit() into return_to_32bit()
(where the syscall result is known) would not work because of issues
with signal handling...  So maybe we are stuck with partially wrong
audit records for vm86, but at least the broken asm should be removed.

> +
>  	__asm__ __volatile__(
> -		"xorl %%eax,%%eax; movl %%eax,%%fs; movl %%eax,%%gs\n\t"
>  		"movl %0,%%esp\n\t"
>  		"movl %1,%%ebp\n\t"
>  		"jmp resume_userspace"
>  		: /* no outputs */
> -		:"r" (&info->regs), "r" (task_thread_info(tsk)) : "ax");
> +		:"r" (&info->regs), "r" (task_thread_info(tsk)));
>  	/* we never return here */
>  }
> =20
> --- linux-2.6.16.11.orig/kernel/auditsc.c
> +++ linux-2.6.16.11/kernel/auditsc.c
> @@ -966,11 +966,6 @@ void audit_syscall_entry(struct task_str
>  	if (context->in_syscall) {
>  		struct audit_context *newctx;
> =20
> -#if defined(__NR_vm86) && defined(__NR_vm86old)
> -		/* vm86 mode should only be entered once */
> -		if (major =3D=3D __NR_vm86 || major =3D=3D __NR_vm86old)
> -			return;
> -#endif
>  #if AUDIT_DEBUG
>  		printk(KERN_ERR
>  		       "audit(:%d) pid=3D%d in syscall=3D%d;"
>=20
> --

--Signature=_Sat__29_Apr_2006_20_34_05_+0400_uXALaUxGVLg5Lo.r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEU5WAW82GfkQfsqIRAknKAJ9i0LYyypr7DmOVWKKqoQU5wIABFQCfduzY
SimYQlzZgxxpxJFk1p4ywQ0=
=PU1c
-----END PGP SIGNATURE-----

--Signature=_Sat__29_Apr_2006_20_34_05_+0400_uXALaUxGVLg5Lo.r--
