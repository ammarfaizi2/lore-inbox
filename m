Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWBGGlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWBGGlG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 01:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWBGGlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 01:41:06 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:58333 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932439AbWBGGlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 01:41:04 -0500
Date: Tue, 7 Feb 2006 17:40:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org, ak@suse.de,
       linuxppc64-dev@ozlabs.org, paulus@samba.org
Subject: Re: [PATCH] compat: add compat functions for *at syscalls
Message-Id: <20060207174017.5e3b0ce0.sfr@canb.auug.org.au>
In-Reply-To: <20060206.160140.59716704.davem@davemloft.net>
References: <20060207105631.39a1080c.sfr@canb.auug.org.au>
	<20060206.160140.59716704.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__7_Feb_2006_17_40_17_+1100_vv37rgNvp=ri.2En"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__7_Feb_2006_17_40_17_+1100_vv37rgNvp=ri.2En
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 06 Feb 2006 16:01:40 -0800 (PST) "David S. Miller" <davem@davemloft=
.net> wrote:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 7 Feb 2006 10:56:31 +1100
>=20
> > This adds compat version of all the remaining *at syscalls
> > so that the "dfd" arguments can be properly sign extended.
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>=20
> I do the sign extension with tiny stubs in arch/sparc64/kernel/sys32.S
> so that the arg frobbing does not consume a stack frame, which is what
> happens if you do this in C code.
>=20
> We need to revisit this at some point and make a way for all
> compat platforms to do this with a portable table of some kind
> that expands a bunch of macros defined by the platform.

How about the following (modifiying Linus' suggestion and copying what
sparc64 already does)?

The assumption is that all arguments have been zero extended by the compat
syscall entry code, so we just sign extend those that need it.

I am not sure of the sparc64 code below, s390 doesn't seem to follow our
"all arguments are zero extended" assumption and x86_64 may not need any
of these wrappers anyway.

It may be that we would be better following Linus's suggestion of
generating stubs for all of the compat syscalls.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

Subject: [PATCH] compat: introduce kernel/compat_wrapper.S

and the necessary compat_wrapper.h with implementations
for powerpc and sparc64.

compat_wrapper.S builds wrappers for those syscalls that
require sign extension for some of their arguments.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

---

 arch/sparc64/kernel/systbls.S        |    6 +++---
 include/asm-ia64/compat_wrapper.h    |   15 +++++++++++++++
 include/asm-mips/compat_wrapper.h    |   15 +++++++++++++++
 include/asm-parisc/compat_wrapper.h  |   15 +++++++++++++++
 include/asm-powerpc/compat_wrapper.h |   28 ++++++++++++++++++++++++++++
 include/asm-s390/compat_wrapper.h    |   15 +++++++++++++++
 include/asm-sparc64/compat_wrapper.h |   33 ++++++++++++++++++++++++++++++=
+++
 include/asm-x86_64/compat_wrapper.h  |   15 +++++++++++++++
 include/linux/compat.h               |   22 ++++++++++++++++++++++
 kernel/Makefile                      |    2 +-
 kernel/compat_wrapper.S              |   18 ++++++++++++++++++
 11 files changed, 180 insertions(+), 4 deletions(-)
 create mode 100644 include/asm-ia64/compat_wrapper.h
 create mode 100644 include/asm-mips/compat_wrapper.h
 create mode 100644 include/asm-parisc/compat_wrapper.h
 create mode 100644 include/asm-powerpc/compat_wrapper.h
 create mode 100644 include/asm-s390/compat_wrapper.h
 create mode 100644 include/asm-sparc64/compat_wrapper.h
 create mode 100644 include/asm-x86_64/compat_wrapper.h
 create mode 100644 kernel/compat_wrapper.S

1cffeae9ae628af849952cf90fbfca1d98befb97
diff --git a/arch/sparc64/kernel/systbls.S b/arch/sparc64/kernel/systbls.S
index 2881faf..a2cc631 100644
--- a/arch/sparc64/kernel/systbls.S
+++ b/arch/sparc64/kernel/systbls.S
@@ -77,9 +77,9 @@ sys_call_table32:
 /*270*/	.word sys32_io_submit, sys_io_cancel, compat_sys_io_getevents, sys=
32_mq_open, sys_mq_unlink
 	.word compat_sys_mq_timedsend, compat_sys_mq_timedreceive, compat_sys_mq_=
notify, compat_sys_mq_getsetattr, compat_sys_waitid
 /*280*/	.word sys_ni_syscall, sys_add_key, sys_request_key, sys_keyctl, co=
mpat_sys_openat
-	.word sys_mkdirat, sys_mknodat, sys_fchownat, compat_sys_futimesat, compa=
t_sys_newfstatat
-/*285*/	.word sys_unlinkat, sys_renameat, sys_linkat, sys_symlinkat, sys_r=
eadlinkat
-	.word sys_fchmodat, sys_faccessat, compat_sys_pselect6, compat_sys_ppoll
+	.word compat_sys_mkdirat, compat_sys_mknodat, compat_sys_fchownat, compat=
_sys_futimesat, compat_sys_newfstatat
+/*285*/	.word compat_sys_unlinkat, compat_sys_renameat, compat_sys_linkat,=
 compat_sys_symlinkat, compat_sys_readlinkat
