Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311072AbSCNPmP>; Thu, 14 Mar 2002 10:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311452AbSCNPmG>; Thu, 14 Mar 2002 10:42:06 -0500
Received: from m1000.netcologne.de ([194.8.194.104]:41043 "EHLO
	m1000.netcologne.de") by vger.kernel.org with ESMTP
	id <S311072AbSCNPmB>; Thu, 14 Mar 2002 10:42:01 -0500
Message-Id: <200203141541.ALU13319@m1000.netcologne.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@gmx.de>
Reply-To: joergprante@gmx.de
Organization: Linux jungle 2.4.19-pre2-jp7 #1 Fre =?iso8859-15?q?M=E4r=208=2021=3A37=3A18=20CET=202002=20i686?= unknown
To: linux-kernel@vger.kernel.org
Subject: [HOWTO] Backporting ALSA from 2.5 to 2.4 kernel 
Date: Thu, 14 Mar 2002 16:41:12 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Backporting ALSA from 2.5 to 2.4 kernel - HOWTO

ALSA can be backported to 2.4 kernels without much problems. Here are 
my experiences with ALSA backporting into my linux-2.4-jp kernel
from 2.5.4 and 2.5.6, but it should work with other 2.4 kernels, too.

I use a patch sequence method. That means, a sequence of patch files is 
created to remove the old sound drivers and insert ALSA, so keeping 
track of the changes in 2.5 kernels will be easier.

There are three steps to be taken:

1. Set up a patch sequence to remove the 2.4 kernel sound.
The directory 'linux-2.4/drivers/sound' must be removed completely, the
Makefile must be changed back to remove the sound driver dependencies.
Additionally, changes related to sound drivers in 'pre' patches can 
occure, they must be reverted, too. Also, it is useful to change the 
defconfig's and config.in's in the architecture directories in order 
to clean up. The sequence I use consists of a three step rollback:

        1918 Mär 12 12:26 01_kernel-sound-remove-0-2.4.19pre3
     4839575 Mär 12 11:41 01_kernel-sound-remove-1-2.4.19pre2
       21675 Mär 12 11:41 01_kernel-sound-remove-2-core

The 2.4 kernel has no sound capabilities at this point and is
ready to get ALSA inserted.

2. Extract ALSA from 2.5 kernel. The ALSA directories are located 
in 'linux-2.5/sound' and 'linux-2.5/include/linux/sound'. They can be 
diff'ed against a 'linux-2.4-nosound' tree and patched to get a 
'linux-2.4-alsa' tree. To complete the patch, the MAINTAINERS, Makefile, 
and architecture dependent config.in's must be adapted from the 2.5 kernel.

  linux-2.4-alsa/MAINTAINERS
  linux-2.4-alsa/Makefile 
  linux-2.4-alsa/arch/i386/config.in
  linux-2.4-alsa/arch/ppc/config.in

As you see, i386 and ppc are supported. If you want to support a different 
architecture, the config.in's must be added respectively.

A convenient method is to keep a patch sequence according to 2.5 kernels 
as they are still under development. Backporting ALSA will be work in progress
as long as development is going on. The ALSA versions used in 2.5 are

  2.5.4 - alsa 0.9.0beta10
  2.5.5 - alsa 0.9.0beta11
  2.5.6 - alsa 0.9.0beta12

Using incremental patches is recommended to keep track with the
2.5 development. The patch sequence I use contains a 0.9.0beta10
ALSA patch of kernel 2.5.4, and two incremental patches to update to the 
status of 2.5.6:

    10419626 Mär 13 12:06 02_alsa-0.9.0beta10
       30029 Mär 13 11:50 02_alsa-0.9.0beta10-beta12-include
      750533 Mär 14 02:12 02_alsa-0.9.0beta10-beta12-sound

In these patches, there are some minor changes:

- the remap_page_range() first argument is dropped in several drivers 
for compatibility

- three times a 'need_resched()' is changed to 'current->need_resched'

- in include/linux/proc_fs.h, some definitions for using 'PDE()' are added 

3. Some extra changes are required for 2.4 kernels.
I collect them in a separate patch. Fortunately, there are no dramatic 
additions:

        1456 Mär 14 00:37 02_alsa-0.9.0beta12-addon

In this patch

- ISA I/O bus memory addresses are defined by some macros in 
linux/include/asm-i386/io.h
- minor fixes in kernel config for making them work properly with 'make 
xconfig'

At this point, the 2.4 ALSA kernel can be configured and will compile. 
Maybe you have to increase the default tkparse.c variable space from 
2048 to a higher value, like 4096.

Also take care of /etc/modules.conf to adjust some names before rebooting. 
The char-major-14 alias can be safely removed. Here is a configuration for a 
single Maestro3 card.

  alias char-major-116 snd
  alias snd-card-0 snd-maestro3
  #alias char-major-14 soundcore
  alias sound-slot-0 snd-card-0
  alias sound-service-0-0 snd-mixer-oss
  alias sound-service-0-1 snd-seq-oss
  alias sound-service-0-3 snd-pcm-oss
  alias sound-service-0-8 snd-seq-oss
  alias sound-service-0-12 snd-pcm-oss
  options snd snd_cards_limit=1 snd_major=116
  options snd-maestro3 snd_index=0

After rebooting with the new kernel and ALSA had been configured as modules,
you can check the status with lsmod and you should get something like this:

  snd-pcm-oss            42608   1  (autoclean)
  snd-mixer-oss          10800   1  (autoclean) [snd-pcm-oss]
  snd-maestro3           12944   2
  snd-pcm                58144   0  [snd-pcm-oss snd-maestro3]
  snd-timer              12144   0  [snd-pcm]
  snd-ac97-codec         23664   0  [snd-maestro3]
  snd                    32480   0  [snd-pcm-oss snd-mixer-oss snd-maestro3 
  snd-pcm snd-timer snd-ac97-codec]

(The snd-seq-oss modules is not installed due to lack of hardware sequencer)

Now the ALSA library and utilities be compiled. Take care of the 
correct version number.

Problems

There are some issues, but no showstoppers. With xmms playing MP3 files, the
following messages are written into /var/log/messages:

 [...]
 Mar 14 13:28:18 jungle kernel: Unexpected hw_pointer value (stream = 0, 
 delta: -984, max jitter = 8192): wrong interrupt acknowledge?
 Mar 14 13:29:16 jungle kernel: Unexpected hw_pointer value (stream = 0, 
 delta: -576, max jitter = 8192): wrong interrupt acknowledge?
 Mar 14 13:32:18 jungle kernel: Unexpected hw_pointer value (stream = 0, 
 delta: -424, max jitter = 8192): wrong interrupt acknowledge?
 Mar 14 13:33:18 jungle kernel: Unexpected hw_pointer value (stream = 0, 
 delta: -864, max jitter = 8192): wrong interrupt acknowledge?
 Mar 14 13:35:18 jungle kernel: Unexpected hw_pointer value (stream = 0, 
 delta: -832, max jitter = 8192): wrong interrupt acknowledge?
 Mar 14 13:36:18 jungle kernel: Unexpected hw_pointer value (stream = 0, 
 delta: -960, max jitter = 8192): wrong interrupt acknowledge?
 Mar 14 13:45:18 jungle kernel: Unexpected hw_pointer value (stream = 0, 
 delta: -696, max jitter = 8192): wrong interrupt acknowledge?
 Mar 14 13:47:18 jungle kernel: Unexpected hw_pointer value (stream = 0, 
 delta: -952, max jitter = 8192): wrong interrupt acknowledge?
 Mar 14 13:52:18 jungle kernel: Unexpected hw_pointer value (stream = 0, 
 delta: -760, max jitter = 8192): wrong interrupt acknowledge?
 [...]

The sound still works with these messages. Notice that ALSA generates 
the messages at full minute intervals. i don't know what is going on.

While shutting, down, ALSA is not able to free all resources, and writes
messages like the following to /var/log/messages:

 Mar 14 13:15:44 jungle kernel: Not freed snd_alloc_pages = 48
 Mar 14 13:15:44 jungle kernel: Not freed snd_alloc_kmalloc = 255
 Mar 14 13:15:44 jungle kernel: kmalloc(9) from d093dac1 not freed
 Mar 14 13:15:44 jungle kernel: kmalloc(76) from d093daa5 not freed
 Mar 14 13:15:44 jungle kernel: kmalloc(9) from d093dac1 not freed
 Mar 14 13:15:44 jungle kernel: kmalloc(76) from d093daa5 not freed
 Mar 14 13:15:44 jungle kernel: kmalloc(9) from d093dac1 not freed
 Mar 14 13:15:44 jungle kernel: kmalloc(76) from d093daa5 not freed

This might have the same reason as the 'unexpected hw_pointer value' stated
above. 

I hope I could give some useful information to everybody who likes to 
use ALSA in a 2.4 kernel. If you like to help me how to solve the problems 
stated above, please email me.

Cheers,

Jörg Prante <joerg@infolinux.de>
