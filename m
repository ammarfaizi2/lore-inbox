Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261588AbSIXHB7>; Tue, 24 Sep 2002 03:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261589AbSIXHB7>; Tue, 24 Sep 2002 03:01:59 -0400
Received: from dp.samba.org ([66.70.73.150]:64698 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261588AbSIXHBx>;
	Tue, 24 Sep 2002 03:01:53 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38) 
In-reply-to: Your message of "Tue, 24 Sep 2002 02:11:56 -0400."
             <3D90022C.3060300@pobox.com> 
Date: Tue, 24 Sep 2002 16:58:12 +1000
Message-Id: <20020924070706.D84CA2C1A7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D90022C.3060300@pobox.com> you write:
> right, that's a bug, it needs struct net_device * like the standard 
> Becker style.

And Andrey Savochkin is no idiot.  But if he had a standard
problem-reporting macro to guide him, he wouldn't have done this.

> 
> >>>-		printk (KERN_ERR "eepro100: cannot reserve MMIO region\n");
> >>>+		pci_problem(LOG_ERR, pdev, "eepro100: cannot reserve MMIO regio
> >>
> > n");
> > 
> >>bloat, no advantage over printk
> > 
> > 
> > Now, which of those 5 cards was it again?
> 
> Another bug, this driver should be using pci_request_regions() which 
> prints that stuff out :)

Ditto.

> Does IBM want to submit a patch that cleans up these problems, and makes 
> the existing event logging more standard [and is compatible with 
> existing 2.4 and 2.5 kernels]?

(Um, this is supposed to go into the 2.5 kernel, so the last arg is
void).

This doesn't deprecate printk().  It just formalizes printk() for
problem reporting inside drivers.  As we see more tools come out
making this useful, I expect drivers will willingly change across.
You can ensure that each message says what the driver name and kernel
version is if you want, *without* changing every driver.

You can do this with some "printk templates", but *that* would be too
ugly to live:

	#include <linux/net_templates.h>
	...
	printk(NETPROBLEM_27, dev, skb);
	...

> As an aside, changing all those printks also introduces a _huge_ PITA 
> for driver developers porting drivers back and forth between 2.4 and 2.5.

That's not a good reason.  compat.h can define them into printks with
a bit of cpp magic.  In fact, Werner already wrote that.  Hmm... the
one in the patch they posted is not based on Werner's, but my older
work.  It should look vaguely like:

/* Do not meddle in the affairs of cpp, for it is subtle, and quick to anger */
#define __detS_
#define __detV_

#define __detS_detail(label,format,value) " " #label "=" format
#define __detV_detail(label,format,value) value,

#define __detV_3(detail) detail
#define __detV_2(detail,...) detail __detV_3( __detV_ ## __VA_ARGS__)
#define __detV_1(detail,...) detail __detV_2( __detV_ ## __VA_ARGS__)

#define __detS_3(detail) detail
#define __detS_2(detail,...) detail __detS_3( __detS_ ## __VA_ARGS__)
#define __detS_1(detail,...) detail __detS_2( __detS_ ## __VA_ARGS__)

#define recovered(id, msg, ...)						     \
	printk(KERN_WARNING "%p:%s:" __detS_1( __detS_ ## __VA_ARGS__) "%c", \
	       id, msg, __detV_1( __detV_ ## __VA_ARGS__) '\n')

#define problem(id, msg, ...)						 \
	printk(KERN_ERR "%p:%s:" __detS_1( __detS_ ## __VA_ARGS__) "%c", \
	       id, msg, __detV_1( __detV_ ## __VA_ARGS__) '\n')

#define introduce(id, name, ...)				\
	printk(KERN_INFO "Introducing %p:%s:"			\
	       __detS_1( __detS_ ## __VA_ARGS__) "%c", 		\
	       id, msg, __detV_1( __detV_ ## __VA_ARGS__) '\n')

#define unintroduce(id)					\
	printk(KERN_INFO "Unintroducing %p\n", id)

================

Now, these were the previous macros which didn't have a severity arg,
but you get the idea.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
