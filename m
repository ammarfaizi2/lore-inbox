Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313798AbSDHX5F>; Mon, 8 Apr 2002 19:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313799AbSDHX5E>; Mon, 8 Apr 2002 19:57:04 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:57497 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313798AbSDHX5D>;
	Mon, 8 Apr 2002 19:57:03 -0400
Date: Mon, 08 Apr 2002 16:54:29 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org, Tony.P.Lee@nokia.com, kessler@us.ibm.com,
        alan@lxorguk.ukuu.org.uk, Dave Jones <davej@suse.de>
Subject: Re: Event logging vs enhancing printk
Message-ID: <91260000.1018310069@flay>
In-Reply-To: <3CB21BFC.B3BFDACF@zip.com.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not aware of that being the case.  The output string
> is formed into a static buffer and then copied into the
> printk ring buffer all under spinlock_irqsave(logbuf_lock).
> 
> If there is something wrong then it would be occurring
> at the other end - where data is taken out of the ring
> and is sent to the console device(s).  The locking there
> is OK, I think?

I think we're talking about slightly different things. I'd agree that
one call to printk is atomic, and won't get interspersed with other
things, but if we output a line via multiple calls to printk, then I 
think we have a problem. Say CPU 0 executes this bit of code:

for (i=0; i<10; i++) { printk ("%d ", i); } printk("\n");

and CPU 1 does "printk("hello\n");" then instead of getting either

0 1 2 3 4 5 6 7 8 9
hello

or 

hello 
0 1 2 3 4 5 6 7 8 9

either of which would be fine, we may get

0 1 2 3 hello
4 5 6 7 8 9

which I don't think is fine - obviously the example is somewhat 
trite, but with the real instances of things that build output for one
line through multiple calls to printk, you can get unreadable garbage,
if I read the code correctly ?

M.