+	.word compat_sys_fchmodat, compat_sys_faccessat, compat_sys_pselect6, com=
pat_sys_ppoll
=20
 #endif /* CONFIG_COMPAT */
=20
diff --git a/include/asm-ia64/compat_wrapper.h b/include/asm-ia64/compat_wr=
apper.h
new file mode 100644
index 0000000..f82befc
--- /dev/null
+++ b/include/asm-ia64/compat_wrapper.h
@@ -0,0 +1,15 @@
+/*
+ * Definitions used to generate the sign extending stubs
+ * for compat syscalls
+ */
+
+#define ARG1
+#define ARG2
+#define ARG3
+#define ARG4
+#define ARG5
+#define ARG6
+
+#define compat_fn1(fn, arg)
+
+#define compat_fn2(fn, arg1, arg2)
diff --git a/include/asm-mips/compat_wrapper.h b/include/asm-mips/compat_wr=
apper.h
new file mode 100644
index 0000000..f82befc
--- /dev/null
+++ b/include/asm-mips/compat_wrapper.h
@@ -0,0 +1,15 @@
+/*
+ * Definitions used to generate the sign extending stubs
+ * for compat syscalls
+ */
+
+#define ARG1
+#define ARG2
+#define ARG3
+#define ARG4
+#define ARG5
+#define ARG6
+
+#define compat_fn1(fn, arg)
+
+#define compat_fn2(fn, arg1, arg2)
diff --git a/include/asm-parisc/compat_wrapper.h b/include/asm-parisc/compa=
t_wrapper.h
new file mode 100644
index 0000000..f82befc
--- /dev/null
+++ b/include/asm-parisc/compat_wrapper.h
@@ -0,0 +1,15 @@
+/*
+ * Definitions used to generate the sign extending stubs
+ * for compat syscalls
+ */
+
+#define ARG1
+#define ARG2
+#define ARG3
+#define ARG4
+#define ARG5
+#define ARG6
+
+#define compat_fn1(fn, arg)
+
+#define compat_fn2(fn, arg1, arg2)
diff --git a/include/asm-powerpc/compat_wrapper.h b/include/asm-powerpc/com=
pat_wrapper.h
new file mode 100644
index 0000000..9bc0669
--- /dev/null
+++ b/include/asm-powerpc/compat_wrapper.h
@@ -0,0 +1,28 @@
+/*
+ * Definitions used to generate the sign extending stubs
+ * for compat syscalls
+ *
+ * Copyright (C) 2006 Stephen Rothwell, IBM Corp
+ */
+
+#define ARG1	%r3
+#define ARG2	%r4
+#define ARG3	%r5
+#define ARG4	%r6
+#define ARG5	%r7
+#define ARG6	%r8
+
+#define compat_fn1(fn, arg)		\
+	.text;				\
+	.global	.compat_sys_ ## fn;	\
+.compat_sys_ ## fn:			\
+	extsw	arg, arg;		\
+	b	.sys_ ## fn
+
+#define compat_fn2(fn, arg1, arg2)	\
+	.text;				\
+	.global	.compat_sys_ ## fn;	\
+.compat_sys_ ## fn:			\
+	extsw	arg1, arg1;		\
+	extsw	arg2, arg2;		\
+	b	.sys_ ## fn
diff --git a/include/asm-s390/compat_wrapper.h b/include/asm-s390/compat_wr=
apper.h
new file mode 100644
index 0000000..f82befc
--- /dev/null
+++ b/include/asm-s390/compat_wrapper.h
@@ -0,0 +1,15 @@
+/*
+ * Definitions used to generate the sign extending stubs
+ * for compat syscalls
+ */
+
+#define ARG1
+#define ARG2
+#define ARG3
+#define ARG4
+#define ARG5
+#define ARG6
+
+#define compat_fn1(fn, arg)
+
+#define compat_fn2(fn, arg1, arg2)
diff --git a/include/asm-sparc64/compat_wrapper.h b/include/asm-sparc64/com=
pat_wrapper.h
new file mode 100644
index 0000000..42afb2c
--- /dev/null
+++ b/include/asm-sparc64/compat_wrapper.h
@@ -0,0 +1,33 @@
+/*
+ * Definitions used to generate the sign extending stubs
+ * for compat syscalls
+ *
+ * Copyright (C) 2006 Stephen Rothwell, IBM Corp
+ * Based on arch/sparc64/kernel/sys32.S
+ */
+
+#define ARG1	%o0
+#define ARG2	%o1
+#define ARG3	%o2
+#define ARG4	%o3
+#define ARG5	%o4
+#define ARG6	%o5
+
+#define compat_fn1(fn, arg)			\
+	.text;					\
+	.align	32;				\
+	.globl	compat_sys_ ## fn;		\
+compat_sys_ ## fn:				\
+	sethi	%hi(sys_ ## fn), %g1;		\
+	jmpl	%g1 + %lo(sys_ ## fn), %g0;	\
+	sra	arg, 0, arg
+
+#define compat_fn2(fn, arg1, arg2)		\
+	.text;					\
+	.align	32;				\
+	.globl	compat_sys_ ## fn;		\
+compat_sys_ ## fn:				\
+	sethi	%hi(sys_ ## fn), %g1;		\
+	sra	arg1, 0, arg1;			\
+	jmpl	%g1 + %lo(sys_ ## fn), %g0;	\
+	sra	arg2, 0, arg2
diff --git a/include/asm-x86_64/compat_wrapper.h b/include/asm-x86_64/compa=
t_wrapper.h
new file mode 100644
index 0000000..f82befc
--- /dev/null
+++ b/include/asm-x86_64/compat_wrapper.h
@@ -0,0 +1,15 @@
+/*
+ * Definitions used to generate the sign extending stubs
+ * for compat syscalls
+ */
+
+#define ARG1
+#define ARG2
+#define ARG3
+#define ARG4
+#define ARG5
+#define ARG6
+
+#define compat_fn1(fn, arg)
+
+#define compat_fn2(fn, arg1, arg2)
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 2d7e7f1..b501201 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -168,6 +168,28 @@ asmlinkage long compat_sys_newfstatat(un
 				      int flag);
 asmlinkage long compat_sys_openat(unsigned int dfd, const char __user *fil=
ename,
 				   int flags, int mode);
+asmlinkage long compat_sys_mkdirat(unsigned int dfd,
+		const char __user * pathname, int mode);
+asmlinkage long compat_sys_mknodat(unsigned int dfd,
+		const char __user *filename, int mode, unsigned dev);
+asmlinkage long compat_sys_fchownat(unsigned int dfd,
+		const char __user *filename, uid_t user, gid_t group, int flag);
+asmlinkage long compat_sys_unlinkat(unsigned int dfd,
+		const char __user *pathname, int flag);
+asmlinkage long compat_sys_renameat(unsigned int olddfd,
+		const char __user *oldname, unsigned int newdfd,
+		const char __user *newname);
+asmlinkage long compat_sys_linkat(unsigned int olddfd,
+		const char __user *oldname, unsigned int newdfd,
+		const char __user *newname);
+asmlinkage long compat_sys_symlinkat(const char __user *oldname,
+		unsigned int newdfd, const char __user *newname);
+asmlinkage long compat_sys_readlinkat(unsigned int dfd,
+		const char __user *path, char __user *buf, int bufsiz);
+asmlinkage long compat_sys_fchmodat(unsigned int dfd,
+		const char __user *filename, mode_t mode);
+asmlinkage long compat_sys_faccessat(unsigned int dfd,
+		const char __user *filename, int mode);
=20
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 4ae0fbd..a0679c4 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_KALLSYMS) +=3D kallsyms.o
 obj-$(CONFIG_PM) +=3D power/
 obj-$(CONFIG_BSD_PROCESS_ACCT) +=3D acct.o
 obj-$(CONFIG_KEXEC) +=3D kexec.o
-obj-$(CONFIG_COMPAT) +=3D compat.o
+obj-$(CONFIG_COMPAT) +=3D compat.o compat_wrapper.o
 obj-$(CONFIG_CPUSETS) +=3D cpuset.o
 obj-$(CONFIG_IKCONFIG) +=3D configs.o
 obj-$(CONFIG_STOP_MACHINE) +=3D stop_machine.o
diff --git a/kernel/compat_wrapper.S b/kernel/compat_wrapper.S
new file mode 100644
index 0000000..da009eb
--- /dev/null
+++ b/kernel/compat_wrapper.S
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2006 Stephen Rothwell, IBM Corp
+ *
+ * this file will generate compat_ wrapper functions for
+ * syscalls that need sign extension for some of their arguments
+ */
+#include <asm/compat_wrapper.h>
+
+compat_fn1(mkdirat, ARG1)
+compat_fn1(mknodat, ARG1)
+compat_fn1(fchownat, ARG1)
+compat_fn1(unlinkat, ARG1)
+compat_fn2(renameat, ARG1, ARG3)
+compat_fn2(linkat, ARG1, ARG3)
+compat_fn1(symlinkat, ARG2)
+compat_fn1(readlinkat, ARG1)
+compat_fn1(fchmodat, ARG1)
+compat_fn1(faccessat, ARG1)
--=20
1.1.5

--Signature=_Tue__7_Feb_2006_17_40_17_+1100_vv37rgNvp=ri.2En
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD6EDRFdBgD/zoJvwRAlbfAJ42PJY+ztnGoYMrLPTMzJAp2/dHfQCfQAmZ
i5rpgmlx01GAzB3/KzMAOcQ=
=k02l
-----END PGP SIGNATURE-----

--Signature=_Tue__7_Feb_2006_17_40_17_+1100_vv37rgNvp=ri.2En--
