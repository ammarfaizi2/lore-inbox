Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWF2OJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWF2OJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 10:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWF2OJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 10:09:56 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:46683 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750737AbWF2OJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 10:09:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UQ7H9GdzLXuRPfGa4iBHfBYDlsT1oXUlohw0FfkF+lMmeILzLj80pkNpZoc0CM0J6S4t/qNo8w7OeKXbMSWpDX4lMoLw2XN0YSQYhCcEeYkX010p5PWSdz6AN8V1czGsINNSRyBHjLeN2qp1kbE7Co1Jd3s882U2QkEjgrE57KU=
Message-ID: <787b0d920606290709k255c6c24k6d3dd502d85bd1ca@mail.gmail.com>
Date: Thu, 29 Jun 2006 10:09:54 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: akpm@osdl.org, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       hawkes@sgi.com, jdaiker@osdl.org, jes@sgi.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       tony.luck@gmail.com, tony.luck@intel.com
Subject: Re: [PATCH] ia64: change usermode HZ to 250
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Fixing param.h to have #define HZ sysconf(_SC_CLK_TCK) sounds
> like a plausible solution, many incorrect uses will be fixed
> automagically by the next rebuild.  But some more obscure usages
> of HZ may not compile (which is good, then they can be fixed
> properly) or worse may compile, but not do the right thing.

This makes compiles fail on one of the non-glibc libraries,
either uClibc or dietlibc, which does not provide sysconf.

The order in which procps tries things is:

1. walk off the end of environ to get the ELF notes
2. /proc/uptime to /proc/stat ratio
3. HZ
4. lame guess based on endianness and word size

I do not want sysconf. It is is an unreliable piece of shit
that gives me poor guesses instead of returning appropriate
error codes. It does this swell job while being damn slow.
I can do no worse with my own random guess.

(on my TODO list: count CPUs myself, because glibc often
thinks there are zero -- and this is not an error code)

> The ultimate safe solution might be:
>
> #define HZ Fix your program to use sysconf(_SC_CLK_TCK)! \
>       (and BTW, you should not include kernel headers)
>
> Which is highly likely to cause a compile failure (but should
> at least provide a clue to the user on what they should do).

This breaks perfectly fine code, except that it will be yet one more
thing for people to patch out when making headers for userspace.
