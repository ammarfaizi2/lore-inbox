Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266723AbRGLVcQ>; Thu, 12 Jul 2001 17:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266691AbRGLVcH>; Thu, 12 Jul 2001 17:32:07 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:18182 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S266714AbRGLVbz>; Thu, 12 Jul 2001 17:31:55 -0400
Message-ID: <3B4E173E.74144A96@namesys.com>
Date: Fri, 13 Jul 2001 01:31:42 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Lance Larsh <llarsh@oracle.com>
CC: Brian Strand <bstrand@switchmanagement.com>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
In-Reply-To: <Pine.LNX.4.31.0107120749520.21040-100000@llarsh-pc2.us.oracle.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lance Larsh wrote:
> 
> On Wed, 11 Jul 2001, Brian Strand wrote:
> 
> > Why did it get so much worse going from 2.2.16 to 2.4.4, with an
> > otherwise-identical configuration?  We had reiserfs+lvm under 2.2.16 too.
> 
> Don't have an answer to that.  I never tried reiser on 2.2.
> 
> > How do ext2+lvm, rawio+lvm, ext2 w/o lvm, and rawio w/o lvm compare in
> > terms of Oracle performance?  I am going to try a migration if 2.4.6
> > doesn't make everything better; do you have any suggestions as to the
> > relative performance of each strategy?
> 
> The best answer I can give at the moment is to use either ext2 or rawio,
> and you might want to avoid lvm for now.
> 
> I never ran any of the lvm configurations myself.  What little I know
> about lvm performance is conjecture based on comparing my reiser results

Lance, I would appreciate it if you would be more careful to identify that you are using O_SYNC,
which is a special case we are not optimized for, and which I am frankly skeptical should be used at
all by an application instead of using fsync judiciously.  It is rare that an application is
inherently completely incapable of ever having two I/Os not be serialized, and using O_SYNC to force
every IO to be serialized rather than picking and choosing when to use fsync, well, I have my doubts
frankly.  If a user really needs every operation to be synchronous, they should buy a system with an
SSD for the journal from applianceware.com (they sell them tuned to run ReiserFS), or else they are
just going to go real slow, no matter what the FS does.


> (5-6x slower than ext2) to the reiser+lvm results from one of our other
> internal groups (10-15x slower than ext2).  So, although it looks like lvm
> throws in a factor of 2-3x slowdown when using reiser, I don't think we
> can assume lvm slows down ext2 by the same amount or else someone probably
> would have noticed by now.  Perhaps there's something that sort of
> resonates between reiser and lvm to cause the combination to be
> particularly bad.  Just guessing...
> 
> And while we're talking about comparing configurations, I'll mention that
> I'm currently trying to compare raw and ext2 (no lvm in either case).
> Although raw should be faster than fs, we're seeing some strange results:
> it looks like ext2 can be as much as 2x faster than raw for reads, though
> I'm not confident that these results are accurate.  The fs might still be
> getting a boost from the fs cache, even though we've tried to eliminate
> that possibility by sizing things appropriately.
> 
> Has anyone else seen results like this, or can anyone think of a
> possible explanation?
> 
> Thanks,
> Lance
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
