Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262688AbUKRANC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbUKRANC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 19:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbUKRAKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 19:10:55 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:5268 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262619AbUKRAJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 19:09:52 -0500
Message-ID: <419BE847.90307@blueyonder.co.uk>
Date: Thu, 18 Nov 2004 00:09:43 +0000
From: Ross Kendall Axe <ross.axe@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ross Kendall Axe <ross.axe@blueyonder.co.uk>
CC: netdev@oss.sgi.com, Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>, jmorris@redhat.com,
       chrisw@osdl.org
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
 using SELinux and SOCK_SEQPACKET
References: <4197A037.1020307@blueyonder.co.uk> <1100525477.31773.38.camel@moss-spartans.epoch.ncsc.mil> <20041116004122.V14339@build.pdx.osdl.net> <419BC2C2.6020100@blueyonder.co.uk>
In-Reply-To: <419BC2C2.6020100@blueyonder.co.uk>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig49C53ACCF8B12CA95AB09638"
X-OriginalArrivalTime: 18 Nov 2004 00:10:20.0468 (UTC) FILETIME=[FDC96740:01C4CD02]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig49C53ACCF8B12CA95AB09638
Content-Type: multipart/mixed;
 boundary="------------060605050504050302020502"

This is a multi-part message in MIME format.
--------------060605050504050302020502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ross Kendall Axe wrote:
> 
> 
> A possibility that hadn't occurred to me was using sendto to send packets
> without connecting. Is this supposed to work? If so, then my patch is
> indeed inappropriate. If not, then that needs fixing also.
> 
> Ross
> 

Well, my reading of socket(2) suggests that it's _not_ supposed to work.

This patch causes sendmsg on SOCK_SEQPACKET unix domain sockets to return
EISCONN or ENOTSUPP as appropriate if the 'to' address is specified. It
also causes recvmsg to return EINVAL on unconnected sockets. This
behaviour is consistent with SOCK_STREAM sockets.

signed-off-by: Ross Axe <ross.axe@blueyonder.co.uk>


--------------060605050504050302020502
Content-Type: text/x-patch;
 name="unix-SOCK_SEQPACKET-unconnected-fix-2.6.10-rc2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="unix-SOCK_SEQPACKET-unconnected-fix-2.6.10-rc2.patch"

--- linux-2.6.10-rc2/net/unix/af_unix.c.orig	2004-11-17 22:26:38.000000000 +0000
+++ linux-2.6.10-rc2/net/unix/af_unix.c	2004-11-17 23:13:37.000000000 +0000
@@ -1272,6 +1272,11 @@ static int unix_dgram_sendmsg(struct kio
 		goto out;
 
 	if (msg->msg_namelen) {
+		if (sk->sk_type == SOCK_SEQPACKET) {
+			err = sk->sk_state == TCP_ESTABLISHED
+				? -EISCONN : -EOPNOTSUPP;
+			goto out;
+		}
 		err = unix_mkname(sunaddr, msg->msg_namelen, &hash);
 		if (err < 0)
 			goto out;
@@ -1531,6 +1536,11 @@ static int unix_dgram_recvmsg(struct kio
 	struct sk_buff *skb;
 	int err;
 
+	err = -EINVAL;
+	if (sk->sk_type == SOCK_SEQPACKET && 
+	    sk->sk_state != TCP_ESTABLISHED)
+		goto out;
+
 	err = -EOPNOTSUPP;
 	if (flags&MSG_OOB)
 		goto out;


--------------060605050504050302020502--

--------------enig49C53ACCF8B12CA95AB09638
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBm+hM9bR4xmappRARAmeWAJ9hJYj2natS8n9IFjw/Xwvw3qWhkACcCQfY
voPbHXw4XGjkXUp7esA9d+A=
=sl9m
-----END PGP SIGNATURE-----

--------------enig49C53ACCF8B12CA95AB09638--
