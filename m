Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbUL2ODk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbUL2ODk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 09:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUL2ODk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 09:03:40 -0500
Received: from ee.oulu.fi ([130.231.61.23]:27821 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S261350AbUL2ODi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 09:03:38 -0500
Date: Wed, 29 Dec 2004 16:03:33 +0200
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Mateusz Berezecki <mateuszb@gmail.com>
Cc: Stefan Knoblich <stkn@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: b44 ifconfig fails with ENOMEM
Message-ID: <20041229140333.GA27964@ee.oulu.fi>
References: <200412290557.29114.stkn@gentoo.org> <41D2B4B4.6090608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <41D2B4B4.6090608@gmail.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2004 at 02:44:20PM +0100, Mateusz Berezecki wrote:
> >unloading and reloading the module didn't help, only a reboot fixed it 
> >(after ~36hours uptime)
> > 
> >
> same problem here. i left my laptop on for a longer time and ifconfig 
> failed too
> kernel backtrace same as above. kernel looked like it didn't swap out 
> some memory.
> lots of swap free no phys mem free. i dont know if this helps.
> reloading the module didn't help too.
> if you want more info please let me know
Hiya... Known feature :-( See
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=118165 for details.

"See last paragraph of comment #66. The problem is that the driver
needs about 750k of memory that has to be located under 1GB physically
to not trigger the hardware bug that causes crashes and other fun. The
driver tries to allocate that kind of memory
(pci_set_consistent_dma_mask(pdev, 0x3fffffff) ). There should be
plenty, right?

Unfortunately the way it's implemented right now in the generic x86
pci code is that if you ask for some memory with a dma mask of < 4GB,
it falls back to giving you memory from the first 16MB. Now that's a
pretty limited resource :-(. There seems to be 3 drivers that need
similar workarounds (wanxl, aacraid and b44)"

Quickest "fix" is to use a B44_DMA_MASK of 0xffffffff . Which is the
pre-2.6.9 behaviour and is fine if you have <= 1GB of memory or use the
standard 1:3 kernel:user split.
