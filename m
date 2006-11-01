Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946800AbWKALXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946800AbWKALXA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 06:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946801AbWKALXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 06:23:00 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:31697 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1946800AbWKALW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 06:22:59 -0500
Date: Wed, 1 Nov 2006 12:21:48 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist hsfmodem module
In-Reply-To: <20061028004147.GB4902@martell.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.61.0611011204140.23977@yvahk01.tjqt.qr>
References: <20061028004147.GB4902@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.61.0611011205541.24409@yvahk01.tjqt.qr>
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>It seems, hcfpcimodem-1.10full.tar.gz from
>http://www.linuxant.com/drivers/hcf/full/downloads.php
>also uses GPL\0 trick.
>
>Patch is obviously not tested (and I'm not sure name is right, got it from
>Ubuntu forums and tarball filename),
>
>Does someone know internal contact so we can weed out all names and
>blacklist them in bulk?


Could not we introduce some compile-time magic that makes sure no extra 
NULs are present? Like...

Consider
  MODULE_LICENSE("GPL\0foobar");
generating an extra symbol
  static const __rodata int __module_license_length = sizeof("GPL\0foobar");

And in the module loader, check:
  if(strcmp(__module_license, "GPL") == 0 &&
  __module_license_length == sizeof("GPL"))
  {
        allow;
  }

That should weed out all those pesky GPL-override attempts, without needing to
blacklist every single module. After all, HSF (or whoever else is blacklisted)
could just change their module's name from hsfmodem.ko to hsf_modem.ko, for
example.

linux/license.h could look like this:

<<<
#ifndef __LICENSE_H
#define __LICENSE_H

#define strcmpexact(given, required, length) \
	(strcmp((given), (required)) == 0 && (length) == sizeof(required))

static inline int license_is_gpl_compatible(const char *license, int len)
{
	return strcmpexact(license, "GPL", len) ||
	       strcmpexact(license, "GPL v2", len) ||
	       strcmpexact(license, "GPL and additional rights", len) ||
	       strcmpexact(license, "Dual BSD/GPL", len) ||
	       strcmpexact(license, "Dual MIT/GPL", len) ||
	       strcmpexact(license, "Dual MPL/GPL", len);
}

#undef strcmpexact

#endif
>>>


	-`J'
-- 
