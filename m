Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbTIMAWv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 20:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbTIMAWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 20:22:51 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:46030 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261972AbTIMAWt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 20:22:49 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Subject: Re: [PATCH] new ioctl type checking causes gcc warning
Date: Sat, 13 Sep 2003 02:22:43 +0200
User-Agent: KMail/1.5.1
Cc: Andreas Schwab <schwab@suse.de>, LKML <linux-kernel@vger.kernel.org>
References: <3F621AC4.4070507@cox.net> <200309121453.07111.arnd@arndb.de> <3F625A26.7050305@cox.net>
In-Reply-To: <3F625A26.7050305@cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309130222.43612.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 September 2003 01:43, Kevin P. Fleming wrote:

> After working on this some more this afternoon, I realize now that
> it's much better to have the typechecking in place than not, even for
> userspace. Maybe the best solution is to still leave the typechecking
> (don't wrap it in #ifdef __KERNEL__), and just
>
> #ifdef size_t

This doesn't work, because size_t is a typedef, not a macro.

> extern size_t __invalid_size_argument_for_IOC;
> #else
> extern unsigned int __invalid_size_argument_for_IOC;
> #endif
>
> Would the type specification of this non-existent variable ever
> actually effect the generated code? If not, then even putting this
> #ifdef in is overkill.

No, but as Andreas pointed out earlier, doing non-optimized builds
with the _IOC_TYPECHECK macro in place always results in link
errors, even for correct code. Since we know that the kernel
is always built with -O2, '#ifdef __KERNEL__' is sufficient
here.

The type checking this in user space is not necessary, because 
the point of the check is only to keep people from adding *new*
invalid ioctl numbers and doing the check for the kernel does that.
However, the old numbers need to be kept for a long time and there
is no point in breaking user applications that use established
interfaces.

	Arnd <><
