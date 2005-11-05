Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVKEBPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVKEBPl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 20:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVKEBPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 20:15:41 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:8945 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751247AbVKEBPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 20:15:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/4] ->compat_ioctl for 390 tape_char
Date: Sat, 5 Nov 2005 02:16:56 +0100
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
References: <20051104221816.GD9384@lst.de> <200511050010.47138.arnd@arndb.de> <20051104235148.GA10604@lst.de>
In-Reply-To: <20051104235148.GA10604@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200511050217.02547.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünnavend 05 November 2005 00:51, Christoph Hellwig wrote:
> we return -ENOIOCTLCMD if we didn't have a valid compat ioctl, and in
> that case the vfs code will try to find it in the core translation
> table.

No, the function you wrote returns -ENOIOCTLCMD only if
device->discipline->ioctl_fn is NULL, otherwise it returns the
code it gets from that function, which is -EINVAL.

> I'm not sure moving everything from fs/compat_ioctl.c is a good idea.
> Everything that is just in a single driver or subsystem that has
> common ioctl code - sure.  else it doesn't make a lot of sense.

It turns out that almost everything is a single driver, the exceptions
are:

- tty ioctls: I move the conversion into drivers/char/tty_io.c with a
  relatively big switch() statement. All drivers implementing these
  use tty_operations.
- block ioctl: similar for drivers/block/ioctl.c
- net ioctl: similar for net/compat.c. I also add compat_ioctl methods
  for proto_ops.
- cdrom, tape, v4l: I create a new file that contains a compat_ioctl
  file operation that can be used in each driver, either by pointing
  directly to it or by calling it from their own compat_ioctl
  handler. The handlers end up calling f_op->ioctl() internally.
- file systems: many file systems implement EXT2_IOC_GETFLAGS etc.
  those are trivial to handle, so I duplicate the code for each of those
  file systems.

	Arnd <><
