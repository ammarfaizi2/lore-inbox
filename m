Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285143AbRLRFg2>; Tue, 18 Dec 2001 00:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285574AbRLRFgT>; Tue, 18 Dec 2001 00:36:19 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:30225 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S285143AbRLRFgF>;
	Tue, 18 Dec 2001 00:36:05 -0500
Date: Tue, 18 Dec 2001 03:35:52 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: SteveW@ACM.org, jschlst@samba.org, ncorbic@sangoma.com, eis@baty.hanse.de,
        dag@brattli.net, torvalds@transmeta.com, marcelo@conectiva.com.br,
        netdev@oss.sgi.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC 2] cleaning up struct sock
Message-ID: <20011218033552.B910@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, SteveW@ACM.org,
	jschlst@samba.org, ncorbic@sangoma.com, eis@baty.hanse.de,
	dag@brattli.net, torvalds@transmeta.com, marcelo@conectiva.com.br,
	netdev@oss.sgi.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011210230810.C896@conectiva.com.br> <20011210.231826.55509210.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011210.231826.55509210.davem@redhat.com>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 10, 2001 at 11:18:26PM -0800, David S. Miller escreveu:
>    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
>    Date: Mon, 10 Dec 2001 23:08:10 -0200
>    
>    David, if you don't like it, I'll happily switch to the big fat
>    union idea, but I think that this is more clean and will avoid us
>    having to patch sock.h every time a new net stack is added to the
>    kernel.
> 
> I'm a little concerned about having to allocate two objects instead of
> one.

ok, this new patch doesn't allocates two objects, just one like it is
today, more below
 
> These things aren't like inodes.  Inodes are cached and lookup
> read-multiple objects, whereas sockets are throw-away and recycled
> objects.  Inode allocation performance therefore isn't that critical,
> but socket allocation performance is.
> 
> Then we go back to the old problem of protocols that can be used to
> embed IP and thus having to keep track of parallel state for multiple
> protocols.  I think your changes did not compromise that for what
> we currently support though.
> 
> I still need to think about this some more....
> 
> You know, actually, the protocols are the ones which call sk_alloc().
> So we could just extend sk_alloc() to take a kmem_cache_t argument.

Well, in this patch I added two new fields to net_proto_family, sk_cachep
and sk_size, so that the current protocols will pass this as zero without
modification and the net_families[proto]->sk_cachep will get the current
sk_cachep slabcache, but the ones that actually initializes the sk_cachep
and sk_size members of net_proto_family will use its private slab cache
that has objsize == sizeof(struct sock) + sizeof(proto_opt), with this I
removed the sk->tp_pinfo altogether and use the macro TCP_PINFO like you
suggested, also net_pinfo is gone and sk->protinfo is just a void pointer
now.

> TCP could thus make a kmem_cache_t which is sizeof(struct sock)
> + sizeof(struct tcp_opt) and then set the TP_INFO pointer to "(sk +
> 1)".
> 
> Oh yes, another overhead is all the extra dereferencing.  To fight
> that we could make a macro that knows the above layout:
> 
> #define TCP_PINFO(SK)	((struct tcp_opt *)((SK) + 1))

yes
 
> So I guess we could do things your way without any of the potential
> performance problems.
> 
> It is going to be a while before I can apply something like this, I
> would like to help Jens+Linus get the new block stuff in shape first.
> This would obviously be a 2.5.x change too.

Ok, this is just for comments, I'll do the modifications that people agree
on here. 

The changes were rather minimal, i.e., tcp already was using this style:

int tcp_foo_function(struct sock* sk)
{
	struct tcp_opt *tp = &sk->tp_pinfo.af_tcp;

and in the patch it just changes it to:

       struct tcp_opt *tp = TCP_PINFO(sk);

in most places.

I could make patches to make the IP_SK case be of similar style of the
current tcp_opt usage (i.e., like the code excerpt above).

This message was sent using the patch 8)

All the protocols, khttpd, netfilter, etc, are already converted to this
new style and the only thing that still has to be done is to remove things
like daddr, saddr, rcv_saddr, dport, sport and other ipv4 specific members
of struct sock. Ah, another thing is to try and make rtnetlink use
sock_register prior to using sk_alloc, so that I can remove the check for
in sk_alloc and net_proto_sk_size for net_families[family] being NULL.

Please let me know if this is something acceptable for 2.5.

The patch is still for 2.4.16, but it should apply cleanly to 2.5.1, I
think. Of course I'll make sure it works with 2.5.1 if it is considered OK.

I'll stop working on it for now till further comments are made by the net
stack maintainers and concentrate on a new task: to do the same thing for
struct inode, where, it seems, we won't even need the per fs slabcaches,
just using a private void pointer 8)

Here is an example of how the slabcaches are:

[acme@rama2 acme]$ grep sock /proc/slabinfo
unix_sock    5     10    396    1    1    1 :     17     735 2 1    0
inet_sock   17     20    800    4    4    1 :     25     207 8 4    0
sock         0      0    332    0    0    1 :      0       0 0 0    0
[acme@rama2 acme]$

And without the patch, using 2.4.16-pre1

[acme@brinquedo linux]$ grep sock /proc/slabinfo
sock        76     84   1056   11   12    2 :     87    4730 19 7    0

With this we get memory savings and performance gains in addition to the
much needed (IMHO) cleanup of include/net/sock.h 8)

On big busy servers these savings can reach over one megabyte of kernel memory,
please correct me if I'm wrong :) IPv6 sockets use about 980 bytes, so for
a kernel with IPv6 compiled even as a module one can get savings even for
the ipv4 sockets case.

Patch available at:

http://www.kernel.org/pub/linux/kernel/people/acme/v2.4/2.4.16/
sock.cleanup-5.patch.bz2

A not so complete changelog is at:
http://www.kernel.org/pub/linux/kernel/people/acme/v2.4/2.4.16/
patch-2.4.16.log

it can be of help in understanding this patch.

Waiting for comments and testers results,

TIA,

- Arnaldo
