Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbULQReC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbULQReC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 12:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbULQRdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 12:33:21 -0500
Received: from ns1.s2io.com ([142.46.200.198]:43442 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S262086AbULQRcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 12:32:20 -0500
Subject: RE: zero copy issue while receiving the data (counter part of sen
	dfil e)
From: Dmitry Yusupov <dima@s2io.com>
Reply-To: dima@s2io.com
To: "Rajat  Jain, Noida" <rajatj@noida.hcltech.com>
Cc: linux-newbie@vger.kernel.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       "Sanjay Kumar, Noida" <sanjayku@hcltech.com>,
       "Deepak Kumar Gupta, Noida" <dkumar@hcltech.com>
In-Reply-To: <267988DEACEC5A4D86D5FCD780313FBB02AF7AF7@exch-03.noida.hcltech.com>
References: <267988DEACEC5A4D86D5FCD780313FBB02AF7AF7@exch-03.noida.hcltech.com>
Content-Type: text/plain
Organization: S2io Technologies
Date: Fri, 17 Dec 2004 09:31:23 -0800
Message-Id: <1103304684.7217.70.camel@beastie>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -106.7
X-Spam-Outlook-Score: ()
X-Spam-Features: BAYES_01,EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-17 at 21:54 +0530, Rajat Jain, Noida wrote:
>  
> Hi,
> 
> Thanks for the reply.
> 
> Actually I am developing a loadable kernel module. I agree that at the bare
> minimum, I need to copy from the NIC's device buffer to kernel's allocated
> sk_buff (socket buffer). What I want is to avoid FURTHER coying of data from
> the sk_buffs to the buffers allocated by the module. 

Looks like you have two options:

a) pre-fill and use "struct iovec" with sock_recvmsg()

b) intercept socket's receive callback with tcp_read_sock() and use 
skb_copy_bits() to copy data from skb to your destination buffer.

Regards,
Dima

> 
> And hence I expected to pass the address of a buffer pointer to
> tcp_read_sock(). And I expected this function to set it to socket buffer.
> Any pointers on the functionality of tcp_read_sock()??
> 
> Rajat
> 
> 
> -----Original Message-----
> From: Dmitry Yusupov [mailto:dima@s2io.com] 
> Sent: Friday, December 17, 2004 7:07 AM
> To: Rajat Jain, Noida
> Cc: linux-net@vger.kernel.org; Sanjay Kumar, Noida; Deepak Kumar Gupta,
> Noida
> Subject: Re: zero copy issue while receiving the data (counter part of
> sendfil e)
> 
> Hi Rajat,
> 
> I was using this function some times back... It's been working for me just
> fine. Also kernel's RPC (see xprt* files) uses it. So you might want to take
> a look.
> 
> In general, it is not possible to fully avoid copying. You need at least
> copy data from NIC's skb to the destination. It might be user buffer or
> kernel buffer(depends on application).
> 
> Regards,
> Dmitry
> 
> 
> On Thu, 2004-12-16 at 19:38 +0530, Rajat Jain, Noida wrote:
> >  
> > Hi,
> > 
> > I'm experimenting on stock kernel 2.6.8
> > 
> > I was looking for an interface that could directly receive data from a 
> > network socket, WITHOUT coying from kernel space to user space. (Like 
> > for sending data, "sendfile" provides to send data to network socket 
> > without copying it to kernel space). I came across tcp_read_sock() 
> > interface in net/ipv4/tcp.c.
> > 
> > Has anybody tried tcp_read_sock()?? Is there any known issue with it 
> > ?? If somebody has some idea, I would appreciate if you can share.
> > 
> > I might be wrong, but what I perceive is that I will pass a pointer to 
> > this function. And when the function returns, I expect it to be set to 
> > the kernel buffer (corresponding to socket).
> > 
> > 1) To fulfill this objective, I expect to pass a pointer to pointer & 
> > only then it can be done. (If we have to modify a pointer's value, we 
> > have to pass its address ... Right??). However, this function expects 
> > a char * buf (in read_descriptor_t argument). Any ideas ?????????
> > 
> > 2) This code also frees the space allocated to sk_buffs etc using 
> > sk_eat_skb(sk, skb) and cleanup_rbuf(sk, copied) etc. But this 
> > function is supposed to return these locations to the calling code ...
> Right???
> > 
> > Any pointers are more than welcome. I have provided the code for
> reference.
> > Please cc the reply to me as I'm not on the list.
> > 
> > Thanks & regards,
> > 
> > Rajat Jain
> > 
> > ----------------------------------------------------------------------
> > -
> > /* net/ipv4/tcp.c
> >  * This routine provides an alternative to tcp_recvmsg() for routines
> >  * that would like to handle copying from skbuffs directly in 'sendfile'
> >  * fashion.
> >  * Note:
> >  *      - It is assumed that the socket was locked by the caller.
> >  *      - The routine does not block.
> >  *      - At present, there is no support for reading OOB data
> >  *        or for 'peeking' the socket using this routine
> >  *        (although both would be easy to implement).
> >  */
> > int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> >                   sk_read_actor_t recv_actor) {
> >         struct sk_buff *skb;
> >         struct tcp_opt *tp = tcp_sk(sk);
> >         u32 seq = tp->copied_seq;
> >         u32 offset;
> >         int copied = 0;
> > 
> >         if (sk->sk_state == TCP_LISTEN)
> >                 return -ENOTCONN;
> >         while ((skb = tcp_recv_skb(sk, seq, &offset)) != NULL) {
> >                 if (offset < skb->len) {
> >                         size_t used, len;
> > 
> >                         len = skb->len - offset;
> >                         /* Stop reading if we hit a patch of urgent data
> */
> >                         if (tp->urg_data) {
> >                                 u32 urg_offset = tp->urg_seq - seq;
> >                                 if (urg_offset < len)
> >                                         len = urg_offset;
> >                                 if (!len)
> >                                         break;
> >                         }
> >                         used = recv_actor(desc, skb, offset, len);
> >                         if (used <= len) {
> >                                 seq += used;
> >                                 copied += used;
> >                                 offset += used;
> >                         }
> >                         if (offset != skb->len)
> >                                 break;
> >                 }
> >                 if (skb->h.th->fin) {
> >                         sk_eat_skb(sk, skb);
> >                         ++seq;
> >                         break;
> >                 }
> >                 sk_eat_skb(sk, skb);
> >                 if (!desc->count)
> >                         break;
> >         }
> >         tp->copied_seq = seq;
> > 
> >         tcp_rcv_space_adjust(sk);
> > 
> >         /* Clean up data we have read: This will do ACK frames. */
> >         if (copied)
> >                 cleanup_rbuf(sk, copied);
> >         return copied;
> > }---------------------------------------------------------------------
> > --
> > 
> > read_descriptor_t is defined as:
> > 
> > /*
> >  * include/linux/fs.h
> >  */
> > typedef struct {
> >         size_t written;
> >         size_t count;
> >         union {
> >                 char __user * buf;
> >                 void *data;
> >         } arg;
> >         int error;
> > } read_descriptor_t;
> > ----------------------------------------------------------------------
> > -
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-net" 
> > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html

