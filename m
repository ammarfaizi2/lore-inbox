Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132209AbRAXAvZ>; Tue, 23 Jan 2001 19:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132295AbRAXAvQ>; Tue, 23 Jan 2001 19:51:16 -0500
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:35341 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id <S132272AbRAXAue>;
	Tue, 23 Jan 2001 19:50:34 -0500
To: Roman Zippel <zippel@fh-brandenburg.de>, Mark Mokryn <mark@sangate.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: ioremap_nocache problem?
In-Reply-To: <Pine.GSO.4.10.10101231903380.14027-100000@zeus.fh-brandenburg.de>
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 24 Jan 2001 00:50:20 +0000
Message-ID: <y7rk87leptf.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Wragg <dpw@doc.ic.ac.uk>
Gcc: nnfolder:mail.sent
--text follows this line--
Roman Zippel <zippel@fh-brandenburg.de> writes:
> On Tue, 23 Jan 2001, Mark Mokryn wrote:
> > ioremap_nocache does the following:
> >     return __ioremap(offset, size, _PAGE_PCD);

You have a point.

It would be nice if ioremap took a argument indicating the desired
memory type -- normal, nocache, write-through, write-combining, etc.
Then it could look in an architecture-specific table to get the
appropriate page flags for that type.

(x86 processors with PAT and IA64 can set write-combining through page
flags.  x86 processors with MTRRs but not PAT would need a more
elaborate implementation for write-combining.)

> > 
> > However, in drivers/char/mem.c (2.4.0), we see the following:
> > 
> >     /* On PPro and successors, PCD alone doesn't always mean 
> >         uncached because of interactions with the MTRRs. PCD | PWT
> >         means definitely uncached. */ 
> >     if (boot_cpu_data.x86 > 3)
> >             prot |= _PAGE_PCD | _PAGE_PWT;
> > 
> > Does this mean ioremap_nocache() may not do the job?
> 
> ioremap creates a new mapping that shouldn't interfere with MTRR, whereas
> you can map a MTRR mapped area into userspace. But I'm not sure if it's
> correct that no flag is set for boot_cpu_data.x86 <= 3...

The boot_cpu_data.x86 > 3 test is there because the 386 doesn't have
PWT.


David Wragg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
