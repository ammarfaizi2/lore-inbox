Return-Path: <linux-kernel-owner+w=401wt.eu-S1753900AbWL1X7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbWL1X7a (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 18:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924AbWL1X7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 18:59:30 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:36562 "EHLO
	ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbWL1X73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 18:59:29 -0500
X-Greylist: delayed 1347 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Dec 2006 18:59:29 EST
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 28 Dec 2006 23:36:36 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Guillaume Chazarain <guichaz@yahoo.fr>,
       David Miller <davem@davemloft.net>, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, Marc Haber <mh+linux-kernel@zugschlus.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Martin Michlmayr <tbm@cyrius.com>, arjan@infradead.org,
       Chen Kenneth W <kenneth.w.chen@intel.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <Pine.LNX.4.64.0612281325290.4473@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612282326460.3586@hermes-1.csi.cam.ac.uk>
References: <1166314399.7018.6.camel@localhost> <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost> <20061217154026.219b294f.akpm@osdl.org>
 <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612171744360.3479@woody.osdl.org> <45861E68.3060403@yahoo.com.au>
 <20061217214308.62b9021a.akpm@osdl.org> <20061219085149.GA20442@torres.l21.ma.zugschlus.de>
 <20061228180536.GB7385@torres.zugschlus.de> <Pine.LNX.4.64.0612281014190.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612281318480.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612281325290.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006, Linus Torvalds wrote:
> Ok,
>  with the ugly trace capture patch, I've actually captured this corruption 
> in action, I think.
> 
> I did a full trace of all pages involved in one run, and picked one 
> corruption at random:
> 
> 	Chunk 14465 corrupted (0-75)  (01423fb4-01423fff)
> 	Expected 129, got 0
> 	Written as (5126)9509(15017)
> 
> That's the first 76 bytes of a chunk missing, and it's the last 76 bytes 
> on a page. It's page index 01423 in the mapped file, and bytes fb4-fff 
> within that file.
> 
> There were four chunks written to that page:
> 
> 	Writing chunk 14463/15800 (15%) (0142344c) (1)
> 	Writing chunk 14462/15800 (30%) (01422e98) (2) (overflows into 00001423)
> 	Writing chunk 14464/15800 (32%) (01423a00) (3)
> 	Writing chunk 14465/15800 (60%) (01423fb4) (4)  <--- LOST!
> 
> and the other three chunks checked out all right.
> 
> And here's the annotated trace as it concerns that page:
> 
>  - here we write the first chunk to the page:
> 	** (1)  do_no_page: mapping index 00001423 at b7d1f44c (write)
> 	**      Setting page 00001423 dirty
> 
>  - something flushes it out to disk:
> 	**      cpd_for_io: index 00001423
> 	**      cleaning index 00001423 at b7d1f000
> 
>  - here we write the second chunk (which was split over the previous page 
>    and the interesting one):
> 	** (2)  Setting page 00001422 dirty
> 	** (2)  Setting page 00001423 dirty
> 
>  - and here we do a cleaning event
> 	**      cpd_for_io: index 00001423
> 	**      cleaning index 00001423 at b7d1f000
> 
>  - here we write the third chunk:
> 	** (3)  Setting page 00001423 dirty
> 
>  - here we write the fourth chunk:
> 	** (4) NO DIRTY EVENT
> 
>  - and a third flush to disk: 
> 	**      cpd_for_io: index 00001423
> 	**      cleaning index 00001423 at b7d1f000
> 
>  - here we unmap and flush:
> 	**      Unmapped index 00001423 at b7d1f000
> 	**      Removing index 00001423 from page cache
> 
>  - here we remap to check:
> 	**      do_no_page: mapping index 00001423 at b7d1f000 (read)
> 	**      Unmapped index 00001423 at b7d1f000
> 
>  - and finally, here I remove the file after the run:
> 	**      Removing index 00001423 from page cache
> 
> Now, the important thing to see here is:
> 
>  - the missing write did not have a "Setting page 00001423 dirty" event 
>    associated with it.
> 
>  - but I can _see_ where the actual dirty event would be happening in the 
>    logs, because I can see the dirty events of the other chunk writes 
>    around it, so I know exactly where that fourth write happens. And 
>    indeed, it _shouldn't_ get a dirty event, because the page is still 
>    dirty from the write of chunk #3 to that page, which _did_ get a dirty 
>    event.
> 
>    I can see that, because the testing app writes the log of the pages it 
>    writes, and this is the log around the fourth and final write:
> 
> 	...
>         Writing chunk 5338/15800 (60%) (0076eb48)       PFN: 76e/76f
>         Writing chunk 960/15800 (60%) (00156300)        PFN: 156
>         Writing chunk 14465/15800 (60%) (01423fb4)  <----
>         Writing chunk 8594/15800 (60%) (00bf74a8)       PFN: bf7
>         Writing chunk 556/15800 (60%) (000c62f0)        PFN: c6
> 	Writing chunk 15190/15800 (60%) (01526678)	PFN: 1526
> 	...
> 
>    and I can match this up with the full log from the kernel, which looks 
>    like this:
> 
>         Setting page 0000076e dirty
>         Setting page 0000076f dirty
>         Setting page 00000156 dirty
>         Setting page 000000c6 dirty
> 	Setting page 00001526 dirty
> 
>    so I know exactly where the missing writes (to our page at pfn 1423, 
>    and the fpn-bf7 page) happened.
> 
>  - and the thing is, I can see a "cpd_for_io()" happening AFTER that 
>    fourth write. Quite a long while after, in fact. So all of this looks 
>    very fine indeed. We are not losing any dirty bits.
> 
>  - EVEN MORE INTERESTING: write 3 makes it onto disk, and it really uses 
>    the SAME dirty bit as write 4 did (which didn't make it out to disk!). 
>    The event that clears the dirty bit that write 3 did happens AFTER 
>    write 4 has happened!
> 
> So if we're not losing any dirty bits, what's going on?
> 
> I think we have some nasty interaction with the buffer heads. In 

But are chunks 3 and 4 in separate buffer heads?  Sorry could not see it 
immediately from the output you showed...

It is just that there may be a different cause rather than buffer dirty 
state...

A shot in the dark I know but it could perhaps be that a "COW for 
MAP_PRIVATE" like event happens when the page is dirty already thus the 
second write never actually makes it to the shared page thus it never gets 
written out.

I am almost certainly totally barking up the wrong tree but I thought it 
may be worth mentioning just in case there was a slip in the COW logic or 
page writable state maintenance somewhere...

Best regards,

	Anton

> particular, I don't think it's the dirty page bits that are broken (I 
> _see_ that the PageDirty bit was set after write 4 was done to memory in 
> the kernel traces). So I think that a real writeback just doesn't happen, 
> because somebody has marked the buffer heads clean _after_ it started IO 
> on them.
> 
> I think "__mpage_writepage()" is buggy in this regard, for example. It 
> even has a comment about its crapola behaviour:
> 
>         /*
>          * Must try to add the page before marking the buffer clean or
>          * the confused fail path above (OOM) will be very confused when
>          * it finds all bh marked clean (i.e. it will not write anything)
>          */
> 
> however, I don't think that particular thing explains it, because I don't 
> think we use that function for the cases I'm looking at.
> 
> Anyway, I'll add tracing for page-writeback setting/cleaning too, in case 
> I might see anything new there..
> 
> 		Linus

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
