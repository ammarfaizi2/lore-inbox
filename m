Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUCaQTG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 11:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbUCaQTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 11:19:06 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:63761 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S262051AbUCaQRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 11:17:49 -0500
Date: Wed, 31 Mar 2004 17:20:53 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Ray Bryant <raybry@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
cc: anton@samba.org, sds@epoch.ncsc.mil, ak@suse.de,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: RE: [PATCH] [0/6] HUGETLB memory commitment
Message-ID: <21167116.1080753653@42.150.104.212.access.eclipse.net.uk>
In-Reply-To: <200403310851.i2V8pkF28306@unix-os.sc.intel.com>
References: <200403310851.i2V8pkF28306@unix-os.sc.intel.com>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On 31 March 2004 00:51 -0800 "Chen, Kenneth W" <kenneth.w.chen@intel.com>
wrote:

>>>>> Andy Whitcroft wrote on Tuesday, March 30, 2004 5:49 PM
>>>> 	fd = open("/mnt/htlb/myhtlbfile", O_CREAT|O_RDWR, 0755);
>>>> 	mmap(..., fd, offset);
>>>> 
>>>> Accounting didn't happen in this case, (grep Huge /proc/meminfo):
>> 
>> O.k.  Try this one.  Should fix that case.  There is some uglyness in
>> there which needs review, but my testing says this works.
> 
> Under common case, worked perfectly!  But there are always corner cases.
> 
> I can think of two ugliness:
> 1. very sparse hugetlb file.  I can mmap one hugetlb page, at offset
>    512 GB.  This would account 512GB + 1 hugetlb page as committed_AS.
>    But I only asked for one page mapping.  One can say it's a feature,
>    but I think it's a bug.

Yes.  This is true.  This is consistent with the preallocation behaviour of
shared memory segments, but inconsistent with the behaviour of mmap'ing
/dev/zero which it essentially emulates.  This is not trival to fix as we
do not get informed when the unmap occurs.  Accounting for normal pages is
handled directly by the VM unmap code.  I think I have found a way to track
these but it does blur the interfaces between the hugetlbfs and hugepage
implementations.

There are a number of other 'bugs' in the implementation of hugetlb.  For
example, the MAP_SHARED/MAP_PRIVATE flags are ignored, behaviour is
identical in both cases.

> 2. There is no error checking (to undo the committed_AS accounting) after
>    hugetlb_prefault(). hugetlb_prefault doesn't always succeed in allocat-
>    ing all the pages user asked for due to disk quota limit.  It can have
>    partial allocation which would put the committed_AS in a wedged state.

True, this needs work on the interface to the quota system in hugetlbfs.
We essentially need to check the quota before we attempt to fault any
pages.  I'll change it around see how it looks.

Expect new patches tomorrow ...

-apw


