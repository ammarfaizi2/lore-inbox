Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266107AbRF2QLT>; Fri, 29 Jun 2001 12:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266113AbRF2QLJ>; Fri, 29 Jun 2001 12:11:09 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:23567 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S266108AbRF2QLB>; Fri, 29 Jun 2001 12:11:01 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: VFS locking & HFS problems (2.4.6pre6)
Date: Fri, 29 Jun 2001 18:10:52 +0200
Message-Id: <20010629161052.15124@smtp.adsl.oleane.com>
In-Reply-To: <E15G08g-0000UO-00@the-village.bc.nu>
In-Reply-To: <E15G08g-0000UO-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>Holding a spinlock while sleeping is an offence punishable by deadlock..

Right, and it's indeed the problem. But I'm still concerned about
locking since by using that spinlock, the guy who wrote it did
not expect beeing re-entered at this point, and just "cleaning" it
may not be enough.

>You might also look for memory allocations that are not GFP_ATOMIC made with
>the lock held

Yup. It's the problem. It locks, then calls some alloc routines, which
fills a cache and uses kmalloc with GFP_KERNEL.

Turning it into GFP_ATOMIC might not be the best idea as the HFS
filesystem currently shares a single hfs_malloc() for everybody and
turning it into GFP_ATOMIC would cause all of HFS allocs to be atomic.

I can change this single routine (and any other doing the same thing),
but  I'd rather fix it by making sure HFS can safely sleep at this
point and still use GFP_KERNEL.

I just found Documentations/filesystems/Locking document, I bet I'll
find all the infos I need there. It's amazing how long it took me
to look for the info where it logically should be ;)

Ben.


