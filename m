Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbVF2KHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVF2KHL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 06:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVF2KHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 06:07:11 -0400
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:27659 "EHLO
	smtp-vbr12.xs4all.nl") by vger.kernel.org with ESMTP
	id S262490AbVF2KG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 06:06:59 -0400
Message-ID: <8824.192.87.1.200.1120039619.squirrel@192.87.1.200>
In-Reply-To: <20050629083452.GC3771@in.ibm.com>
References: <20050624200916.GJ6656@stusta.de>
    <20050624132826.4cdfb63c.akpm@osdl.org>
    <20050627132941.GD3764@in.ibm.com>
    <20050627140029.GB29121@nevyn.them.org>
    <20050628045111.GB4296@in.ibm.com> <20050628112412.GB5652@in.ibm.com>
    <200506281959.j5SJxaeM022138@elgar.sibelius.xs4all.nl>
    <20050629083452.GC3771@in.ibm.com>
Date: Wed, 29 Jun 2005 12:06:59 +0200 (CEST)
Subject: Re: [Fastboot] Re: [-mm patch] i386: enable REGPARM by default
From: "Mark Kettenis" <mark.kettenis@xs4all.nl>
To: vgoyal@in.ibm.com
Cc: gdb@sources.redhat.com, dan@debian.org, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, bunk@stusta.de,
       alexn@dsv.su.se
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jun 28, 2005 at 09:59:36PM +0200, Mark Kettenis wrote:
>>    Date: Tue, 28 Jun 2005 16:54:12 +0530
>>    From: Vivek Goyal <vgoyal@in.ibm.com>
>>
>>    > Thanks. Any idea what might be amiss with my case where I am not
>> seeing
>>    > proper function parameter values while analyzing kdump generated
>> crash
>>    > dump with gdb. I am using following gdb and gcc versions.
>>    >
>>    > GNU gdb Red Hat Linux (6.1post-1.20040607.62rh)
>>    > gcc (GCC) 3.4.3 20041212 (Red Hat 3.4.3-9.EL4)
>>    >
>>
>>    Some more info. I dumped the stack contents and it seems that stack
>> is fine
>>    and parameters are intact on stack. So now it seems to be a matter of
>>    how gdb is interpreting the stack contents. Any guess, what the
>> problem is?
>>
>> I'd say the problem is with a user building stuff with non-standard
>> "optimizations", probably even stripping his executable, and expecting
>> to be able to debug the result.
>>
>>    Why func2() and func1() are not showing right parameter values.
>>
>
>
> In this case I am building linux kernel with debug info (-g) and -mregparm
> is not specified. So parameters should be passed on stack. Following
> is the effective command line to build kernel/sysfs.c. I am not sure if
> any of the below mentioned options are going to affect the gdb results.
>
>   gcc -m32 -Wp,-MD,kernel/.ksysfs.o.d  -nostdinc -isystem
> /usr/lib/gcc/i386-redhat-linux/3.4.3/include -D__KERNEL__ -Iinclude
> -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
> -fno-common -ffreestanding -O2     -fomit-frame-pointer -g -pipe
> -msoft-float -mpreferred-stack-boundary=2 -fno-unit-at-a-time
> -march=i686 -mtune=pentium4 -Iinclude/asm-i386/mach-default
> -Wdeclaration-after-statement     -DKBUILD_BASENAME=ksysfs
> -DKBUILD_MODNAME=ksysfs -c -o kernel/ksysfs.o kernel/ksysfs.c

-O2 will have some effect.  The compiler might optimize away variables
(including function arguments) and doesn't always record that fact in
the debug information.

But the real killer here is probably -fomit-frame-pointer.  Last time I
looked GCC didn't generate the correct debug information in that case.
I didn't really look into this, but it seemed as if GCC blindly produces
location descriptions relative to the frame pointer even though there no
longer is a frame pointer.  GCC 4.0 or 4.1 might have this fixed.

>
>> Repeating what Daniel said before, by using "regparm", function
>> arguments are now passed in registers instead of on the stack.  It's
>> extremely unlikely that these function arguments will stay in those
>> registers for ever, especially since you've only got a handfull of
>> them on the i386.
>
> Sorry for the confusion. In the last mail all the results were reported
> with REGPARM disabled. I wanted to make sure that first normal case works
> fine and then discuss the REGPARM case later.

If you're prepared to do some more tests, you might want to check out
what happens if you leave out -O2 and -fomit-frame-pointer, and then add
back only -O2

Mark

