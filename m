Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265293AbUHCKVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbUHCKVb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 06:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbUHCKVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 06:21:31 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:63223 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265354AbUHCKVJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 06:21:09 -0400
Date: Tue, 3 Aug 2004 15:47:33 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [patchset] Lockfree fd lookup 0 of 5
Message-ID: <20040803101733.GB4432@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com> <20040802165607.GN12308@parcelfarce.linux.theplanet.co.uk> <20040803092316.GE1753@vitalstatistix.in.ibm.com> <20040803093553.GF1753@vitalstatistix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803093553.GF1753@vitalstatistix.in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 03:05:55PM +0530, Ravikiran G Thirumalai wrote:
> On Tue, Aug 03, 2004 at 02:53:17PM +0530, Ravikiran G Thirumalai wrote:
> > I ran tiobench on this patch and here is the comparison:
> > 
> > 
> > Kernel		Seqread		Randread	Seqwrite	Randwrite
> > --------------------------------------------------------------------------
> > 2.6.7		410.33		234.15		254.39		189.36
> > rwlocks-viro	401.84		232.69		254.09		194.62
> > refcount (kref)	455.72		281.75		272.87		230.10
> > 

Hm...

11514     6.7783  fget_light (vanilla)
13168     7.7224  fget_light (rwlock)
1993      1.2633  fget_light (kref)

Total ticks -

169886  (vanilla)
170520  (rwlock)
157760  (kref)

Of the 12126 ticks that were reduced by kref, 9521 came from 
reduction in fget_light(). So, lock-free fget_light() does help.
Also, it seems the lock contention is not much of an issue -

1203      0.7082  .text.lock.file_table

That explains why rwlock didn't help. I guess we are benefiting
mostly from avoiding the cacheline bouncing and removal of the
lock acquisition.

Thanks
Dipankar
