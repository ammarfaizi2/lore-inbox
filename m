Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267546AbTBUP7E>; Fri, 21 Feb 2003 10:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267547AbTBUP7E>; Fri, 21 Feb 2003 10:59:04 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:24715 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S267546AbTBUP7A>; Fri, 21 Feb 2003 10:59:00 -0500
Message-Id: <200302211608.h1LG8tGi014271@locutus.cmf.nrl.navy.mil>
To: Mitchell Blank Jr <mitch@sfgoth.com>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [ATM] who 'owns' the skb created by drivers/atm? 
In-reply-to: Your message of "Thu, 20 Feb 2003 22:24:04 PST."
             <20030220222404.B11525@sfgoth.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 21 Feb 2003 11:08:55 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030220222404.B11525@sfgoth.com>,Mitchell Blank Jr writes:
>Hmmmm.. I guess we've just been getting lucky before in that case - we've
>always just left the ATM_SKB() stuff in there.

i think fortunate might be a better word.  comparing the two:

struct atm_skb_data {
        struct atm_vcc  *vcc;       
        int             iovcnt;    
        unsigned long   atm_options;
};

struct inet_skb_parm
{
	struct ip_options {
	  __u32         faddr;
	  unsigned char optlen;
	  unsigned char srr;
	  unsigned char rr;
	  unsigned char ts;
...
}

surprising you only run into trouble on some 64bit platforms.  at this
point the atm_vcc* overlaps with optlen and chaos ensues.  on a somewhat
related note, i believe iovcnt is probably obselete.  skb's support
scatter/gather.

>Chas - I guess you should just do a memset(skb->cb, 0, sizeof(skb->cb))
>just before the netif_rx() in {clip,lec,mpc}.c and before the ppp_input()
>in pppoatm.c to make sure it's zeroed correctly.

this is one option.  the other would be to clone the skb and pass the
clone to the ip layer.  the last option, and the one i prefer, would
be to make the atm drivers not modify skb->cb (or reset it) when passing
up the skb.  the atm socket layer doesnt rely on it, and it would keep
the 'extra' processing to a minimum.
