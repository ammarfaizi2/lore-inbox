Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUEDWlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUEDWlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 18:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUEDWlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 18:41:24 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:39947 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261236AbUEDWlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 18:41:14 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] deinline large functions in sock.h
Date: Wed, 5 May 2004 01:41:00 +0300
User-Agent: KMail/1.5.4
Cc: "David S. Miller" <davem@redhat.com>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org
References: <200405030050.40077.vda@port.imtp.ilyichevsk.odessa.ua> <20040503160000.56087d22@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040503160000.56087d22@dell_ss3.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405050141.00556.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Inline staistics for this file:
> >
> >  Size Uses Wasted Name and definition
> > ===== ==== ====== ================================================
> >   381   21   7220 sock_queue_rcv_skb    include/net/sock.h
>
> yup, this looks long.
>
> >   101   18   1377 sock_orphan   include/net/sock.h
>
> only used in close, release path

Okay, so is it pro- or contra- argument for inlining?

> >    90   18   1190 sk_del_node_init      include/net/sock.h
> >   150    8    910 sk_dst_reset  include/net/sock.h
> >    44   31    720 skb_set_owner_w       include/net/sock.h
> >    53   18    561 sk_add_node   include/net/sock.h
>
> in main path, and should be small for most cases
>
> >    61   10    369 sock_recv_timestamp   include/net/sock.h
>
> probably critical path, be careful.

I did not touch it, it's 60 bytes (less than 90).

> >    55   10    315 sock_i_ino    include/net/sock.h
> >    55    9    280 sock_i_uid    include/net/sock.h
> >    97    4    231 sk_filter     include/net/sock.h
> >   236    2    216 sk_dst_check  include/net/sock.h
>
> only used by udp and decnet, probably not a big win.

Again, I didnt understand here what do you mean:
"ok to deinline" or "keep inlined" ?

> >   194    2    174 sock_queue_err_skb    include/net/sock.h
> >   103    3    166 sock_graft    include/net/sock.h
> >    66    3     92 sk_dst_get    include/net/sock.h
> >    63    3     86 __sk_dst_reset        include/net/sock.h
> >    45    4     75 __sk_dst_check        include/net/sock.h
> >    63    2     43 __sk_dst_set  include/net/sock.h
> >    46    2     26 sk_filter_release     include/net/sock.h
> >    46    2     26 sk_add_bind_node      include/net/sock.h
> >    46    2     26 __sk_add_node include/net/sock.h
> >
> > Included are two patches. They deinline functions which are larger
> > than ~90 bytes.
> >
> > Why two patches? I realize that since inlining/deinlining of
> > a function can happen multiple times as kernel evolves,
> > it can be very inconvenient to move function definition
> > from .h to .c file and back.
> >
> > First patch simply does such a move.
> >
> > Second does not. Instead it adds _inlined suffix to
> > the functions and a controlling #define. If it is #defined to 1,
> > function will be inlined. Otherwise not.
> > At the first glance it looks, well, ugly as hell:
>
> It still look ugly, just make up your mind. and do it or not!

I thought about functions becoming larger/smaller
when somebody modifies logic of relevant network subsystem.
One-liners may turn into ten-liners, and vice versa.

> > Ugliness can be reduced somewhat with macros.
>
> No macro's generally increase ugliness sorry.

I don't push it. Just wanted to know what others think.
--
vda

