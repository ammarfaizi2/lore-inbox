Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264978AbUDUGce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264978AbUDUGce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265077AbUDUGbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:31:45 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:26635 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265087AbUDUG3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:29:39 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Kevin O'Connor" <kevin@koconnor.net>, Andrew Morton <akpm@osdl.org>
Subject: Re: inline_hunter 0.2 and it's results
Date: Wed, 21 Apr 2004 09:29:22 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <200404162230.40530.vda@port.imtp.ilyichevsk.odessa.ua> <20040419214041.GA3749@ohio.localdomain> <200404210901.48882.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200404210901.48882.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_YOCIKBCL7OUL5PMVYOF9"
Message-Id: <200404210929.22198.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_YOCIKBCL7OUL5PMVYOF9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> disasm, diff of
> void inline_copy_from_user_3(void) { copy_from_user(0,0,0); }
> yields:
>
> --- copy_from_user_43   Tue Apr 20 23:40:07 2004
> +++ copy_from_user_56   Tue Apr 20 23:41:23 2004
> @@ -11,11 +11,16 @@
>         39 5a 18                cmp    %ebx,0x18(%edx)
>         83 d9 00                sbb    $0x0,%ecx
>         85 c9                   test   %ecx,%ecx
> -       75 0b                   jne    XXXX <inline_copy_from_user_3+0x=
28>
> +       75 0d                   jne    XXXX <inline_copy_from_user_3+0x=
2a>
>         31 c9                   xor    %ecx,%ecx
>         31 d2                   xor    %edx,%edx
>         31 c0                   xor    %eax,%eax
>         e8 fc ff ff ff          call   XXXX <inline_copy_from_user_3+0x=
24>
> +       eb 0b                   jmp    XXXX <inline_copy_from_user_3+0x=
35>
> +       31 c9                   xor    %ecx,%ecx
> +       31 d2                   xor    %edx,%edx
> +       31 c0                   xor    %eax,%eax
> +       e8 4f 01 00 00          call   XXXX <__constant_c_and_count_mem=
set>
>         5b                      pop    %ebx
>         c9                      leave
>         c3                      ret
>
> oops... we've got files which do not honor 'inline' on
> __constant_c_and_count_memset()! For example,
>
> fs/open.c:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> #include <linux/string.h>
>         this pulls __constant_c_and_count_memset()
> #include <linux/mm.h>
>         this pulls <compiler.h>, re#defining
>         inline =3D=3D __inline__ __attribute__((always_inline)).
>         too late!
> #include <linux/utime.h>
>
> Will do patch tomorrow.

All affected files #include strings.h
This should fix it. Untested.
--=20
vda
--------------Boundary-00=_YOCIKBCL7OUL5PMVYOF9
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="include_compiler_h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="include_compiler_h.patch"

diff -urN linux-2.6.5/include/linux/string.h linux-2.6.5.fixed_includes/include/linux/string.h
--- linux-2.6.5/include/linux/string.h	Sun Apr  4 06:36:56 2004
+++ linux-2.6.5.fixed_includes/include/linux/string.h	Wed Apr 21 09:17:32 2004
@@ -5,6 +5,7 @@
 
 #ifdef __KERNEL__
 
+#include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
 

--------------Boundary-00=_YOCIKBCL7OUL5PMVYOF9--

