Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271367AbTHHOaL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 10:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271374AbTHHOaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 10:30:10 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:2542 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S271367AbTHHOaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 10:30:02 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: David Woodhouse <dwmw2@infradead.org>
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E19gnVi-00006M-00@calista.inka.de>
References: <E19gnVi-00006M-00@calista.inka.de>
Content-Type: text/plain
Message-Id: <1060352999.25209.507.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Fri, 08 Aug 2003 15:29:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-27 at 16:32, Bernd Eckenfels wrote:
> In article <1059315409.10692.215.camel@sonja> you wrote:
> > A device layer that shuffles around sectors would have interesting
> > semantics, like hardly being portable because one would have to use
> > exactly the same device driver with the same parameters to use the
> > filesystem and thus retrieve the data.
> 
> In fact it should not shuffle around, but support the filesystem in
> requesting new free blocks.

In practice it _does_ shuffle around. It'll keep some kind of metadata
somewhere logging which physical 512-byte 'sectors' on the medium
contain data belonging to each logical 512-byte sector of the emulated
block device. Each time a logical sector is overwritten, it'll just
write it out elsewhere on the physical medium and adjust the metadata
accordingly, and the original copy of that sector becomes obsolete.

When it (almost) runs out of 'elsewhere', it needs to garbage collect --
it'll pick an eraseblock which contains mostly obsolete data, copy the
still-valid sectors into the remaining 'elsewhere' as if they'd been
rewritten with the same data again, then erase the eraseblock which now
_only_ contains obsolete sectors. 

> But I see that FS must support the flash by for example beeing prepared to
> move often used blocks (super blocks, bitmaps, ... ) around.

And by telling it which blocks no longer contain relevant data, so that
the block 'translation layer' can discard them and stop copying them
around the physical medium as described above...

Basically, if you're going to teach the filesystem about flash, you
should teach it about flash properly and quit pretending to be a block
device altogether. The artificial extra layer just begs you to violate
the layering in _so_ many ways that you should just abolish it.

-- 
dwmw2

