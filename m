Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130132AbRAPMfm>; Tue, 16 Jan 2001 07:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130159AbRAPMfc>; Tue, 16 Jan 2001 07:35:32 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:22800 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130132AbRAPMfT>;
	Tue, 16 Jan 2001 07:35:19 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Urban Widmark <urban@teststation.com>
Date: Tue, 16 Jan 2001 13:33:46 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Oops with 4GB memory setting in 2.4.0 stable
CC: <linux-kernel@vger.kernel.org>, rmager@vgkk.com
X-mailer: Pegasus Mail v3.40
Message-ID: <12BC861F21D7@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jan 01 at 9:40, Urban Widmark wrote:
> On Tue, 16 Jan 2001, Rainer Mager wrote:
> 
> > Hi all,
> >
> >   I have a 100% reproducable bug in all of the 2.4.0 kernels including the
> > latest stable one. The issue is that if I compile the kernel to support 4GB
> > RAM (I have 1 GB) and then try to access a samba mount I get an oops. This
> 
> I'll have a look tonight or so. It works for you on non-bigmem?
> 
> > ALWAYS happens. Usually after this the system is frozen (although the magic
> > SYSREQ still works). If the system isn't frozen then any commands that
> > access the disk will freeze. Fortunately GPM worked and I was able to paste
> > the oops to a file via telnet.
> 
> smb_rename suggests mv, but the process is ls ... er? What commands where
> you running on smbfs when it crashed?
> 
> Could this be a symbol mismatch? Keith Owens suggested a less manual way
> to get module symbol output. Do you get the same results using that?

smb_get_dircache looks suspicious to me, as it can try to map unlimited
number of pages with kmap. And kmaps are not unlimited resource...
You have 512 kmaps, but one SMBFS cache page can contain about 504
pages... So two smbfs cached directories can consume all your kmaps,
dying then in endless loop in mm/highmem.c:map_new_virtual().

Also, smb_add_to_cache looks suspicious:

cachep->idx++;
if (cachep->idx > NINDEX) goto out_full;

cannot idx grow over any limit?

get_block:
  cachep->pages++;
  ...
  if (page) {
    block = kmap(page);
    ...
  }
  
Should not you increment cachep->pages only if grab_cache_page
succeeded? This can cause that smb_find_in_cache finds NULL
index->block, which then oopses...

smb_find_in_cache should verify index->block == NULL anyway, as
smb_get_dircache can return couple of index->block == NULL when system
decided to throw out one of cache pages connected to directory.

But I personally do not use neither smbfs nor PAE, so what I can say...
                                            Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz

BTW: For ncpfs PAE testing I was using patch which needed kmap() for
all memory above 32MB... It was very educational...
                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
