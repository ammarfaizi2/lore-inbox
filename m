Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbVITJML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbVITJML (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 05:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVITJMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 05:12:10 -0400
Received: from mf2.realtek.com.tw ([220.128.56.22]:53516 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S964943AbVITJMJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 05:12:09 -0400
Message-ID: <020801c5bdc3$519ddde0$106215ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: "Andrew Morton" <akpm@osdl.org>, "Vadim Lobanov" <vlobanov@speakeasy.net>
Cc: <pazke@donpac.ru>, <linux-kernel@vger.kernel.org>
References: <01bf01c5bdaa$9e8b81c0$106215ac@realtek.com.tw><20050920063805.GB20363@pazke><Pine.LNX.4.58.0509200047120.3173@shell2.speakeasy.net> <20050920010305.745d5ccf.akpm@osdl.org>
Subject: Re: CONFIG_PRINTK doesn't makes size smaller
Date: Tue, 20 Sep 2005 17:11:43 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/09/20 =?Bog5?B?pFWkyCAwNToxMTo0Mw==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/09/20 =?Bog5?B?pFWkyCAwNToxMTo0NQ==?=,
	Serialize complete at 2005/09/20 =?Bog5?B?pFWkyCAwNToxMTo0NQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
Andrey's suggestion can solve the compiling problem.

I also tested the problem that Vadim had just said. I found that the marco
version of printk indeed will have the problem in this kind of situation:
    printk("foo %d\n", bar());
bar() in marco version of printk won't be called. Because someone may put
meaningful instructions in it, it may cause error.
Is there any better solution of definition of printk that can greatly reduce
size?

BTW, I see many function definitions in kernel using "do {} while(0);". Do
they have this kind of potential problem, too?

Regards,
Colin




----- Original Message ----- 
From: "Andrew Morton" <akpm@osdl.org>
To: "Vadim Lobanov" <vlobanov@speakeasy.net>
Cc: <pazke@donpac.ru>; <colin@realtek.com.tw>;
<linux-kernel@vger.kernel.org>
Sent: Tuesday, September 20, 2005 4:03 PM
Subject: Re: CONFIG_PRINTK doesn't makes size smaller


> Vadim Lobanov <vlobanov@speakeasy.net> wrote:
> >
> > On Tue, 20 Sep 2005, Andrey Panin wrote:
> >
> > > On 263, 09 20, 2005 at 02:14:55PM +0800, colin wrote:
> > > >
> > > > Hi there,
> > > > I tried to make kernel with CONFIG_PRINTK off. I considered it
should become
> > > > smaller, but it didn't because it actually isn't an empty function,
and
> > > > there are many copies of it in vmlinux, not just one. Here is its
> > > > definition:
> > > >     static inline int printk(const char *s, ...) { return 0; }
> > > >
> > > > I change the definition to this and it can greatly reduce the size
by about
> > > > 5%:
> > > >     #define printk(...) do {} while (0)
> > > > However, this definition would lead to error in some situations. For
> > > > example:
> > > >     1. (printk)
> > > >     2. ret = printk
> > > >
> > > > I hope someone could suggest a better definition of printk that can
both
> > > > make printk smaller and eliminate errors.
> > >
> > > What about the macro below ?
> > >
> > > #define printk(...) ({ do { } while(0); 0; })
> >
> > So what does the do-while loop give us in the above case? In other
> > words, why not just do the following...?
> >
> > #define printk(...) ({ 0; })
> >
>
> You may find that when printk() is a static inline there are still copies
> of the control string in the generated kernel image:
>
> printk("foo %d\n", bar());
>
> must still evaluate bar() and may cause "foo %d\n" to turn up in vmlinux.
> IIRC later versions of gcc do remove the unreferenced string.
>
> If printk is a macro, it all of course disappears.

