Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317626AbSGJVM4>; Wed, 10 Jul 2002 17:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317627AbSGJVMz>; Wed, 10 Jul 2002 17:12:55 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:39642 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S317626AbSGJVMx>; Wed, 10 Jul 2002 17:12:53 -0400
Date: Wed, 10 Jul 2002 15:15:38 -0600 (MDT)
From: "Hurwitz Justin W." <hurwitz@lanl.gov>
To: niv@us.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: How many copies to get from NIC RX to user read()?
In-Reply-To: <1026316367.3d2c584f45ab0@imap.linux.ibm.com>
Message-ID: <Pine.LNX.4.44.0207101509240.17835-100000@alvie-mail.lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So, to make sure I have this right:

When the data is processed from the NIC
  tcp_rcv_established() is called in processing it
    if a user process is waiting on the socket
      iovec copy data to the user
    else
      copy it to receive_queue or backlog_queue

When the user tries read (in any way) a socket
  iovec copy from receive_queue or backlog_queue


E.g., if the user is ready for the data, dump it straight from SKBs. Else, 
don't waste SKBs on a lazy (or busy) user and copy the data to a queue.

If this is right, I'm happy :) If it's wrong, please correct. 

Thx,
--Gus

On Wed, 10 Jul 2002 niv@us.ibm.com wrote:

> 
> > I could've sworn I heard the stack was single-copy 
> > on both the TX and RX sides. But, it doesn't look to 
> > me like it is. Rather, it looks like there is one copy 
> > in tcp_rcv_estabilshed() (via tcp_copy_to_iovec()), and a
> > second copy in tcp_recvmsg() (which is called when the 
> > user calls read()). Both of these copies are, I believe, 
> > done by skb_copy_datagram_iovec().
> 
> tcp_recvmsg() only does the copy from the receive_queue
> or the backlog queue. tcp_rcv_established() does the copy
> directly into the iovec or queues it onto the receive_queue 
> or backlog queue for tcp_recvmsg() to complete the work. So 
> there arent two copies of the same data happening, just a 
> question of one or the other function doing the work depending 
> on whether there is currently a process doing a read or not..
> 
> hth,
> 
> thanks,
> Nivedita
> 
> 

