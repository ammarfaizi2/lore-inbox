Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130454AbQKZVGL>; Sun, 26 Nov 2000 16:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131604AbQKZVGB>; Sun, 26 Nov 2000 16:06:01 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:51210 "EHLO
        mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
        id <S130454AbQKZVFt>; Sun, 26 Nov 2000 16:05:49 -0500
To: Christoph Rohland <cr@sap.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test5 bug: invalid "shmid_kernel" passed to "shm_nopage_core"
In-Reply-To: <vbaaeapf4ti.fsf@mozart.stat.wisc.edu>
        <m3g0kggydi.fsf@linux.local> <vbay9y7dxgr.fsf@mozart.stat.wisc.edu>
        <m37l5rggmm.fsf@linux.local>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Christoph Rohland's message of "26 Nov 2000 11:41:21 +0100"
Date: 26 Nov 2000 14:35:47 -0600
Message-ID: <vbasnoeeajg.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland <cr@sap.com> writes:
> 
> > I use a SysReq patch to do an oops-style dump instead of the usual
> > "showPc" function, so I was able to copy a stack dump down.
> 
> Could you send me the patch? Does it do the dump on all cpus?

You can grab it at:

        ftp://mozart.stat.wisc.edu/pub/misc/patch-2.4.0-test5-sysreq

It doesn't dump all CPUs; it just dumps whichever one handles the
SysReq request, so I just keep doing it until I get them both.

> I would be happy to help debug the shm code if you find a way to
> reproduce it. 

Okay.  I've actually determined that my window manager (Enlightenment)
creates a shared memory segment for the X server to map and unmap
anywhere from 25 to 100 times a second; the segment appears in the X
server's memory map at the address 0x40014000 that "shm_nopage" was
trying to fault in when my lockup occurred.

I didn't notice it before because the time the page is mapped is
small.  To catch it, I had to do

        while true; do egrep 40014000 /proc/xxx/maps; done

and wait a bit.  A "printk" for shm_mmapping at address 0x40014004
gave me the 25-100 times per second figure.

The fact that this has crashed once in all the time I've been using
this setup would seem to imply a very subtle race condition.  Ugh.

Can you offer me a tutorial on the SHM locking?  What's supposed to
protect against what?

In the meantime, I'll keep plugging away at it.

Kevin <buhr@stat.wisc.edu>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
