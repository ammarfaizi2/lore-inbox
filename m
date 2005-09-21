Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbVIULtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVIULtv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 07:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVIULtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 07:49:50 -0400
Received: from science.horizon.com ([192.35.100.1]:33352 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750830AbVIULtu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 07:49:50 -0400
Date: 21 Sep 2005 07:49:31 -0400
Message-ID: <20050921114931.14363.qmail@science.horizon.com>
From: linux@horizon.com
To: johnstul@us.ibm.com
Subject: Re: [PATCH] NTP shift_right cleanup (v. A3)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- For fixed shifts, you can just write it as a divide; GCC will DTRT.
  For interest's sake, GCC 4.0 generates, for x /= 64:
        testl   %eax, %eax
	jns	.L2
	addl	$63, %eax
.L2:
	sarl	$6, %eax

- If you want to be more verbose with the explanation, try something like:
  (Public domain, copyright abandoned, use freely, yadda yadda.)
/*
 * NTP uses power-of-two divides a lot for speed, but it wants to use
 * negative numbers.
 * 1) ANSI C does not guarantee signed right shifts (but GCC does)
 * 2) Such a shift is like a divide that rounds to -infinity.
 *    NTP wants rounding to zero, i.e. -3/2 = -2, while -3>>1 = -2.
 */

Interestingly, _Hacker's Delight_ chapter 10 skips over this particular
case, signed division by a variable power of two.
