Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262770AbUKRQtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbUKRQtM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 11:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbUKRQs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 11:48:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:55755 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262767AbUKRQoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 11:44:54 -0500
Date: Thu, 18 Nov 2004 08:44:49 -0800
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: Ross Kendall Axe <ross.axe@blueyonder.co.uk>, netdev@oss.sgi.com,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when using SELinux and SOCK_SEQPACKET
Message-ID: <20041118084449.Z14339@build.pdx.osdl.net>
References: <Xine.LNX.4.44.0411180257300.3144-100000@thoron.boston.redhat.com> <Xine.LNX.4.44.0411180305060.3192-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Xine.LNX.4.44.0411180305060.3192-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Thu, Nov 18, 2004 at 03:27:42AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@redhat.com) wrote:
> What's happening is that mixing stream and dgram ops for SEQPACKET is
> having some unfortunate side effects.

Agreed.

> One of these is that there is a race between client sendmsg() and server
> accept().  The server child socket is attached via sock_graft() after the 
> client has entered unix_dgram_sendmsg() and called 
> 
> 	security_unix_may_send(sk->sk_socket, other->sk_socket);
> 
> other->sk_socket will thus be null, causing the oops in SELinux and any 
> other LSM which tries to dereference the pointer.

Yup.  And it's not much of a race, the window is wide open.  One
malicious app simply has to do:

bind()
listen()
connect()
send() <-- Oops

> The fix is a combination of some of Ross's ideas:
> 
> 1) SOCK_SEQPACKET is connection oriented, and there no need to call 
> security_unix_may_send() for each packet.  security_unix_stream_connect() 
> is sufficient.

Why not make a unix_seq_sendmsg, which is a very small wrapper?
e.g.
static int unix_seq_sendmsg(struct kiocb *kiocb, struct socket *sock,
			    struct msghdr *msg, size_t len)
{
	struct sock *sk = sock->sk;

	if (sk->sk_type == SOCK_SEQPACKET && sk->sk_state != TCP_ESTABLISHED)
		return -ENOTCONN;
	if (msg->msg_name || msg->msg_namelen)
		return -EINVAL;
	return unix_dgram_sendmsg(kiocb, sock, msg, len);
}


Also, I missed how MSG_EOR is honored.

> 2) Ensure that unix_dgram_sendmsg() fails for SOCK_SEQPACKET sockets which
> are not connected, otherwise someone could bypass LSM by sending on an
> unconnected socket.

Agreed, not connected, it should fail IMHO.

> Note that this only solves the problem for the LSM hook.

Does the above stop the other issue?  My laptop died, so I'm not able to
test ATM.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
