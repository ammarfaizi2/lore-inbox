Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136458AbRD3GkL>; Mon, 30 Apr 2001 02:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136459AbRD3GkB>; Mon, 30 Apr 2001 02:40:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35989 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136458AbRD3Gj6>;
	Mon, 30 Apr 2001 02:39:58 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15085.2216.4509.498498@pizda.ninka.net>
Date: Sun, 29 Apr 2001 23:39:35 -0700 (PDT)
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Fabio Riccardi <fabio@chromium.com>, <mingo@elte.hu>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, <David_J_Morse@Dell.com>
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <Pine.LNX.4.33.0104292207530.14261-100000@twinlark.arctic.org>
In-Reply-To: <3AEC86B7.119362D9@chromium.com>
	<Pine.LNX.4.33.0104292207530.14261-100000@twinlark.arctic.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


dean gaudet writes:
 > is this too slow for some reason?  (does it play well with zero-copy?)

His trick ends up with a minimal set of scatter gather entries.
That's the whole gain behind the trick he's doing.

If you do the TCP_CORK thing, what you end up with is a scatter gather
entry in the SKB for the header bits, then the page cache segments.

Even if we had the HP sendfile() interface iovec garbage, we would end
up with the same number of SKB iovec entries as for the TCP_CORK case
today.

What TUX basically does is build up the header by hand in a scribble
page it uses for header builing, passes that to tcp_sendpage() with
MSG_MORE set, then it initiates the sendfile() part.  The final effect
inside the networking is basically equivalent to using
TCP_CORK+sendfile() in userspace, the only difference being that:

1) the scratch page for the headers is maintained per-socket by TCP
2) the header is copied once from user to kernel

I would find it amusing to see what adding the header+file caching
trick to TUX would do to it's results :-)

Later,
David S. Miller
davem@redhat.com
