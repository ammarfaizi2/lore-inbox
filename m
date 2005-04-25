Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbVDYCuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbVDYCuW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 22:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbVDYCuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 22:50:22 -0400
Received: from smtpout.mac.com ([17.250.248.73]:36057 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262471AbVDYCsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 22:48:36 -0400
In-Reply-To: <426C51C4.9040902@lab.ntt.co.jp>
References: <4263275A.2020405@lab.ntt.co.jp> <m1y8b9xyaw.fsf@muc.de> <426C51C4.9040902@lab.ntt.co.jp>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e83d0cb60cb50a56b38294e9160d7712@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Date: Sun, 24 Apr 2005 22:48:15 -0400
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you want that exact functionality, do this:

At program start, spawn a new thread:
	1) Open a UNIX socket (/var/run/someapp_live_patch.sock)
	2) poll() that socket for a connection.
	3) When you get a connection, do your own security checks
	4) If it's ok, then map the specified file into memory
	5) Read a table of crap to patch from the file
	6) Do the patching, being careful to avoid the millions of
	   races involved for each CPU, *especially* regarding the
	   separate icache and dcache on CPUs like PPC and such.
	7) Go back to step 2

If you want equivalent functionality but much safer and not CPU
dependent and full of hand-coded assembly:

1) open(), mmap(), and mlock() the file (/var/lib/someapp/data)
2) Spawn normal operation threads
3) Spawn a new hot-patch thread:
	1) Open a UNIX socket (/var/run/someapp_live_patch.sock)
	2) poll() that socket for a connection.
	3) When you get one, coordinate with the new process as it
	   attaches itself to /var/lib/someapp/data
	4) Handle shared locking of parts of /var/lib/someapp/data
	5) Send it your listen() file-descriptors over the socket.
	6) Wait for the other process to signal it's ready.
	7) Stop accepting new connections on the socket.
	8) Send file-descriptors for current connections
	9) Cleanup and quit

When live-patching:
1)  connect to the socket /var/run/someapp_live_patch.sock
2)  open(), mmap() and mlock() /var/lib/someapp/data
3)  Coordinate with the other process via the socket
4)  Receive the listen() file-descriptors over the socket.
5)  Set up the shared data locking
6)  Spawn normal operation threads
7)  Signal readiness
8)  Receive file-descriptors for current connections
9)  Spawn threads for them too.
10) Spawn a new hot-patch thread as above

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


