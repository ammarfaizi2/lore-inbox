Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289471AbSAVWKw>; Tue, 22 Jan 2002 17:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289476AbSAVWKM>; Tue, 22 Jan 2002 17:10:12 -0500
Received: from chaos.analogic.com ([204.178.40.224]:60803 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S289471AbSAVWKB>; Tue, 22 Jan 2002 17:10:01 -0500
Date: Tue, 22 Jan 2002 17:10:27 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Mason <mason@suse.com>
cc: Hans Reiser <reiser@namesys.com>, Rik van Riel <riel@conectiva.com.br>,
        Andreas Dilger <adilger@turbolabs.com>, Shawn Starr <spstarr@sh0n.net>,
        linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <2116720000.1011733708@tiny>
Message-ID: <Pine.LNX.3.95.1020122164209.14535A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What's wrong with having the file-system call a VM function
to free some buffer once it's been written and hasn't been
accessed recently? Isn't that what's being done already.

That keeps FS in the FS and VM in VM.

The file-system is the only thing that "knows"  or should know about
file-system activity.

The only problem I see with the current implementation is that it
"seems as though" the file-system keeps old data too long. Therefore,
RAM gets short.

The actual buffer(s) that get written and then released
should be based upon "least-recently-used". Buffers should
be written until some target of free memory is reached. Presently
it doesn't seem as though we have such a target. Therefore, we
eventually run out of RAM and try to find some magic algorithm
to use. As a last resort, we kill processes. This is NotGood(tm).

We need a free-RAM target, possibly based upon a percentage of
available RAM. The lack of such a target is what causes the
out-of-RAM condition we have been experiencing. Somebody thought
that "free RAM is wasted RAM" and the VM has been based upon
that theory. That theory has been proven incorrect. You need
free RAM, just like you need "excess horsepower" to make
automobiles drivable. That free RAM is the needed "rubber-band"
to absorb the dynamics of real-world systems.

That free-RAM target can be attacked both by the file-system(s)
and the VM system. The file-system gives LRU buffers until
it has obtained the free-RAM target, without regard for the
fact that VM may immediately use those pages for process expansion.

VM will also give up LRU pages until it has reached the same target.
These targets occur at different times, which is the exact mechanism
necessary to load-balance available RAM. VM can write to swap if
it needs, to satisfy its free-RAM target but writing to swap
has to go directly to the device or you will oscillate if the
swap-write doesn't free its buffers. In other words, you don't
free cache-RAM by writing to a cached file-system. You will
eventually settle into the time-constant which causes oscillation.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


