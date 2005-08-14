Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbVHNQYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbVHNQYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 12:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbVHNQYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 12:24:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932537AbVHNQYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 12:24:25 -0400
Date: Sun, 14 Aug 2005 09:24:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 2.6.13-rc6] Fix kmem read on 32-bit archs
In-Reply-To: <200508141214_MC3-1-A731-BBE9@compuserve.com>
Message-ID: <Pine.LNX.4.58.0508140921240.3553@g5.osdl.org>
References: <200508141214_MC3-1-A731-BBE9@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Aug 2005, Chuck Ebbert wrote:
>
>   The first thing drivers/char/mem.c:read_kmem does is convert the
> loff_t it gets as the offset for reading into an unsigned int.  This
> patch makes the kmem driver's llseek operator do that up-front, so
> that fs/read_write.c:rw_verify_area doesn't return -EINVAL when
> we try to read from higher addresses.

Why would rw_verify_area() return -EINVAL? It does

        if (unlikely((pos < 0) || (loff_t) (pos + count) < 0))
                goto Einval;

but pos and "loff_t" is 64-bit, and if the thing is negative in 64 bits, 
then that thing really _should_ fail.

Yes, the thing needs to be opened with O_LARGEFILE and you need to use 
"llseek()" to seek into it, but once you do that, everything should be 
fine.

		Linus
