Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261563AbTCKT2h>; Tue, 11 Mar 2003 14:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbTCKT2h>; Tue, 11 Mar 2003 14:28:37 -0500
Received: from unknown.Level3.net ([63.210.233.185]:33105 "EHLO
	cinshrexc03.shermfin.com") by vger.kernel.org with ESMTP
	id <S261563AbTCKT2f> convert rfc822-to-8bit; Tue, 11 Mar 2003 14:28:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: OOPS in do_try_to_free_pages with VERY large software RAID array
Date: Tue, 11 Mar 2003 14:38:30 -0500
Message-ID: <8075D5C3061B9441944E137377645118012E97@cinshrexc03.shermfin.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: OOPS in do_try_to_free_pages with VERY large software RAID array
Thread-Index: AcLnPFm8WAyWMmkgSTaTtfl+XtoHTQAyLX6g
From: "Rechenberg, Andrew" <ARechenberg@shermanfinancialgroup.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
Cc: "Kevin P. Fleming" <kpfleming@cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the help Martin.  It looks like that was the problem.  The
kernel mdstat statistics must have been overwriting some other kernel
memory and giving me my panics.  With the help of Kevin's 2.5 patch I
patched the Red Hat 2.4.18-26 md code to use seq_file and now my big
RAID arrays are syncing and I haven't had a panic yet :D

Thanks again to everyone for the help.  I'll submit the patch to the
linux-raid list as md-seq_file-2.4.18-26.7.x.patch if anyone's
interested.

Regards,
Andy.

-----Original Message-----
From: Martin J. Bligh [mailto:mbligh@aracnet.com] 
Sent: Monday, March 10, 2003 2:28 PM
To: Rechenberg, Andrew; linux-kernel@vger.kernel.org
Subject: Re: OOPS in do_try_to_free_pages with VERY large software RAID
array


> Can anyone help me out please?  I'm trying to create a monster 
> software RAID array and the kernel is not behaving.  On some test 
> hardware I can get 17 RAID1 arrays to begin syncing and will sync with

> /proc/sys/dev/raid/speed_limit_max set to 100000 (the max allowed) 
> with no problem.
> 
> We wanted to use 26 RAID1 arrays and then stripe across them to get 
> very high performance.  When I tried to do that this weekend on our 
> production box we started getting kernel panics when the RAID1 arrays 
> started syncing.  This was with speed_limit_max set to 10000 so the 
> rate wasn't very high.  Since we knew 34 disks worked we decided to 
> put the box in to production with just 13 RAID1 arrays and striping 
> across those.  The performance is great compared to our hardware RAID,

> but I would like to get all the disks we purchase for this system 
> working.
> 
> This morning I connected 56 disks to our test hardware and tried to 
> reproduce the problem.  With the test hardware, the 26 RAID1 arrays 
> were working OK at speed_limit_max 10000 however the kernel OOPSed 
> when I 'less'ed /proc/mdstat.  It wasn't a hard crash because I could 
> still work.  However when I upped the speed_limit_max to 30000 there 
> was a hard crash.

At a wild guess (OK, I only looked for about 1 minute),
md_status_read_proc is generating more than 4K of information, and
overwriting the end of it's 4K page. Throw some debug in there, and get
it to printk how much of the buffer it thinks it's using (just printk sz
every time it changes it). If it's > 4K, convert it to the seq_file
interface.

May not be it, but it seems likely given the unusual scale of what
you're doing, and it's easy to check.

M.



