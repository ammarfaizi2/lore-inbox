Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315423AbSEYXA2>; Sat, 25 May 2002 19:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315425AbSEYXA1>; Sat, 25 May 2002 19:00:27 -0400
Received: from berta.E-Technik.Uni-Dortmund.DE ([129.217.182.12]:49157 "HELO
	kt.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S315423AbSEYXA0>; Sat, 25 May 2002 19:00:26 -0400
Date: Sun, 26 May 2002 01:00:25 +0200
From: Wolfgang Wegner <ww@kt.e-technik.uni-dortmund.de>
To: Wolfgang Wegner <ww@kt.e-technik.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: sk_buff modification problem
Message-ID: <20020526010025.A18021@bigmac.e-technik.uni-dortmund.de>
In-Reply-To: <20020524100434.B1778@bigmac.e-technik.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as my first post was a bit confused maybe, I try again - hopefully
more specific...

i am trying to do a modification in the kernel to get a more precise
timestamp directly from a modified network driver, and am having some
difficulty (or maybe misunderstanding) with sk_buff's... Kernel used
is 2.4.18.

Here's a list what I modified:

- struct sk_buff has a new member, struct ww_timestamp rcvtime, containing
  the actual timestamp and a flag is_valid. The flag is initialized to
  "0" in alloc_skb as well as skb_headerinit, and the complete struct
  is copied in skb_clone and copy_skb_header.
- the driver (currently orinoco.c from pcmcia_cs) is modified to fill
  the my_timestamp struct and sets is_valid.
- when passing the packet to a socket, this new timestamp is evaluated
  (in sock_recv_timestamp, where both sk_buff _and_ sock are known)

The problem is: in sock_recv_timestamp, is_valid is reset to 0 - and i
have no idea why. To track it down I tried to put some printk's in the
sk_buff handling functions and sock_recv_timestamp, but it seems there
is not even any copying done (as "&skb" is the same in orinoco.c and
sock_recv_timestamp):

> May 24 08:55:43 licht kernel: skb_head_from_pool, skb=cfaa6d80
> May 24 08:55:43 licht kernel: orinoco.c: skb=cfaa6d80
> May 24 08:55:43 licht kernel: skb=cfaa6d80, timestamp.is_valid=0!
> May 24 08:55:43 licht kernel: skb_head_from_pool, skb=cfaa6d80
> May 24 08:55:43 licht kernel: skb_head_from_pool, skb=cf0fa200

In case somebody wants to look at it, the patch is at
http://www-kt.e-technik.uni-dortmund.de/m_ww/l-k/patch-2.4.18-ww3.gz
and the orinoco_ev_rx part of orinoco.c is at
http://www-kt.e-technik.uni-dortmund.de/m_ww/l-k/orinoco.c

I am really out of ideas here, especially I do not know how to
debug it, because I do not see any further possibility where (and
why) the value gets overwritten.

Thanks,
Wolfgang

