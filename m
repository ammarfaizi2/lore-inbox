Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319281AbSHNTjN>; Wed, 14 Aug 2002 15:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319282AbSHNTjN>; Wed, 14 Aug 2002 15:39:13 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:37850 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S319281AbSHNTjM>; Wed, 14 Aug 2002 15:39:12 -0400
Date: Wed, 14 Aug 2002 20:42:47 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Gianni Tedesco <gianni@ecsc.co.uk>
Cc: Mike Black <mblack@csihq.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mmap'ing a large file
Message-ID: <20020814204247.C26404@kushida.apsleyroad.org>
References: <050a01c243a9$2afa3590$f6de11cc@black> <1029342745.8255.6.camel@lemsip>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1029342745.8255.6.camel@lemsip>; from gianni@ecsc.co.uk on Wed, Aug 14, 2002 at 05:32:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gianni Tedesco wrote:
> On Wed, 2002-08-14 at 16:42, Mike Black wrote:
> > Is there a logical reason why a process can't mmap more than a 2G file?
> > 
> > I seem to get stuck at 2142208000 with
> > mmap: Cannot allocate memory
> 
> Perhaps this should be an FAQ item.
> 
> Intel is a 32bit architecture, that is to say the address space is 2^32
> bytes (4GB), of this address space the kernel takes the top 2GB and
> userspace the bottom 2GB.

No, firstly those numbers are incorrect and secondly, that's not the
reason why Mike's program stops at 2142208000.

The standard kernel's address space provides exactly 3GB for userspace.
The range of user addresses is 0x00000000 to 0xbfffffff.  So the
absolute maximum that can be mmaped at a time is a little under 3GB.

The reason why Mike's program won't mmap() more than about 2GB of the
file is for two reasons:

  1. mmap() will search for a free address starting at 0x40000000, up to
     0xbffff000.  It won't search lower addresses, unless you give it a
     hint, and the hinted address is actually unmapped.  I think this is
     to reserve about 1GB for brk().

  2. The executable and shared libraries take some room, too.

Btw Mike, the original program uses `p' uninitialised.  If you weren't
so lucky (say if the stack is initialised differently) you could get
much less than 2GB.

-- Jamie
