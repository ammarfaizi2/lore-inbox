Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVA2Rk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVA2Rk1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 12:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVA2Rk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 12:40:27 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:62663 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261283AbVA2RkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 12:40:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=JT1OUYRuMWauuxjSUoOT8A4J6yP7xoHyGdTBrZoU+DqdB9ItKxckCxTc0bKXRkfDaPIJlSA3uJPK7rJvvqkpcjSGpSeRZzYUHQFAZ+iuMfzYZVuPNfpzRE+bPdCxFj8HG+YXYejrnm3Ghbs9i7wdjFzkGEjsa/QzdXHd6l0NSUI=
Message-ID: <5a4c581d05012909402ae321b8@mail.gmail.com>
Date: Sat, 29 Jan 2005 18:40:13 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: ee21rh@surrey.ac.uk
Subject: Re: OpenOffice crashes due to incorrect access permissions on /dev/dri/card*
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <pan.2005.01.29.13.02.51.478976@surrey.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <pan.2005.01.29.10.44.08.856000@surrey.ac.uk>
	 <E1CurmR-0000H8-00@calista.eckenfels.6bone.ka-ip.net>
	 <pan.2005.01.29.12.49.13.177016@surrey.ac.uk>
	 <pan.2005.01.29.13.02.51.478976@surrey.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2005 13:02:51 +0000, Richard Hughes <ee21rh@surrey.ac.uk> wrote:
> On Sat, 29 Jan 2005 12:49:16 +0000, Richard Hughes wrote:
> > Note, that strace glxgears gives exactly the same output, going from 0 to
> > 14 and then seg-faulting, so it's *not just a oo problem*.
> 
> I know it's bad to answer your own post, but here goes.
> 
> I changed my /etc/udev/permissions.d/50-udev.permissions config to read:
> 
> dri/*:root:root:0666
> 
> changing it from
> 
> dri/*:root:root:0660
> 
> And oowriter and glxgears work from bootup. Shall I file a bug with udev?

Interesting. On my FC2 (without udev) under 2.6.11-rc2-bk5
both programs work fine with /dev/dri/card0 in its default
 permissions - 666 (obviously).

However, if I manually chmod /dev/dri/card0 to 660 I don't
 get a SEGV, but rather

[asuardi@incident asuardi]$ glxgears
libGL error: failed to open DRM: Operation not permitted
libGL error: reverting to (slow) indirect rendering
711 frames in 5.0 seconds = 142.200 FPS
X connection to :0.0 broken (explicit kill or server shutdown).
[asuardi@incident asuardi]$ ooffice
libGL error: failed to open DRM: Operation not permitted
libGL error: reverting to (slow) indirect rendering

And both still work.

Relevant strace portion from glxgears says

read(3, "\1\355\21\0\3\0\0\0\0\200\204\370\0\0\0\0\t\0\0\0\33\0"..., 32) = 32
readv(3, [{"PCI:1:0:0", 9}, {"\0\0\0", 3}], 2) = 12
geteuid32()                             = 41
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat64("/dev/dri/card0", {st_mode=S_IFCHR|0660, st_rdev=makedev(226,
0), ...}) = 0
open("/dev/dri/card0", O_RDWR)          = -1 EACCES (Permission denied)
open("/dev/dri/card0", O_RDWR)          = -1 EACCES (Permission denied)
unlink("/dev/dri/card0")                = -1 EACCES (Permission denied)
geteuid32()                             = 41
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat64("/dev/dri/card1", 0xbffff0dc)    = -1 ENOENT (No such file or directory)
...
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat64("/dev/dri/card14", 0xbffff0dc)   = -1 ENOENT (No such file or directory)
write(2, "libGL error: failed to open DRM:"..., 57libGL error: failed
to open DRM: Operation not permitted
) = 57
write(2, "libGL error: reverting to (slow)"..., 52libGL error:
reverting to (slow) indirect rendering
) = 52
mmap2(NULL, 266240, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb7b68000
write(3, "\222\3\2\0\0\0\0\0\220\24$\2\1\0\0\0\2\0\0\0\200\10\0\0"...,
2544) = 2544

This with libGL and glxgears from FC2 updated RPMs 
 xorg-x11-Mesa-libGL-6.7.0-11
 xorg-x11-tools-6.7.0-11

--alessandro
 
 "And every dream, every, is just a dream after all"
  
    (Heather Nova, "Paper Cup")
