Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267258AbUHVObW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267258AbUHVObW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 10:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUHVObW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 10:31:22 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:63880 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S267258AbUHVObT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 10:31:19 -0400
Date: Sun, 22 Aug 2004 16:31:12 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Ville Herva <vherva@viasys.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm2 breaks vmware
Message-ID: <20040822143112.GB24092@vana.vc.cvut.cz>
References: <20040820104230.GH23741@viasys.com> <20040820035142.3bcdb1cb.akpm@osdl.org> <20040820131825.GI23741@viasys.com> <20040820144304.GF8307@viasys.com> <20040820151621.GJ23741@viasys.com> <20040820114518.49a65b69.akpm@osdl.org> <20040821062927.GM23741@viasys.com> <20040821134918.GA1585@devserv.devel.redhat.com> <20040821190027.GQ3024@viasys.com> <20040821190730.GA25932@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040821190730.GA25932@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2004 at 09:07:30PM +0200, Arjan van de Ven wrote:
> On Sat, Aug 21, 2004 at 10:00:27PM +0300, Ville Herva wrote:
> 
> > > can you try the one below as a replacement ?
> > >
> > > diff -purN linux-2.6.8/arch/i386/mm/init.c linux/arch/i386/mm/init.c
> > > --- linux-2.6.8/arch/i386/mm/init.c	2004-08-21 15:38:10.323915313 +0200
> > > +++ linux/arch/i386/mm/init.c	2004-08-21 15:43:15.082088389 +0200
> > > @@ -93,6 +93,26 @@ static inline int page_is_ram(unsigned l
> > >  	return 0;
> > >  }
> > 
> > (Sorry for the delay.)
> > 
> > Yes, this works. 
> 
> Andrew,
> 
> could you replace the devmem patch in your tree with this one?
> Ingo and I verified that the behavior as to blocking access to physical
> memory is the same while Ville verified it unbreaks this old vmware version
> (which seems to do something nasty just not harmful)
> Thanks,

Sorry that it took so long, I was without connectivity during weekend, trying to
find what's going on.

VMware Workstation 3.2.x (builds 2230 to 2242) uses very strange way to allocate
memory below 4GB range (older prods than 3.2.0 crash on systems with page
tables above 4GB, and VMware 4.x use better technology).

Whole situation (with originally released vmmon) looked like that vmware binary
issued ioctl() to allocate memory, marked that page PG_RESERVED, and returned
physical page number to userspace. Userspace then opened /dev/mem, and mapped
that page to the process.  On cleanup /dev/mem was unmapped, PG_RESERVED bit
was cleared, and page released (in my updates PG_RESERVED setting/clearing is
removed, as it badly intereferes with page's refcounting).

This is broken by two patches in MM: 
* get_user_pages_handle-VM_IO, which marks all /dev/mem memory mmaps as VM_IO 
  (thus breaking get_user_pages() on these pages, which is later needed) and 
* dev-mem-restricton-patch which prevents main memory to be mapped through
  /dev/mem (if page obtained from kernel is above 1MB).

During weekend I was able to create binary patch for VMware Workstation 3.2.1 
(patch available at http://platan.vc.cvut.cz/ftp/pub/vmware/vmware-any-any-update82.tar.gz)
which turns that messy ioctl & /dev/mem mmap to simpler, safer and better /dev/vmmon mmap
(and unmap + ioctl to simple unmap) (as used by WS4+/GSX3+).  After that WS 3.2.1 works on 
your 2.6.8.1-mm3 without problems (after applying two patches I'm sending you
separately to get -mm3 to work at all on my notebook).

Andrew, because I have a binary patch for affected products, I think that you should 
leave your tree as is.  Although I do not agree with dev-mem-restriction-patch,
maybe some other people will feel safer with this restriction in place.  

You can redirect VMware Workstation 3.2.x and VMware GSX Server 2.x customers to 
me, and I'll create binary patches for these other products on demand (I do not 
want to waste my time, and GSX customers should either use supported OSes, or 
latest released GSX version anyway).

Ville, please try applying vmware-any-any-update82.tar.gz.  During application it
must say that it found 'VMware Workstation 3.2.1-build 2242'.  If it will say that it found
build-2230 to 2242, new binary pattern was not recognized and I'll need your vmware binary,
as I did not find build 2230 in my archive. Or you can upgrade to the build 2242.

					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz
