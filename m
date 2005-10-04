Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbVJDPKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbVJDPKL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVJDPKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:10:11 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:32901 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S964791AbVJDPKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:10:09 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [swsusp] separate snapshot functionality to separate file
Date: Tue, 4 Oct 2005 17:11:12 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
References: <20051002231332.GA2769@elf.ucw.cz> <200510032339.08217.rjw@sisk.pl> <20051003231715.GA17458@elf.ucw.cz>
In-Reply-To: <20051003231715.GA17458@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510041711.13408.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 4 of October 2005 01:17, Pavel Machek wrote:
> Hi!
> 
> > > Split swsusp.c into swsusp.c and snapshot.c. Snapshot only cares
> > > provides system snapshot/restore functionality, while swsusp.c will
> > > provide disk i/o. It should enable untangling of the code in future;
> > > swsusp.c parts can mostly be done in userspace.
> > > 
> > > No code changes.
> > 
> > I think that the functions:
> > 
> > read_suspend_image()
> > read_pagedir()
> > swsusp_pagedir_relocate() (BTW, why there's "swsusp_"?)
> > check_pagedir() (BTW, misleading name)
> > data_read()
> > eat_page()
> > get_usable_page()
> > free_eaten_memory()
> > 
> > should be moved to snapshot.c as well, because they are in fact
> > symmetrical to what's there (they perform the reverse of creating
> > the snapshot and use analogous data structures).  IMO the code
> > change required would not be so drammatic and all of the functions
> > that _operate_ on the snapshot would be in the same file.
> 
> No. read_suspend_image/read_pagedir/data_read is image reading.

Yes, they are, but they use the same data structures and even call the same
functions that are used in snapshot.c (eg. alloc_pagedir).

> That does not belong to snaphost. The rest is notthat clear, but I have it
> working in userspace.

Of course it is doable in the userland, but this does not mean it should be
done in the userland.  Personally I don't think so (please see below).

> Image creation is still done in kernel space, but I think that kernel
> <-> user interface is going to be cleaner that way, and I do not think
> pushing it to user is so huge win.
> 
> Yes, names are not ideal, but that will be followup patch.

Having considered it for a while I think it's too early for the splitting,
because:
1) we have bug fixes pending (viz. the x86-64 resume problem),
2) we can simplify swsusp quite a bit thanks to the rework-memory-freeing
patch (eg. we can get rid of eat_page(), free_eaten_memory() and
some complicated error paths in the resume code), which I'd prefer to do
before the code is split,
3) some cleanups are due before the splitting (eg. function names, the removal
of prepare_suspend_image() etc.),
4) we could make swsusp consist of two functionally independent parts (ie. such
that they use different data structures etc.) while it is in the single file
and _then_ split.

IMHO there could be the snapshot-handling part and the storage-handling
part interfacing via some functions (called by the snapshot-handling part)
like:
1) prepare_to_save(n, m) - initializing the data structures of the storage-handling
part and the storage itself,
2) save_page(*addr, nr) - with addr being the addres of the page to save and nr
the number of the page, where:
- nr = 0 for the first pagedir page,
- nr = (n - 1) for the last pagedir page,
- nr = n for the first image page (ie. the page pointed to by the first pagedir
entry)
- nr = (n + m - 1) for the last image page (ie. the page pointed to by the
last pagedir entry)
3) finish_saving() - removing the storage-handling part data structures,
4) prepare_to_load(*n, *m),
5) load_page(*addr, nr) - now addr being the address where to store the page,
6) finish_loading()

Then the storage-handling part would only have to save/load individual pages
and associate the page numbers given by the snapshot-handling part
with swap offsets or equivalent storage addresses.  In that case the
storage-handling could be moved (at leas partially) to the userland
_without_ reimplementing the swsusp's data structures in there.

Also, we could use more memory-efficient representation of the PBE, as the
only component of it that we really _need_ to save is the .orig_address field.
Namely, the snapshot-handling part could use PBEs consisting of .address,
.orig_address and .next internally, passing only the .orig_address fields
to the storage-handling part (the original order of them could be recreated
based on nr in save_page() and load_page()).

Even if that sounds complicated, I think I can implement it in two weeks,
so please give me a chance.

Greetings,
Rafael
