Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVGXRTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVGXRTu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 13:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVGXRTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 13:19:49 -0400
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:13753 "EHLO
	gw01.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S261415AbVGXRTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 13:19:48 -0400
Message-ID: <42E3DB70.2030000@trn.iki.fi>
Date: Sun, 24 Jul 2005 21:18:24 +0300
From: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen_/_Tronic?= 
	<tronic+lzID=5yg01qrsbg@trn.iki.fi>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050712)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve French <smfltc@us.ibm.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       linux-cifs-client@lists.samba.org
Subject: Re: CIFS slowness & crashes
References: <42E01163.3090302@trn.iki.fi>	 <9a87484905072115041cc576a4@mail.gmail.com> <1121985312.26833.28.camel@stevef95.austin.ibm.com>
In-Reply-To: <1121985312.26833.28.camel@stevef95.austin.ibm.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4897A0C7FD0F252891A3E4E3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4897A0C7FD0F252891A3E4E3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

>>nor umount -f
> What are the errors?  What is the version of cifs.ko module?

umount2: Device or resource busy
umount: /tmpmnt: device is busy
umount2: Device or resource busy
umount: /tmpmnt: device is busy

Without -f it doesn't print those umount2 errors, just the other two.

The version is whatever comes with 2.6.12 or 2.6.13rc1.

> My tests of reconnection after server crash or network reconnection with
> smbfs works (for the past year or two) and also of course for cifs. 
> cifs also reconnects state (open files) not just the connection to
> \\server\share

Reconnection usually (or perhaps always, with new versions) works, but
nothing cannot be done if the server goes permanently offline (nor until
it comes back online). When the server is down, the programs that were
using the CIFS mount or that try to access it will halt.

> My informal tests (cifs->samba) showed a maximum of about 20%
> utilization of gigabit doing large file writes and about double that for
> large file reads with a single cifs client to Samba over gigabit. Should
> be somewhat simalar to Windows server.

This seems quite bad. Is it waiting for packet confirmations or what?

However, I have never got anything better than about 40 Mo/s with a
gigabit network so far. Jumbo frames and using direct cross-over cable
between the clients make no difference. Still, all protocols that I have
tried, except for SMB and CIFS, can reach that easily. I'll try to get
two Windows machines that I can test with. Perhaps the problem is with
Linux network drivers.

Anyway, 20 Mo/s or something like that would not be a big problem. The
real problem occurs when the speed drops under 3 Mo/s.

> The most common cause of widely varying speeds are the following:
> 1) memory fragmentation - some versions of the kernel badly fragment
> slab allocations greater than 4 pages (cifs by default allocates 16.5K
> buffers - which results in larger size allocations when more than 5
> processes are accessing the mount and the cifs buffer pool is exceeded)

Wouldn't this show up as increased system loads?

> 2) write behind due to oplock - smbfs does not do oplock, cifs does -
> which means that cifs client caching can cause a large amount of
> writebehind data to accumulate (with great performance for a while) -
> then when memory gets tight due to the inode caching in linux's mm
> layer, the cifs client is asked to write out a large amount of file data
> at one time (which it does synchronously). 
> 
> Both of these are being improved.  You can bypass the inode caching on
> the client by using the cifs mount option
> 	"forcedirectio"

This option has little or no effect. Still runs slowly (2.4 Mo/s right now).

My benchmark is reading data in 50 Mio chunks, as quickly as it can,
calculating the average read speed. The files being read are bigger than
4 Gio. I haven't tried writing anything (the shares that I play with are
read-only).

For the record, I am using O_RDONLY | O_LARGEFILE on open and then pread
 for all reads. However, I am getting similar results with all programs,
so I don't think that the reading method really matters that much.

- Tronic -


--------------enig4897A0C7FD0F252891A3E4E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC49tzOBbAI1NE8/ERAkFqAJ9gpj4TCRJv0Kpy9h8vZf9zJiUDVgCeMlGk
oSs/M8LdqOXNtCIuiZnxJ+s=
=Msm+
-----END PGP SIGNATURE-----

--------------enig4897A0C7FD0F252891A3E4E3--
