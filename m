Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbWFIW2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbWFIW2l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWFIW2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:28:40 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:39857 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750838AbWFIW2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:28:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ndGcfAM/UYxG6PH3kqyT1WpnejIct2vMnSzM1eSwM9Wu94VdsnNJJ9U98fZfME6VQLQOnNEG/zYWZeVdTooY5Mqlq44mTzgVRYZ/2F7Flk5K9YVqXOLYknK6wt3D/IaGfdmMqU+iz9YjzWG+9IQpx815B6hhIM2Gu/dI+bqwI9w=
Message-ID: <bda6d13a0606091528h4e85265du8651818c73827b7d@mail.gmail.com>
Date: Fri, 9 Jun 2006 15:28:39 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: klibc
In-Reply-To: <871wty6rl9.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <e65jj9$m9p$1@terminus.zytor.com>
	 <200606071425.35802.ncunningham@linuxmail.org>
	 <bda6d13a0606062351i5c94414fpa03ee2ce3dd180ae@mail.gmail.com>
	 <e67fg0$grr$1@terminus.zytor.com> <8764ja7o2d.fsf@hades.wkstn.nix>
	 <bda6d13a0606091050n40fda044v668eef09af3c29a7@mail.gmail.com>
	 <871wty6rl9.fsf@hades.wkstn.nix>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/06, Nix <nix@esperi.org.uk> wrote:
> On Fri, 9 Jun 2006, Joshua Hudson whispered secretively:
> > On 6/9/06, Nix <nix@esperi.org.uk> wrote:
> >> What happens if you do? I mean, it doesn't make even conceptual sense,
> >> really. The rootfs is always there: that's its entire purpose.
> >
> > I just need it accessable somewhere else on the tree so that the system
> > init runs from that rather than the root filesystem, and so can unmount
> > root filesystem. Obvously, after a mount /, it is not.
>
> You cannot unmount rootfs: it's the first filesystem mounted, the
> ultimate parent of all attached mounts, the fallback used if you umount
> everything else, and is explicitly checked for at mount and pivot_root
> time.
>
> You also don't often want to leave anything in it after you've booted:
> unlike tmpfs, it's not swap-backed, so stuff in there stays in
> nonswappable memory, pinned in the page cache. This is generally
> undesirable. Yes, it stays around empty: but if you boot without an
> initramfs, it stays around empty *in any case*: the kernel builds an
> empty one and uses it automatically, then falls back to code which
> mounts a root filesystem for you (code which HPA's klibc patch removes
> in favour of doing everything it did from an initramfs).
>
>
> The end of my initramfs script (busybox / uclibc-based) reads
>
> # Unmount everything and switch root filesystems for good:
> # exec the real init and begin the real boot process.
> /bin/umount -l /proc
> /bin/umount -l /sys
> /bin/umount -l /dev
>
> exec switch_root /new-root $init $INIT_ARGS
>
> where switch_root is the aforementioned busybox `rm -rf everything on
> this filesystem and mount --move us into the new root'. (At the time
> it runs, it's PID 1 and there are no other non-kernel threads running:
> it execs init.)
>
>
> What are you trying to accomplish?

Once again. Loopback mount requires a clean unmount of root and
host filesystem. After remounting root read-only, host is still read-write
and cannot be remounted read-only.

It is necessary to provide access to the rootfs tree somewhere else
or use pivot_root, like the initrd solution below:

initrd: /linuxrc
#!/bin/sh
mount /dev/hda1 -o rw -t ntfs /host
mount /host/linux/root.img -o loop,ro -t ext3 /root
pivot_root /root /root/initrd
exec /initrd/bin/init

root:/etc/rc.d/rc.halt:
#!/bin/sh
pivot_root /initrd /initrd/root
cd /
exec /stop $RUNLEVEL

initrd:/stop
#!/bin/sh
kill -SIGUSR1 1
umount /root
umount /host
case $1 in
0) poweroff -f ;;
*) reboot -f ;;
esac


This requires static binaries of init, sh, mount, umount, an extant /etc, and a
few nodes in /dev.
