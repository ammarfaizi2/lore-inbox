Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWDLVub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWDLVub (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 17:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWDLVub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 17:50:31 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:38043 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932330AbWDLVua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 17:50:30 -0400
Date: Wed, 12 Apr 2006 15:50:27 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>,
       Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/3] ext3 percpu counter fixes to suppport for ext3 unsigned long type free blocks counter
Message-ID: <20060412215027.GO17364@schatzie.adilger.int>
Mail-Followup-To: Mingming Cao <cmm@us.ibm.com>,
	Ravikiran G Thirumalai <kiran@scalex86.org>,
	Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
	Laurent Vivier <Laurent.Vivier@bull.net>,
	linux-kernel@vger.kernel.org,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-fsdevel@vger.kernel.org
References: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com> <Pine.LNX.4.64.0604111007230.564@schroedinger.engr.sgi.com> <1144782073.3986.15.camel@dyn9047017067.beaverton.ibm.com> <20060411222012.GA5007@localhost.localdomain> <1144877315.3722.26.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144877315.3722.26.camel@dyn9047017067.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 12, 2006  14:28 -0700, Mingming Cao wrote:
> where the check for unsigned long overflow is only turned on 32 bit
> platforms.
> 
> > Or make the counter s64? so that it stays 64 bit on all arches? 
> > 
> 
> Well, don't we have the problem : 64 bit counter add/dec/update is not
> always atomic on all 32 bit platforms? There are risk that we will get
> bogus global value. 

My thought here is that the per-cpu counter could still be a 32-bit counter
and the global value could be a 64-bit value.  That way, we don't need to
mess with 64-bit math in the common case, and we can still have a 64-bit
global value.  The minor drawback would be that we can't have a per-cpu
delta of more than 2^31 at a time, but I don't think this is a worry here.

> > why not change the global per-cpu counter type to unsigned long (as we
> > discussed earlier), so we don't need the extra "ul" flags and interfaces, 
> > and all arches get a standard unsigned long return type? 
> >  We could also 
> > do away with percpu_read_positive then no?  The applications for per-cpu 
> > counters is going to be upcounters always methinks...

The "percpu_read_positive" usage is broken in any case, since it doesn't
correctly handle the case where there is no space in the filesystem at
all.  The calling code (ext3_statfs) really needs to just call percpu_read()
and then return zero if this is negative.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

