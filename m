Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbSLJWFg>; Tue, 10 Dec 2002 17:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266928AbSLJWFf>; Tue, 10 Dec 2002 17:05:35 -0500
Received: from [66.70.28.20] ([66.70.28.20]:50948 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S265305AbSLJWFe>; Tue, 10 Dec 2002 17:05:34 -0500
Date: Tue, 10 Dec 2002 23:13:57 +0100
From: DervishD <raul@pleyades.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [BK-2.4] [PATCH] Small do_mmap_pgoff correction
Message-ID: <20021210221357.GA46@DervishD>
References: <20021210204530.GA63@DervishD> <20021210.124740.86261163.davem@redhat.com> <20021210205906.GA82@DervishD> <20021210.132207.23687680.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021210.132207.23687680.davem@redhat.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi David :)

>        Because PAGE_ALIGN won't return 0?
> What if TASK_SIZE is ~0?  Both your checks will pass
> for the case of (SIZE_MAX-PAGE_SIZE + 1) to ~0 cases.

    Well, the checks were already there... I didn't add them, I just
move a comparison to a better place. If TASK_SIZE is ~0, then
the patch works. If you look at the patch, you will notice that I've
only changed the order of the checks.

    But all of this is pointless. The patch has been reverted and the
2.4.x branch will keep on silently failing when the requested size
for an mmap() call is too large. That's good?

    The patch just took a wrong comparison, did not introduce any
TASK_SIZE comparison and made mmap() work in a corner case.

    FYI, without the patch mmap will silently fail when size is
between SIZE_MAX-PAGE_SIZE and SIZE_MAX. With the patch, it will
return -EINVAL or, in the worst case, it will still silently fail.
This happens only when TASK_SIZE is larger than SIZE_MAX-PAGE_SIZE,
ok, but then propose another solution. The true problem is
PAGE_ALIGN. We shouldn't use it for aligning sizes...

-	if ((len = PAGE_ALIGN(len)) == 0)
+	if (!len)
 		return addr;
 
 	if (len > TASK_SIZE)
 		return -EINVAL;
 
+	len = PAGE_ALIGN(len);  /* This cannot be zero now */

    Anyway, without the patch, mmap fails on all architectures. With
it, it only fails on archs where TASK_SIZE is the entire address
space. On those archs, nothing change so, why punish the other archs?

    Sincerely, I don't understand why this patch is bad. Is no worse
than the previous situation :??

    Raúl
