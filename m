Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932922AbWJIRpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932922AbWJIRpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 13:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932994AbWJIRpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 13:45:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56032 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932922AbWJIRpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 13:45:38 -0400
Date: Mon, 9 Oct 2006 10:45:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Drynoff <pauldrynoff@gmail.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [BUG]: can not compile 2.6.19-rc1: 'boot_cpu_data' undeclared
Message-Id: <20061009104527.079fe63b.akpm@osdl.org>
In-Reply-To: <20061009135441.1ae38233.pauldrynoff@gmail.com>
References: <20061009135441.1ae38233.pauldrynoff@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006 13:54:41 +0400
Paul Drynoff <pauldrynoff@gmail.com> wrote:

> I update kernel to patch-2.6.19-rc1-git, but problem still here.
> __acpi_acquire_global_lock uses cmpxchg it uses struct cpuinfo_x86,
> but it not defined, and if include asmp/processor.h where it defined,
> this cause another problems of compilation. Any ideas?
> 
> 
> 
> Date: Sun, 8 Oct 2006 20:28:01 +0400
> From: Paul Drynoff <pauldrynoff@gmail.com>
> To: linux-kernel@vger.kernel.org
> Subject: [BUG]: can not compile 2.6.19-rc1: 'boot_cpu_data' undeclared
> 
> 
> $ make
>  CHK     include/linux/version.h
>  CHK     include/linux/utsrelease.h
>  CHK     include/linux/compile.h
>  CC      arch/i386/mach-generic/probe.o
> In file included from include/asm/fixmap.h:30,
>                 from arch/i386/mach-generic/probe.c:13:
> include/asm/acpi.h: In function '__acpi_acquire_global_lock':
> include/asm/acpi.h:67: error: 'boot_cpu_data' undeclared (first use
> in this function)
> include/asm/acpi.h:67: error: (Each undeclared identifier is reported
> only once
> include/asm/acpi.h:67: error: for each function it appears in.)
> include/asm/acpi.h: In function '__acpi_release_global_lock':
> include/asm/acpi.h:79: error: 'boot_cpu_data' undeclared (first use
> in this function)

I suspect the problem is:

CONFIG_M386=y

which makes the support of cmpxchg do complex things.  But it _should_
work.

Still, it makes sense to uninline those ACPI locking functions.  I haven't
yet checked to see if these functions need exporting to modules.

Note that with this patch and your .config, we get

arch/i386/kernel/acpi/boot.c:91:2: warning: #warning ACPI uses CMPXCHG, i486 and later hardware


From: Andrew Morton <akpm@osdl.org>

- Fixes a build problem with CONFIG_M386=y (include file dependenciers get
  messy).

- Share the implementation between x86 and x86_64

- These are too big to inline anyway.

Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/acpi/boot.c |   22 ++++++++++++++++++++++
 include/asm-i386/acpi.h      |   26 ++------------------------
 include/asm-x86_64/acpi.h    |   26 ++------------------------
 3 files changed, 26 insertions(+), 48 deletions(-)

diff -puN arch/i386/kernel/acpi/boot.c~i386-acpi-build-fix arch/i386/kernel/acpi/boot.c
--- a/arch/i386/kernel/acpi/boot.c~i386-acpi-build-fix
+++ a/arch/i386/kernel/acpi/boot.c
@@ -1319,3 +1319,25 @@ static int __init setup_acpi_sci(char *s
 	return 0;
 }
 early_param("acpi_sci", setup_acpi_sci);
+
+int __acpi_acquire_global_lock(unsigned int *lock)
+{
+	unsigned int old, new, val;
+	do {
+		old = *lock;
+		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
+		val = cmpxchg(lock, old, new);
+	} while (unlikely (val != old));
+	return (new < 3) ? -1 : 0;
+}
+
+int __acpi_release_global_lock(unsigned int *lock)
+{
+	unsigned int old, new, val;
+	do {
+		old = *lock;
+		new = old & ~0x3;
+		val = cmpxchg(lock, old, new);
+	} while (unlikely (val != old));
+	return old & 0x1;
+}
diff -puN include/asm-i386/acpi.h~i386-acpi-build-fix include/asm-i386/acpi.h
--- a/include/asm-i386/acpi.h~i386-acpi-build-fix
+++ a/include/asm-i386/acpi.h
@@ -56,30 +56,8 @@
 #define ACPI_ENABLE_IRQS()  local_irq_enable()
 #define ACPI_FLUSH_CPU_CACHE()	wbinvd()
 
-
-static inline int
-__acpi_acquire_global_lock (unsigned int *lock)
-{
-	unsigned int old, new, val;
-	do {
-		old = *lock;
-		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
-		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
-	return (new < 3) ? -1 : 0;
-}
-
-static inline int
-__acpi_release_global_lock (unsigned int *lock)
-{
-	unsigned int old, new, val;
-	do {
-		old = *lock;
-		new = old & ~0x3;
-		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
-	return old & 0x1;
-}
+int __acpi_acquire_global_lock(unsigned int *lock);
+int __acpi_release_global_lock(unsigned int *lock);
 
 #define ACPI_ACQUIRE_GLOBAL_LOCK(GLptr, Acq) \
 	((Acq) = __acpi_acquire_global_lock((unsigned int *) GLptr))
diff -puN include/asm-x86_64/acpi.h~i386-acpi-build-fix include/asm-x86_64/acpi.h
--- a/include/asm-x86_64/acpi.h~i386-acpi-build-fix
+++ a/include/asm-x86_64/acpi.h
@@ -54,30 +54,8 @@
 #define ACPI_ENABLE_IRQS()  local_irq_enable()
 #define ACPI_FLUSH_CPU_CACHE()	wbinvd()
 
-
-static inline int
-__acpi_acquire_global_lock (unsigned int *lock)
-{
-	unsigned int old, new, val;
-	do {
-		old = *lock;
-		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
-		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
-	return (new < 3) ? -1 : 0;
-}
-
-static inline int
-__acpi_release_global_lock (unsigned int *lock)
-{
-	unsigned int old, new, val;
-	do {
-		old = *lock;
-		new = old & ~0x3;
-		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
-	return old & 0x1;
-}
+int __acpi_acquire_global_lock(unsigned int *lock);
+int __acpi_release_global_lock(unsigned int *lock);
 
 #define ACPI_ACQUIRE_GLOBAL_LOCK(GLptr, Acq) \
 	((Acq) = __acpi_acquire_global_lock((unsigned int *) GLptr))
_

