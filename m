Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265643AbUAGVx4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 16:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265646AbUAGVx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 16:53:56 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:54292 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S265643AbUAGVxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 16:53:52 -0500
Date: Thu, 8 Jan 2004 08:52:40 +1100
From: Nathan Scott <nathans@sgi.com>
To: Andrew Morton <akpm@osdl.org>, Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: Performance drop 2.6.0-test7 -> 2.6.1-rc2
Message-ID: <20040107215240.GA768@frodo>
References: <20040107023042.710ebff3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107023042.710ebff3.akpm@osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 02:30:42AM -0800, Andrew Morton wrote:
> 
> Nathan, did anything change in XFS which might explain this?

Just been back through the revision history, and thats a definate
"no" - very little changed in 2.6 XFS while the big 2.6 freeze was
on, and since then too (he says, busily preparing a merge tree).

> I see XFS has some private readahead code.   Anything change there?

No, and that readahead code is used for metadata only - for file data
we're making use of the generic IO path code.

cheers.

> Date: Wed, 7 Jan 2004 10:25:21 +0100
> From: Jan Kasprzak <kas@informatics.muni.cz>
> To: linux-kernel@vger.kernel.org
> Subject: Performance drop 2.6.0-test7 -> 2.6.1-rc2
> 
> 
> 	Hello, kernel hackers!
> 
> 	Yesterday I have upgraded the kernel on my FTP server to 2.6.1-rc2
> (from 2.6.0-test7) and today I have found the server struggling under
> load average of 40+ and the system was barely usable. The main load on the
> server is ProFTPd serving mainly ISO 9660 images using sendfile().
> 
> 	Under 2.6.1-rc2 the server put out about 30 Mbit/s of data and load
> average was >40. According to top(1) under 2.6.1-rc2, the CPU was about
> 30% system and 70% iowait. Killing proftpds of course helped and the load
> went back to normal. After rebooting back to 2.6.0-test7 the load was 1-3
> and bandwidth >50 Mbit/s (at which point it is probably limited by
> bandwidth of FTP clients). During past releases of Linux distributions
> the same hardware was able to serve ~400 FTP clients and >220 Mbit/s of
> bandwidth.
> 
> 	The system is Athlon 850, 1.2GB RAM (CONFIG_HIGHMEM4G),
> seven IDE disks, six of them joined to a 800GB LVM1 volume, which holds
> an XFS filesystem with the anonymous FTP tree.
>  
> 	I think I can see a one possible explanation to this behaviour:
> I have written a simple script to parse /proc/diskstats, and according
> to its output, it seems that a block layer in 2.6.1-rc2 issues a several
> times larger read operations than 2.6.0-test7. The later has requests
> between 64 and 128 KB (and never bigger than 128 KB), while former can
> apparently issue as big as 1MByte requests. Anyway, the output of my
> script (5 second average) looks like this under 2.6.1-rc2:
> 
> disk   rops    read   rsize rload  wops   write   wsize wload pend  util ioload
> name  [1/s]  [KB/s]    [KB] [req] [1/s]  [KB/s]    [KB] [req]  [1]   [%]  [req]
> hda    11.6      50     4.3   0.3  35.6     550    15.4   0.4    0  38.0    0.7
> hde   104.6    6562    62.7  24.1   0.0       0     0.0   0.0    0  21.4   24.1
> hdh    25.0     100     4.0   0.0   0.0       0     0.0   0.0    0   1.4    0.0
> hdi    62.4    7798   125.0  12.0   0.0       0     0.0   0.0   38  95.2    9.9
> hdj    20.0   15718   785.9 133.4   0.0       0     0.0   0.0  148 100.2  132.2
> hdk    93.0   11807   127.0  67.2   0.0       0     0.0   0.0   23 100.2   42.6
> hdl    58.2    9050   155.5  16.5   0.0       0     0.0   0.0   34  95.2   11.8
>                                                                                 
> disk   rops    read   rsize rload  wops   write   wsize wload pend  util ioload
> name  [1/s]  [KB/s]    [KB] [req] [1/s]  [KB/s]    [KB] [req]  [1]   [%]  [req]
> hda    47.0    1303    27.7   1.9  13.6     170    12.5   2.5    0  71.5    4.3
> hde    68.8    4362    63.4  17.4   0.0       0     0.0   0.0    0  16.2   17.4
> hdh   283.0   16861    59.6  92.3   0.0       0     0.0   0.0    0  71.2   92.3
> hdi    49.6    9586   193.3  17.1   0.0       0     0.0   0.0   26  89.0   18.6
> hdj    27.0    9248   342.5 137.2   0.0       1     0.0   0.0  126 100.3  133.4
> hdk   298.2   11202    37.6  14.4   0.0       0     0.0   0.0   34  93.3   17.8
> hdl    87.8    9549   108.8  17.0   0.0       0     0.0   0.0   31  85.4   19.8
> 
> 	and the following is from 2.6.0-test7:
> 
> rops    read   rsize rload  wops   write   wsize wload pend  util ioload
> name  [1/s]  [KB/s]    [KB] [req] [1/s]  [KB/s]    [KB] [req]  [1]   [%]  [req]
> hda     4.6      21     4.5   0.0  19.2     252    13.1   0.2    1  15.5    0.2
> hde    42.6    2660    62.4   0.2   0.0       0     0.0   0.0    0  10.9    0.2
> hdh    12.8     601    46.9   0.1   0.0       0     0.0   0.0    0   5.8    0.1
> hdi    40.2    3992    99.3   0.3   0.0       0     0.0   0.0    0  25.0    0.3
> hdj    30.8    2990    97.1   0.4   0.0       0     0.0   0.0    1  31.3    0.4
> hdk    42.8    4843   113.2   0.3   0.0       0     0.0   0.0    0  24.3    0.3
> hdl    81.8    9879   120.8   0.5   0.0       0     0.0   0.0    0  39.2    0.5
>  
> disk   rops    read   rsize rload  wops   write   wsize wload pend  util ioload
> name  [1/s]  [KB/s]    [KB] [req] [1/s]  [KB/s]    [KB] [req]  [1]   [%]  [req]
> hda     8.4      34     4.1   0.2  57.2     574    10.0   4.2    0  41.3    4.4
> hde    26.0    1461    56.2   0.2   0.0       0     0.0   0.0    0   8.1    0.2
> hdh    54.4    3272    60.1   0.3   0.0       0     0.0   0.0    0  14.0    0.3
> hdi    35.4    3590   101.4   0.3   0.6       6     9.3   0.0    0  29.0    0.3
> hdj    61.8    5895    95.4   1.0   0.2       2     8.0   0.0    2  57.4    1.1
> hdk    44.2    5042   114.1   0.2   0.4       2     6.0   0.0    0  21.2    0.2
> hdl    13.6    1136    83.5   0.1   0.0       0     0.0   0.0    0  11.3    0.1
>  
> note the "rsize" column.
> 
> 	But of course the reason can be anything else (changes in XFS,
> maybe?).
> 
> 	I am willing to do more testing, but since this is a production
> server, I cannot go through each kernel version between -test7 and 2.6.1-rc2.
> 
> 	Can you explain (or better, suggest a fix for) this behaviour?
> Thanks,
> 
> -Yenya
> 
> -- 
> | Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
> | GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
> | http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> |  I actually have a lot of admiration and respect for the PATA knowledge  |
> | embedded in drivers/ide. But I would never call it pretty:) -Jeff Garzik |
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Nathan
