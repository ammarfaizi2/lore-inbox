Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTK0WGg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 17:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTK0WGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 17:06:35 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:3077 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261294AbTK0WGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 17:06:33 -0500
Subject: Re: [PATCH 2.6]: IPv6: strcpy -> strlcpy
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>,
       davem@redhat.com,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <20031127200041.B25015@flint.arm.linux.org.uk>
References: <1069934643.2393.0.camel@teapot.felipe-alfaro.com>
	 <20031127.210953.116254624.yoshfuji@linux-ipv6.org>
	 <20031127194602.A25015@flint.arm.linux.org.uk>
	 <20031128.045413.133305490.yoshfuji@linux-ipv6.org>
	 <20031127200041.B25015@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1069970770.2138.10.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 27 Nov 2003 23:06:10 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-11-27 at 21:00, Russell King wrote:
> > 
> > I believe that it, to change from strcpy() to strlcpy(), just 
> > eliminates possibility of buffer-overrun.
> 
> While this is 100% correct, the bit which raised my attention was the
> original message which didn't seem to show that the above had been
> considered.

Well, I can't see the difference between using strcpy() and strlcpy().
Let be:

char destination[MAX];
char * source;
N = strlen(source);

We could use strlcpy(destination, source, MAX) or strcpy(destination,
source).

We have the following scenarios:

- N < MAX. In this case, both strcpy() and strlcpy() should yield the
same results. No buffer overflows. If the source strings does not
already contain uninitialised data, there's no way for strlcpy() to copy
them.

- N >= MAX. In this case, strlcpy() will copy less bytes than strcpy().
To be exact, strlcpy() will copy N-MAX+1 bytes less than strcpy().
Again, no buffer overflows. Also, it's still impossible to copy
uninitialised data since we just stop at \0 or when we fill up the
destination buffer.

So I don't see how using strlcpy() could copy uninitialised data from
kernel space to user space. If we used memcpy() we could end up copying
uninitialised data, but I can't see how using strlcpy() would do that.

In general terms, strlcpy() will copy *at most* the same number of bytes
as strcpy(), but there is no single case when strlcpy() will copy more
bytes than strcpy().

Can someone throw some light on this?

