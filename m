Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268285AbUIWF0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268285AbUIWF0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 01:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268289AbUIWF0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 01:26:49 -0400
Received: from relay.pair.com ([209.68.1.20]:64525 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S268285AbUIWF0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 01:26:32 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <41525E05.7020506@kegel.com>
Date: Wed, 22 Sep 2004 22:24:21 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       arjanv@redhat.com
Subject: Re: 2.6.8 link failure for powerpc-970?
References: <414E93BC.4080107@kegel.com> <1095669339.2800.3.camel@laptop.fenrus.com> <4150EF69.1060007@kegel.com> <4151AB3D.3040003@kegel.com> <20040922222723.GD30109@MAIL.13thfloor.at>
In-Reply-To: <20040922222723.GD30109@MAIL.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
>>>arch/ppc64/kernel/built-in.o(.text+0xdc44): In function `.sys32_ipc':
>>>: undefined reference to `.compat_sys_shmctl'
>>>...
>>
>>Could it be a config problem?  My config file was from 'allnoconfig', I 
>>think, and has
>>$ egrep 'SYSV|COMPAT' .config
>>CONFIG_COMPAT=y
>># CONFIG_SYSVIPC is not set
>>compat_sys_shmctl is in ipc/compat.c, and is enabled by 
>>CONFIG_SYSVIPC_COMPAT,
>>which depends on CONFIG_SYSVIPC, which is off. ...
>>Seems like linking problems are expected unless you turn on
>>CONFIG_SYSVIPC and CONFIG_SYSVIPC_COMPAT.
> 
 > once you figured out what 'default' configs
 > are appropriate for the special archs not working
 > with allyes/noconfig could you send me a note
 > and/or post a link to them somewhere?

Sure.  For ppc64, beyond allnoconfig, I had to enable

CONFIG_SYSVIPC
CONFIG_SYSCTL
CONFIG_NET
... um, but that didn't fix everything.  Now it fails with

...
make -f scripts/Makefile.build obj=arch/ppc64/boot arch/ppc64/boot/zImage
   gzip -f -9 < vmlinux > arch/ppc64/boot/kernel-vmlinux.gz
touch arch/ppc64/boot/kernel-vmlinux.c
   gcc -Wp,-MD,arch/ppc64/boot/.kernel-vmlinux.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -Iinclude -fno-builtin  -c -o arch/ppc64/boot/kernel-vmlinux.o arch/ppc64/boot/kernel-vmlinux.c
objcopy  arch/ppc64/boot/kernel-vmlinux.o --add-section=.kernel:vmlinux=arch/ppc64/boot/kernel-vmlinux.gz --set-section-flags=.kernel:vmlinux=contents,alloc,load,readonly,data
   gzip -f -9 < .config > arch/ppc64/boot/kernel-.config.gz
touch arch/ppc64/boot/kernel-.config.c
   gcc -Wp,-MD,arch/ppc64/boot/.kernel-.config.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -Iinclude -fno-builtin  -c -o arch/ppc64/boot/kernel-.config.o arch/ppc64/boot/kernel-.config.c
objcopy  arch/ppc64/boot/kernel-.config.o --add-section=.kernel:.config=arch/ppc64/boot/kernel-.config.gz --set-section-flags=.kernel:.config=contents,alloc,load,readonly,data
   gzip -f -9 < System.map > arch/ppc64/boot/kernel-System.map.gz
touch arch/ppc64/boot/kernel-System.map.c
   gcc -Wp,-MD,arch/ppc64/boot/.kernel-System.map.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -Iinclude -fno-builtin  -c -o arch/ppc64/boot/kernel-System.map.o arch/ppc64/boot/kernel-System.map.c
objcopy  arch/ppc64/boot/kernel-System.map.o --add-section=.kernel:System.map=arch/ppc64/boot/kernel-System.map.gz --set-section-flags=.kernel:System.map=contents,alloc,load,readonly,data

gcc -Wp,-MD,arch/ppc64/boot/.crt0.o.d -D__ASSEMBLY__ -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -Iinclude -fno-builtin  -traditional -c -o arch/ppc64/boot/crt0.o arch/ppc64/boot/crt0.S

arch/ppc64/boot/crt0.S: Assembler messages:
arch/ppc64/boot/crt0.S:17: Error: no such instruction: `lis 9,_start@h'
...

Um, why is it using the host's gcc?  I ran make with
make V=1 ARCH=ppc64 CROSS_COMPILE=/opt/crosstool/powerpc64-unknown-linux-gnu/gcc-3.4.2-glibc-2.3.3/bin/powerpc64-unknown-linux-gnu-
so it really should know better, shouldn't it?

I'm too sleepy to figure this out at the moment.
Thanks for any tips ("I'm programming... while I sleep")!
- Dan


-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
