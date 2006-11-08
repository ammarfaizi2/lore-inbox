Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754605AbWKHR1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbWKHR1A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754607AbWKHR1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:27:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:49486 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1754605AbWKHR06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:26:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ucXBnawxd7jga8CU1thCu4ttMsa898P+CprKMD+J8HlaT6/dOmQ4s7XJBa7Dct6aIQU3iqoImjBwVEqlwSjfL3UmyYEuUYfnvPI/8FYIC5CDwNGcCL7V3F61xw7DBUwrOHRdPJpVoYIpSlGNcSt3bqnfVjReNo2SRn9BZNc1dCI=
Message-ID: <4807377b0611080926x21bd6326xc5e7683100d20948@mail.gmail.com>
Date: Wed, 8 Nov 2006 09:26:56 -0800
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: John <me@privacy.net>
Subject: Re: Intel 82559 NIC corrupted EEPROM
Cc: auke-jan.h.kok@intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, hpa@zytor.com, saw@saw.sw.com.sg
In-Reply-To: <4551B7B8.8080601@privacy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <454B7C3A.3000308@privacy.net> <454BF0F1.5050700@zytor.com>
	 <45506C9A.5010009@privacy.net> <4551B7B8.8080601@privacy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/06, John <me@privacy.net> wrote:
> Hello all,
>
> [ E-mail address is a bit-bucket. I *do* monitor the mailing lists. ]
>
> I will try and summarize the problem as I understand it at this point.
>
> I've written two messages so far:
> http://groups.google.com/group/linux.kernel/msg/3a05d819c66474db
> http://groups.google.com/group/linux.kernel/msg/391aebbb3dfd6039
>
> And here is a link to the complete thread:
> http://lkml.org/lkml/fancy/2006/11/3/124
>
> I have a motherboard with three on-board 82559 NICs.
>
>   o eepro100.ko properly initializes all three NICs
>   o e100.ko fails to initialize one of them
>
> NOTE: With kernel 2.6.14, e100.ko fails to initialize the NIC with MAC
> address 00:30:64:04:E6:E4. With kernel 2.6.18 e100.ko fails to
> initialize the NIC with MAC address 00:30:64:04:E6:E5.
>
> The problem is not an incorrect checksum. (Donald Becker's dump utility
> reports a correct checksum for all three NICs.) The problem seems to be
> that e100.ko fails to read the contents of one of the EEPROMs.

<snip>

Thanks for the report, I have some thoughts.
I suspect that one reason beckers code works is that it uses IO based
access (slower, and different method) to the adapter rather than
memory mapped access.

The second thought is that the adapter is in D3, and something about
your kernel or the driver doesn't successfully wake it up to D0.  An
indication of this would be looking at lspci -vv before/after loading
the driver.  Also, after loading/unloading eepro100 does the e100
driver work?

A third idea is look for a master abort in lspci after e100 fails to load.

And a last idea is for us to instrument the reads /writes from/to the
device during init and see if everything is returning 0xffffffff, as
that indicates the I/O and/or memory bar is not enabled, or the
address returned from ioremap is invalid.

Jesse
