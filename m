Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965913AbWKNPRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965913AbWKNPRI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 10:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965920AbWKNPRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 10:17:08 -0500
Received: from mivlgu.ru ([81.18.140.87]:1951 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S965913AbWKNPRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 10:17:04 -0500
Date: Tue, 14 Nov 2006 18:16:56 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: sharyath@in.ibm.com
Cc: Pavel Emelianov <xemul@sw.ru>, Vadim Lobanov <vlobanov@speakeasy.net>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Patch to fixe Data Acess error in dup_fd
Message-Id: <20061114181656.6328e51a.vsu@altlinux.ru>
In-Reply-To: <1163151121.3539.15.camel@legolas.in.ibm.com>
References: <1163151121.3539.15.camel@legolas.in.ibm.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.2; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__14_Nov_2006_18_16_56_+0300_7wOtApbWUV0J5VlX"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__14_Nov_2006_18_16_56_+0300_7wOtApbWUV0J5VlX
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2006 15:02:01 +0530 Sharyathi Nagesh wrote:

> On running the Stress Test on machine for more than 72 hours following
> error message was observed.

Was your stress test using threads (or other nonstandard clone() calls)?

> 0:mon> e
> cpu 0x0: Vector: 300 (Data Access) at [c00000007ce2f7f0]
>     pc: c000000000060d90: .dup_fd+0x240/0x39c
>     lr: c000000000060d6c: .dup_fd+0x21c/0x39c
>     sp: c00000007ce2fa70
>    msr: 800000000000b032
>    dar: ffffffff00000028
>  dsisr: 40000000
>   current = 0xc000000074950980
>   paca    = 0xc000000000454500
>     pid   = 27330, comm = bash
>
> 0:mon> t
> [c00000007ce2fa70] c000000000060d28 .dup_fd+0x1d8/0x39c (unreliable)
> [c00000007ce2fb30] c000000000060f48 .copy_files+0x5c/0x88
> [c00000007ce2fbd0] c000000000061f5c .copy_process+0x574/0x1520
> [c00000007ce2fcd0] c000000000062f88 .do_fork+0x80/0x1c4
> [c00000007ce2fdc0] c000000000011790 .sys_clone+0x5c/0x74
> [c00000007ce2fe30] c000000000008950 .ppc_clone+0x8/0xc
> --- Exception: c00 (System Call) at 000000000fee9c60
> SP (fcb2e770) is in userspace

Did you find the exact instruction which faulted, and the place in
dup_fd() C code which it corresponds to?  Was the oops due to a NULL
dereference or an invalid pointer?

> The problem is because of race window. When if(expand) block is executed in dup_fd
> unlocking of oldf->file_lock give a window for fdtable in oldf to be
> modified. So actual open_files in oldf may not match with open_files
> variable.
> This is the debug patch to fix the problem

> --- kernel/fork.c.orig	2006-11-10 14:42:02.000000000 +0530
> +++ kernel/fork.c	2006-11-10 14:42:30.000000000 +0530
> @@ -687,6 +687,7 @@ static struct files_struct *dup_fd(struc
>  		 * the latest pointer.
>  		 */
>  		spin_lock(&oldf->file_lock);
> +		open_files = count_open_files(old_fdt);
>  		old_fdt = files_fdtable(oldf);
>  	}

I don't see immediately how the wrong open_files value could cause an
oops in this function.  If the stale open_files value was too big (some
files were closed while we dropped the lock), it should still be safe
(AFAIK file tables can only grow, but never shrink, so access to entries
which were valid before should not access invalid memory).  If the stale
open_files value was too small (some more files were opened), the copy
would miss some files, which should be OK (except that memcpy() calls
which copy fd_sets will copy bits for some of that missed files which
happened to be in the last word - this would cause some fd's to be
permanently busy, and potentially could cause problems later, but an
oops in dup_fd() due to this problem does not look likely).  Seeing the
exact place in the code which oopsed would be interesting.

However, the new code does not look safe in all cases.  If some other
task has opened more files while dup_fd() released oldf->file_lock, the
new code will update open_files to the new larger value.  But newf was
allocated with the old smaller value of open_files, therefore subsequent
accesses to newf may try to write into unallocated memory.

Hmm, and actually the patch seems to be wrong for yet another reason -
the old_fdt pointer which you pass to count_open_files() may be stale
(the comment above even warns about that, and the following line updates
old_fdt).  The count_open_files() call must be after the "old_fdt =
files_fdtable(oldf)" line.

--Signature=_Tue__14_Nov_2006_18_16_56_+0300_7wOtApbWUV0J5VlX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFWd3oW82GfkQfsqIRAvpMAJ9HgsHIJ22e+Ta1e6gjBicp9HWHqwCdEfK0
b5ueAVYlJ+jjrQFkbRNCo4A=
=RH+y
-----END PGP SIGNATURE-----

--Signature=_Tue__14_Nov_2006_18_16_56_+0300_7wOtApbWUV0J5VlX--
