Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262883AbVAFQ6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbVAFQ6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 11:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbVAFQ6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 11:58:53 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:57728 "EHLO vana")
	by vger.kernel.org with ESMTP id S262883AbVAFQ6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 11:58:31 -0500
Date: Thu, 6 Jan 2005 17:58:27 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
       mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, greg@kroah.com
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Message-ID: <20050106165827.GH5772@vana.vc.cvut.cz>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050106145356.GA18725@infradead.org> <20050106150941.GE1830@wotan.suse.de> <20050106151429.GA19155@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106151429.GA19155@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 03:14:29PM +0000, Christoph Hellwig wrote:
> On Thu, Jan 06, 2005 at 04:09:42PM +0100, Andi Kleen wrote:
> > I would agree that it shouldn't be used for in tree code, but for
> > out of tree code it is rather useful. There are other such feature macros
> > for major driver interface changes too (e.g. in the network stack).
> 
> Which is the only place doing it.  We had this discussion in the past
> (lastone I revolve Greg vetoed it).  We simply shouldn't clutter our
> headers for the sake of out of tree drivers - with LINUX_VERSION_CODE
> we've already implemented a mechanism for out of tree drivers.

LINUX_VERSION_CODE never worked in last ~4 years as definite key to make
decision about supported API.  Vendors are porting stuff across releases,
there exists additional trees like -mm, -wolk, -ac, and even if you look 
at the current example with deprecating register_ioctl32_conversion you'll 
find that it does not work: 

2.6.10 kernel which presents itself as 0x02060A does have this, but 
does not have {compat,native}_ioctl.  

2.6.10-mm2 kernel, which presents itself as 0x02060A too, has 
{compat,native}_ioctl, and also has register_ioctl32_conversion.  

And there is intention to apply patch to 2.6.10-mmX which will present 
itself as 0x02060A again, will have {compat,native}_ioctl, and will either
not have register_ioctl32_conversion at all, or will produce 
unfortunate unwanted annoying warning when this function is used.

So you'll have two 2.6.10 kernels, one says that register_ioctl32_conversion is
only way to do things, and at same time it will say that register_ioctl32_conversion
is deprecated.  Strange, isn't it?  Unfortunate?  Maybe.  Can this work with
LINUX_VERSION_CODE?  Definitely not without an additional checks on other
things.

Same situation exists with pml4/pgd/pud I described in previous mail.  You have
2.6.10 with pgd only, 2.6.10-bkWhatever with pgd/pud, and 2.6.10-mmX with pml4/pgd.
This cannot be checked by LINUX_VERSION_CODE too...

Other changes usually add some #define which can be checked (like PUD_MASK or
pml4_offset), but sometime it happens that no useful macro is created and
test-compile is only way how to discover things (from past let's name epoll
change backported from 2.5.x to 2.4.x-wolk, SKAS's change to do_mmap_pgoff 
prototype living in SUSE tree for a bit, or nopage's change in prototype 
around 2.6.1).
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz
