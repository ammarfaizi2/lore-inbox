Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbVHPIQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbVHPIQW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 04:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbVHPIQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 04:16:22 -0400
Received: from herkules.vianova.fi ([194.100.28.129]:17045 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S965139AbVHPIQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 04:16:21 -0400
X-Qmail-Scanner-Mail-From: vherva@ENIGMA.viasys.com via herkules.vianova.fi
X-Qmail-Scanner: 1.23 (Clear:RC:1(194.100.28.161):. Processed in 0.059203 secs)
From: "Ville Herva" <vherva@ENIGMA.viasys.com>
Date: Tue, 16 Aug 2005 11:16:17 +0300
To: linux-kernel@vger.kernel.org, linux-lvm@redhat.com
Subject: Upgrade from 2.6.10-ac8 to 2.6.12.5 broke lvm rootfs
Message-ID: <20050816081617.GB3172@vianova.fi>
Reply-To: vherva@vianova.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Operating-System: CYGWIN_NT-5.1 enigma 1.5.18(0.132/4/2) 2005-07-02 20:30 i686 unknown unknown Cygwin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading the kernel from 2.6.10-ac8 to 2.6.12.5 the initramfs was no
longer able to mount rootfs.

  mount: error 6 mounting ext3

All the configuration options are identical, and upgrading lvm2 package:
  lvm2-2.00.25-1.01       -> lvm2-2.01.14-1.0
  device-mapper-1.00.19-2 -> device-mapper-1.01.04-1.0

Did not change anything.

Dm, ext3 and the relevant block device drivers statically compiled in.

The vg has lvm1 format, fwiw.

I enabled all the debug options I could think of in the nash-based initramfs
init script. That did not appear to tell much: all I was able to tell was
that lvm was succesfully called by the init script:

mount -t proc /proc /proc
mount -t sysfs none /sys
insmod /lib/dm-snapshot.ko 
mkdevices /dev
mkdmnod
lvm vgscan -v
# sleep 5
lvm vgchange -ay
# sleep 5
lvm vgmknodes
# sleep 5
mkrootdev /dev/root
umount /sys
# sleep 5
mount -o defaults --ro -t ext3 /dev/root /sysroot
switchroot /sysroot

but those didn't give any meaningful output (other than notices about
setting log indentation level).

Finally, I added "sleep 5" after each lvm command (commented out above),
which appeared "solve" the problem. 

Apparently the lvm scripts somehow do their initialization asynchronously
and the init script tries to mount root before it is available. I'm not sure
why this is affected by the kernel version, though.



-- v --

v@iki.fi
