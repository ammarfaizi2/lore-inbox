Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261690AbSI0MXl>; Fri, 27 Sep 2002 08:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261693AbSI0MXl>; Fri, 27 Sep 2002 08:23:41 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:28944 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261690AbSI0MXf>; Fri, 27 Sep 2002 08:23:35 -0400
Message-Id: <200209271224.g8RCOLp09105@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: Re: Does kernel use system stdarg.h?
Date: Fri, 27 Sep 2002 15:18:35 -0200
X-Mailer: KMail [version 1.3.2]
References: <200209270804.g8R84cp08026@Port.imtp.ilyichevsk.odessa.ua> <20020927092647.A7485@flint.arm.linux.org.uk>
In-Reply-To: <20020927092647.A7485@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 September 2002 06:26, Russell King wrote:
> On Fri, Sep 27, 2002 at 10:58:52AM -0200, Denis Vlasenko wrote:
> > make[3]: Entering directory `/usr/src/linux-2.5.36/kernel'
> > gcc -E
> > -Wp,-MD,/usr/src/linux-2.5.36/include/linux/modules/kernel/.exec_domain.v
> >er.d -D__KERNEL__ -I/usr/src/linux-2.5.36/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> > -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> > -march=i486 -nostdinc -iwithprefix include -DKBUILD_BASENAME=exec_domain
> > -D__GENKSYMS__  exec_domain.c | /sbin/genksyms -p smp_ -k 2.5.36 >
> > /usr/src/linux-2.5.36/include/linux/modules/kernel/exec_domain.ver.tmp
> > In file included from exec_domain.c:12:
> > /usr/src/linux-2.5.36/include/linux/kernel.h:10:20: stdarg.h: No such
> > file or directory
> >
> > There is no stdarg.h in kernel tree, should it be there?
> > For now I just copied GCC one into linux/include...
>
> It must be the GCC one.  If your GCC isn't finding it, then you've got a
> broken GCC installation; "-iwithprefix include" tells GCC to look in its
> private include directory for such things.
>
> You could try adding -v to CFLAGS to see where it is searching for
> includes.

This is funny.

t.c
===
#include <stdarg.h>
int main() { return 0; }

# gcc t.c
# ./a.out 
(runs okay)

So it works this way.

But gcc invocation from kernel compile does not work.
Here is its output with -v:
---------------------------
Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/3.0.3/specs
Configured with: ../gcc-3.0.3/configure --prefix=/usr/app/gcc-3.0.3posix --exec-prefix=/usr/app/gcc-3.0.3posix --bindir=/usr/app/gcc-3.0.3posix/bin --libdir=/usr/lib --infodir=/usr/app/gcc-3.0.3posix/info --mandir=/usr/app/gcc-3.0.3posix/man --with-slibdir=/usr/lib --with-local-prefix=/usr/local --with-gxx-include-dir=/usr/include/g++-v3 --enable-threads=posix
Thread model: posix
gcc version 3.0.3
 /usr/lib/gcc-lib/i686-pc-linux-gnu/3.0.3/cpp0 -lang-c -nostdinc -v
                                                       ^^^^^^^^^
-I/usr/src/linux-2.5.36/include
-iprefix /usr/sbin/../../lib/gcc-lib/i686-pc-linux-gnu/3.0.3/
-D__GNUC__=3 -D__GNUC_MINOR__=0 -D__GNUC_PATCHLEVEL__=3 -D__ELF__ -Dunix -Dlinux -D__ELF__ -D__unix__ -D__linux__ -D__unix -D__linux -Asystem=posix -D__OPTIMIZE__ -D__STDC_HOSTED__=1
-Wall -Wstrict-prototypes -Wno-trigraphs -Acpu=i386 -Amachine=i386
-Di386 -D__i386 -D__i386__ -D__i486 -D__i486__ -D__tune_i486__ -D__KERNEL__ -DKBUILD_BASENAME=exec_domain -D__GENKSYMS__ 
-iwithprefix include
-MD /usr/src/linux-2.5.36/include/linux/modules/kernel/.exec_domain.ver.d exec_domain.c
ignoring nonexistent directory "/usr/sbin/../../lib/gcc-lib/i686-pc-linux-gnu/3.0.3/include"
GNU CPP version 3.0.3 (cpplib) (i386 Linux/ELF)
#include "..." search starts here:
#include <...> search starts here:
 /usr/src/linux-2.5.36/include    <------ no system/GCC/glibc paths! :-(
End of search list.
In file included from exec_domain.c:12:
/usr/src/linux-2.5.36/include/linux/kernel.h:10:20: stdarg.h: No such file or directory


Hmm... lets try gcc -v t.c:
---------------------------
Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/3.0.3/specs
Configured with: ../gcc-3.0.3/configure --prefix=/usr/app/gcc-3.0.3posix --exec-prefix=/usr/app/gcc-3.0.3posix --bindir=/usr/app/gcc-3.0.3posix/bin --libdir=/usr/lib --infodir=/usr/app/gcc-3.0.3posix/info --mandir=/usr/app/gcc-3.0.3posix/man --with-slibdir=/usr/lib --with-local-prefix=/usr/local --with-gxx-include-dir=/usr/include/g++-v3 --enable-threads=posix
Thread model: posix
gcc version 3.0.3
 /usr/lib/gcc-lib/i686-pc-linux-gnu/3.0.3/cc1 -lang-c -v
-iprefix /usr/sbin/../../lib/gcc-lib/i686-pc-linux-gnu/3.0.3/
-D__GNUC__=3 -D__GNUC_MINOR__=0 -D__GNUC_PATCHLEVEL__=3 -D__ELF__ -Dunix -Dlinux -D__ELF__ -D__unix__ -D__linux__ -D__unix -D__linux -Asystem=posix -D__NO_INLINE__ -D__STDC_HOSTED__=1 -Acpu=i386 -Amachine=i386 -Di386 -D__i386 -D__i386__ -D__tune_i686__ -D__tune_pentiumpro__
t.c -quiet -dumpbase t.c -version -o /tmp/ccH59JjF.s
GNU CPP version 3.0.3 (cpplib) (i386 Linux/ELF)
GNU C version 3.0.3 (i686-pc-linux-gnu)
        compiled by GNU C version 3.0.3.
ignoring nonexistent directory "/usr/sbin/../../lib/gcc-lib/i686-pc-linux-gnu/3.0.3/include"
ignoring nonexistent directory "/usr/sbin/../../lib/gcc-lib/i686-pc-linux-gnu/3.0.3/../../../../i686-pc-linux-gnu/include"
ignoring nonexistent directory "/usr/local/include"
ignoring nonexistent directory "/usr/lib/gcc-lib/../../i686-pc-linux-gnu/include"
#include "..." search starts here:
#include <...> search starts here:
 /usr/lib/gcc-lib/i686-pc-linux-gnu/3.0.3/include
 /usr/include
End of search list.
 as --traditional-format -V -Qy -o /tmp/cc0GhxK1.o /tmp/ccH59JjF.s
GNU assembler version 2.11.90.0.8 (i686-pc-linux-gnu) using BFD version 2.11.90.0.8
 /usr/lib/gcc-lib/i686-pc-linux-gnu/3.0.3/collect2 -m elf_i386 -dynamic-linker /lib/ld-linux.so.2 /usr/lib/crt1.o /usr/lib/crti.o /usr/lib/gcc-lib/i686-pc-linux-gnu/3.0.3/crtbegin.o -L/usr/lib/gcc-lib/i686-pc-linux-gnu/3.0.3 -L/usr/lib/gcc-lib/i686-pc-linux-gnu/3.0.3/../../.. /tmp/cc0GhxK1.o -lgcc -lc -lgcc /usr/lib/gcc-lib/i686-pc-linux-gnu/3.0.3/crtend.o /usr/lib/crtn.o


Heh. Kernel one contains -nostdinc! See underlined (^^^^^^) above.
Tested it with --nostdinc - it worked.
--
vda
