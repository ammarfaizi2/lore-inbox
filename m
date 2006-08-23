Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWHWKwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWHWKwF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWHWKwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:52:04 -0400
Received: from dee.erg.abdn.ac.uk ([139.133.204.82]:19896 "EHLO erg.abdn.ac.uk")
	by vger.kernel.org with ESMTP id S964840AbWHWKwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:52:02 -0400
From: gerrit@erg.abdn.ac.uk
To: davem@davemloft.net
Subject: [RFC][PATCH 0/3] net: a lighter UDP-Lite (RFC 3828)
Date: Wed, 23 Aug 2006 11:50:37 +0100
User-Agent: KMail/1.8.3
Cc: jmorris@namei.org, alan@lxorguk.ukuu.org.uk, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, kaber@coreworks.de, yoshfuji@linux-ipv6.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200608231150.37895@strip-the-willow>
X-ERG-MailScanner: Found to be clean
X-ERG-MailScanner-From: gerrit@erg.abdn.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[NET/IPV4]: a lighter UDP-Lite (RFC 3828)

This is a revised RFC resubmission of the UDP-Lite code	which, thanks
to suggestions by David Miller, is now drastically reduced in size:

   ``A fully functional UDP-Lite module in a mere 209 lines !''

I feel that not much more can be removed without making the code obfuscated,
but would like to challenge people on this list to look out for further 
possible integration and reductions. 

I would further like to hear suggestions for a common naming scheme, after 
some of the UDP functions have been made generic, shared between both UDP
and UDP-Lite. 

I will wait with the UDP(-Lite)v6 part until feedback and comments have been
received: the v6-side will mirror the format of the v4-side.

To get a quick idea of what is happening, it is best to start with udplite.c,
since this also lists all the shared functions. This file is #included into 
udp.c -- I did want to keep functionally different blocks of code logically 
separate, but could not see the need for separate compilation.

A detailed changelog is included below. 

The code has been tested over several days on i686, i386-SMP, AMD,
and sparc64 platforms; using various userland and kernel applications
such as multicast streaming, DNS, socket programs, NFS client/server
(different file sizes); and on hardware with TX/RX UDP checksums (tg3).

Enclosed patch can be applied to Torvald's tree. Application code for testing is on
http://www.erg.abdn.ac.uk/users/gerrit/udp-lite/files/udplite_linux.tar.gz


                    *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
                    Important things that need to be resolved
                    *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

a)  Naming scheme: Several functions are now generic, shared between UDP and UDP-Lite. 
    They have not been given new names so far. Which naming scheme should be used ???
    [e.g.  `udpl_checksum_complete() instead of `udp_checksum_complete()' ?] 

b)  udp_v{4,6}_get_port(): raised earlier, this function appears almost identical in
    two places. There has been discussion, resubmission, but no final opinion yet. 
    Can people please decide whether the suggested integration is OK or not -- the single
    get_port algorithm now has a total of four customers: udp4, udplite4, udp6, udplite6.

c)  Code cosmetics: I have left out any cosmetical changes for later, to minimize patch 
    size. But eventually I would like to tidy up the code, in particular add more 
    documentation to the structs and some of the (shared) functions. Suggestions ?

d)  Shared udp_hash_lock: Is it worth to implement separate rwlocks for UDP and UDP-Lite?
    This would make the code quite a lot more complicated and disadvantages will only occur 
    in the borderline case when many UDP applications have to compete at the same time with
    many UDP-Lite applications. But will this result in noticeable performance loss at all?

                                 C h a n g e l o g

