Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263986AbTEGPjL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263992AbTEGPjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:39:11 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:31125 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263986AbTEGPjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:39:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Date: Wed, 7 May 2003 17:46:15 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20030507104008$12ba@gated-at.bofh.it> <200305071518.25595.arnd@arndb.de> <20030507151613.GB412@elf.ucw.cz>
In-Reply-To: <20030507151613.GB412@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="euc-jp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305071746.15908.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 May 2003 17:16, Pavel Machek wrote:

> > Has anyone solved the register_ioctl32_conversion() from module problem
> > yet? The patch will break if you build scsi as a module because you
> > never unregister the conversion helper on unload.
> > Even if you do the unregister from a module_exit() function, there
> > will still be a small race against running ioctl handlers. I suppose
> > we have to add an 'owner' field to struct ioctl_trans in order to
> > get it right.
>
> Its in drivers/block/scsi_ioctl.c. AFAICS, its always compiled in, so
> I'm not hitting that problem *yet*.

No, it has indeed been possible to build scsi as a module for a long
time and in that case, scsi_ioctl becomes part of that module. The same 
problem also exists for any user of register_ioctl32_conversion(), e.g.
ieee1394.

> > > +		ss.iomem_base = (void *)((unsigned long)ss.iomem_base & 0xffffffff);
> >
> > you need compat_ptr() for iomem_base as well
>
> Its not pointer, AFAICS (at least it can not be dereferenced by
> userspace).

Right, it appears to be a physical address, which therefore would require
a new mapping macro to be really correct. If this were used on s390, that
macro would be the same as compat_ptr(), the other architectures probably 
need a simple cast (again, like compat_ptr()). Either of 1. new macro, 2.
compat_ptr() or 3. the existing code works correctly here, so just do
whichever you prefer. Maybe somebody else has a strong opinion on it.

	Arnd <><


