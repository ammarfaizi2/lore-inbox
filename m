Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUBRWmR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266927AbUBRWmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:42:16 -0500
Received: from chaos.analogic.com ([204.178.40.224]:62080 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266650AbUBRWmN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:42:13 -0500
Date: Wed, 18 Feb 2004 17:45:16 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: [NET] 64 bit byte counter for 2.6.3
In-Reply-To: <1077137014.18843.10.camel@midux>
Message-ID: <Pine.LNX.4.53.0402181645220.27707@chaos>
References: <1077123078.9223.7.camel@midux>  <20040218101711.25dda791@dell_ss3.pdx.osdl.net>
  <Pine.LNX.4.53.0402181527000.7318@chaos> <1077137014.18843.10.camel@midux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004, Markus [ISO-8859-1] Hästbacka wrote:

> On Wed, 2004-02-18 at 22:32, Richard B. Johnson wrote:
> > Manipulation of a 'long long' is not atomic in 32 bit architectures.
> > Please explain how we don't care, if we shouldn't care. Also some
> > /proc entries might get read incorrectly with existing tools.
> Please, tell me all the tools, I'll test them. ifconfig and netstat
> works correctly atleast.
>

Hum, they will work when they see 2^64 written in ASCII in /proc/net/dev ?
I doubt that. Have you ever even seen 64-bit ASCII?

The largest unsigned long long will be 18446744073709551615.
If it's read with 32-bit tools (sscanf), it will read 4294967295.

> And about the caring, is rx/tx bytes so important that they can't use
> long long? I would care to see more than 4GB, and maybe some error in
> the counter at some point (Have you _ever_ seen that happen?) than only
> 4GB.
>

The 32-bit wrap is a serious problem. It can't be ignored. The writing
of any multiple-part variable in the kernel can be interrupted at
any time. Interrupting half-written variables can have dire
consequences. Let's pretend that gcc knows how to write a long-long
with minimum overhead..... high word is in edx and the low word is
in eax. The memory variable is addressed by ebx....

		addl	%eax, (%ebx)		# Sum low word
		adcl	%edx, 0x04(%ebx)	# Sum CY and high

Now, get interrupted...

		addl	%eax, (%ebx)		# Sum low word
		->>> interrupt <<<--

                Do some code that adds more stuff to
		the variable....

		Return to the interrupted code.

		adcl	%edx, 0x04(%ebx)	# Sum CY and high

The memory variable is now wrong. If it's an event counter, maybe
it doesn't make any difference. That's what needs to be addressed.
You can't just dismiss it. Any time you write code that knowingly
results in the wrong results, its impact needs to be fully understood.

Changing a bunch of variables in a 32-bit machine to 64-bit ones
is a major change, regardless of how trivial it may seem.

You need to make a spin-locked thingy for every variable you
want to manipulate if the result needs to be correct.

> And no, I didn't post this to be merged into the mainline kernel, just
> to let users know that there maybe is an option for seeing maximum 4GB.
>
> This has been working for me since, umm.. let's say 2.4.20. All the
> tools I've needed have worked.

Just wait until your packet count is 4294967296. It will likely read 0.
When 4294967297, may read 1.  That's off by quite a bit.

>
>         Markus
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an Intel Pentium III machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


