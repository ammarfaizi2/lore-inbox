Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267762AbSLTJg2>; Fri, 20 Dec 2002 04:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267764AbSLTJg2>; Fri, 20 Dec 2002 04:36:28 -0500
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:2314 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267762AbSLTJg0>; Fri, 20 Dec 2002 04:36:26 -0500
Date: Fri, 20 Dec 2002 09:44:47 +0000
To: lvm-devel@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] [PATCH] add kobject to struct mapped_device
Message-ID: <20021220094447.GA1169@reti>
References: <20021218184307.GA32190@kroah.com> <20021219105530.GA2003@reti> <20021220083149.GA10484@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021220083149.GA10484@kroah.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 12:31:50AM -0800, Greg KH wrote:
> Here's an ascii picture which probably makes more sense:
> /sys/block/
> |-- fd0
> |   |-- dev
> |   |-- range
> |   |-- size
> |   `-- stat
> |-- dm-1
> |   |-- dev
> |   |-- dm
> |   |   |-- device0 -> ../../devices/pci0/00:02.5/ide0/0.0
> |   |   |-- device1 -> ../../devices/pci0/00:02.5/ide1/1.0
> |   |   |-- status
> |   |   |-- suspend
> |   |   `-- table
> |   |-- range
> |   |-- size
> |   `-- stat
> 
> Look reasonable?

Yes, it looks promising.  Some worries:

i) The 'status' and 'table' files do not contain a single value.
Splitting it up into single values would be ungainly to say the least,
eg.

  dm
  |-- table
      |-- target1
      |   |-- sector_start
      |   |-- sector_len
      |   |-- target_type
      |   `-- target args
      |
      |-- target2
          |-- sector_start

  hmm ... maybe that's not too bad.

ii) If the table files are not split up then we have the problem that
    they can be larger than a single page, which sysfs can't handle
    (is this still true ?).

iii) We need to be able to poll on the status file so that people can
     block until there is a change of status.  eg, a snapshot uses up
     another 5% of its COW storage, a mirror completes its initial
     build, a path fails in the multipath target.

> Ok.  I can place all of the sysfs specific functions in dm.c, just like
> drivers/block/genhd.c has, or if we place struct mapped_device into
> dm.h, they can live in their own file.  Doesn't bother me either way.

Either put it in dm.c, or define some extra access functions (like
dm_suspended() and dm_kdev()) to get the information you need.  I
would prefer the latter, but we can always move things later.

- Joe
