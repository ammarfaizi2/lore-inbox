Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267487AbTBRKwh>; Tue, 18 Feb 2003 05:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267534AbTBRKwh>; Tue, 18 Feb 2003 05:52:37 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:8854 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267487AbTBRKwf>; Tue, 18 Feb 2003 05:52:35 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "David S. Miller" <davem@redhat.com>
Date: Tue, 18 Feb 2003 22:00:37 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15954.4693.893707.471216@notabene.cse.unsw.edu.au>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       "Alexey N. Kuznetsov" <kuznet@ms2.inr.ac.ru>
Subject: Re: sendmsg and IP_PKTINFO
In-Reply-To: message from David S. Miller on  February 17
References: <15949.40369.601166.550803@notabene.cse.unsw.edu.au>
	<1045552237.4501.8.camel@rth.ninka.net>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  February 17, davem@redhat.com wrote:
> On Fri, 2003-02-14 at 17:53, Neil Brown wrote:
> > No.
> > My application (which is just using standard rpc server libraries) is
> > saying
> >   "This is in reply to a request that came in through a given
> >   interface".
> > 
> > It is not reasonable to treat that statement as equivalent to:
> >   "This packet must go out that interface"
> > 
> > which is what appears to be happening.
> 
> You misunderstand what this control message knob means during
> a sendmsg() then, it means "send this over interface X"
> 
> There is no other valid expectation.
> 
> I'm curious where you read something that would suggest otherwise
> for sendmsg() behavior wrt. ip_pktinfo

man 7 ip

on debian (unstable).

I quote:

       IP_PKTINFO
              Pass an IP_PKTINFO ancillary message  that  contains  a  pktinfo
              structure  that  supplies  some  information  about the incoming
              packet.  This only works for  datagram  oriented  sockets.   The
              argument  is a flag that tells the socket whether the IP_PKTINFO
              message should be passed or not. The message itself can only  be
              sent/retrieved as control message with a packet using recvmsg(2)
              or sendmsg(2).

              struct in_pktinfo {
                  unsigned int   ipi_ifindex;  /* Interface index */
                  struct in_addr ipi_spec_dst; /* Local address */
                  struct in_addr ipi_addr;     /* Header Destination address */
              };

              ipi_ifindex is the unique index of the interface the packet  was
              received  on.   ipi_spec_dst  is the local address of the packet
              and ipi_addr is the destination address in  the  packet  header.
              If  IP_PKTINFO  is passed to sendmsg(2) then the outgoing packet
              will be sent over the interface specified  in  ipi_ifindex  with
              the destination address set to ipi_spec_dst


Note that the in_pktinfo is described as "some information about the
incoming packet".  In particular ipi_ifindex is "the unique index of
the interface the packets was received on".

i.e. it is more about the incoming than the outgoing packet.

It does go on to say that the outgoing packet will be sent over the
same interface, however I feel that is an illogical conclusion given
the description of the meaning of the field.

So yes, the current behaviour seems to match part of the
documentation.  However I argue that the documented behaviour is
irrational.
A more rational behaviour is
 "the outgoing packet will be sent over the interface specified in
 ipi_ifindex if that interface has a valid route to the packets
 destination.  Otherwise normal rouing rules apply".

I further argue that this is not only more rational, but is actually
more useful (which is a more telling point).

NeilBrown
