Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKCWzf>; Fri, 3 Nov 2000 17:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129042AbQKCWz0>; Fri, 3 Nov 2000 17:55:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129033AbQKCWzI>; Fri, 3 Nov 2000 17:55:08 -0500
Date: Fri, 3 Nov 2000 17:54:51 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: linux-2.4.0-test9
Message-ID: <Pine.LNX.3.95.1001103175055.612A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have, again, tried to use a new kernel. It is linux-2.4.0-test9
Apparently a newer version was just put up while downloading this
one. This is possible because it took a day to download it );

The following problems exist:

(1)	I have SCSI modules that have to be installed upon boot
from initrd. Insmod failed with "Can't find the kernel version that
this module was compiled with..." Yes, I have the latest and greatest
modutils, downloaded and installed today. Also `insmod -f` doesn't
work (not a kernel problem, yes, I know).

The only fix I could come up with was to remove EXTRAVERSION=test9 in
the top-level Makefile (actually set it to nothing), then recompile
the whole kernel. This problem will get others, I am sure.


(2)	Samba fails to start (seg-faults). I'll look into this later.
	Maybe I have to re-compile it (I shouldn't, it uses standard
	socket interfaces).

(3)	 With the new kernel, I can't access screen memory anymore. When
testing software drivers for hardware that I don't have, I usually use
the screen-regen buffer to emulate the shared memory window.

Here is a snippet of code: 

//    info->mem = 0xb8000     what they actually are
//    info->mem_len = 0x4000

    if((info->vxi_iomem = ioremap(info->mem, info->mem_len)) == NULL)
    {
        printk(KERN_ALERT "%s: Can't allocate shared memory\n", devname);
        (void)unregister_chrdev(info->major, info->dev);
        kfree(info->tmp_buf);
        kfree(info);
        return -ENOMEM;
    }
    info->vxi_base   = (UNIV *) bus_to_virt(UL info->vxi_iomem);
    ||||||||||||||
    This pointer should point to the beginning of the screen buffer.
    It always has before.

When accessing this from a module, I get;
Unable to handle kernel paging requist at virtual address 800b8304.

Access fails at 0x304 (772 d) bytes into the page.

Perhaps, the bus_to_virt() macro or something else has changed??
I tried to use the result of ioremap() directly, but just before
the seg-fault, the kernel message warned that it was not a correct
address.

(4)	More name-space polution. Somebody added another macro called
	get_page(). When, if ever, will we start using the good-old
	convention of defining macros in upper-case?

	The name-space polution has really gotten out-of-hand. You
	can't write code using ordinary symbol names anymore. You
	need to make variables have names like:

	int LoopCounterForOutSideLoop;
	char *UserInputAndOutputBufferForWednesday;

	This is NotGood(tm)

(5)	More stuff added to 'struct file_operations', a new member
	at the beginning, forcing obsolescence of previous
	versions -- and now different for non-module drivers.
	Fortunately a macro was defined (in upper-case!), called
	THIS_MODULE, so modifying my current 11 drivers wasn't
	too bad.


Presently this kernel is running here, fingers crossed. I need to
resolve the screen access problem. Anybody got any hints?


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
