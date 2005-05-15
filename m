Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262826AbVEOMtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbVEOMtX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 08:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVEOMtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 08:49:23 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:16859 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S262826AbVEOMtT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 08:49:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/8] ppc64: SPU file system
Date: Sun, 15 May 2005 14:33:09 +0200
User-Agent: KMail/1.7.2
Cc: Pavel Machek <pavel@ucw.cz>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>
References: <200505132117.37461.arnd@arndb.de> <20050515090705.GA2343@elf.ucw.cz> <1116158548.5095.17.camel@gaston>
In-Reply-To: <1116158548.5095.17.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505151433.11108.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünndag 15 Mai 2005 14:02, Benjamin Herrenschmidt wrote:
> 
> > That's even more evil than ioctl()... Try doing 32-vs-64bit conversion
> > on write...
> 
> I don't see the problem ... if you are passing a structure, you have to
> convert it anyway, and it's bad practice. I was thinking about passing
> ascii so it can be controlled by shell scripts.

Parsing multi-value ascii data is error prone. in kernel space, I would
not want to do anything more complex than a simple_strtoul(), if only
for the reason of not giving bad examples.

When passing binary structures, there is a significant difference between
passing it through ioctl or read/write: We already have a rather complicated
method of detecting if whether and how to convert them (f_op->compat_ioctl,
hash lookup and the deprecated dynamic registration).

For read/write, there is no way to tell if you need to do the conversion,
even if the file operation is aware of the actual data layout of both
variants. Moreover, a good implementation of a read/write file operation
should be able to deal with resuming partial transfers.

Regarding the shell scripting possibility, I don't really see the point.
The only code that should actually use the kernel interfaces is something
like an /lib/ld-spu.so interpreter and that is better implemented in C
anyway because it needs to parse ELF structures and such.

	Arnd <><
