Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbTKMLXr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 06:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263998AbTKMLXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 06:23:47 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:47235 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263983AbTKMLXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 06:23:42 -0500
Date: Thu, 13 Nov 2003 16:59:12 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: 2.6.0-test9-mm2 - AIO tests still gets slab corruption
Message-ID: <20031113112912.GA4274@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20031104225544.0773904f.akpm@osdl.org> <1068505605.2042.11.camel@ibm-c.pdx.osdl.net> <20031110154232.55eb9b10.akpm@osdl.org> <20031111150229.GA4345@in.ibm.com> <1068667834.1817.13.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068667834.1817.13.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12, 2003 at 12:10:34PM -0800, Daniel McNeil wrote:
> Suparna,
> 
> I ran some AIO tests on your lastest patch and do not get any slab
> corruptions.  However, when I used different i/o sizes (the default is
> 64k), it looks like the AIOs never complete.  I updated my tests to add
> more debug output (with -d option).  As usual, the tests are here:
> http://developer.osdl.org/daniel/AIO/TESTS/

Thanks for unearthing this. 
The i/o size combinations you tried involve partial block i/o
which appear to be triggering a situation where a request spans an 
allocated region followed by a hole, just the case that I wanted 
to see :)

If I correctly understand what is going on, it seems appropriate
to make the fall through to buffered i/o skip the portion
which was written out by already submitted DIO requests -- i.e. to
carry on from where DIO broke off with -ENOTBLK, rather than issue
the entire write from the beginning. That should help address this 
problem. It means that we need to be able to return how much
got written out when we hit -ENOTBLK .... that's a slight change in 
return semantics - thus needs thinking through. 
I had considered doing this earlier, but at that time I didn't see 
a specific problem that would arise if we didn't.  
Have to work on a patch ...

Regards
Suparna

> 
> FYI, '-r' sets the readsize.
>      '-w' sets the writesize.
>      '-s' sets the filesize.
> 
> The tests hang waiting for the AIO writes to complete.  I had to hit
> ^c to get out of the tests.  No messages on the console.
> 
> Examples:
> 
> $ ./aiodio_sparse -d -s 180k -r 18k -w 18k
> io_submit() return 10
> aiodio_sparse: 10 i/o in flight
> child 2223, read loop count 0
> child 2223, read loop count 10
> 
> (The writes never complete)
> 
> $ ./aiodio_sparse -dd -s 180k -r 18k -w 11k
> child 2128, read loop count 0
> io_submit() return 16
> aiodio_sparse: 16 i/o in flight
> aiodio_sparse: offset 180224 filesize 184320 inflight 16
> aiodio_sparse: io_getevent() returned 1
> aiodio_sparse: io_getevent() res 11264 res2 0
> io_submit() return 1
> child 2128, read loop count 10
> 
> (1 write returns, then no more)
> 
> $ ~/AIO/AIO_TESTS/aiodio_sparse -dd -s 160k -r 18k -w 18k
> [....]
> io_submit() return 1
> aiodio_sparse: offset 349184 filesize 1793024 inflight 16
> aiodio_sparse: io_getevent() returned 1
> aiodio_sparse: io_getevent() res 11264 res2 0
> io_submit() return 1
> aiodio_sparse: offset 360448 filesize 1793024 inflight 16
> child 2300, read loop count 20
> child 2300, read loop count 30
> 
> (writes complete for a while and then stop).
> 
> Let me know if you want me to test something else.
> 
> Thanks,
> 
> Daniel
> 
> 
> On Tue, 2003-11-11 at 07:02, Suparna Bhattacharya wrote:
> > On Mon, Nov 10, 2003 at 03:42:32PM -0800, Andrew Morton wrote:
> > > Daniel McNeil <daniel@osdl.org> wrote:
> > > >
> > > > Andrew,
> > > > 
> > > > test9-mm2 is still getting slab corruption with AIO:
> > > 
> > > Why?
> > > 
> > > > Maximal retry count.  Bytes done 0
> > > > Slab corruption: start=dc70f91c, expend=dc70f9eb, problemat=dc70f91c
> > > > Last user: [<c0192fa3>](__aio_put_req+0xbf/0x200)
> > > > Data: 00 01 10 00 00 02 20 00 *********6C ******************************A5
> > > > Next: 71 F0 2C .A3 2F 19 C0 71 F0 2C .********************
> > > > slab error in check_poison_obj(): cache `kiocb': object was modified after freeing
> > > > 
> > > > With suparna's retry-based-aio-dio patch, there are no kernel messages
> > > > and the tests do not see any uninitialized data.
> > > > 
> > > > Any reason not to add suparna's patch to -mm to fix these problems?
> > > 
> > > It relies on infrastructure which is not present in Linus's kernel.  We
> > > should only be interested in fixing mainline 2.6.x.
> > > 
> > > Furthermore I'd like to see the direct-vs-buffered locking fixes fully
> > > implemented against Linus's tree, not -mm.  They're almost there, but are
> > > not quite complete.  Running off and making it dependent on the retry
> > > infrastructure is not really helpful.
> > > 
> > 
> > It was just easier to do this in a non-kludgy way, if we used the
> > retry infrastructure. Here's why:
> > 
> > For fixing some of the cases, we run into a situation when we've 
> > already submitted some of the I/O as AIO (with AIO callbacks set up)
> > by the time we realise that we actually need to wait for that to 
> > complete synchronously before falling back to buffered i/o (otherwise
> > we can corrupt file data). 
> > 
> > With the retry model it is only the actual wait that occurs 
> > differently for AIO and Sync I/O, not the submission. So we 
> > can simply switch to be synchronous at the latter stage.
> > 
> > Having done that, though, I was actually working on trying 
> > to find a way to do this that could hold for the mainline as well
> > (i.e. without using retry infrastructure). The attached patch has 
> > some special casing tweaks that might do the job; it 
> > modifies the AIO-DIO callback to wakeup the caller synchronously 
> > instead of issuing an aio_complete in such situations. 
> > 
> > However the existing aio-dio tests do not seem to exercise some 
> > of those code paths, so I haven't had a chance to verify 
> > if it really works for that case (i.e. A single AIO-DIO request 
> > overwriting an allocated region followed by a hole).
> > 
> > The patch should apply to 2.6.0-test9-mm2.
> > 
> > Regards
> > Suparna
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

