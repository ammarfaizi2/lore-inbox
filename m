Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285134AbSAGB1P>; Sun, 6 Jan 2002 20:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286238AbSAGB1G>; Sun, 6 Jan 2002 20:27:06 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:41997 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S285134AbSAGB0q>;
	Sun, 6 Jan 2002 20:26:46 -0500
Date: Mon, 7 Jan 2002 12:25:55 +1100
From: Anton Blanchard <anton@samba.org>
To: Dave Jones <davej@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: results: Remove 8 bytes from struct page on 64bit archs
Message-ID: <20020107012555.GA6623@krispykreme>
In-Reply-To: <20020106.060824.106263786.davem@redhat.com> <Pine.LNX.4.33.0201061542450.3859-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201061542450.3859-100000@Appserv.suse.de>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> I'm curious to see how large the tradeoff is with calculating
> virtual in page_address(). The overhead there may be larger than
> the win we get from better cacheline footprint in struct page

Check out:

http://samba.org/~anton/linux/struct_page/

"struct page can be hazardous to your health"

On this machine (2 way power3) we see a ~5% improvement on dbench by
removing ->zone. Quite a nice improvement.

When we also remove ->virtual and use pointer arithmetic to do
page_address() performance drops back down. The reason for this can
be found in:

http://samba.org/~anton/linux/struct_page/2.4.18pre1-nopagezone-nopagevirtual/2/6.html

Search for divd, remembering the percentage to the left is shifted one
instruction down. Yes divides really hurt.

Basically the difference is:


page_address() using page->virtual:

        ld 25,112(31)


page_address() using pointer arithmetic:

.LC1:
        .quad   mem_map
.LC2:
        .quad   0xc000000000000000

...

        ld 9,.LC1
        li 11,120		; sizeof(struct page)
        ld 10,.LC2
        ld 0,0(9)
        subf 0,0,31
        divd 0,0,11
        sldi 0,0,12
        add 25,0,10


Perhaps the compiler should be optimising this better (can we replace
the divide?)

Anton
