Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbUKRH0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbUKRH0G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 02:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbUKRH0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 02:26:06 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:52057 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262661AbUKRHZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 02:25:48 -0500
Message-ID: <419C4E72.5050307@blueyonder.co.uk>
Date: Thu, 18 Nov 2004 07:25:38 +0000
From: Ross Kendall Axe <ross.axe@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
CC: netdev@oss.sgi.com, Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
 using SELinux and SOCK_SEQPACKET
References: <Xine.LNX.4.44.0411172222160.2531-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0411172222160.2531-100000@thoron.boston.redhat.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFA96D0167C4E289837EFC6F4"
X-OriginalArrivalTime: 18 Nov 2004 07:26:16.0546 (UTC) FILETIME=[E4062C20:01C4CD3F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA96D0167C4E289837EFC6F4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

James Morris wrote:
> On Thu, 18 Nov 2004, Ross Kendall Axe wrote:
> 
> 
>>Ross Kendall Axe wrote:
>>
>>>A possibility that hadn't occurred to me was using sendto to send packets
>>>without connecting. Is this supposed to work? If so, then my patch is
>>>indeed inappropriate. If not, then that needs fixing also.
>>>
>>
>>Well, my reading of socket(2) suggests that it's _not_ supposed to work.
> 
> 
> sendto() on a non connected socket should fail with ENOTCONN.
> 
> 
>>This patch causes sendmsg on SOCK_SEQPACKET unix domain sockets to return
>>EISCONN or ENOTSUPP as appropriate if the 'to' address is specified.
> 
> 
> For sendto():
> 
> The address must be ignored on a connected mode socket (i.e. in this 
> case).
> 
> According to the send(2) man page, we may return EISCONN if the address
> and addr length are not NULL and zero.  I think that the man page is
> incorrect.  Posix says that EISCONN means "A destination address was
> specified and the socket is already connected", not "A destination address
> was specified and the socket is connected mode".  i.e. we should only 
> return EISCONN if the socket is in a connected state.
> 

The man page then goes on to say "the error ENOTCONN is returned when the 
socket was not actually connected". Admittedly, this is not what my patch 
does; it returns ENOTSUPP, as do SOCK_STREAM sockets.

> I'm not sure if we should return any error at all if an address is 
> supplied to sendto() on SOCK_SEQPACKET.  We're only required to ignore it.
> 
> I would say that we should return an error as it is likely a progamming 
> mistake in the application and we should let them know.

This was, after all, the point of the patch. Well, that and closing the 
security hole opened by my earlier patch :-)

> 
> However, as mentioned above, I don't think EISCONN is appropriate in this 
> case.  EINVAL might be better.
> 

I would say that ENOTSUPP all the time would be more sensible. However, my
choice of error codes was determined by the ones used by SOCK_STREAM.
SOCK_SEQPACKET and SOCK_STREAM should use the same error codes, I would 
say. Further, they should use the codes specified by POSIX.

> 
>>It also causes recvmsg to return EINVAL on unconnected sockets. This
>>behaviour is consistent with SOCK_STREAM sockets.
> 
> 
> This seems incorrect too, Posix says to use ENOTCONN.

That seems eminently sensible. Again, I was just cut-n'-pasting from
SOCK_STREAM. If these error codes are wrong, then SOCK_STREAM also needs
fixing.

> 
> There is a non SELinux-related bug lurking in this code.

IMHO, there never was an SELinux bug here. SELinux merely exposed an 
existing bug.

> I got this oops
> when trying to kill a modified version of seqpacket-crash which keeps
> sending in a loop and uses sendto() and an address with SOCK_SEQPACKET.
> 

I'm unable to reproduce that, or the bug you mention in your other 
message. Care to send us your code?

> 
> - James


I think that af_unix.c needs a bit of cleaning up. All of the functions 
are named as being stream vs dgram, even when the issue is connectionless 
vs connection-oriented. For example, unix_connectionless_connect would 
make a lot more sense than unix_dgram_connect. sendmsg and recvmsg are the 
worst since they require a mixture of SOCK_STREAM and SOCK_DGRAM 
semantics. It would be nice to rewite unix_dgram_recvmsg and 
unix_stream_recvmsg as four helper functions dealing with the 
connectionless, connection-oriented, datagram and stream operations and 
then have 3 wrapper functions (one for each socket type) calling the 
appropriate helpers. This is all strictly IMHO, of course.

Ross


--------------enigFA96D0167C4E289837EFC6F4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBnE559bR4xmappRARAtfvAJwIitwnMWlUhuwv/CPP0N8nlDlUfACfUrE8
QXR2N7qu6sN8E3ebYRTcD1k=
=xPML
-----END PGP SIGNATURE-----

--------------enigFA96D0167C4E289837EFC6F4--
