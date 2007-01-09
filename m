Return-Path: <linux-kernel-owner+w=401wt.eu-S932374AbXAIVzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbXAIVzb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 16:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbXAIVza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 16:55:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:24556 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932374AbXAIVza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 16:55:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=A2XN9udD6QUDgl0/42idj9YYTAZgLTzSLdde91H+7R47RkrdEMJj3net5HstzZUh1S9RPgxB7zP0iRCDyItVT9G43E1WGe4ahB7oR0UX3kJh+hq4utCdmthlUvoHVW+I49/PcW2+RTJL9oYMBllJTNH712uHbXkHlChN3ptuOqc=
Date: Tue, 9 Jan 2007 22:55:27 +0100
From: Luca Tettamanti <kronos.it@gmail.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@germaschewski.name>,
       linux-kernel@vger.kernel.org
Subject: Re: .version keeps being updated
Message-ID: <20070109215527.GA24318@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109102057.c684cc78.khali@linux-fr.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <khali@linux-fr.org> ha scritto:
> Hi all,

Hi Jean,

> Since 2.6.20-rc1 or so, running "make" always builds a new kernel with
> an incremented version number, whether there has actually been any
> change done to the code or configuration or not. This increases the
> build time quite a bit.
> 
> I've tracked it down to include/linux/compile.h always being updated,
> and this is because .version is updated. I couldn't find what is
> causing .version to be updated each time though. Can anybody help
> there? Was this change made on purpose or is this a bug which we should
> fix?

kronos:~/src/linux-2.6.git$ cat ../linux-build-git/include/linux/compile.h
/* This file is auto generated, version 14 */
/* SMP PREEMPT */
#define UTS_MACHINE "i386"
#define UTS_VERSION "#14 SMP PREEMPT Tue Jan 9 22:45:18 CET 2007"
#define LINUX_COMPILE_TIME "22:45:18"
#define LINUX_COMPILE_BY "kronos"
#define LINUX_COMPILE_HOST "dreamland.darkstar.lan"
#define LINUX_COMPILE_DOMAIN "darkstar.lan"
#define LINUX_COMPILER "gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-20)"

LINUX_COMPILE_TIME and UTS_VERSION differs at each rebuild. UTS_VERSION
is responsible of rebuilding fs/proc/proc_misc.o; init/main.o uses just
about everything, init/version.o requires UTS_VERSION.

I don't think it's a regression from earlier kernels though, is it?

kronos:~/src/linux-2.6.git$ make -j3 V=2 O=../linux-build-git/
  GEN     /home/kronos/src/linux-build-git/Makefile
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     include/linux/utsrelease.h
  Using /home/kronos/src/linux-2.6.git as source for kernel
  UPD     include/linux/compile.h
  CC      init/main.o - due to: include/linux/compile.h
  CC      init/version.o - due to: include/linux/compile.h
  LD      init/built-in.o - due to: init/main.o init/version.o
  CC      fs/proc/proc_misc.o - due to: include/linux/compile.h
  LD      fs/proc/proc.o - due to: fs/proc/proc_misc.o
  LD      fs/proc/built-in.o - due to: fs/proc/proc.o
  LD      fs/built-in.o - due to: fs/proc/built-in.o
  GEN     .version - due to: init/built-in.o fs/built-in.o
  LD      .tmp_vmlinux1 - due to: init/built-in.o fs/built-in.o
  KSYM    .tmp_kallsyms1.S - due to: .tmp_vmlinux1
  AS      .tmp_kallsyms1.o - due to: .tmp_kallsyms1.S
  LD      .tmp_vmlinux2 - due to: init/built-in.o fs/built-in.o .tmp_kallsyms1.o
  KSYM    .tmp_kallsyms2.S - due to: .tmp_vmlinux2
  AS      .tmp_kallsyms2.o - due to: .tmp_kallsyms2.S
  LD      vmlinux - due to: init/built-in.o fs/built-in.o .tmp_kallsyms2.o
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
  MODPOST vmlinux - due to vmlinux not in $(targets)
  Building modules, stage 2.
  AS      arch/i386/boot/setup.o - due to: include/linux/compile.h
  OBJCOPY arch/i386/boot/compressed/vmlinux.bin - due to: vmlinux
  GZIP    arch/i386/boot/compressed/vmlinux.bin.gz - due to: arch/i386/boot/compressed/vmlinux.bin
  MODPOST 130 modules - due to target is PHONY
  LD      arch/i386/boot/compressed/piggy.o - due to: arch/i386/boot/compressed/vmlinux.bin.gz
  LD      arch/i386/boot/compressed/vmlinux - due to: arch/i386/boot/compressed/piggy.o
  LD      arch/i386/boot/setup - due to: arch/i386/boot/setup.o
  OBJCOPY arch/i386/boot/vmlinux.bin - due to: arch/i386/boot/compressed/vmlinux
  BUILD   arch/i386/boot/bzImage - due to: arch/i386/boot/setup arch/i386/boot/vmlinux.bin
Root device is (254, 0)
Boot sector 512 bytes.
Setup is 6959 bytes.
System is 1567 kB
Kernel: arch/i386/boot/bzImage is ready  (#16)

Luca
-- 
La somma dell'intelligenza sulla terra e` una costante.
La popolazione e` in aumento.
