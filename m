Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbUKUKcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbUKUKcU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 05:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbUKUKcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 05:32:19 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:45749 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261459AbUKUKcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 05:32:13 -0500
To: bulb@ucw.cz
CC: pavel@ucw.cz, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20041121095038.GV2870@vagabond> (message from Jan Hudec on Sun,
	21 Nov 2004 10:50:38 +0100)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <20041117190055.GC6952@openzaurus.ucw.cz> <E1CUVkG-0005sV-00@dorka.pomaz.szeredi.hu> <20041117204424.GC11439@elf.ucw.cz> <E1CUhTd-0006c8-00@dorka.pomaz.szeredi.hu> <20041118144634.GA7922@openzaurus.ucw.cz> <E1CVmN5-0007qq-00@dorka.pomaz.szeredi.hu> <20041121095038.GV2870@vagabond>
Message-Id: <E1CVp0g-0008Cw-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 11:31:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But you won't bundle the *write* requests. And that's what will be
> painfuly slow.

Well, painfully slow is just about 100Mbytes/sec on my 1GHz C3
machine.  Be real.


>     3) Use a real disk file to back the page cache. Exactly like coda
>        does it.

Yes, that could be done.  Not exactly like coda, because the
filesystem would have no way of knowing exacty _what_ was written.
For many applications it's _way_ too inefficient to write back the
whole file on every little change.  And writing back the file on
release would mean a) big latency b) inconsistency between the backing
filesystem and the virtual one.

Actually latency _is_ the major problem with the CODA like interface.
Try doing a 'less bigfile' with an sftp filesystem based on CODA and
FUSE, and you'll see what I mean.  It will _feel_ a hell of a lot
slower with CODA, just because you'd have to wait for the whole file
to download to get the first byte.

> I would not be so sure about this. The deadlock is caused by the fact
> that such pages may exist, not by their number. Limiting the number will
> only decrease the probability the deadlock will happen, but won't make
> it go away.

No.  The problem _is_ caused by their number, because it will only
happen if pages cannot be freed in any other way, only by doing
writeback to the userspace filesystem.  If there are pages which _can_
be freed other ways, then deadlock won't happen.

Now if you limit the total number of pages that FUSE can use for
writable memory mappings to 10% of the total memory in the machine,
you can be pretty sure, that the remaining 90% will not be filled with
unpageable memory (otherwise you'd be in pretty big trouble anyway).

Miklos
