Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUBRLJh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 06:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbUBRLJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 06:09:36 -0500
Received: from ns.suse.de ([195.135.220.2]:31123 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264419AbUBRLJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 06:09:30 -0500
Date: Thu, 19 Feb 2004 07:37:34 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1
Message-Id: <20040219073734.309e396d.ak@suse.de>
In-Reply-To: <20040218025549.4e7c56a1.akpm@osdl.org>
References: <20040217232130.61667965.akpm@osdl.org.suse.lists.linux.kernel>
	<p73wu6k653f.fsf@verdi.suse.de>
	<20040218025549.4e7c56a1.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004 02:55:49 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Andi Kleen <ak@suse.de> wrote:
> >
> > Andrew Morton <akpm@osdl.org> writes:
> > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm1/
> > > 
> > > - Added the dm-crypt driver: a crypto layer for device-mapper.
> > > 
> > >   People need to test and use this please.  There is documentation at
> > >   http://www.saout.de/misc/dm-crypt/.
> > > 
> > >   We should get this tested and merged up.  We can then remove the nasty
> > >   bio remapping code from the loop driver.  This will remove the current
> > >   ordering guarantees which the loop driver provides for journalled
> > >   filesystems.  ie: ext3 on cryptoloop will no longer be crash-proof.
> > > 
> > >   After that we should remove cryptoloop altogether.
> > > 
> > >   It's a bit late but cyptoloop hasn't been there for long anyway and it
> > >   doesn't even work right with highmem systems (that part is fixed in -mm).
> > 
> > Is it guaranteed that this thing will be disk format compatible to cryptoloop? 
> > (mainly in IVs and crypto algorithms)
> 
> Allegedly.  Of course, doing this will simply retain crypto-loop's security
> weaknesses.
> 
> > While 2.3 and 2.4 have broken the on disk format of crypto loop several
> > times (each time to a new "improved and ultimately perfect format")
> > I don't think that's acceptable for a mature OS anymore.
> 
> Well I guess people are free to do that sort of thing with out-of-kernel
> patches.
> 
> One question which needs to be adressed is whether dm-crypt adequately
> addresses crypto-loop's security weaknesses, and if so, how one should set
> it up to do so.

AFAIK the two big security weaknesses in most version of cryptoloop are:
(note that some versions have it fixed with various hacks) 

- Weak IV 
- Extremly bad key management

The first can be addressed in an crypto API module e.g. with an hashed IV, but it needs a 
stable IV format from dm-crypto (that is one of the things I asked for) 

The second one is more a user space problem. However to solve it you need metadata. 
It would be much nicer if it was possible to store it on the block device directly  
(with a special losetup flag for compatibility). Otherwise you get into nasty 
chicken and egg problems with fully encrypted systems.

Supporting metadata can be quite simple - e.g. a standard header on the first blocks that
has a length and a number of records with unique IDs. And the kernel driver would need
to skip over these headers.

-Andi
