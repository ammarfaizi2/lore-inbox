Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310323AbSCBFr6>; Sat, 2 Mar 2002 00:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310322AbSCBFru>; Sat, 2 Mar 2002 00:47:50 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:1947 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S310323AbSCBFra>; Sat, 2 Mar 2002 00:47:30 -0500
Date: Fri, 1 Mar 2002 23:01:42 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Mike Anderson <andmike@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: queue_nr_requests needs to be selective
Message-ID: <20020301230142.B14239@vger.timpanogas.org>
In-Reply-To: <20020301132254.A11528@vger.timpanogas.org> <20020301165104.C6778@beaverton.ibm.com> <20020301213908.B13983@vger.timpanogas.org> <20020301225918.A14239@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020301225918.A14239@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Fri, Mar 01, 2002 at 10:59:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 10:59:18PM -0700, Jeff V. Merkey wrote:
> 
> 
> Mike,
> 
> Here are some numbers from the running system.  This system is 
> running at 120 MB/S on a single 3Ware adapter.  Stats attached.  You
> will note that the max commands hitting the adapter are way above
> 15.  I can only presume this is due to caching behavior on the card.
> I do have these cards enabled with caching.  I have had these numbers
> as high as 319 MB/S with multiple cards in separate buses.  The system
> this test is running on has 3 PCI buses.  2 x 33 Mhz and 1 x 66 Mhz.  
> with Serverwork HE Chipset.
> 
> We are averaging complete saturation of the inbound command queue
> on the 3Ware adapter and are posting 64K writes (128 * 512) * 3 on
> aeverage with each command.  I have no idea why the 15 queue depth
> limit is being exceeded here, possibly due to the fact the adapter 
> is caching, but the stats report up to 255 requests being posted 
> per driver pass.
> 
> cat /proc/scsi/3w-xxxx/3
> 
> scsi3: 3ware Storage Controller
> Driver version: 1.02.00.016
> Current commands posted:       205


Why 64/64 request blocks read/write queue was not enough.  

===========>

> Max commands posted:           255

Jeff


> Current pending commands:        0
> Max pending commands:            0
> Last sgl length:                 0
> Max sgl length:                  3
> Last sector count:             128
> Max sector count:              256
> Resets:                          0
> Aborts:                          0
> AEN's:                           0
> 
> 
> cat /proc/scsi/3w-xxxx/3
> 
> scsi3: 3ware Storage Controller
> Driver version: 1.02.00.016
> Current commands posted:         7
> Max commands posted:           255
> Current pending commands:        0
> Max pending commands:            0
> Last sgl length:                 0
> Max sgl length:                  3
> Last sector count:             128
> Max sector count:              256
> Resets:                          0
> Aborts:                          0
> AEN's:                           0
> 
> 
> This test is posting a max of 54,000 4K buffer heads to a single 3Ware
> adapter.  See below:
> 
> 
> trxinfo -a  
> 
> ioctl TRXDRV_QUERY_AIO ret 0
> TRXDRV-AIO STATS
> aio_submitted-3 aio_completed-25601331 aio_error-0
> disk_aio_submitted-25601539 disk_aio_completed-25601331
> sync_active [ x x x x x x x x ]
> async_active [ x x x x x x x x ]
> cb_active-0 aio_sequence-0
> bh_count-65536 bh_inuse-32208 bh_max_inuse-54593 bh_waiters-0
> hash_hits-0 hash_misses-0 hash_fill-3 hash_total-3
> probe_avg-0 probe_max-1
> total_read_req-0 total_write_req-25601536 total_fill_req-0
> total_complete-25739847
> req_sec-0 seconds-12925
> 
> trxinfo -a  
> 
> ioctl TRXDRV_QUERY_AIO ret 0
> TRXDRV-AIO STATS
> aio_submitted-3 aio_completed-25605732 aio_error-0
> disk_aio_submitted-25605891 disk_aio_completed-25605732
> sync_active [ x x x x x x x x ]
> async_active [ x x x x x x x x ]
> cb_active-0 aio_sequence-0
> bh_count-65536 bh_inuse-31440 bh_max_inuse-54593 bh_waiters-0
> hash_hits-0 hash_misses-0 hash_fill-3 hash_total-3
> probe_avg-0 probe_max-1
> total_read_req-0 total_write_req-25605888 total_fill_req-0
> total_complete-25744271
> req_sec-0 seconds-12927
> 
> This test is posting a max of 54,000 4K buffer heads to a single 3Ware
> adapter.
> 
> 
> Jeff
> 
> 
> 
> 
> On Fri, Mar 01, 2002 at 09:39:08PM -0700, Jeff V. Merkey wrote:
> > 
> > 
> > We are going to sleep a lot in __get_request_wait().  This 
> > means the write queue has no free request blocks.  We are mostly writing 
> > to the adapter in this test case, and the data we are writing 
> > is already in order when it's posted.    
> > 
> > We are also posting via submit_bh() so you should trace 
> > that path.  I am seeing 22,000+ buffer heads posted concurrently
> > on each 3Ware card of 4K each with this application
> > on the patch for 2.4.19-pre2.  I will post the actual data
> > for you.  Stand by. 
> > 
> > These 3Ware cards are incredible. 
> > 
> > Jeff
> > 
> > 
> > On Fri, Mar 01, 2002 at 04:51:04PM -0800, Mike Anderson wrote:
> > > Jeff V. Merkey [jmerkey@vger.timpanogas.org] wrote:
> > > > 
> > > > ..snip..
> > > >
> > > > What is really needed here is to allow queue_nr_requests to be 
> > > > configurable on a per adapter/device basis for these high end 
> > > > raid cards like 3Ware since in a RAID 0 configuration, 8 drives
> > > > are in essence a terabyte (1.3 terrabytes in our configuration) 
> > > > and each adapter is showing up as a 1.3 TB device.  64/128
> > > > requests are simply not enough to get the full spectrum of 
> > > > performance atainable with these cards.
> > > > 
> > > Not having direct experience on this card it appears that increasing the
> > > queue_nr_requests number will not allow you to have more ios in flight.
> > > 
> > > Unless I am reading the driver wrong you will be limited to
> > > TW_MAX_CMDS_PER_LUN (15). This value is used by scsi_build_commandblocks
> > > to allocate scsi commands for your scsi_device. This driver does not provide
> > > a select_queue_depths function which allows for increase to the default
> > > template value. 
> > > 
> > > Could it be that the experimentation of increasing this number has
> > > allowed for better merging.
> > > 
> > > -Mike
> > > -- 
> > > Michael Anderson
> > > andmike@us.ibm.com
> > > 
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
