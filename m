Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbTBJV3A>; Mon, 10 Feb 2003 16:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbTBJV3A>; Mon, 10 Feb 2003 16:29:00 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:56746 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265201AbTBJV25>; Mon, 10 Feb 2003 16:28:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: "James Lamanna" <james.lamanna@appliedminds.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.60 Compile error
Date: Mon, 10 Feb 2003 15:38:40 -0600
X-Mailer: KMail [version 1.2]
References: <021d01c2d148$3de259d0$39140b0a@amthinking.net>
In-Reply-To: <021d01c2d148$3de259d0$39140b0a@amthinking.net>
MIME-Version: 1.0
Message-Id: <03021015384004.02639@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 February 2003 15:06, James Lamanna wrote:
> Another compiler error that's been around for a little while:
> Looks like some weird gcc problem.
> gcc version: 2.95.4 20011002 (Debian prerelease)
>
> make -f scripts/Makefile.build obj=scripts
> make -f scripts/Makefile.build obj=drivers/md drivers/md/linear.o
>   gcc -Wp,-MD,drivers/md/.linear.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=i686
> -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=linear -DKBUILD_MODNAME=linear -c -o
> drivers/md/linear.o drivers/md/linear.c
> drivers/md/linear.c: In function `linear_run':
> drivers/md/linear.c:159: Internal compiler error:
> drivers/md/linear.c:159: internal error--unrecognizable insn:
> (insn 316 315 673 (parallel[
>             (set (reg:SI 0 %eax)
>                 (asm_operands ("") ("=a") 0[
>                         (reg:DI 1 %edx)
>                     ]
>                     [
>                         (asm_input:DI ("A"))
>                     ]  ("drivers/md/linear.c") 115))
>             (set (reg:SI 1 %edx)
>                 (asm_operands ("") ("=d") 1[
>                         (reg:DI 1 %edx)
>                     ]
>                     [
>                         (asm_input:DI ("A"))
>                     ]  ("drivers/md/linear.c") 115))
>         ] ) -1 (insn_list 313 (nil))
>     (nil))
> make[1]: *** [drivers/md/linear.o] Error 1
> make: *** [drivers/md/linear.o] Error 2

I have been getting this same error for several kernel versions
now. I have fixed it with the following patch. 

==========
--- linux-2.5.59a/drivers/md/linear.c	Thu Jan 16 20:22:04 2003
+++ linux-2.5.59b/drivers/md/linear.c	Fri Jan 31 15:00:48 2003
@@ -111,6 +111,9 @@
 	}
 
 	{
+#if __GNUC__ < 3
+		volatile
+#endif
 		sector_t sz = md_size[mdidx(mddev)];
 		unsigned round = sector_div(sz, conf->smallest->size);
 		nb_zone = conf->nr_zones = sz + (round ? 1 : 0);
==========

I believe I found it in the lkml archives, but...I have no idea if this
is the correct fix. I also get a very similar error in fs/readdir.c:

==========
make -f scripts/Makefile.build obj=fs
  gcc -Wp,-MD,fs/.readdir.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -g -nostdinc -iwithprefix include    -DKBUILD_BASENAME=readdir -DKBUILD_MODNAME=readdir   -c -o fs/readdir.o fs/readdir.c
fs/readdir.c: In function `filldir64':
fs/readdir.c:242: internal error--unrecognizable insn:
(insn 184 183 657 (set (reg/v:SI 4 %esi)
        (asm_operands/v ("1:	movl %%eax,0(%2)
2:	movl %%edx,4(%2)
3:
.section .fixup,"ax"
4:	movl %3,%0
	jmp 3b
.previous
.section __ex_table,"a"
	.align 4
	.long 1b,4b
	.long 2b,4b
.previous") ("=r") 0[ 
                (reg:DI 1 %edx)
                (reg:SI 0 %eax)
                (const_int -14 [0xfffffff2])
                (reg/v:SI 4 %esi)
            ] 
            [ 
                (asm_input:DI ("A"))
                (asm_input:SI ("r"))
                (asm_input:SI ("i"))
                (asm_input:SI ("0"))
            ]  ("fs/readdir.c") 226)) -1 (insn_list 181 (insn_list 183 (nil)))
    (nil))
make[1]: *** [fs/readdir.o] Error 1
make: *** [fs] Error 2
==========

which I've managed to fix with this patch:

==========
--- linux-2.5.59a/fs/readdir.c	Thu Jan 16 20:22:08 2003
+++ linux-2.5.59b/fs/readdir.c	Fri Jan 31 15:00:25 2003
@@ -216,14 +216,14 @@
 		return -EINVAL;
 	dirent = buf->previous;
 	if (dirent) {
-		if (__put_user(offset, &dirent->d_off))
+		if (put_user(offset, &dirent->d_off))
 			goto efault;
 	}
 	dirent = buf->current_dir;
 	buf->previous = dirent;
-	if (__put_user(ino, &dirent->d_ino))
+	if (put_user(ino, &dirent->d_ino))
 		goto efault;
-	if (__put_user(0, &dirent->d_off))
+	if (put_user(0, &dirent->d_off))
 		goto efault;
 	if (__put_user(reclen, &dirent->d_reclen))
 		goto efault;
@@ -268,9 +268,12 @@
 	error = buf.error;
 	lastdirent = buf.previous;
 	if (lastdirent) {
+#if __GNUC__ < 3
+		volatile
+#endif
 		struct linux_dirent64 d;
 		d.d_off = file->f_pos;
-		__put_user(d.d_off, &lastdirent->d_off);
+		put_user(d.d_off, &lastdirent->d_off);
 		error = count - buf.count;
 	}
 
==========

I'm using gcc 2.95.2. It looks to me like there is a problem with
gcc handling certain 64-bit data fields.

Anyone else seeing these errors? Any comments on the validity of
the above patches?

Thanks,
-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
