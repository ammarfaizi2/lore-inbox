Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282966AbRLQWrG>; Mon, 17 Dec 2001 17:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282993AbRLQWq5>; Mon, 17 Dec 2001 17:46:57 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:41677 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S282966AbRLQWqn>;
	Mon, 17 Dec 2001 17:46:43 -0500
Date: Mon, 17 Dec 2001 14:45:49 -0800
To: Martin Diehl <lists@mdiehl.de>
Cc: Pawel Kot <pkot@linuxnews.pl>, Dag Brattli <dagb@cs.uit.no>,
        linux-kernel@vger.kernel.org, linux-irda@pasta.cs.uit.no
Subject: Re: [BUG()] IrDA in 2.4.16 + preempt
Message-ID: <20011217144549.B3647@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <Pine.LNX.4.33.0112141128300.662-100000@urtica.linuxnews.pl> <Pine.LNX.4.21.0112161338110.444-100000@notebook.diehl.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0112161338110.444-100000@notebook.diehl.home>; from lists@mdiehl.de on Mon, Dec 17, 2001 at 10:28:45AM +0100
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 10:28:45AM +0100, Martin Diehl wrote:
> 
> [Jean added to CC]
> 
> On Fri, 14 Dec 2001, Pawel Kot wrote:
> 
> > I found an annoying problem with irda on 2.4.16.
> > When I remove irlan module I get sementation fault:
> > root@blurp:~# rmmod irlan
> > Dec 14 02:27:35 blurp kernel: kernel BUG at slab.c:1200!
> > Dec 14 02:27:35 blurp kernel: invalid operand: 0000
> > Dec 14 02:27:35 blurp kernel: CPU:    0
> > Dec 14 02:27:35 blurp kernel: EIP:    0010:[kmem_extra_free_checks+81/140] Not tainted
> [...]
> > Dec 14 02:27:35 blurp kernel: Process rmmod (pid: 110, stackpage=cc045000)
> [..]
> > Dec 14 02:27:35 blurp kernel: Call Trace:


	Where is this comming from ? Was it sent to the IrDA mailing list ?


>  [kfree+450/576]
>  [netdev_finish_unregister+145/152]
>  [unregister_netdevice+451/632]
>  [unregister_netdev+16/40]
> 
> Seems some inconsistency in the way how the irlan netdev is handled:
> having NETIF_F_DYNALLOC set for a netdev which is not allocated as an
> independent object doesn't seem to be a good idea to me ;-)
> 
> The patch below simply removes NETIF_F_DYNALLOC just before calling
> unregister_netdev() und should fix the issue. It's untested however,
> since I'm unable to reproduce the Oops on UP without preempt (but it
> should be there as well, due to ipfrag_time for example). At least it
> compiles and doesn't do any harm to me.

	Why don't you just fix irlan_eth_init() ? The NETIF_F_DYNALLOC
is only used in the unregister_netdevice() functions (check your
kernel), so it's cleaner to never set the flag in the first place.

	Also : I suspect the Dag added this flag as a workaround for
some refcount problem, because with it the code does one more unref
that without. So, I suspect the refcount is broken. By the way, this
flag doesn't change the behaviour as far as waiting for people that
hold some refcount on the device.

> IMHO, retiring dynalloc is just some sort of band-aid because I do
> believe, using it would be a good idea - but would need some more
> changes for irlan.

	No, that the right way. NETIF_F_DYNALLOC is only ever used for
that. One the other hand, you might need to fix the refcount.

> Btw., I'm not sure about the status of irlan - I'm only using ppp over
> ircomm or irnet.

	Same for me.

> HTH
> Martin

	Have fun...

	Jean
