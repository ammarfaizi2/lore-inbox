Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbVDYKkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVDYKkX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 06:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbVDYKkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 06:40:23 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:29829 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S262578AbVDYKkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 06:40:08 -0400
Message-ID: <426CC8F7.8070905@lab.ntt.co.jp>
Date: Mon, 25 Apr 2005 19:39:51 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <4263275A.2020405@lab.ntt.co.jp> <m1y8b9xyaw.fsf@muc.de> <426C51C4.9040902@lab.ntt.co.jp> <e83d0cb60cb50a56b38294e9160d7712@mac.com>
In-Reply-To: <e83d0cb60cb50a56b38294e9160d7712@mac.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle, thank you so much for your detailed information.
If you design completely new software, your suggestion is very useful!

Unfortunately, we carrier have very many exiting software and try to run
on Linux.
We need to seek the way which can apply to exiting software also...

Kyle Moffett wrote:

> If you want that exact functionality, do this:
>
> At program start, spawn a new thread:
> 1) Open a UNIX socket (/var/run/someapp_live_patch.sock)
> 2) poll() that socket for a connection.
> 3) When you get a connection, do your own security checks
> 4) If it's ok, then map the specified file into memory
> 5) Read a table of crap to patch from the file
> 6) Do the patching, being careful to avoid the millions of
> races involved for each CPU, *especially* regarding the
> separate icache and dcache on CPUs like PPC and such.
> 7) Go back to step 2
>
> If you want equivalent functionality but much safer and not CPU
> dependent and full of hand-coded assembly:
>
> 1) open(), mmap(), and mlock() the file (/var/lib/someapp/data)
> 2) Spawn normal operation threads
> 3) Spawn a new hot-patch thread:
> 1) Open a UNIX socket (/var/run/someapp_live_patch.sock)
> 2) poll() that socket for a connection.
> 3) When you get one, coordinate with the new process as it
> attaches itself to /var/lib/someapp/data
> 4) Handle shared locking of parts of /var/lib/someapp/data
> 5) Send it your listen() file-descriptors over the socket.
> 6) Wait for the other process to signal it's ready.
> 7) Stop accepting new connections on the socket.
> 8) Send file-descriptors for current connections
> 9) Cleanup and quit
>
> When live-patching:
> 1) connect to the socket /var/run/someapp_live_patch.sock
> 2) open(), mmap() and mlock() /var/lib/someapp/data
> 3) Coordinate with the other process via the socket
> 4) Receive the listen() file-descriptors over the socket.
> 5) Set up the shared data locking
> 6) Spawn normal operation threads
> 7) Signal readiness
> 8) Receive file-descriptors for current connections
> 9) Spawn threads for them too.
> 10) Spawn a new hot-patch thread as above
>
> Cheers,
> Kyle Moffett
>
> -----BEGIN GEEK CODE BLOCK-----
> Version: 3.12
> GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
> L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
> PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r
> !y?(-)
> ------END GEEK CODE BLOCK------
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/



-- 
Takashi Ikebe
NTT Network Service Systems Laboratories
9-11, Midori-Cho 3-Chome Musashino-Shi,
Tokyo 180-8585 Japan
Tel : +81 422 59 4246, Fax : +81 422 60 4012
e-mail : ikebe.takashi@lab.ntt.co.jp


