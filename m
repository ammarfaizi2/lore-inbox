Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbWFIXNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWFIXNP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbWFIXNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:13:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:51664 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030319AbWFIXNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:13:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i3NJX7qmsUBexMKo5ZMFBiddiAzRSnrbOc5xb+BUPbM13LJ6dbGkdgbmmpGHXcl4T1vPKUS7lr+Q1xMdYuWWucYF55DYMuZbx7QAXUsRv4zs9X0MdNfPxaKEA8NCyEDqUOo/yrdIVcR9UPjnP2dR19LmUEBVCn4XF1beOnbodCk=
Message-ID: <bda6d13a0606091613h3334facbrcb86dbb2de01b412@mail.gmail.com>
Date: Fri, 9 Jun 2006 16:13:13 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: klibc
In-Reply-To: <e6ctsb$hij$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <bda6d13a0606091050n40fda044v668eef09af3c29a7@mail.gmail.com>
	 <871wty6rl9.fsf@hades.wkstn.nix>
	 <bda6d13a0606091528h4e85265du8651818c73827b7d@mail.gmail.com>
	 <e6ctsb$hij$1@terminus.zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/06, H. Peter Anvin <hpa@zytor.com> wrote:
> Followup to:  <bda6d13a0606091528h4e85265du8651818c73827b7d@mail.gmail.com>
> By author:    "Joshua Hudson" <joshudson@gmail.com>
> In newsgroup: linux.dev.kernel
> >
> > Once again. Loopback mount requires a clean unmount of root and
> > host filesystem. After remounting root read-only, host is still read-write
> > and cannot be remounted read-only.
> >
> > It is necessary to provide access to the rootfs tree somewhere else
> > or use pivot_root, like the initrd solution below:
> >
> > initrd: /linuxrc
> > #!/bin/sh
> > mount /dev/hda1 -o rw -t ntfs /host
> > mount /host/linux/root.img -o loop,ro -t ext3 /root
> > pivot_root /root /root/initrd
> > exec /initrd/bin/init
> >
> > root:/etc/rc.d/rc.halt:
> > #!/bin/sh
> > pivot_root /initrd /initrd/root
> > cd /
> > exec /stop $RUNLEVEL
> >
> > initrd:/stop
> > #!/bin/sh
> > kill -SIGUSR1 1
> > umount /root
> > umount /host
> > case $1 in
> > 0) poweroff -f ;;
> > *) reboot -f ;;
> > esac
> >
> > This requires static binaries of init, sh, mount, umount, an extant /etc, and a
> > few nodes in /dev.
>
> Another solution is to leave a process with its cwd parked in the
> rootfs.  Look at run_linuxrc() in usr/kinit/initrd.c of any klibc tree
> to see how this can be used.  (That is there to support old-style
> /linuxrc, but should be applicable here, too.)
>
>         -hpa
Should work if the following is true:
   if pwd is /, mount / followed by ls . retunrs the contents of initramfs.
