Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267636AbTCBJmz>; Sun, 2 Mar 2003 04:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269172AbTCBJmz>; Sun, 2 Mar 2003 04:42:55 -0500
Received: from AMarseille-201-1-3-35.abo.wanadoo.fr ([193.253.250.35]:24359
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267636AbTCBJmy>; Sun, 2 Mar 2003 04:42:54 -0500
Subject: Re: 2.5.63: 'Debug: sleeping function called from illegal context
	at mm/slab.c:1617'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1046568414.24557.11.camel@irongate.swansea.linux.org.uk>
References: <20030301210518.GA740@gallifrey>
	 <1046568414.24557.11.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046598825.2030.101.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 02 Mar 2003 10:53:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-02 at 02:26, Alan Cox wrote:
> On Sat, 2003-03-01 at 21:05, Dr. David Alan Gilbert wrote:
> > Hi,
> >   2.5.63 had a good go at trying to boot for me; the only error during
> > boot was 'Debug: sleeping function called from illegal context at
> > mm/slab.c:1617' during the IDE startup.
> 
> Known problem. Its a bug in the request_irq code on x86. IDE just
> happens to be a victim of it.

Well... it's a bug in _all_ archs. They (almost) all call the proc
stuff from request_irq, and worse, on x86, I think, has the
kmalloc inside request_irq changed to GFP_ATOMIC.

You really think request_irq should be safe to be called from irq
context ?

I tend to think IDE is at fault here. It doesn't seem to be a
sane requirement to me to have request_irq be called at IRQ
time. It's rather easy to fix it's kmalloc to be GFP_ATOMIC
instead of GFP_KERNEL, but what about /proc stuff ? And the
day we want to fit IRQs in the driver model, that will probably
involve taking a semaphore as well here and do other IRQ tree
management task that are definitely not something we want to
do at IRQ time.

Ben.
