Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWFIWsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWFIWsv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWFIWsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:48:51 -0400
Received: from hera.kernel.org ([140.211.167.34]:53898 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751432AbWFIWsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:48:51 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: klibc
Date: Fri, 9 Jun 2006 15:48:43 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e6ctsb$hij$1@terminus.zytor.com>
References: <20060604135011.decdc7c9.akpm@osdl.org> <bda6d13a0606091050n40fda044v668eef09af3c29a7@mail.gmail.com> <871wty6rl9.fsf@hades.wkstn.nix> <bda6d13a0606091528h4e85265du8651818c73827b7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1149893323 18004 127.0.0.1 (9 Jun 2006 22:48:43 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 9 Jun 2006 22:48:43 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <bda6d13a0606091528h4e85265du8651818c73827b7d@mail.gmail.com>
By author:    "Joshua Hudson" <joshudson@gmail.com>
In newsgroup: linux.dev.kernel
> 
> Once again. Loopback mount requires a clean unmount of root and
> host filesystem. After remounting root read-only, host is still read-write
> and cannot be remounted read-only.
> 
> It is necessary to provide access to the rootfs tree somewhere else
> or use pivot_root, like the initrd solution below:
> 
> initrd: /linuxrc
> #!/bin/sh
> mount /dev/hda1 -o rw -t ntfs /host
> mount /host/linux/root.img -o loop,ro -t ext3 /root
> pivot_root /root /root/initrd
> exec /initrd/bin/init
> 
> root:/etc/rc.d/rc.halt:
> #!/bin/sh
> pivot_root /initrd /initrd/root
> cd /
> exec /stop $RUNLEVEL
> 
> initrd:/stop
> #!/bin/sh
> kill -SIGUSR1 1
> umount /root
> umount /host
> case $1 in
> 0) poweroff -f ;;
> *) reboot -f ;;
> esac
> 
> This requires static binaries of init, sh, mount, umount, an extant /etc, and a
> few nodes in /dev.

Another solution is to leave a process with its cwd parked in the
rootfs.  Look at run_linuxrc() in usr/kinit/initrd.c of any klibc tree
to see how this can be used.  (That is there to support old-style
/linuxrc, but should be applicable here, too.)

	-hpa
