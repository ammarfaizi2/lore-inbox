Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754610AbWKHRwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610AbWKHRwe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754619AbWKHRwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:52:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50078 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754610AbWKHRwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:52:33 -0500
Date: Wed, 8 Nov 2006 09:49:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Matthew Wilcox <matthew@wil.cx>, Andi Kleen <ak@suse.de>,
       Jeff Chua <jeff.chua.linux@gmail.com>,
       Aaron Durbin <adurbin@google.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [discuss] Re: 2.6.19-rc4: known unfixed regressions (v3)
In-Reply-To: <20061108172650.GC4729@stusta.de>
Message-ID: <Pine.LNX.4.64.0611080932320.3667@g5.osdl.org>
References: <Pine.LNX.4.64.0611080056480.12828@silvia.corp.fedex.com>
 <20061107171143.GU27140@parisc-linux.org> <200611080839.46670.ak@suse.de>
 <20061108122237.GF27140@parisc-linux.org> <Pine.LNX.4.64.0611080803280.3667@g5.osdl.org>
 <20061108172650.GC4729@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Nov 2006, Adrian Bunk wrote:
> > 
> > Anyway, I do not consider this a regression. MMCONFIG has _never_ worked 
> > reliably. It has always been a case of "we can make it work on some 
> > machines by making it break on others".
> 
> It is a serious regression:
> 
> The problem is that with the default CONFIG_PCI_GOANY, MMCONFIG is the 
> _first_ method tried.

No. That was a bug at some point, but it's not that way now. See

	pci_access_init(void)

which checks the pci_direct_probe() first, and only _then_ calls 
pci_mmcfg_init(). And pci_mmcfg_init() will refuse to even use MMCONFIG 
unless either the direct probe failed _or_ the MMCONFIG area is marked 
entirely reserved in the e820 tables. Exactly because MMCONFIG generally 
doesn't _work_.

Now, if that is indeed broken, then yes, we need to fix it. 

Jeff - when you enable "direct PCI access", what is the printout? You 
should get

	PCI: Using configuration type 1

and the kernel should never have used MMCONFIG if the area wasn't marked 
as reserved in e820..

		Linus
