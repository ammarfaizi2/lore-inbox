Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289020AbSBDPcJ>; Mon, 4 Feb 2002 10:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289025AbSBDPcA>; Mon, 4 Feb 2002 10:32:00 -0500
Received: from 216-42-72-147.ppp.netsville.net ([216.42.72.147]:8625 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S289020AbSBDPbw>; Mon, 4 Feb 2002 10:31:52 -0500
Date: Mon, 04 Feb 2002 10:31:06 -0500
From: Chris Mason <mason@suse.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>, Andi Kleen <ak@suse.de>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT fails in some kernel and FS
Message-ID: <404960000.1012836666@tiny>
In-Reply-To: <3C5EA521.B7D2F8C2@mandrakesoft.com>
In-Reply-To: <E16WkQj-0005By-00@antoli.uib.es.suse.lists.linux.kernel> <3C5AFE2D.95A3C02E@zip.com.au.suse.lists.linux.kernel> <1012597538.26363.443.camel@jen.americas.sgi.com.suse.lists.linux.kernel> <20020202093554.GA7207@tapu.f00f.org.suse.lists.linux.kernel> <234710000.1012674008@tiny.suse.lists.linux.kernel> <20020202205438.D3807@athlon.random.suse.lists.linux.kernel> <242700000.1012680610@tiny.suse.lists.linux.kernel> <3C5C4929.5080403@sgi.com.suse.lists.linux.kernel> <20020202155028.B26147@havoc.gtf.org.suse.lists.linux.kernel> <p737kpvauvv.fsf@oldwotan.suse.de> <3C5EA521.B7D2F8C2@mandrakesoft.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, February 04, 2002 10:13:37 AM -0500 Jeff Garzik <jgarzik@mandrakesoft.com> wrote:

> Andi Kleen wrote:
>> 
>> Jeff Garzik <garzik@havoc.gtf.org> writes:
>> 
>> > On Sat, Feb 02, 2002 at 02:16:41PM -0600, Stephen Lord wrote:
>> > > Can't you fall back to buffered I/O for the tail? OK it complicates the
>> > > code, probably a lot, but it keeps things sane from the user's point of
>> > > view.
>> > 
>> > For O_DIRECT, IMHO you should fail not fallback.  You're simply lying
>> > to the underlying program otherwise.
>> 
>> It's just impossible to write a tail which is smaller than a disk block
>> without another buffer.
> 
> I argue, for reiserfs:
> 
> For O_DIRECT writes, the preferred behavior is to write disk blocks
> obtained through the normal methods (get_block, etc.), and fully support
> inodes for which file tails do not exist.

Done ;-)

> 
> For O_DIRECT reads, if the data is determined to be in a file tail,
> ->direct_IO should either (a) fail or (b) dump the file tail to a normal
> disk block before performing ->direct_IO.

The current patch does A.  Another option is to change the reiserfs open
code to detect the tail and do an -EINVAL for o_direct.  This gives the
application a better way to fall back to normal open methods than returning
an error during the read.

Just to restate, the current O_DIRECT code can never hit a reiserfs tail in 
the normal case.  By definition, reiserfs tails are not block aligned, and 
O_DIRECT writes are.  The only time it is a concern is with a screwy 
interaction between expanding truncates and tails on kernels < 2.4.17.  
Since most O_DIRECT users are databases, and tails are never created on
files > 16k in size, I don't expect anyone to ever see the reiserfs 
triggered -EINVAL from the current patch (famous last words).

-chris

