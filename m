Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281797AbRLUNzD>; Fri, 21 Dec 2001 08:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281809AbRLUNyx>; Fri, 21 Dec 2001 08:54:53 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:39439 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281797AbRLUNyl>;
	Fri, 21 Dec 2001 08:54:41 -0500
Date: Fri, 21 Dec 2001 11:54:38 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: SteveW@ACM.org, jschlst@samba.org, ncorbic@sangoma.com, eis@baty.hanse.de,
        dag@brattli.net, torvalds@transmeta.com, marcelo@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC 3] cleaning up struct sock
Message-ID: <20011221115438.A5990@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, SteveW@ACM.org,
	jschlst@samba.org, ncorbic@sangoma.com, eis@baty.hanse.de,
	dag@brattli.net, torvalds@transmeta.com, marcelo@conectiva.com.br,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20011218.130809.22018359.davem@redhat.com> <20011218232222.A1963@conectiva.com.br> <20011220012339.A919@conectiva.com.br> <20011220.002126.119272610.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011220.002126.119272610.davem@redhat.com>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 20, 2001 at 12:21:26AM -0800, David S. Miller escreveu:
>    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
>    Date: Thu, 20 Dec 2001 01:23:39 -0200
> 
>    Available at:
>    
>    http://www.kernel.org/pub/linux/kernel/people/acme/v2.5/2.5.1/
>    sock.cleanup-2.5.1.patch.bz2
> 
> Looking pretty good.  I have one improvement.
> 
> I'd rather you pass the "kmem_cache_t" directly into sk_alloc, use
> NULL for "I don't have any extra private area".
> 
> And then, for the IP case lay it out like this:
> 
> 	struct sock
> 	struct ip_opt
> 	struct {tcp,raw4,...}_opt
> 
> And use different kmem_cache_t's for each protocol instead of
> the same one for tcp, raw4, etc.
> 
> RAW/UDP sockets waste a lot of space with your current layout.

Indeed it wastes, but the current setup in the stock kernel wastes even more ;)

Well, did what you suggested, adding a slab parameter to sk_alloc and I
also overloaded zero_it but its current behaviour is maintained, i.e., 0 ==
don't zeroes the newly allocated sock, 1 == zeroes it, the overloading is:
1 == sizeof(struct sock), > 1 == objsize of the per protocol slabcache. For
now I did only to UDPv4 sockets, will do the others this afternoon, this is
the result so far:

[rama2 kernel-acme]$ grep sock /proc/slabinfo
unix_sock   7   20   400  1  2  1 :  17   572 2 0  0
udp_sock    6   10   372  1  1  1 :   7    31 1 0  0
tcp_sock   13   15   800  3  3  1 :  13    46 3 0  0
sock        0    0   336  0  0  1 :   0     0 0 0  0

Now UDP sockets use only 372 bytes while in the stock kernel it uses 1280
bytes when all the protocols are selected (as modules or statically
linked, but more than 1 KB when just TCP/IP v4 is selected).

More to come. Patch will be available later today.

- Arnaldo
