Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbUKSDYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbUKSDYC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 22:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUKSDYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 22:24:02 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:5595 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261261AbUKSDX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 22:23:57 -0500
Message-ID: <419D6746.2020603@blueyonder.co.uk>
Date: Fri, 19 Nov 2004 03:23:50 +0000
From: Ross Kendall Axe <ross.axe@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: James Morris <jmorris@redhat.com>, netdev@oss.sgi.com,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
 using SELinux and SOCK_SEQPACKET
References: <Xine.LNX.4.44.0411180257300.3144-100000@thoron.boston.redhat.com> <Xine.LNX.4.44.0411180305060.3192-100000@thoron.boston.redhat.com> <20041118084449.Z14339@build.pdx.osdl.net>
In-Reply-To: <20041118084449.Z14339@build.pdx.osdl.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2BDD3484146A7E1EC73F5BEF"
X-OriginalArrivalTime: 19 Nov 2004 03:24:25.0731 (UTC) FILETIME=[45514530:01C4CDE7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2BDD3484146A7E1EC73F5BEF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Chris Wright wrote:
> 
> Why not make a unix_seq_sendmsg, which is a very small wrapper?
> e.g.
> static int unix_seq_sendmsg(struct kiocb *kiocb, struct socket *sock,
> 			    struct msghdr *msg, size_t len)
> {
> 	struct sock *sk = sock->sk;
> 
> 	if (sk->sk_type == SOCK_SEQPACKET && sk->sk_state != TCP_ESTABLISHED)
> 		return -ENOTCONN;
> 	if (msg->msg_name || msg->msg_namelen)
> 		return -EINVAL;
> 	return unix_dgram_sendmsg(kiocb, sock, msg, len);
> }
> 
> 
> -chris

Taking this idea further, couldn't we split unix_dgram_sendmsg into 2 
functions, do_unix_dgram_sendmsg and do_unix_connectionless_sendmsg (and 
similarly for unix_stream_sendmsg), then all we'd need is:

<pseudocode>
static int do_unix_dgram_sendmsg(...);
static int do_unix_stream_sendmsg(...);
static int do_unix_connectionless_sendmsg(...);
static int do_unix_connectional_sendmsg(...);

static int unix_dgram_sendmsg(struct kiocb *kiocb, struct socket *sock,
			      struct msghdr *msg, size_t len)
{
	return do_unix_connectionless_sendmsg(kiocb, sock, msg, len,
					      do_unix_dgram_sendmsg);
}
static int unix_stream_sendmsg(struct kiocb *kiocb, struct socket *sock,
			       struct msghdr *msg, size_t len)
{
	return do_unix_connectional_sendmsg(kiocb, sock, msg, len,
					    do_unix_stream_sendmsg);
}
static int unix_seqpacket_sendmsg(struct kiocb *kiocb, struct socket *sock,
				  struct msghdr *msg, size_t len)
{
	return do_unix_connectional_sendmsg(kiocb, sock, msg, len,
					    do_unix_dgram_sendmsg);
}
</pseudocode>

What do we think?

Ross


--------------enig2BDD3484146A7E1EC73F5BEF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBnWdK9bR4xmappRARAihLAKCzFZPZApRyoBKS4/FQXpqjTV6XYACg2nl3
wa0It2/jwa5kPymDxtXygjk=
=1TBd
-----END PGP SIGNATURE-----

--------------enig2BDD3484146A7E1EC73F5BEF--
