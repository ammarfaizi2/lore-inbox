Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTK0WTe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 17:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbTK0WTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 17:19:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49680 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261305AbTK0WTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 17:19:32 -0500
Date: Thu, 27 Nov 2003 22:19:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>,
       davem@redhat.com,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: [PATCH 2.6]: IPv6: strcpy -> strlcpy
Message-ID: <20031127221928.F25015@flint.arm.linux.org.uk>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	"YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>,
	davem@redhat.com,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	netdev@oss.sgi.com
References: <1069934643.2393.0.camel@teapot.felipe-alfaro.com> <20031127.210953.116254624.yoshfuji@linux-ipv6.org> <20031127194602.A25015@flint.arm.linux.org.uk> <20031128.045413.133305490.yoshfuji@linux-ipv6.org> <20031127200041.B25015@flint.arm.linux.org.uk> <1069970770.2138.10.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1069970770.2138.10.camel@teapot.felipe-alfaro.com>; from felipe_alfaro@linuxmail.org on Thu, Nov 27, 2003 at 11:06:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 27, 2003 at 11:06:10PM +0100, Felipe Alfaro Solana wrote:
> On Thu, 2003-11-27 at 21:00, Russell King wrote:
> > > 
> > > I believe that it, to change from strcpy() to strlcpy(), just 
> > > eliminates possibility of buffer-overrun.
> > 
> > While this is 100% correct, the bit which raised my attention was the
> > original message which didn't seem to show that the above had been
> > considered.
> 
> Well, I can't see the difference between using strcpy() and strlcpy().

You misunderstand me.  Consider the difference between:

	strcpy(d, s)
	strlcpy(d, s, sizeof(d));
	strncpy(d, s, sizeof(d));

strncpy zeros the remainder of d if strlen(s) < sizeof(d), but does not
zero terminate the buffer if strlen(s) == sizeof(d).  (Note: this is
how strncpy under the Linux kernel is supposed to work, and yes, the
generic strncpy version in lib/string.c is still buggy.)

strlcpy copies up to the smaller of strlen(s)-1 and sizeof(d)-1, and
ensures that the string is null terminated.  If strlen(s) < sizeof(d)-1,
bytes in d will not be written.

Note my final sentence there.  Consider the following:

	char foo[256];

	strlcpy(foo, "hello", sizeof(foo);

	copy_to_user(uptr, foo, sizeof(foo));

That ends up writing uninitialised kernel data to (unprivileged) user
space.  So would strcpy() used in that situation.

strncpy() on the other hand, will zero the rest of the buffer (on x86
at least) but you'll have to manually ensure that there is a terminator
on the end.  Or, you use strlcpy but memset the entire space you're
copying the string into beforehand, which could be wasteful.

Note: we should really fix the generic strncpy() - there are places in
the kernel source which rely on the x86 strncpy() behaviour today (eg,
binfmt_*.c core file generation.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
