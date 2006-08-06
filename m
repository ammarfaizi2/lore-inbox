Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWHFAQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWHFAQu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 20:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWHFAQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 20:16:49 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:14040 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751453AbWHFAQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 20:16:48 -0400
Date: Sat, 5 Aug 2006 17:13:06 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: David Lang <dlang@digitalinsight.com>
Cc: Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjan@linux.intel.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Valerie Henson <val_henson@linux.intel.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Akkana Peck <akkana@shallowsky.com>,
       Jesse Barnes <jesse.barnes@intel.com>, jsipek@cs.sunysb.edu,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] [PATCH] Relative lazy atime
Message-ID: <20060806001306.GR29686@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060803063622.GB8631@goober> <20060805122537.GA23239@lst.de> <1154797123.12108.6.camel@kleikamp.austin.ibm.com> <1154797475.3054.79.camel@laptopd505.fenrus.org> <20060805183609.GA7564@tuatara.stupidest.org> <20060805222247.GQ29686@ca-server1.us.oracle.com> <Pine.LNX.4.63.0608051604420.20114@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608051604420.20114@qynat.qvtvafvgr.pbz>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 04:06:47PM -0700, David Lang wrote:
> On Sat, 5 Aug 2006, Mark Fasheh wrote:
> 
> >On Sat, Aug 05, 2006 at 11:36:09AM -0700, Chris Wedgwood wrote:
> >>should it be atime-dirty or non-critical-dirty? (ie. make it more
> >>generic to cover cases where we might have other non-critical fields
> >>to flush if we can but can tolerate loss if we dont)
> >So, just to be sure - we're fine with atime being lost due to crashes,
> >errors, etc?
> 
> at least as a optional mode of operation yes.
Well, it certainly doesn't sound like XFS is making this sort of guarantee.

Another method I've seen file systems use is to only update atime if the
difference between current time and the current inode atime is greater than
some timeout value. I'm not a huge fan of that approach as it seems less
predicatble than Val's, and doesn't (theoretically) preserve performance
like the XFS approach.

That said, it's not like OCFS2 doesn't have to care just because other file
systems don't but I don't see much complaining about their methods.


> I'm sure someone will want/need the existing 'update atime immediatly', and 
> there are people who don't care about atime at all (and use noatime), but 
> there is a large middle ground between them where atime is helpful, but 
> doesn't need the real-time update or crash protection.
For OCFS2, the performance hit of 'immediate' atime updates could be
considerable. It's essentially turning a bunch of read only cluster locks
into exclusive ones, and forcing a disk update. This means that other nodes
who have locks on the object would have to invalidate their cache. The node
doing the update will be have to flush it's journal before giving the lock
up, incurring additional cost.

We could certainly give OCFS2 an "immediate atime" mode, but maybe that
could be done as a different mount option? Say, "immatime"? That way the
default is to get the large middle ground. Those who want more performance
could use 'noatime', and those concerned with absolute 100% correctness of
atime in the event of a crash could use the new option.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
