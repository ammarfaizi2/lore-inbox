Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269842AbRHDJwb>; Sat, 4 Aug 2001 05:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269845AbRHDJwV>; Sat, 4 Aug 2001 05:52:21 -0400
Received: from [193.14.164.225] ([193.14.164.225]:17171 "EHLO wlug.westbo.se")
	by vger.kernel.org with ESMTP id <S269842AbRHDJwL>;
	Sat, 4 Aug 2001 05:52:11 -0400
Date: Sat, 4 Aug 2001 11:30:50 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Stefan Burkei <stefan@burkei.de>
cc: "'@Linux Kernel Miller, David S.'" <davem@redhat.com>,
        "'@Linux Kernel Ostrowski, Michal'" <mostrows@us.ibm.com>,
        "'@Linux Kernel Mailingliste'" <linux-kernel@vger.kernel.org>
Subject: Re: oops in skbuff.c
In-Reply-To: <000001c11c64$f3bc5d40$3100000a@sb>
Message-ID: <Pine.LNX.4.30.0108041128410.785-100000@wlug.westbo.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan.

Marc Boucher of netfilter fame posted this patch
to various lists two days ago.

http://marc.theaimsgroup.com/?l=linux-netdev&m=99660200431340&w=2

According to people on the netfilter-lists this patch fixes the problems
they have been having with netfilter and pppoe.

But there might be an even newer patch in the netfilter CVS patch-o-matic,
please check that out. You have cvs instructions on the netfilter page:

http://netfilter.samba.org
http://netfilter.gnumonks.org

then run 'make patch-o-matic' in the netfilter/userspace directory

/Martin



On Fri, 3 Aug 2001, Stefan Burkei wrote:

> Hi,
>
> I'm using Kernel 2.4.7 (i think with the actual
> pppoe-patches 0.6.8) and it still oopses on the
> same place - in the routine skb_drop_fraglist.
>
> My Linux-Box acts as a NAT-Router to the Internet
> for my Win98-Clients with a german DSL-Connection
> using pppoe with pppd 2.4.1.
> With pppd 2.4.0 the result is the same.
>
> The problem appears with Kernel 2.4.4 and
> is always reproducable since then.
> I start on my Win98-Box the Gnutella-Client
> BearShare and don't have to wait longer
> than 10 sec. until the machine crashes.
>
> I figured out, that the kernel attempts to free
> a fraglist in the routine skb_drop_fraglist with
> an invalid pointer to it.
> During one pppd-session this "pointer" has
> always the same (i think) false value. The
> high word is always zero and the low word doesn't
> change during one online session of pppd.
> The low word will have a new value on the next
> dialup of pppd. Again - this value stays in place
> until the pppd hangs up.
>
> I use a short code fragment to check this invalid
> pointer and, if detected, jumps over the kfree-routine.
> This isn't a really patch, because the real error wasn't
> corrected - but the kernel remains stable since then.
>
> This here is my skb_drop_fraglist-routine:
>
> static void skb_drop_fraglist(struct sk_buff *skb)
> {
>         struct sk_buff *list = skb_shinfo(skb)->frag_list;
>
>         skb_shinfo(skb)->frag_list = NULL;
>
>         if ((unsigned long)list & 0xffff0000) {
>             do {
>                     struct sk_buff *this = list;
>                     list = list->next;
>                     kfree_skb(this);
>             } while (list);
>         } else
>             printk(KERN_WARNING "Warning: skb_drop_fraglist() \
> 	    invalid pointer detected: %08lx.\n", (unsigned long)list);
> }
>
>
> I hope I can give you two a hint on your bug-hunting.
>
> ciao - stebu
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
Linux hackers are funny people: They count the time in patchlevels.

