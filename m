Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262550AbUKQWBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbUKQWBF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbUKQVbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 16:31:40 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:30358 "EHLO
	smtp-out3.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262615AbUKQV3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 16:29:40 -0500
Message-ID: <419BC2C2.6020100@blueyonder.co.uk>
Date: Wed, 17 Nov 2004 21:29:38 +0000
From: Ross Kendall Axe <ross.axe@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@oss.sgi.com
CC: Stephen Smalley <sds@epoch.ncsc.mil>, lkml <linux-kernel@vger.kernel.org>,
       jmorris@redhat.com
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
 using SELinux and SOCK_SEQPACKET
References: <4197A037.1020307@blueyonder.co.uk> <1100525477.31773.38.camel@moss-spartans.epoch.ncsc.mil> <20041116004122.V14339@build.pdx.osdl.net>
In-Reply-To: <20041116004122.V14339@build.pdx.osdl.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD148A6950C18B5194DE33259"
X-OriginalArrivalTime: 17 Nov 2004 21:30:08.0812 (UTC) FILETIME=[9CCB16C0:01C4CCEC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD148A6950C18B5194DE33259
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Chris Wright wrote:
> * Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> 
>>On Sun, 2004-11-14 at 13:13, Ross Kendall Axe wrote:
>>
>>>With CONFIG_SECURITY_NETWORK=y and CONFIG_SECURITY_SELINUX=y, using
>>>SOCK_SEQPACKET unix domain sockets causes an oops in the superfluous(?)
>>>call to security_unix_may_send in sock_dgram_sendmsg. This patch avoids
>>>making this call for SOCK_SEQPACKET sockets.
>>
>>I'd prefer to track down the actual issue in the SELinux code and
>>correct it than just omit the security hook call entirely.  Do you have
>>the Oops output and a trivial test case?  Thanks.
> 

Oops at
http://www.rossaxe.pwp.blueyonder.co.uk/seqpacket-oops/seqpacket-oops.txt
and test case at
http://www.rossaxe.pwp.blueyonder.co.uk/seqpacket-oops/seqpacket-killer.tar.gz
Just run 'seqpacket-crashd & seqpacket-crash' a couple of times.

> 
> Well, there is one simple case that will trigger the Oops.  Send a
> SEQPACKET to a connected but not yet accepted socket.  In this case
> other->sk_socket is still NULL, and SELinux will deref the NULL pointer
> in selinux_socket_may_send() when geting other_isec.  There is already
> a check in unix_stream_connect, which is all that's used for normal unix
> stream sockets.  But the seqpacket socket then uses unix_dgram_sendmsg,
> so triggers the may_send check as well.
> 
> thanks,
> -chris

A possibility that hadn't occurred to me was using sendto to send packets
without connecting. Is this supposed to work? If so, then my patch is
indeed inappropriate. If not, then that needs fixing also.

Ross


--------------enigD148A6950C18B5194DE33259
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBm8LC9bR4xmappRARAqNJAKCs6TwkFyR/ammEiK+B1VsDT0zqDwCfUpi0
OfFWZzLkSFoq9Fn+aQyi338=
=0AW9
-----END PGP SIGNATURE-----

--------------enigD148A6950C18B5194DE33259--
