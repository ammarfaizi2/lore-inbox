Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132114AbQKZD3K>; Sat, 25 Nov 2000 22:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132198AbQKZD3A>; Sat, 25 Nov 2000 22:29:00 -0500
Received: from [209.249.10.20] ([209.249.10.20]:64712 "EHLO
        freya.yggdrasil.com") by vger.kernel.org with ESMTP
        id <S132114AbQKZD2p>; Sat, 25 Nov 2000 22:28:45 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 25 Nov 2000 18:58:43 -0800
Message-Id: <200011260258.SAA02245@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Patch(?): isapnp_card_id tables for all isapnp drivers in 2.4.0-test11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   == Kai Germaschewski
>>  == Keith Owens  
>>> == Adam Richter

>>>	[...] I plan to go
>>>through all of the changes and bracket all of these new tables
>>>with #ifdef MODULE...#endif so they do not result in complaints
>>>about the table being defined static and never used in cases where
>>>the driver is compiled directly into the kernel.

(I have now done this and release the patch at
ftp://ftp.yggdrasil.com/pub/dist/device_control/kernel/.)


>> This is cleaner.  Append MODULE_ONLY after __initdata and remove the
>> ifdef.  It increases the size of initdata in the kernel, compared to
>> ifdef, but since initdata is promptly reused as scratch space it should
>> not be a problem.
[...]
>> +#define MODULE_ONLY		__attribute__ ((unused))

>What about the making MODULE_DEVICE_TABLE reference this table? This has
>the same disadvantage (i.e. having a little unneeded __initdata in the
>kernel image), but it wouldn't need the rather ugly MODULE_ONLY macro.

>I'ld suggest something like this in module.h, #ifndef MODULE part:

>#define MODULE_DEVICE_TABLE(type,name) \
>static struct type##_device_id *__dummy_##name \
>       __attribute__ ((unused, __section__(".text.exit"))) \
>       = name;

	I did not realize that this thread had been posted to
linux-kernel.  Here is a response that I emailed to Keith Owens
and Kai Germaschewski that explains my reasons for sticking with
#ifndef MODULE...#endif rather than creating a new kernel facility
for something that, by the way, should become completely unused in
the next couple of months after 2.4.0 is released and the device
drivers are converted to the new PCI and isapnp interfaces:

|From: "Adam J. Richter" <adam@yggdrasil.com>
|To: kaos@ocs.com.au
|
|        Thanks for the patch, but I think I'll stick with the ifdefs
|for now, for the following reasons.
|
|        1. I think ifdef MODULE is more understandable to the casual observer.
|        2. There is often some other condition that I need to combine
|           with (CONFIG_PCI, CONFIG_ISAPNP, CONFIG_ISAPNP_MODULE).
|        3. There is often an existing ifdef in the right place that I
|           can just tuck the code into.
|        4. I would prefer that this change not have even a file size cost
|           to people who want to build minimal monolithic kernels
|           for applicance applications.
|        5. My feeling is that just the few kilobytes of file size cost
|           associated with #4 and knowing that absolutely nothing is
|           added for non-module usage will psychologically make
|           maintainers feel better about it and have even fewer misgivings
|           about integrating it.
|        6. We can expect the lines bracketing these table declarations
|           to be changed in the near future as the drivers are changed
|           to use the new PCI and isapnp interfaces or to use the ID
|           tables just to eliminate the old custom data structures that
|           hold the same information.
|
|        Thanks for the patch anyhow, though.  It's a clever idea that
|may be useful in other situations.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
