Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWENUtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWENUtl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 16:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWENUtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 16:49:41 -0400
Received: from usea-naimss2.unisys.com ([192.61.61.104]:39694 "EHLO
	usea-naimss2.unisys.com") by vger.kernel.org with ESMTP
	id S1751158AbWENUtk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 16:49:40 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 0/10] bulk cpu removal support
Date: Sun, 14 May 2006 15:49:16 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0BEE@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 0/10] bulk cpu removal support
Thread-Index: AcZ1V/ViTjJ/kowOSJCa8g0DxVCvwACPk1Fg
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Nathan Lynch" <ntl@pobox.com>, "Ashok Raj" <ashok.raj@intel.com>
Cc: "Martin Bligh" <mbligh@mbligh.org>, "Andrew Morton" <akpm@osdl.org>,
       <shaohua.li@intel.com>, <linux-kernel@vger.kernel.org>,
       <zwane@linuxpower.ca>, <vatsa@in.ibm.com>, <nickpiggin@yahoo.com.au>
X-OriginalArrivalTime: 14 May 2006 20:49:17.0162 (UTC) FILETIME=[DDCD3CA0:01C67797]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj wrote:
> > On Thu, May 11, 2006 at 01:42:47PM -0700, Martin Bligh wrote:
> > > Ashok Raj wrote:
> > > > 
> > > > 
> > > > It depends on whats running at the time... with some 
> light load, i 
> > > > measured wall clock time, i remember seeing 2 secs at 
> times, but 
> > > > its been a long time i did that.. so take that with a pinch :-)_
> > > > 
> > > > i will try to get those idle and load times worked out again... 
> > > > the best i have is a  16 way, if i get help from big 
> system oems i 
> > > > will send the numbers out
> > > 
> > > Why is taking 30s to offline CPUs a problem?
> > > 
> > 
> > Well, the real problem is that for each cpu offline we 
> schedule a RT 
> > thread
> > kstopmachine() on each cpu, then turn off interrupts until this one 
> > cpu has removed. stop_machine_run() is a big enough sledge hammer 
> > during cpu offline and doing this repeatedly... say on a 4 socket 
> > system, where each socket=16 logical cpus.
> > 
> > the system would tend to get hick ups 64 times, since we do the 
> > stopmachine thread once for each logical cpu. When we want 
> to replace 
> > a node for reliability reasons, its not clear if this hick 
> ups is a good thing.
> 
> Can you provide more detail on what you mean by hiccups?
>
> 
> > Doing kstopmachine() on a single system is in itself 
> noticable, what 
> > we heard from some OEM's is this would have other app level 
> impact as well.
> 
Per Ashok's request here is some data on offlining with cpu_bulk_remove
vs. sequentially with a shell script.
I had 64x system (physical CPU) and 128 (those 64 hyperthreaded). The
system was idle. 
Elapsed times are not strikingly different but system/user times are:

                64 CPU                                          128 CPU
(64 physical hyperthreaded)
                cpu_bulk_remove         shell script
cpu_bulk_remove         shell script
all offline     real    0m11.231s       real    0m10.775s       real
0m26.973s       real    0m16.484s
                user    0m0.000s        user    0m0.056         user
0m0.000s        user    0m0.068s
                sys     0m0.072s        sys     0m0.448         sys
0m0.132s        sys     0m1.312s

                real    0m11.977s       real    0m10.550s       real
0m28.978s       real    0m14.259s
                user    0m0.000s        user    0m0.064s        user
0m0.000s        user    0m0.060s
                sys     0m0.032s        sys     0m0.464s        sys
0m0.152s        sys     0m1.432s

32 offline      real    0m1.320s        real    0m2.422s        real
0m1.647s        real    0m1.896s
                user    0m0.000s        user    0m0.000s        user
0m0.000s        user    0m0.020s
                sys     0m0.076s        sys     0m0.232s        sys
0m0.096s        sys     0m0.456s

                real    0m1.407s        real    0m3.348s        real
0m0.418s        real    0m1.198s
                user    0m0.000s        user    0m0.012s        user
0m0.000s        user    0m0.008s
                sys     0m0.072s        sys     0m0.276s        sys
0m0.044s        sys     0m0.244s

groups of 16    real 0m5.877s           real 0m11.403s
                user 0m0.000s           user 0m0.024s
                sys 0m0.140s            sys 0m0.408s

groups of 8     real 0m8.847s           real 0m12.078s          real
0m12.311s       real    0m12.736s
                user 0m0.004s           user 0m0.028s           user
0m0.004s        user    0m0.076s
                sys 0m0.232s            sys 0m0.536s            sys
0m0.448s        sys     0m1.448s

                                                                real
0m11.968s       real    0m14.314s
                                                                user
0m0.008s        user    0m0.084s
                                                                sys
0m0.400s        sys     0m1.492s

With smaller "bulks" cpu_bulk_remove is always better, but with large
ones shell script mostly wins, especially with hyperthreading (despite
of much better system and user times!)

Thanks,
--Natalie
