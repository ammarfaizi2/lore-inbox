Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTHFOaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 10:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263398AbTHFOaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 10:30:15 -0400
Received: from chaos.analogic.com ([204.178.40.224]:14465 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263062AbTHFOaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 10:30:09 -0400
Date: Wed, 6 Aug 2003 10:32:06 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andy Winton <andreww@bemac.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Multiple symbols same address in vmlinux map file? huh?
In-Reply-To: <1060177192.2866.11.camel@pussy.bemac.com>
Message-ID: <Pine.LNX.4.53.0308061000280.9051@chaos>
References: <1060177192.2866.11.camel@pussy.bemac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003, Andy Winton wrote:

> hi there,
>
>   When doing a 'nm' on the vmlinux I see that some different
>   symbols are at the same address.  This seems very strange
>   to me.  Can anyone explain this?
>
>   What I typed (to see the duplicates only)...
>
> nm vmlinux-2.4.18-14  | awk 'BEGIN{oldval=01;} { if ($1==oldval) {
> if(plast) { print "\n"; print oldrow;} print $0; plast=0} else plast=1;
> oldrow=$0; oldval=$1}' - | more
>
>   What I saw....
>
>   [stuff removed...]
> c0305a78 d emergency_lock
> c0305a78 d emergency_pages
>
> c0303100 d i8259A_irq_type
> c0303100 D i8259A_lock
>
> c0386628 B jiffies
> c0386628 B jiffies_64
>   [stuff removed...]
>
>   Any idea?
>
>   Thanks again,
>
> andy winton
>

They are aliases. GCC uses 'weak aliases' so objects may be accessed
at the same location with different names. This seems strange for
'C', but perfectly normal for assembly. For instance...

a:
b:
c:	.long	0
.global	a
.global	b
.global	c

All 4 objects refer to the same memory location. "a" may actually
be a char[4], "b" may actually be a short[2] and "c" a long. So
we have the equivalent of a 'C' union. Some spin-locks and
other aggregate types end up being represented this way.

That said, there seems to be a problem.
  "i8259A_lock" is a spin-lock in i8259.c, line 133 (version 2.4.20)
  "i8259A_irq_type" is a structure in i8259.c, line 151.

It is static, therefore can not be visible outside the file, plus
it can't exist at the same address as the spin-lock.  So, some
tool is broken. Look at System.map. On my system I see:

c01fd9c0 D i8259A_lock
c01fd9e0 d i8259A_irq_type

These are (correctly) at different addresses, but the static
structure is still visible, which must not happen! So, you
have certainly discovered something that's not right. Perhaps
the 'd' stuff is "really" not visible? If so, what 'th..???

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

