Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316679AbSEQU1M>; Fri, 17 May 2002 16:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316680AbSEQU1L>; Fri, 17 May 2002 16:27:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54284 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316679AbSEQU1K>;
	Fri, 17 May 2002 16:27:10 -0400
Message-ID: <3CE56751.D71C84E9@zip.com.au>
Date: Fri, 17 May 2002 13:25:53 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        Peter Chubb <peter@chubb.wattle.id.au>,
        Anton Altaparmakov <aia21@cantab.net>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        axboe@suse.de, martin@dalecki.de, neilb@cse.unsw.edu.au
Subject: Re: [PATCH] remove 2TB block device limit
In-Reply-To: <200205171332.IAA93516@tomcat.admin.navo.hpc.mil> <E178nm3-000074-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Friday 17 May 2002 15:32, Jesse Pollard wrote:
> > Note - most these really large filesystems allow the inode tables and
> > bitmaps to be stored on disks with a relatively small blocksize (raid 5),
> > and the data on different drives (striped) with a large block size (I believe
> > ours is 64K to 128K sized data blocks, inode/bitmaps are 16K-32K.) This is
> > done for two reasons:
> 
> Since we're on this subject, and you have experience with these large block
> sizes, where exactly do you see the large savings?
> 
>   - setup cost of the disk transfer?
>   - rotational latency of small transfers?
>   - setup cost of the network transfer?
>   - interrupt processing overhead?
>   - other?

If you surf on over to
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.15/ you'll see
some code which performs 64k I/Os.  Reads direct into pagecache.
It reduces the cost of reading from disk by 25% in my testing.
(That code is ready to go - just waiting for Linus to rematerialise).

The remaining profile is interesting.  The workload is simply
`cat large_file > /dev/null':

c012b448 33       0.200877    kmem_cache_free         
c0131af8 33       0.200877    flush_all_zero_pkmaps   
c01e51bc 33       0.200877    blk_recount_segments    
c01f9aec 34       0.206964    hpt374_udma_stop        
c016eb80 36       0.219138    ext2_get_block          
c0133320 37       0.225225    page_cache_readahead    
c013740c 37       0.225225    __getblk                
c0131ba0 41       0.249574    kmap_high               
c01fa1c4 41       0.249574    ata_start_dma           
c016e7dc 46       0.28001     ext2_block_to_path      
c01e5320 48       0.292184    blk_rq_map_sg           
c01c65d0 50       0.304358    radix_tree_reserve      
c014bfb0 53       0.32262     do_mpage_bio_readpage   
c01f4d88 54       0.328707    ata_irq_request         
c0136b34 64       0.389579    __get_hash_table        
c0126a00 72       0.438276    do_generic_file_read    
c016e910 82       0.499148    ext2_get_branch         
c0126610 88       0.535671    unlock_page             
c0106df4 91       0.553932    system_call             
c012b04c 94       0.572194    kmem_cache_alloc        
c01f2494 126      0.766983    ata_taskfile            
c01c66e8 163      0.992208    radix_tree_lookup       
c012d250 165      1.00438     rmqueue                 
c0105274 2781     16.9284     default_idle            
c0126e48 11009    67.0136     file_read_actor         

That's a single 500MHz PIII Xeon, reading at 35 megabytes/sec.

There's 17% "overhead" here.  Going to a larger filesystem
blocksize would provide almost zero benefit in the I/O layers.

Savings from larger blocks and larger pages would come into
the radix tree operations, get_block, a few other places.
At a guess, 8k blocks would cut the overhead to 10-12%.

And larger block size significantly penalises bandwidth for
the many-small-file case.  The larger the blocks, the worse
it gets.  You end up having to implement complexities such
as tail-merging to get around the inefficiency which the
workaround for your other inefficiency caused.

And larger pages with small blocks isn't an answer - CPU load
and seek costs from 2-blocks-per-page is measurable.  At
4 blocks-per-page it's getting serious.

Small pages and pagesize=blocksize are good.  I see no point in
going to larger pages or blocks until the current scheme is 
working efficiently and has been *proven* to still be unfixably
inadequate.

The current code sucks.  Simply amortising that suckiness across
larger blocks is not the right thing to do.

-
