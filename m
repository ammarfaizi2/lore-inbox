Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313258AbSDDQpW>; Thu, 4 Apr 2002 11:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313261AbSDDQpN>; Thu, 4 Apr 2002 11:45:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:45106 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313257AbSDDQo4>; Thu, 4 Apr 2002 11:44:56 -0500
Date: Thu, 4 Apr 2002 18:44:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@redhat.com>
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Message-ID: <20020404184405.C32431@dualathlon.random>
In-Reply-To: <Pine.LNX.4.33.0204041245340.1475-100000@einstein.homenet> <Pine.LNX.4.44.0204040747260.25330-100000@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 08:26:50AM -0500, Ingo Molnar wrote:
> the moment you start to argue 'but why cannot we just add this set of
> EXPORTs and put our binary-only modules here and there' you are in essence
> questioning our freedom to specify the license of our work. You are
> abusing the internal modularization mechanizm to put in code that we
> cannot debug, cannot read and cannot develop and cannot support in any
> reasonable way. It's like exchanging kernel/sched.o with your binary-only

adding export symbol here and there it's the same thing you did in the
redhat kernel and in your tux patches here:

diff -urN net-ref/net/netsyms.c net/net/netsyms.c
--- net-ref/net/netsyms.c	Mon Feb 25 22:05:09 2002
+++ net/net/netsyms.c	Tue Mar 26 19:56:32 2002
@@ -108,6 +108,8 @@
 EXPORT_SYMBOL(sock_create);
 EXPORT_SYMBOL(sock_alloc);
 EXPORT_SYMBOL(sock_release);
+EXPORT_SYMBOL(sock_map_fd);
+EXPORT_SYMBOL(sockfd_lookup);
 EXPORT_SYMBOL(sock_setsockopt);
 EXPORT_SYMBOL(sock_getsockopt);
 EXPORT_SYMBOL(sock_sendmsg);
@@ -324,6 +326,7 @@
 EXPORT_SYMBOL(memcpy_fromiovecend);
 EXPORT_SYMBOL(csum_partial_copy_fromiovecend);
 EXPORT_SYMBOL(tcp_v4_lookup_listener);
+EXPORT_SYMBOL(cleanup_rbuf);
 /* UDP/TCP exported functions for TCPv6 */
 EXPORT_SYMBOL(udp_ioctl);
 EXPORT_SYMBOL(udp_connect);
@@ -341,6 +344,7 @@
 EXPORT_SYMBOL(tcp_getsockopt);
 EXPORT_SYMBOL(tcp_recvmsg);
 EXPORT_SYMBOL(tcp_send_synack);
+EXPORT_SYMBOL(tcp_send_skb);
 EXPORT_SYMBOL(tcp_check_req);
 EXPORT_SYMBOL(tcp_child_process);
 EXPORT_SYMBOL(tcp_parse_options);

There is no difference at all with what you did above and with my
removal of the _GPL tag from the vmalloc_to_page and the above patch in
tux. According to Alan also the above if done in the US is equivalent
to:

	-	subverting a digital rights management system
                        [5 years jail in the USA]
        -       breaking a license

There's no difference at all, you're also exposing those GPL functions
to potential non GPL drivers out there, without asking all the authors
and contributors of such code first.

This shows how much Alan claim can hold legally, if it can then you're
in trouble in the first place. There's not such thing as a "legal"
kernel that defines the allowed EXPORT_SYMBOL, all kernel trees out
there can be modifed freely, they all have the same legal rights, you
haven't more right than me to add EXPORT_SYMBOL here and there for tux
and altering the EXPORT_SYMBOL has nothing to do with the licence of the
exported sourcecode. It's not that if you do it for tux then I cannot do
it for my own module (no matter if it's binary only or not, that still
is "subverting a digital rights management system" according to Alan).

And the whole point is that it doesn't matter if the module calls
vmalloc_to_page or tcp_send_skb directly via EXPORT_SYMBOL or not, still
the non GPL module can call it indirectly. See below:

For istance I can very well implement a kernel function under the GPL
into the kernel called vmalloc_to_page_for_nongpl, and then I can export
such function that incidentally goes to recall vmalloc_to_page.  And
that's perfectly legal because vmalloc_to_page_for_nongpl is GPL and it can call
vmalloc_to_page. Now if you claim that that's not legal, then I claim
all binary only drivers out there are completly illegal, because they
all goes to recall shrink_cache indirectly, and nobody ever asked me if
shrink_cache can be recalled indirectly from a non GPL module.

So unless I've really the right to make all the GPL drivers out there
illegal to use in 2.4 and 2.2, then you can always write GPL wrappers,
to work around the _GPL tagged symbols and this in turn means the _GPL
tag is completly useless and it should be avoided and that we can export
whatever we need.

My understanding is that what the GPL forbids, is for Microsoft to take
your sched.c module and to put it into Windows, that's where BSD is very
bad about. The only thing that can be hidden is the part they wrote
themself, just like with device drivers, the hidden part is the device
driver, they cannot take the kernel and release a binary only statically
linked kernel, only their part can be hidden, your part has to remain
open and if they want to change it their changes must remain open. All
the other arguing about EXPORT_SYMBOL legal issues cannot hold legally I
think, they're emotional and about "moral abuse", not about anything
legal or logical or technical or priorly written anywhere.

Now if my understanding is wrong, I'd like to know of course, I'm not
expert here, but the only logical thing I'm sure about is that if it's
illegal for me to export my GPL wrapper then I've just the right to
make all non GPL drivers illegal, that is the only logical sure thing
that can be deducted. And yes, I'd be really happy if I'd that right.

Everybody should realize that binary only modules are inferior and that
it's a great pain to deal with them and they should be avoided to all
possible extents. I said, I ignore them, I never used a binary only
module in my life, and finally I will break them without care (not
intentionally though). The reason I'm looking into this issue is infact
that I _broke_ them with pte-highmem and so I wanted to teach those guys
that they've to use vmalloc_to_page instead if they want their driver to
work correctly with >800M of ram.

Andrea
