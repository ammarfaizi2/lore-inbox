Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262295AbREUSJb>; Mon, 21 May 2001 14:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbREUSJV>; Mon, 21 May 2001 14:09:21 -0400
Received: from fungus.teststation.com ([212.32.186.211]:33233 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S262295AbREUSJN>; Mon, 21 May 2001 14:09:13 -0400
Date: Mon, 21 May 2001 20:03:34 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Xuan Baldauf <xuan--lkml@baldauf.org>
cc: <linux-kernel@vger.kernel.org>, "James H. Puttick" <james.puttick@kvs.com>
Subject: Re: [PATCH][RFT] smbfs bugfixes for 2.4.4
In-Reply-To: <3B08F54D.F1C75D14@baldauf.org>
Message-ID: <Pine.LNX.4.30.0105211539300.3118-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2001, Xuan Baldauf wrote:

> Hello Urban,
> 
> I've been playing around a while with that patch and so far could not find any
> problems anymore. But I've noticed some other annoying behaviour, which might

Good.

> be caused by trying to work around the initially reported bug where the
> win98se server does not update something (the new file contents after writing
> to a file or the file size?) when something is written by the client: Every
> little SMBwrite is followed by an SMBflush, which is translated by win98se
> into a "commit" of the file, which seems to be an fsync(2) equivalent.

Yes, I know.

> 
> That is annoying, because it heavily slows down bulk transfers of small
> writes, like automatically unzipping a new mozilla build from the linux box to
> the windows box. Every write of say 100 bytes is implemented as
> 
> send write req
> recv write ack
> send flush req
> sync to disk (on the windows machine)
> recv flush ack
>
> This creates heaviest disk load (on the windows machine) for minimal
> throughput. Is the SMBflush needed anymore, after you seem to have found
> another, better workaround?

SMBflush is the better variant of the workaround I sent you first, as
flush will always work but setting that flag doesn't ("correctness" over
speed, or something like that).

But does it really do that? It will only flush when the page you wrote to
is sent to the fs for writing. The page cache doesn't do that on each
write (I assume, should check) so then a 10 byte write, followed by
another 10 doesn't give 2 flushes but only one when that page is written.

It's still very much a slowdown with win9x servers.


I'll see if I can come up with something better than flush. What I need is
a way to tell the server that the file did change so that it will start
giving back the correct size.

I'm guessing that the win9x smb server caches some values but doesn't
understand that writing changes that. Possibly an assumption that the
client "knows" the correct filesize (but that breaks if someone else
changes the file).

People shouldn't be using win9x as "servers" anyway ... :)

/Urban

