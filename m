Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBLSB4>; Mon, 12 Feb 2001 13:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129146AbRBLSBq>; Mon, 12 Feb 2001 13:01:46 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:36055 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S129098AbRBLSBc>;
	Mon, 12 Feb 2001 13:01:32 -0500
Date: Mon, 12 Feb 2001 13:00:24 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
X-X-Sender: <cowboy@badlands.lexington.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.19pre10
In-Reply-To: <E14SMl5-0007Zh-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0102121253340.22778-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, Alan Cox wrote:

> 2.2.19pre10
> o	Revert shm change - its unsafe			(Richard Nelson)
>
> [...]
>
> 2.2.19pre3
> o	Fix IPC_RMID behaviour				(Christoph Rohland)
>

Ack...

First, I'm glad I wasn't hallucinating, and that the mail did indeed get
seen by someone.

Second, instead of reverting, can't we simply move those two lines up a
bit:
        case IPC_RMID:
                if (current->euid == shp->u.shm_perm.uid ||
                    current->euid == shp->u.shm_perm.cuid ||
                    capable(CAP_SYS_ADMIN)) {
                        shp->u.shm_perm.mode |= SHM_DEST;
+                       /* Do not find it any more */
+                       shp->shm_perm.key = IPC_PRIVATE;
                        if (shp->u.shm_nattch <= 0)
                                killseg (id);
                        break;

This way, we're not violating specs, programs work, *and* we're not
touching freshly kfree()d storage?

-- 
Rick Nelson
DOS: n., A small annoying boot virus that causes random spontaneous system
     crashes, usually just before saving a massive project.  Easily cured by
     UNIX.  See also MS-DOS, IBM-DOS, DR-DOS.
(from David Vicker's .plan)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
