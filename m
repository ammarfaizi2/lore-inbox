Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289380AbSAODRL>; Mon, 14 Jan 2002 22:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289376AbSAODRB>; Mon, 14 Jan 2002 22:17:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65037 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289386AbSAODQq>;
	Mon, 14 Jan 2002 22:16:46 -0500
Date: Tue, 15 Jan 2002 03:16:45 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
Message-ID: <20020115031644.E1929@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E16OlMo-0005NV-00@the-village.bc.nu> <200201102115.g0ALF1e28859@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200201102115.g0ALF1e28859@eng2.beaverton.ibm.com>; from pbadari@us.ibm.com on Thu, Jan 10, 2002 at 01:15:01PM -0800
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 01:15:01PM -0800, Badari Pulavarty wrote:
> The issue with my (mostly) PAGE_SIZE RAW IO patch is, it could generate
> buffer heads with different b_size in a single IO request. Jens & Ben
> have concerns about some of the low level drivers not able to handle
> these. (it would be hard to analyse all the drivers to verify this).
> 
> So, Andrea suggested we add a flag in "blk_dev" structure. Only the
> drivers which support variable size buffer heads in a single IO will
> set it. My RAW VARY patch will use this flag to see if I can do 
> RAW VARY or not. Makes sense ?

	The way I handled it in my O_DIRECT code for the same task (do
the largest I/O you can, instead of a hardcoded 512 or sw_blocksize) was
to merely choose the minimum alignment.  See the patch in
<20020109195606.A16884@parcelfarce.linux.theplanet.co.uk>.  In your
approach, you want leading blocks to be aligned at 512 or so, then all
4k aligned I/Os to be 4k size, then the trailing I/Os are aligned again
at their size.  My approach was 'if aligned at 512, do all 512'.  It is
slower than your approach for large I/Os aligned on 512, but it also
has the property of submitting identical blocksizes in one request.
	Andrea has suggested that I work with you to be incremental on
top of your code.  This would include managing a flag bit to decide if a
device can handle variable I/O sizes in one request.  The issue I have
with that is that in the O_DIRECT case, the fallback is failure, not
slow I/O.  IOW, in rawio, if the flag is false, you issue all I/Os with
a 512 blocksize.  That's slow.  However, in O_DIRECT, if the flag is
false, the sw_blocksize is 4096, and the alignment is 512, you fail with
EINVAL.  That is bad.  In my current patch, the O_DIRECT I/O would
succeed at a 512 byte blocksize.  However, my patch doesn't touch rawio
at all.
	Please have a look at my patch and maybe we can work on merging
our efforts.

Joel

-- 

"The first thing we do, let's kill all the lawyers."
                                        -Henry VI, IV:ii

			http://www.jlbec.org/
			jlbec@evilplan.org
