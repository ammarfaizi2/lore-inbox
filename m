Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265310AbUFXT2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265310AbUFXT2A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 15:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbUFXT2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 15:28:00 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:50144 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S265366AbUFXT0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 15:26:46 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mariusz Mazur <mmazur@kernel.pl>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.7.0
References: <200406240020.39735.mmazur@kernel.pl> <40DA0F7D.60606@pobox.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 24 Jun 2004 18:43:56 +0200
In-Reply-To: <40DA0F7D.60606@pobox.com> (Jeff Garzik's message of "Wed, 23
 Jun 2004 19:17:17 -0400")
Message-ID: <m3n02s9a9f.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> HPA suggested include/abi and I don't think anyone objected.
>
> But that's most likely a 2.7 project :(

I think we should start with (and it doesn't have to wait for 2.7):

/usr/include/abi -> linux/include/abi
/usr/include/linux -> abi (obsolete, to be removed with 2.8)
Appropriate $ARCH + generic dirs (names?).

in the kernel:
mkdir linux/include/abi (and appropriate $ARCH + generic dirs - names?)
for f in all-user-space-header-names; do
	copy << EOF >> linux/include/abi/$f
  #ifndef __ABI_HEADER_H
  #define __ABI_HEADER_H

  #ifdef __KERNEL__
  #include <linux/header.h>
  #else
  #include <linux-internal/header.h>
  #endif

  #endif

I above scheme should give us a) source compatibility with both kernel
and userland files, b) smooth transition without a single 50 MB patch,
c) allows each maintainer to move/clean "her/his" headers independently.

After a header file is "cleaned" it would look like:
  #ifndef __ABI_HEADER_H
  #define __ABI_HEADER_H
  #include <abi/required_headers.h>

  ... actual ABI definitions
  #endif

-------
  #ifndef __LINUX_HEADER_H
  #define __LINUX_HEADER_H
  #include <abi/required_headers.h>
  #include <linux/required_headers.h>

  ... kernel-only stuff
  #endif
-- 
Krzysztof Halasa, B*FH
