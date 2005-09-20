Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbVITIEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbVITIEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbVITIEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:04:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24798 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964924AbVITIEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:04:21 -0400
Date: Tue, 20 Sep 2005 01:03:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: pazke@donpac.ru, colin@realtek.com.tw, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PRINTK doesn't makes size smaller
Message-Id: <20050920010305.745d5ccf.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509200047120.3173@shell2.speakeasy.net>
References: <01bf01c5bdaa$9e8b81c0$106215ac@realtek.com.tw>
	<20050920063805.GB20363@pazke>
	<Pine.LNX.4.58.0509200047120.3173@shell2.speakeasy.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vadim Lobanov <vlobanov@speakeasy.net> wrote:
>
> On Tue, 20 Sep 2005, Andrey Panin wrote:
> 
> > On 263, 09 20, 2005 at 02:14:55PM +0800, colin wrote:
> > >
> > > Hi there,
> > > I tried to make kernel with CONFIG_PRINTK off. I considered it should become
> > > smaller, but it didn't because it actually isn't an empty function, and
> > > there are many copies of it in vmlinux, not just one. Here is its
> > > definition:
> > >     static inline int printk(const char *s, ...) { return 0; }
> > >
> > > I change the definition to this and it can greatly reduce the size by about
> > > 5%:
> > >     #define printk(...) do {} while (0)
> > > However, this definition would lead to error in some situations. For
> > > example:
> > >     1. (printk)
> > >     2. ret = printk
> > >
> > > I hope someone could suggest a better definition of printk that can both
> > > make printk smaller and eliminate errors.
> >
> > What about the macro below ?
> >
> > #define printk(...) ({ do { } while(0); 0; })
> 
> So what does the do-while loop give us in the above case? In other
> words, why not just do the following...?
> 
> #define printk(...) ({ 0; })
> 

You may find that when printk() is a static inline there are still copies
of the control string in the generated kernel image:

	printk("foo %d\n", bar());

must still evaluate bar() and may cause "foo %d\n" to turn up in vmlinux. 
IIRC later versions of gcc do remove the unreferenced string.

If printk is a macro, it all of course disappears.
