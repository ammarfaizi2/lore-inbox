Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291297AbSCDEWd>; Sun, 3 Mar 2002 23:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291291AbSCDEWX>; Sun, 3 Mar 2002 23:22:23 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:9969
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S291272AbSCDEWG>; Sun, 3 Mar 2002 23:22:06 -0500
Date: Sun, 3 Mar 2002 18:49:11 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "T. A." <tkhoadfdsaf@hotmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question on the rmap VM
Message-ID: <20020304024911.GC353@matchmail.com>
Mail-Followup-To: "T. A." <tkhoadfdsaf@hotmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <OE50LayI4TY7zD5J47O00005d3d@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OE50LayI4TY7zD5J47O00005d3d@hotmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2002 at 04:17:31AM -0500, T. A. wrote:
> Hi,
> 
>     I have a question on the rmap VM.  What is the swap requierment for it?
> I remember the previous Rik van Riel VM required twice the amount of
> swapspace as memory to run effectively as many people were complaining about
> that.  I read a while ago that the switch in 2.4.10 to the new AA VM fixed
> that issue.  Will rmap bring back that 2x requirement?  Thanks.

All three 2.4 VMs run best with swap at the same size as ram.

Let me define some VM names:
mainline (latest from Marcelo (currently based on an older version of -aa))
rik-vscan (latest in 2.4.13-ac7 (ac8 has some probs))
rik-rmap (latest patch from rik is still in development but stable (ie,
         running in production for me))
-aa (andrea) (latest patch against mainline)

The 2x ram requirement has been removed in all of the latest versions of the
VM implementations.

Let's compare this part of the 2.2 VM with the base concept of what the 2.4
VMs are doing.

2.2:
  o swap page (4k on most arches) to disk
  o swap page from disk
  o remove from swap
On a system that has a lot of swap activity it is common for the swap areas
to become fragmented.  Also, if the same page needs to be swapped out again,
(and hasn't been modified while in memory) it has to write to disk again.

2.4:
  o swap page (4k on most arches) to disk
  o swap page from disk
  o leave page in swap
With this solution, the pages are left in place there is less chance to get
a fragmented swap area.  Also, if the same page needs to be swapped out
again, (and hasn't been modified while in memory) it is *not* written to
disk again, just simply marked as swapped and freed for other purposes.

===========

Now, if the swap space is smaller than RAM, then when swap space gets low
the kernel will have to start freeing pages that are both in swap and
memory (remember, this is possible now in the 2.4 VMs).  This causes
fragmentation and extra overhead and slows you down at what is probably the
worst time possible to slow down.

Of course I might've left something out, so if I did, please fill in the
blanks...

Hope this helps.

Mike
