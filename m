Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263426AbUJ2Rs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbUJ2Rs3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 13:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263383AbUJ2Rs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:48:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55274 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263162AbUJ2Rq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:46:57 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Buffered I/O slowness
Date: Fri, 29 Oct 2004 10:46:48 -0700
User-Agent: KMail/1.7
Cc: akpm@osdl.org
References: <200410251814.23273.jbarnes@engr.sgi.com>
In-Reply-To: <200410251814.23273.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IIogBbRGvh3sR3i"
Message-Id: <200410291046.48469.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_IIogBbRGvh3sR3i
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday, October 25, 2004 6:14 pm, Jesse Barnes wrote:
> I've been doing some simple disk I/O benchmarking with an eye towards
> improving large, striped volume bandwidth.  I ran some tests on individual
> disks and filesystems to establish a baseline and found that things
> generally scale quite well:
>
> o one thread/disk using O_DIRECT on the block device
>   read avg: 2784.81 MB/s
>   write avg: 2585.60 MB/s
>
> o one thread/disk using O_DIRECT + filesystem
>   read avg: 2635.98 MB/s
>   write avg: 2573.39 MB/s
>
> o one thread/disk using buffered I/O + filesystem
>   read w/default (128) block/*/queue/read_ahead_kb avg: 2626.25 MB/s
>   read w/max (4096) block/*/queue/read_ahead_kb avg: 2652.62 MB/s
>   write avg: 1394.99 MB/s
>
> Configuration:
>   o 8p sn2 ia64 box
>   o 8GB memory
>   o 58 disks across 16 controllers
>     (4 disks for 10 of them and 3 for the other 6)
>   o aggregate I/O bw available is about 2.8GB/s
>
> Test:
>   o one I/O thread per disk, round robined across the 8 CPUs
>   o each thread did ~450MB of I/O depending on the test (ran for 10s)
>     Note: the total was > 8GB so in the buffered read case not everything
>     could be cached

More results here.  I've run some tests on a large dm striped volume formatted 
with XFS.  It had 64 disks with a 64k stripe unit (XFS was made aware of this 
at format time), and I explicitly set the readahead using blockdev to 524288 
blocks.  The results aren't as bad as my previous runs, but are still much 
slower than they ought to be I think given the direct I/O results above.  
This is after a fresh mount, so the pagecache was empty when I started the 
tests.

o one thread on one large volume using buffered I/O + filesystem
  read (1 thread, one volume, 131072 blocks/request) avg: ~931 MB/s
  write (1 thread, one volume, 131072 blocks/request) avg: ~908 MB/s

I'm intentionally issuing very large reads and writes here to take advantage 
of the striping, but it looks like both the readahead and regular buffered 
I/O code will split the I/O into page sized chunks?  The call chain is pretty 
long, but it looks to me like do_generic_mapping_read() will split the reads 
up by page and issue them independently to the lower levels.  In the direct 
I/O case, up to 64 pages are issued at a time, which seems like it would help 
throughput quite a bit.  The profile seems to confirm this.  Unfortunately I 
didn't save the vmstat output for this run (and now the fc switch is 
misbehaving so I have to fix that before I run again), but iirc the system 
time was pretty high given that only one thread was issuing I/O.

So maybe a few things need to be done:
  o set readahead to larger values by default for dm volumes at setup time
    (the default was very small)
  o maybe bypass readahead for very large requests?
    if the process is doing a huge request, chances are that readahead won't
    benefit it as much as a process doing small requests
  o not sure about writes yet, I haven't looked at that call chain much yet

Does any of this sound reasonable at all?  What else could be done to make the 
buffered I/O layer friendlier to large requests?

Thanks,
Jesse

--Boundary-00=_IIogBbRGvh3sR3i
Content-Type: text/plain;
  charset="iso-8859-1";
  name="vol-buffered-read-profile.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vol-buffered-read-profile.txt"

115383 total                                      0.0203
 49642 ia64_pal_call_static                     258.5521
 42065 default_idle                              93.8951
  7348 __copy_user                                3.1030
  5865 ia64_save_scratch_fpregs                  91.6406
  5766 ia64_load_scratch_fpregs                  90.0938
  1944 _spin_unlock_irq                          30.3750
   352 _spin_unlock_irqrestore                    3.6667
   231 buffered_rmqueue                           0.1245
   225 kmem_cache_free                            0.5859
   151 mpage_end_io_read                          0.2776
   147 __end_that_request_first                   0.1242
   133 bio_alloc                                  0.0967
   122 smp_call_function                          0.1089
   102 shrink_list                                0.0224
    99 unlock_page                                0.4420
    86 free_hot_cold_page                         0.0840
    82 kmem_cache_alloc                           0.3203
    65 __alloc_pages                              0.0271
    53 do_mpage_readpage                          0.0224
    53 bio_clone                                  0.1380
    49 __might_sleep                              0.0806
    44 mpage_readpages                            0.0598
    43 generic_make_request                       0.0345
    42 sn_pci_unmap_sg                            0.1010
    42 sn_dma_flush                               0.0597
    41 clear_page                                 0.2562
    40 file_read_actor                            0.0431
    34 mark_page_accessed                         0.0966
    32 __bio_add_page                             0.0278

--Boundary-00=_IIogBbRGvh3sR3i--
