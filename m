Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130348AbQKZHg0>; Sun, 26 Nov 2000 02:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129627AbQKZHgR>; Sun, 26 Nov 2000 02:36:17 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:32778 "EHLO
        mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
        id <S130348AbQKZHgC>; Sun, 26 Nov 2000 02:36:02 -0500
To: Christoph Rohland <cr@sap.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test5 bug: invalid "shmid_kernel" passed to "shm_nopage_core"
In-Reply-To: <vbaaeapf4ti.fsf@mozart.stat.wisc.edu>
        <m3g0kggydi.fsf@linux.local>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Christoph Rohland's message of "25 Nov 2000 11:05:45 +0100"
Date: 26 Nov 2000 01:05:56 -0600
Message-ID: <vbay9y7dxgr.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland <cr@sap.com> writes:
> 
> This is the first report of such corruption. If it's real it is _not_
> fixed between test5 and test11. There is probably no way to reproduce
> it since you ask if it's fixed in test11, right?

I know no way to reproduce it.  I've been using "test5" reliably since
just after its release, and I've triggered this bug only the one time.

I was running Mozilla, one of the few programs I run that uses shared
memory to communicate with the X server.  If I recall correctly, the
machine had been idle for a few minutes when my ISP suddenly hung up
on me.  Then, I discovered the machine had locked: CPU1 running "pppd"
got stuck waiting for the kernel lock in "sock_ioctl".  I believe it
was the innocent victim.  CPU0 (running "XF86_SVGA") had grabbed the
kernel lock and gotten stuck spinning on the invalid swap device
spinlock, as mentioned in my previous message.

I use a SysReq patch to do an oops-style dump instead of the usual
"showPc" function, so I was able to copy a stack dump down.

>From the stack dump, I can be 100% positive that, in shm_nopage_core,
"shp" was 0xc218b240 on entry and "idx" was 0, but the line

        pte = SHM_ENTRY(shp,idx);

calculated a value of 0xc218b268, the memory location of
"shp->shm_dir".  That is, I had shp->shm_dir == **shp->shm_dir, so I
*suspect* that that shp->shm_dir == *shp->shm_dir.

In any event, the "shp" was corrupt (hadn't been initialized or had
been freed and reused).

I'll fiddle around a bit more and see if I can find a way to reproduce
it reliably.

Thanks.

Kevin <buhr@stat.wisc.edu>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
