Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265754AbTL3Lvz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 06:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265765AbTL3Lvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 06:51:55 -0500
Received: from ahriman.Bucharest.roedu.net ([141.85.128.71]:18593 "EHLO
	ahriman.bucharest.roedu.net") by vger.kernel.org with ESMTP
	id S265754AbTL3Lvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 06:51:52 -0500
Date: Tue, 30 Dec 2003 13:52:21 +0200 (EET)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: dizzy@ahriman.bucharest.roedu.net
To: Markus Kolb <usenet@tower-net.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: tcp socks at close_wait for days without process
In-Reply-To: <3FF04584.9010606@tower-net.de>
Message-ID: <Pine.LNX.4.58L0.0312301342470.380@ahriman.bucharest.roedu.net>
References: <3FF04584.9010606@tower-net.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 29 Dec 2003, Markus Kolb wrote:

> Hello,
Hi

> I have a problem with this close_wait state in tcp connections.
> 
> There is no process left in the process list which could belong to the
> specific port.
> It is known that the application has bugs, but shouldn't the Linux
> kernel manage this close_wait state and free the port after a while?
> I believe I could wait for months and years and the close_wait won't go
> away without a reboot.


CLOSE_WAIT means that the socket has received FIN from the other end and 
has send ACK but the application holding the local socket has not yet 
closed the socket (with close() or shutdown()). Are you sure there is no 
application running that holds the CLOSE_WAIT sockets (also the remote 
end should have sockets in FIN_WAIT2 state)? Try something like 
this as root: 
netstat -an | grep CLOSE_WAIT
fuser -n tcp <localport>,<remote-addr>,<remote-port>
where <localport>, <remote-addr>, <remote-port> you take them from the 
netstat output. fuser should give you the PID of the owner of the sockets 
in CLOSE_WAIT. kill it and they should dissapear.

> I have watched a 2nd strange kernel behavior. For that I don't know how
> to reproduce.
> A server application listened at a specific port. The application
> crashed and no process belonging to this application was in process list
> anymore. But the listening socket alives for about 5 minutes although
> there was no process. How this can be? A listening port without a daemon
> process belonging to it?

Strange. Try fuser again (fuser -n tcp <local-listening-port>) to see if 
it pops anything out.

> Bye
> Markus

- -- 
Mihai RUSU                                    Email: dizzy@roedu.net
GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
                       "Linux is obsolete" -- AST
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/8Wb3PZzOzrZY/1QRAouxAKDWkaCOBS2uuZeo3uu6WxDLZWw07wCdFeVD
C4BT0Dkh7gZpRwESEA4+ZTE=
=usNX
-----END PGP SIGNATURE-----
