Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129266AbRBKNE2>; Sun, 11 Feb 2001 08:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129204AbRBKNEI>; Sun, 11 Feb 2001 08:04:08 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:59042 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129159AbRBKND6>; Sun, 11 Feb 2001 08:03:58 -0500
Message-ID: <3A868FF3.BC7F6679@uow.edu.au>
Date: Mon, 12 Feb 2001 00:13:23 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [UPDATE] zerocopy patch against 2.4.2-pre2
In-Reply-To: <14979.43130.731593.90703@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> As usual:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/davem/zerocopy-2.4.2p2-1.diff.gz
> 
> It's updated to be against the latest (2.4.2-pre2) and I've removed
> the non-zerocopy related fixes from the patch (because I've sent them
> under seperate cover to Linus).
> 

Changing the memory copy function did make some difference
in my setup.  But the performance drop on send(8k) is only approx 10%,
partly because I changed the way I'm testing it - `cyclesoak' is
now penalised more heavily by cache misses, and amount of cache
missing which networking causes cyclesoak is basically the same,
whether or not the ZC patch is applied.

I tried a number of things to try to optimise this situation
on an SG-capable NIC with the ZC patch:

	while (more_to_send) {
		read(fd, buf, 8192);
		send(sock, buf, 8192);
	}

Things I tried:

- Use the csum_copy() functions

- Use copy_from_user()

- Use copy_from_user if src and dest are 8-byte aligned,
  else use csum_copy.

- Force data alignment.

  Explain:  If an application sends a few bytes to a connection
  (say, some headers) and then starts pumping bulk data down the
  same connection, we end up in the situation where the source of
  a copy_from_user is poorly aligned, and it *stays* that way for
  the whole operation.  This is because new, incoming data is always
  tacked onto the end of the socket write buffer.

  Copying from a poorly aligned source address takes 1.5 to 2 times
  as long, depending upon the combination of source-cached and
  dest-cached.

  So I special-cased this in tcp_sendmsg: if we see a large write
  from userspace and we're poorly aligned then just send out a single
  undersized frame so we can drop back into alignment.

  This didn't make a lot of difference, which perhaps indicates
  that the dominating factor is misses, not alignment.  If it
  _is_ misses, they're probably due to aliasing - Ingo said his
  toy has 2 megs of full-speed L2.

- skbuff_cache.

  Explain: When we build an skbuff for ZC transmit it is always
  the same size - it only holds the headers.  The data is put
  into the fragment buffer.  So I created a slab cache for
  skbuffs whose data length is <= 256 bytes, and used that.

  This didn't make much difference.


send(8k), no SG                                             19.2%
send(8k), SG, csum_copy                                     20.3%
send(8k), SG, copy_from_user                                20.9%
send(8k), SG, choose copy                                   20.6%     (huh?)
send(8k), SG, page-aligned, choose copy                     20.3%
send(8k), SG, page-aligned, csum_copy                       20.2%
send(8k), SG, csum_copy, skbuff_cache                       20.5%     (huh?)
send(8k), SG, csum_copy, skbuff_cache, page-aligned         20.2%
send(8k), SG, copy_from_user, skbuff_cache, page-aligned    20.2%


That's all pretty uninteresting, except for the observation
that not using Pentium string ops on un-8byte-aligned is the
biggest win.  And the two huhs, the first of which is
bizarre.  I've checked that code over and over:

   if (((long)_from | (long)_to) & 7)
	csum_and_copy()
   else
        copy_from_user()

and it's slower than an unconditional csum_and_copy().  Wierd.
 

The profiles are more interesting:

send(8k), no SG                     18.2%
=========================================

c0224734 tcp_transmit_skb                             47   0.0347
c01127dc schedule                                     54   0.0340
c021599c ip_output                                    54   0.1688
c010a768 handle_IRQ_event                             55   0.4583
c02041ec skb_release_data                             60   0.5357
c0211068 ip_route_input                               69   0.1938
c022abac tcp_v4_rcv                                   75   0.0470
c0215adc ip_queue_xmit                                76   0.0571
c0204410 skb_clone                                    85   0.1986
c0219a54 tcp_sendmsg_copy                             99   0.0270
c02209fc tcp_clean_rtx_queue                         101   0.1153
c02042c4 __kfree_skb                                 113   0.3404
c024a3cc csum_partial_copy_generic                   436   1.7581
c0125580 file_read_actor                             548   6.5238
00000000 total                                      2874   0.0021

send(8k), SG, csum copy             20.3%
=========================================

c0211068 ip_route_input                               47   0.1320
c011be60 del_timer                                    49   0.6806
c021599c ip_output                                    49   0.1531
c010a768 handle_IRQ_event                             56   0.4667
c022abac tcp_v4_rcv                                   66   0.0414
c02041ec skb_release_data                             69   0.6161
c0215adc ip_queue_xmit                                69   0.0518
c0204410 skb_clone                                    70   0.1636
c02042c4 __kfree_skb                                  96   0.2892
c02209fc tcp_clean_rtx_queue                         100   0.1142
c021b6fc tcp_sendmsg                                 109   0.0439
c021a8ac do_tcp_sendpages                            152   0.0440
c024a3cc csum_partial_copy_generic                   520   2.0968
c0125580 file_read_actor                             615   7.3214
00000000 total                                      3222   0.0024

Note that in each and every profile which I've taken with
the ZC patch, file_read_actor() took a big hit.  That's
the read from the kernel into userspace.   Which confirms
that ZC is more cache-hungry.

Also, note that the sum of ZC's do_tcp_sendpages and tcp_sendmsg
is considerably higher than non-ZC's tcp_sendmsg_copy.

These profiles also show us the aggregate impact of the 
ZC patch: 3222/2874 = 1.12.  Twelve percent.  The device
driver cost isn't shown here because it's in a module.

Here is a profile with a non-modular driver:

c020833c skb_release_data                             54   0.3857
c0218d4c ip_queue_xmit                                63   0.0497
c010a768 handle_IRQ_event                             70   0.5833
c024d4f8 __strncpy_from_user                          74   2.0556
c021e53c tcp_sendmsg                                  75   0.0302
c022d9ec tcp_v4_rcv                                   77   0.0482
c022383c tcp_clean_rtx_queue                          90   0.1027
c0208434 __kfree_skb                                 104   0.4000
c021d6ec do_tcp_sendpages                            122   0.0353
c01d3a08 boomerang_rx                                150   0.1276
c01d32ac boomerang_interrupt                         287   0.2781
c01d2c94 boomerang_start_xmit                        324   0.4475
c024d1cc csum_partial_copy_generic                   443   1.7863
c01255f0 file_read_actor                             643   7.6548
00000000 total                                      3852   0.0028

Device driver cost is 15-20% of the kernel occupancy.

We can pull ZC's 12% cost down a little bit by using a slab
cache on the skbuffs, and by forcing better copy alignment (not
sure how though).  Also perhaps by doing some colouring on the data
structures which are being used.  These differences are all
quite small, which makes this stuff pretty tricky.

I now need to go off and hunt down a Pentium performance
counter patch which take less than a year to understand,
find out where these alleged misses are happening.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
