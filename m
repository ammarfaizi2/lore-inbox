Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263752AbRFHWmG>; Fri, 8 Jun 2001 18:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264380AbRFHWl4>; Fri, 8 Jun 2001 18:41:56 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:43532 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S263752AbRFHWlr>; Fri, 8 Jun 2001 18:41:47 -0400
Date: Fri, 8 Jun 2001 18:42:40 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@vesta.nine.com>
To: <linux-kernel@vger.kernel.org>
Subject: DoS using tmpfs
Message-ID: <Pine.LNX.4.33.0106081755220.1324-100000@vesta.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

It appears that a system with tmpfs mounted with the default (!!!)
parameters can be used by ordinary users to make the system
non-functional.

Let me tell you the whole story. I don't know what is wrong here and what
is not, but the end result is a security hole.

The kernel version is 2.4.5-ac9. It's compiled with gcc from RedHat 7.1.
The processor is Pentium III 550 MHz. Alt-Sysrq is enabled - we'll need it
later.

# mount
/dev/ide/host2/bus0/target0/lun0/part4 on / type reiserfs (rw)
none on /proc type proc (rw)
usbdevfs on /proc/bus/usb type usbdevfs (rw)
devfs on /dev type devfs (rw)
none on /tmp type tmpfs (rw,mode=1777)
none on /dev/shm type shm (rw)

Note the "mode=1777" is not required - it's the default. I put is here
just in case if the default changes.

# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/ide/host2/bus0/target0/lun0/part4
                       5124540   3510036   1614504  69% /
none                    277728         0    277728   0% /tmp
none                    277728         0    277728   0% /dev/shm

# free
             total       used       free     shared    buffers     cached
Mem:        255948      97520     158428          0      14880      68172
-/+ buffers/cache:      14468     241480
Swap:       104380          0     104380

Note that my swap file is just 100M compared to 256M memory, but I never
run anything bigger than Mozilla, so even 350M virtual memory is more than
enough for me.

Now I log in on tty2 as user.

$ dd if=/dev/zero of=/tmp/foo

If a few seconds I'm pressing Ctrl-C - it doesn't work. Alt-F1 works. I
type df as root, press enter and it hangs. I'm hitting Ctrl-C in vain. Now
I press Alt-F2 - it works. I'm trying the last resort - Alt-Sysrq-K. It
works, the login appears.

Now let's see what we have.

# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/ide/host2/bus0/target0/lun0/part4
                       5124540   3510044   1614496  69% /
none                    177124    159968     17156  91% /tmp
none                     17156         0     17156   0% /dev/shm

There is still free space in /tmp, but ...

# free
             total       used       free     shared    buffers     cached
Mem:        255948     253680       2268      55588      14880     171280
-/+ buffers/cache:      67520     188428
Swap:       104380     104380          0

... the swap is exhausted, and so it the memory. Now let's remove /tmp/foo
and see what happens.

# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/ide/host2/bus0/target0/lun0/part4
                       5124540   3510044   1614496  69% /
none                     72340         0     72340   0% /tmp
none                     72340         0     72340   0% /dev/shm

The free space didn't rebound to it's initial value, and here's why:

# free
             total       used       free     shared    buffers     cached
Mem:        255948     198492      57456          0      14880     171284
-/+ buffers/cache:      12328     243620
Swap:       104380     104380          0

The memory is freed, but the swap is still full!

Running "swapoff -a" followed by "swapon -a" brings the system to the sane
state.

Now let me stress some points where the kernel is _possibly_ at fault.

1) tmpfs, as opposed to ramfs doesn't limit the usage by default. It's not
a good default for a filesystem designed for temporary files.

2) Not delivering SIGINT to processes is probably not the best behavior if
the memory if low. However, one could argue that some processes would use
even more resources if they get control with SIGINT.

3) All swap in the system was exhausted and yet tmpfs didn't return ENOSPC
to "dd".

4) The swap wasn't freed. Yes, I know, it's not a new problem.

I don't really know much about OS design and VM in particular, but I was
bitten by this behavior, so I desided to report it. If you cannot find
anything useful in this message, I'm sorry for your time. "IMHO" applies
to all statements made in this message.

-- 
Regards,
Pavel Roskin

