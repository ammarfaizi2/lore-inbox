Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbTIMLFY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 07:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTIMLFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 07:05:23 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:9447 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262130AbTIMLFR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 07:05:17 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Subject: Re: [PATCH] new ioctl type checking causes gcc warning
Date: Sat, 13 Sep 2003 13:05:11 +0200
User-Agent: KMail/1.5.1
Cc: Andreas Schwab <schwab@suse.de>, LKML <linux-kernel@vger.kernel.org>
References: <3F621AC4.4070507@cox.net> <200309130222.43612.arnd@arndb.de> <3F626544.40000@cox.net>
In-Reply-To: <3F626544.40000@cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309131305.12161.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 September 2003 02:31, Kevin P. Fleming wrote:
> Does that mean that
> these two lines:
>
> #define BLKGETSIZE64    _IOR(0x12,114,sizeof(__uint64_t))
> #define BLKGETSIZE64    _IOR(0x12,114,__uint64_t)
>
> actually produce different ioctl numbers?

Exactly. On 32 bit systems, the former is 0x80041272, the
latter is 0x80081272. On 64 bit systems, they are both
0x80081272.

>                                            If so, then I don't
> understand how the kernel can continue to offer the old/invalid
> interface when the new _IOR macro won't accept the first version any
> longer.

Inside the kernel, the first definition has to be changed to
something like:

#define BLKGETSIZE64    _IOR(0x12,114,size_t) /* broken: actually __u64 */
or
#define BLKGETSIZE64    _IOR_BAD(0x12,114,sizeof(__uint64_t)) /* broken */

in order to get a definition that will pass the check and
generate the well-known number.
