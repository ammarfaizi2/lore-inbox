Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422965AbWBOFlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422965AbWBOFlh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 00:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422966AbWBOFlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 00:41:37 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:3780 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422965AbWBOFlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 00:41:36 -0500
Date: Wed, 15 Feb 2006 11:16:20 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andi Kleen <ak@suse.de>, Ray Bryant <raybry@mpdtxmail.amd.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes 2.6.16-rc1[2] on 2 node X86_64
Message-ID: <20060215054620.GA2966@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <20060205163618.GB21972@in.ibm.com> <200602081706.26853.ak@suse.de> <20060209043933.GA2986@in.ibm.com> <200602091058.26811.ak@suse.de> <Pine.LNX.4.64.0602141131280.14488@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602141131280.14488@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 11:33:00AM -0800, Christoph Lameter wrote:
> I just took another look at this issue and I cannot see anything wrong. An 
> empty zone should be ignored by the page allocator since nr_free == 0. My 
> patch should not be needed.

There is a check for list_empty(&area->free_list) in __rmqueue(), which
I think is one of the points in the page allocator where the emptiness of
the free_area list is checked. The current zone(when the crash happens)
bypasses this test leading to this crash.

> 
> Could you get us the contents of the struct zone that the page allocator 
> is trying to get memory from?

The zone looks like this:

crash> p *(struct zone *)0xffff81000000e700
$1 = {
  free_pages = 0,
  pages_min = 0,
  pages_low = 0,
  pages_high = 0,
  lowmem_reserve = {0, 0, 0, 0},
  pageset = {0xffff81000c013740, 0xffff81013fc42f40, 0xffffffff8071d600,
    0xffffffff8071d680, 0xffffffff8071d700, 0xffffffff8071d780,
    0xffffffff8071d800, 0xffffffff8071d880, 0xffffffff8071d900,
    0xffffffff8071d980, 0xffffffff8071da00, 0xffffffff8071da80,
    0xffffffff8071db00, 0xffffffff8071db80, 0xffffffff8071dc00,
    0xffffffff8071dc80, 0xffffffff8071dd00, 0xffffffff8071dd80,
    0xffffffff8071de00, 0xffffffff8071de80, 0xffffffff8071df00,
    0xffffffff8071df80, 0xffffffff8071e000, 0xffffffff8071e080,
    0xffffffff8071e100, 0xffffffff8071e180, 0xffffffff8071e200,
    0xffffffff8071e280, 0xffffffff8071e300, 0xffffffff8071e380,
    0xffffffff8071e400, 0xffffffff8071e480},
  lock = {
    raw_lock = {
      slock = 0
    },
    break_lock = 1
  },
  free_area = {{
      free_list = {
        next = 0x0,
        prev = 0x0
      },
      nr_free = 0
    }, {
      free_list = {
        next = 0x0,
        prev = 0x0
      },
      nr_free = 0
    }, {
      free_list = {
        next = 0x0,
        prev = 0x0
      },
      nr_free = 0
    }, {
      free_list = {
        next = 0x0,
        prev = 0x0
      },
      nr_free = 0
    }, {
      free_list = {
        next = 0x0,
        prev = 0x0
      },
      nr_free = 0
    }, {
      free_list = {
        next = 0x0,
        prev = 0x0
      },
      nr_free = 0
    }, {
      free_list = {
        next = 0x0,
        prev = 0x0
      },
      nr_free = 0
    }, {
      free_list = {
        next = 0x0,
        prev = 0x0
      },
      nr_free = 0
    }, {
      free_list = {
        next = 0x0,
        prev = 0x0
      },
      nr_free = 0
    }, {
     free_list = {
        next = 0x0,
        prev = 0x0
      },
      nr_free = 0
    }, {
      free_list = {
        next = 0x0,
        prev = 0x0
      },
      nr_free = 0
    }},
  _pad1_ = {
    x = 0xffff81000000e980 "\001"
  },
  lru_lock = {
    raw_lock = {
      slock = 1
    },
    break_lock = 0
  },
  active_list = {
    next = 0xffff81000000e988,
    prev = 0xffff81000000e988
  },
  inactive_list = {
    next = 0xffff81000000e998,
    prev = 0xffff81000000e998
  },
  nr_scan_active = 0,
  nr_scan_inactive = 0,
  nr_active = 0,
  nr_inactive = 0,
  pages_scanned = 0,
  all_unreclaimable = 0,
  reclaim_in_progress = {
    counter = 0
  },
  last_unsuccessful_zone_reclaim = 0,
 temp_priority = 12,
  prev_priority = 12,
  _pad2_ = {
    x = 0xffff81000000ea00 ""
  },
  wait_table = 0x0,
  wait_table_size = 0,
  wait_table_bits = 0,
  zone_pgdat = 0xffff81000000e000,
  zone_mem_map = 0x0,
  zone_start_pfn = 0,
  spanned_pages = 0,
  present_pages = 0,
  name = 0xffffffff804a858c "Normal"
}

Regards,
Bharata.
