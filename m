Return-Path: <linux-kernel-owner+w=401wt.eu-S964920AbXALSt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbXALSt4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 13:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbXALSt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 13:49:56 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:46243 "EHLO
	noname.neutralserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964920AbXALSt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 13:49:56 -0500
Date: Fri, 12 Jan 2007 20:49:45 +0200
From: Dan Aloni <da-x@monatomic.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: kexec + ACPI in 2.6.19 (was: Re: kexec + USB storage in 2.6.19)
Message-ID: <20070112184945.GC24291@localdomain>
References: <20070112122444.GA28597@localdomain> <m1mz4oe3xm.fsf@ebiederm.dsl.xmission.com> <20070112145710.GA29884@localdomain> <m1irfce06s.fsf@ebiederm.dsl.xmission.com> <20070112160243.GA13980@localdomain> <20070112162800.GA23791@localdomain> <20070112164339.GA24291@localdomain> <20070112165600.GB24291@localdomain> <m18xg8dua9.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18xg8dua9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-PopBeforeSMTPSenders: da-x@monatomic.org
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 10:33:34AM -0700, Eric W. Biederman wrote:
> > And I get:
> >
> > [ 1013.864201] PAGE ffff810001000000 (pfn=0): flags=0, count=0
> >
> > So at least no one is using that page. Still it is not clear why it
> > doesn't have the reserve flag turned on.
> 
> My hunch is that it might have something to do with the difference
> in the e820 map.  The original map reports that whole page as
> being usable while in the kexec case the memory from 0x100 is
> reported as being usable.  Perhaps someone has a rounding error?

I added this right at the beginning of sanitize_e820_map():

	for (i=0; i < *pnr_map; i++) {
		printk("index %d: addr=%llx, size=%llx, type=%d\n",
		       i, 
		       (unsigned long long)biosmap[i].addr, 
		       (unsigned long long)biosmap[i].size, 
		       (unsigned int)biosmap[i].type);
	}

.. and got (kexec boot):

[    0.000000] index 0: addr=100, size=9b700, type=1
[    0.000000] index 1: addr=9b800, size=4800, type=2
[    0.000000] index 2: addr=100000, size=cfe70000, type=1
[    0.000000] index 3: addr=cff70000, size=8000, type=3
[    0.000000] index 4: addr=cff78000, size=8000, type=4
[    0.000000] index 5: addr=cff80000, size=80000, type=2
[    0.000000] index 6: addr=e0000000, size=10000000, type=2
[    0.000000] index 7: addr=fec00000, size=10000, type=2
[    0.000000] index 8: addr=fee00000, size=1000, type=2
[    0.000000] index 9: addr=ff800000, size=400000, type=2
[    0.000000] index 10: addr=fffffc00, size=400, type=2
[    0.000000] index 11: addr=100000000, size=30000000, type=1

Compared with a normal boot:

[    0.000000] index 0: addr=0, size=9b800, type=1
[    0.000000] index 1: addr=9b800, size=4800, type=2
[    0.000000] index 2: addr=e4000, size=1c000, type=2
[    0.000000] index 3: addr=100000, size=cfe70000, type=1
[    0.000000] index 4: addr=cff70000, size=8000, type=3
[    0.000000] index 5: addr=cff78000, size=8000, type=4
[    0.000000] index 6: addr=cff80000, size=80000, type=2
[    0.000000] index 7: addr=e0000000, size=10000000, type=2
[    0.000000] index 8: addr=fec00000, size=10000, type=2
[    0.000000] index 9: addr=fee00000, size=1000, type=2
[    0.000000] index 10: addr=ff800000, size=400000, type=2
[    0.000000] index 11: addr=fffffc00, size=400, type=2
[    0.000000] index 12: addr=100000000, size=30000000, type=1

So that is the actual boot data that is passed to us.

Anyway, if I add this:

	if (*pnr_map >= 1) {
		if (biosmap[0].addr == 0x100)
			biosmap[0].addr = 0;
	}

kexec works. I'll use this for now, but obviously we _must_ come up 
with a cleaner fix...		   

-- 
Dan Aloni
XIV LTD, http://www.xivstorage.com
da-x (at) monatomic.org, dan (at) xiv.co.il
