Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273723AbRI0R1c>; Thu, 27 Sep 2001 13:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273721AbRI0R1W>; Thu, 27 Sep 2001 13:27:22 -0400
Received: from ntt-connection.daiwausa.com ([210.175.188.3]:35119 "EHLO
	ead42.ead.dsa.com") by vger.kernel.org with ESMTP
	id <S273723AbRI0R1J>; Thu, 27 Sep 2001 13:27:09 -0400
Date: Thu, 27 Sep 2001 13:27:21 -0400
From: "Bill Rugolsky Jr." <rugolsky@ead.dsa.com>
To: James D Strandboge <jstrand1@rochester.rr.com>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>
Subject: Re: status of nfs and tcp with 2.4
Message-ID: <20010927132721.I28277@ead45>
In-Reply-To: <20010927105321.A15128@rochester.rr.com> <shssnd88xae.fsf@charged.uio.no> <20010927131030.A15669@rochester.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010927131030.A15669@rochester.rr.com>; from jstrand1@rochester.rr.com on Thu, Sep 27, 2001 at 01:10:30PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 01:10:30PM -0400, James D Strandboge wrote:
> On Thu, Sep 27, 2001 at 05:32:09PM +0200 or thereabouts, Trond Myklebust wrote:
> > None: AFAIK nobody has yet written any code that works for the server.
> 
> In your opinion, how involved would it be to write the tcp code since
> the udp is already written?  I haven't actually looked into it much,
> and thought you might have some ideas, or perhaps pointers.

Neil Brown answered a query from Martin Pool about this on the NFS list
back in July.  You should probably contact Martin.

Regards,

   Bill Rugolsky

> From: Neil Brown <neilb@cse.unsw.edu.au>
> To: Martin Pool <mbp@valinux.com>
> Message-ID: <15198.47569.868029.592501@notabene.cse.unsw.edu.au>
> Cc: nfs@lists.sourceforge.net, tpot@valinux.com
> Subject: Re: [NFS] NFSv3/tcp -- where to begin?
> In-Reply-To: message from Martin Pool on Wednesday July 25
> References: <20010725205307.B1435@wistful.humbug.org.au>
> List-Archive: <http://lists.sourceforge.net/archives//nfs/>
> Date: Wed, 25 Jul 2001 22:21:37 +1000 (EST)

On Wednesday July 25, mbp@valinux.com wrote:
> Can anybody give me some idea of what in particular is broken with NFS
> over TCP in knfsd?  I'd like to try and fix it.
> 
> I can start by just removing the #if 0 and seeing what breaks, but if
> some kind soul would point me in the right direction that would be
> great...

I think that is it all corner cases now.  I have run the SPEC SFS
benchmark against knfsd using tcp and got it to complete, so it sort
of works.

Issues that I can think of include:

- Guard against denial of service - impose some limit on the number of
  incoming connections, and start randomly dropping connections when
  this limit is exceeded.
- cope with fragmented rpc packets - or prove that they don't exist.
  RPC over TCP consists of a number of frames, each with a 4 byte
  header.  The bottom 31 bits are the frame size.  The top bit
  indicates whether this is a terminal fragment.
  A sequence of non-terminal fragements followed by a terminal
  fragment make one RPC packet.  The code current rejects any
  non-terminal fragment and (I think) closes the connections.
  See comment in  net/sunrpc/svcsock.c:svc_tcp_recvfrom
  Many clients never send non-terminal fragments, but the spec says
  they are allowed so....
- Fix svc_tcp_sendto.
  If there is insufficient room in the socket buffers, the write will
  block (I think) and a dead client could tie up a tcp thread for a
  long time.  Alternately, the write might not block (I cannot
  remember) and some data will simple never be sent, which will
  confuse the client.
  There have been various suggestions for fixing this, like having a
  single thread given the responsibility of blocking, and
  disassociating the svc_rqst structure from the threads (currently
  there is one request structure per thread).
  Ultimately, you need to decide when you are going to say "I cannot
  deliver this reply", and then whether you will just drop the packet,
  or close the connection.
  You need to decide the maximum amount of buffers that you will
  allocate, and under what circumstances you will wait for space to be
  available in the queue.
  Maybe if there is insufficient spare to write the whole replay then:
   if there a 10% idle threads, block, 
   else close the connection.

  Also, you might want to throttle incoming requests when memory gets
  tight.  E.g. if any thread is blocking on writing to a tcp
  connection, don't accept any more requests on that connection.

- guard against ridiculously large incoming packets.  If a header
  arrives saying there are 10 million bytes to come, the code will
  currently wait for them.  If should reject any packets which claims
  to be larged than RPCSVC_MAXPAYLOAD.
  There is also a "FIXME" that points out that data is left on the
  incoming queue until a full frame has arrived.  If this is bigger
  than the TCP window size, it will never arrive.
  Now I think that RPCSVC_MAXPAYLOAD is smaller than the default
  window size, so the above fix should resolve this, but it should be checked.

- address every "FIXME" in net/sunrpc/svcsock.c

That should be enough to get you started :-)
It pretty much all fits the category of avoiding denial of service,
either deliberate or accidental.  Ask yourself "How can an obnoxious client
behave in a way that we don't expect and hence confuse or disable the
server."


NeilBrown



_______________________________________________
NFS maillist  -  NFS@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/nfs

