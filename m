Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265953AbUFDTeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265953AbUFDTeV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 15:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265957AbUFDTeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 15:34:21 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:30992 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265956AbUFDTdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 15:33:51 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Valdis.Kletnieks@vt.edu, Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: keyboard problem with 2.6.6
Date: Fri, 4 Jun 2004 22:33:41 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200406041817.i54IHFgZ004530@eeyore.valparaiso.cl> <200406041837.i54IbfYE023527@turing-police.cc.vt.edu>
In-Reply-To: <200406041837.i54IbfYE023527@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406042233.41441.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 June 2004 21:37, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 04 Jun 2004 14:17:14 EDT, Horst von Brand said:
> > Pavel Machek <pavel@suse.cz> said:
> > > You get pretty nasty managment problems. How do you do init=/bin/bash
> > > if your keyboard is userspace?
> >
> > You don't tell any kernel about that... it is the bootloader you are
> > talking to. And that one may very well have integrated kbd support.
>
> So GRUB knows about keyboards, lets you type in the "init=/bin/bash", it
> loads the kernel, the kernel launches init, /bin/bash gets loaded - and
> /bin/bash can't talk to the keyboard because the userspace handler hasn't
> happened.  At that point you're stuck...

Using shell scripts instead of 'standard' init etc is
way more configurable. As an example, my current setup
at home:

My kernel params are:

root=/dev/ram
init=/linuxrc
devfs=mount
ROOTFS=/dev/ide/host0/bus0/target0/lun0/part7
IPCFG=mac,100mbit
INIT=/init



/linuxrc (in initrd):

#!/bin/sh

export PATH=/bin:/usr/bin

cd /
mount -n -t devfs none /dev
mount -n -t proc none /proc
#mount -n -t sysfs none /sys

echo "# Configuring interfaces"
# Optional, for NFS happiness
ip l set dev lo up
ip a add 127.0.0.1/8 dev lo

/script/cfg_ip

echo "# Mounting root fs"
/script/mount_root

# Clean up
#umount /sys
umount /proc

echo "# Chrooting into root fs"
mount -n -t devfs none /new_root/dev
cd /new_root
# making sure we dont keep /dev busy
exec <dev/console >dev/console 2>&1
# proc/ in new root is used here as a temp mountpoint
pivot_root . proc

echo "# Exec'ing init"
if ! test "$INIT"; then
    INIT=/init
fi

exec \
    chroot . \
    sh -c \
    'umount -n /proc/dev; umount -n /proc; exec /bin/env - $INIT'

echo "Error in 'exec chroot . sh': exit code $?"
while true; do
    sleep 32000
done



And, finally, /init:

#!/bin/sh

fileprefix=/etc/rc.d
bootprog=3.runlevel

unset HOSTNAME
unset devfs
unset MACHTYPE
unset SHLVL
unset SHELL
unset HOSTTYPE
unset OSTYPE
unset HOME
unset TERM

export PATH=/bin:/usr/bin

exec >/dev/console
exec 2>&1
exec </dev/null

(
cd "$fileprefix"
env - PATH="$PATH" "$fileprefix/$bootprog" start
)

# Close all descriptors
exec >&-
exec 2>&-
exec <&-

while true; do
    env - sleep 32000
done

--
vda

