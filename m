Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264132AbUECXA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbUECXA2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 19:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbUECXA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 19:00:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:47810 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264132AbUECXAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 19:00:16 -0400
Date: Mon, 3 May 2004 16:00:00 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: "David S. Miller" <davem@redhat.com>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deinline large functions in sock.h
Message-Id: <20040503160000.56087d22@dell_ss3.pdx.osdl.net>
In-Reply-To: <200405030050.40077.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200405030050.40077.vda@port.imtp.ilyichevsk.odessa.ua>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2004 00:50:39 +0300
Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:

> Inline staistics for this file:
> 
>  Size Uses Wasted Name and definition
> ===== ==== ====== ================================================
>   381   21   7220 sock_queue_rcv_skb    include/net/sock.h
yup, this looks long.

>   101   18   1377 sock_orphan   include/net/sock.h
only used in close, release path

>    90   18   1190 sk_del_node_init      include/net/sock.h
>   150    8    910 sk_dst_reset  include/net/sock.h
>    44   31    720 skb_set_owner_w       include/net/sock.h
>    53   18    561 sk_add_node   include/net/sock.h
in main path, and should be small for most cases

>    61   10    369 sock_recv_timestamp   include/net/sock.h
probably critical path, be careful.

>    55   10    315 sock_i_ino    include/net/sock.h
>    55    9    280 sock_i_uid    include/net/sock.h
>    97    4    231 sk_filter     include/net/sock.h
>   236    2    216 sk_dst_check  include/net/sock.h
only used by udp and decnet, probably not a big win.

>   194    2    174 sock_queue_err_skb    include/net/sock.h
>   103    3    166 sock_graft    include/net/sock.h
>    66    3     92 sk_dst_get    include/net/sock.h
>    63    3     86 __sk_dst_reset        include/net/sock.h
>    45    4     75 __sk_dst_check        include/net/sock.h
>    63    2     43 __sk_dst_set  include/net/sock.h
>    46    2     26 sk_filter_release     include/net/sock.h
>    46    2     26 sk_add_bind_node      include/net/sock.h
>    46    2     26 __sk_add_node include/net/sock.h
> 
> Included are two patches. They deinline functions which are larger
> than ~90 bytes.
> 
> Why two patches? I realize that since inlining/deinlining of
> a function can happen multiple times as kernel evolves,
> it can be very inconvenient to move function definition
> from .h to .c file and back.
> 
> First patch simply does such a move.
> 
> Second does not. Instead it adds _inlined suffix to
> the functions and a controlling #define. If it is #defined to 1,
> function will be inlined. Otherwise not.
> At the first glance it looks, well, ugly as hell:

It still look ugly, just make up your mind. and do it or not!

> a.h:
> #define F_INLINED 1
> inline int f_inlined()
> {
> ...
> ...
> ...
> }
> #if F_INLINED
> inline int f() { return f_inlined(); }
> #else
> int f();
> #endif
> 
> a.c:
> #if !F_INLINED
> int f() { return f_inlined(); }
> EXPORT_SYMBOL(f);
> #endif
> 
> But it allows you to change inlining of f() in a single
> place - just #define F_INLINED 0. No shuffling function
> bodies around.
> 
> You may notice that patch takes advantage
> of it: there is #define SK_DST_SET_INLINED 1 because
> this function currently has one caller. 'Simple' patch
> deinlines it "to save trouble making another patch when
> another caller will appear". Alternative one does not
> need to bother: "another patch" will be trivial
> in this case.
> 
> Ugliness can be reduced somewhat with macros.

No macro's generally increase ugliness sorry.


> Dave, please let me know whether you like
> such form or not.
> 
> You may apply either of patches, they are both made
> against 2.6.5 (will apply to 2.6.6-rc3 with offset)
> and compile tested against 2.6.6-rc3.
> --
> vda
> 