1/ Code integration.

 The patch follows David's suggestions. Additionally, the implementation
 was made simpler by exploiting the new `pcflag' member which
                                    struct udp_sock
 now contains. This flag can only be set by UDP-Lite and so uniquely
 distinguishes UDP and UDP-Lite sockets. On UDP sockets, pcflag will
 always be 0 since the structure is zeroed out upon allocation.


2/ No separate UDP-Lite header.

 UDP-Lite does not really define a new header structure, rather it re-interprets the 
 `len' header field of UDP with a different semantics. Therefore, a separate `struct 
 udplitehdr' is not really  necessary  and hides the fact that 75% of the header 
 structures have exactly the same meaning.  Thus UDP-Lite now also uses `struct udphdr', 
 the semantic difference is taken care of by the code.


3/ Code-sharing.

 The following functions can now be shared due to reliance on common structures:
   * udp_disconnect()         (thanks to unified struct udp_sock )
   * udp_v4_mcast_next()      (thanks to unified struct udp_sock )
   * udp_getsockopt()         (thanks to unified struct udp_sock )
   * do_udp_getsockopt()      (thanks to unified struct udp_sock )
   * compat_udp_getsockopt()  (thanks to unified struct udp_sock )
   * udp_encap_rcv()          (thanks to unified struct udphdr )
   * udp_ioctl()              (thanks to unifying both structures)

 The following functions have been turned into parameterised ones:

   * udp_v4_get_port()      -  parameterised as __udp_get_port()
   * udp_v4_lookup()        -  parameterised as __udp_lookup()
   * udp_err()              -  parameterised as __udp_err()
   * udp_v4_mcast_deliver() -  parameterised as __udp_mcast_deliver()
     This was possible thanks to common use of udp_v4_mcast_next(see above).
   * udp_lport_inuse()      -  parameterised as __udp_lport_inuse()
     This function is unnecessary in net/udp.h ! See earlier patch / discussion
     on udp_get_port() in net/ipv6/udp.c
   * udp_rcv()              -  parameterised as __udp_common_rcv()

 Functions shared between UDP and UDP-Lite: in several cases it was more straightforward
 and cleaner to make shared functions udplite-aware than adding even more functions. 

   *   udp_checksum_complete()   and
   * __udp_checksum_complete()
     The entire checksumming code has been revised and integrated; inevitably, the UDP
     checksumming code implements a subset of the UDP-Lite checksumming code, a good reason
     to consolidate both. See also udp(lite)_checksum_init(), udp(lite)_csum_outgoing().
   * udp_recvmsg()
     Required minor modifications in 3 places, thanks to unified checksumming procedures.
   * udp_poll()
     The task which udp_poll tackles is the same for UDP and UDP-Lite. The gain is
     that a separate `struct proto_ops' is not necessary for udplite, the modification
     is trivial thanks to shared checksum routines.
   * udp_sendmsg()
     Required only 6 minor changes, removing 189 lines out of udplite.c.
   * udp_push_pending_frames()
     All checksumming code has been externalized into udp(lite)_csum_outgoing(),
     which are called accordingly. Also makes it easier to compare UDP/-Lite checksumming.
   * udp_sendpage()
     Modifications required one variable and two conditionals.
   * udp_queue_rcv_skb()
     Thanks to udp_encap_rcv() and unified checksum processing, the differences
     essentially amount to updating the MIB statistics variables.
   * udp_setsockopt()         and
   * compat_udp_setsockopt()  and
   * do_udp_getsocktopt()
     Setsockopt required three additional tests, to avoid setting UDP-Lite options
     on UDP sockets.

 The following functions have been merged with existing UDP functions:

   * udp_check()              -  one-line (not in-line) function which was only called once in v4/udp.c
                                 and not at all in v6/udp.c;  further used an used udphdr as parameter.
   * udp_v4_lookup_longway()  -  Has been renamed into __udp_lookup() and the locking code from 
                                 udp_v4_lookup() has been put in-place.
 These are new functions:	 

  * udp_csum_outgoing()       -  externalizes existing code into self-contained function
  * udplite_csum_outgoing()   -  symmetrical to udp_checksum_outgoing(), also fully self-contained
  * udplite_checksum_init()   -  symmetrical to udp_checksum_init()
  * udplite4_proc_init()      -  simply registers the udplite4-specific seq_afinfo 
  * udplite4_proc_exit()      -  symmetrical to udp4_proc_exit()

 And, finally, there are functions which required no changes and can trivially be shared:

   * udp_v4_hash/unhash()
   * udp_flush_pending_frames()
   * udp_destroy_sock()
   * udp_close()
   * udp_seq_open()           (thanks to an updated udp_iter_state struct)
   * udp_seq_start(), udp_seq_next()
   * udp4_seq_show(), udp_seq_stop()
   * udp_get_first(), udp_get_next()
   * udp4_format_sock()
   * udp_get_idx() 
   * udp_proc_register()
   * udp_proc_unregister()


4/ UDP counter bug.

  The present implementation of UDP increments InDatagrams when the packet is enqueued and increments
  InErrors when the datagram is dequeued later due to a failed checksum (udp_recvmsg(), udp_poll()).
  This behaviour is contrary to RFC 2013 (cf.  http://bugzilla.kernel.org/show_bug.cgi?id=6660).
  The present implementation resolves this bug both for UDP and UDP-Lite by decrementing whenever
  an enqueued datagram is removed due to failed input processing; applications count correctly.


5/ A MIB for UDP-Lite.

  UDP-Lite, a `lighter' UDP, currently re-uses the existing SNMPv2 MIB for UDP (RFC 2013). This is 
  perfectly OK for the moment, since so far there has been no standardization effort for a UDP-Lite
  MIB yet. Experimental UDP-Lite MIB patches will be made available for testing and research purposes, 
  and will be submitted to this list as soon as standardization effort can be discerned.

-- grrtrr
