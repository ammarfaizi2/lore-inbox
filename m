Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWFUXfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWFUXfh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 19:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWFUXfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 19:35:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9159 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932107AbWFUXfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 19:35:36 -0400
Message-ID: <4499D7CD.1020303@engr.sgi.com>
Date: Wed, 21 Jun 2006 16:35:41 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com> <20060609042129.ae97018c.akpm@osdl.org> <4489EE7C.3080007@watson.ibm.com> <449999D1.7000403@engr.sgi.com> <44999A98.8030406@engr.sgi.com> <44999F5A.2080809@watson.ibm.com>
In-Reply-To: <44999F5A.2080809@watson.ibm.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>> System: SGI a350, a two cpus IA64 machine.
>>> Kernel:  2.6.17-rc3 + delay-acct-taskstats patch set
>>>      + tgid-disable_patch_shailabh + exit race patch_balbir +
>>> csa_patch_jlan
>>>
>>> I also modified the Decumentation/accounting/getdelay.c:
>>>  - it repeatedly does recv() to retrieve data from kernel
>>>  - instead of using printf() to display data received, i simply write
>>> it to
>>>    disk as it would be for an accounting daemon. Note that currently
>>> both the
>>>    BSD (or GNU) accounting and the CSA writes accounting data from
>>> kernel.
>>>    As an effort of moving accounting system to userspace, the raw data
>>> needs
>>>    to be written to a raw file first before further processing.
>>>   
> In exit_recv.c, you appear to be dumping the per-tgid data  received
> to disk too ?
> If the accounting daemon isn't interested in per-tgid, shouldn't it be
> discarding the data immediately after
> doing the recv() and only write to disk the data it wants ?
> Perhaps I'm missing something.
>
I modified my exit_recv.c so that
1) i can totally skip data marked  TASKSTATS_TYPE_AGGR_TGID
2) i can optinally drop data after receipt without writing to disk

The first case produced a system time of 1.34 second and the second
case produced a system time of 1.25 sec.  Big improvement over 1.74
sec, but still too high compared to 0.34 sec when we disable tgid
completely.

Shailabh and me now eye on the lock patch that fixed an exit race
crash i reported. The global lock was held too long in scanning threads.
Shailabh is working on a new patch.

- jay

