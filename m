Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbTB0Q0B>; Thu, 27 Feb 2003 11:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbTB0Q0B>; Thu, 27 Feb 2003 11:26:01 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:64454 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S265523AbTB0QZ7>; Thu, 27 Feb 2003 11:25:59 -0500
Date: Thu, 27 Feb 2003 11:36:17 -0500
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Horrible L2 cache effects from kernel compile
Message-ID: <20030227163617.GB28232@delft.aura.cs.cmu.edu>
Mail-Followup-To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <3E5ABBC1.8050203@us.ibm.com.suse.lists.linux.kernel> <p7365r88heo.fsf@amdsimf.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p7365r88heo.fsf@amdsimf.suse.de>
User-Agent: Mutt/1.5.3i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 05:16:31PM +0100, Andi Kleen wrote:
> Dave Hansen <haveblue@us.ibm.com> writes:
> 
> > The surprising thing?  d_lookup() accounts for 8% of the time spent
> > waiting for an L2 miss.
> 
> The reason:
> 
> Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
> 
> (1GB) I bet on your big memory box it is even worse. No cache
> in the world can cache that. If the hash function works well it'll
> guarantee few if any cache locality.

Ehh, I read that as 1MB for the dentry cache and .5MB for the inode
cache, Which is several orders less than 1GB. Ofcourse these are only
the pointers to the chains of dentries and inodes which take up far more
than just 8 bytes per entry. And once you have to start traversing those
hashchains you're toast.

> Try the appended experimental patch. It replaces the hash table madness
> with relatively small fixed tables. The actual size is probably left 
> for experimentation. I choose 64K for inode and 128K for dcache for now.

And as a result you are probably just making the length of any given
hashchain longer, and walking the chain is painful as the referenced
objects are actually scattered throughout memory.

Another optimization is to leave the tables big (scaled up with memory
size), but try to keep the chains as short as possible. f.i. when adding
a new entry to a non-empty chain, drop the old entry if it isn't used.

That would give a lot more control over the actual size of the dentry
and inode caches, so that updatedb runs won't push these caches to
completely take over the VM.

Jan
