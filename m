Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWJPJaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWJPJaQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 05:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWJPJaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 05:30:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62901 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751484AbWJPJaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 05:30:15 -0400
Subject: Re: [PATCH] gfs2 endianness bug: be16 assigned to be32 field
From: Steven Whitehouse <swhiteho@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610141123580.3952@g5.osdl.org>
References: <20061014154930.GL29920@ftp.linux.org.uk>
	 <Pine.LNX.4.64.0610141123580.3952@g5.osdl.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 16 Oct 2006 10:36:40 +0100
Message-Id: <1160991400.27980.43.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2006-10-14 at 11:32 -0700, Linus Torvalds wrote:
> 
> On Sat, 14 Oct 2006, Al Viro wrote:
> >
> > -	leaf->lf_dirent_format = cpu_to_be16(GFS2_FORMAT_DE);
> > +	leaf->lf_dirent_format = cpu_to_be32(GFS2_FORMAT_DE);
> 
> Hmm. Doesn't this change the on-disk format on a LE machine (eg x86)?
> 
> In other words, this change makes me nervous. A quick grep seems to 
> indicate that nothing actually _uses_ this field, so maybe we don't really 
> care, but I think we should double-check that this is what the GFS2 people 
> really want.
> 
> If we don't want to change the format on a LE machine, then maybe the 
> gfs2_leaf structure should be changed to be
> 
> 	..
> 	__be16 lf_dirent_format;
> 	__be16 lf_unused;
> 	..
> 
> which should keep the bits in the same position on LE.
> 
Its a tricky question, but I think on balance that Al's proposed fix is
the right one...

> Regardless, the old code was clearly wrong, since it gives different 
> on-disk format for a big-endian and a little-endian machine. Al's fix is 
> proper, but perhaps people would prefer something that breaks the BE 
> format rather than the LE format. Hmm?
> 
> Steven?
> 
> 		Linus

As you say, this field isn't actually used by anything. Its whole reason
for existing is to be forwards compatible with GFS1. So I'd be inclined
to accept the patch as proposed in order that as few filesystems as
possible will have the incorrect format. We'll make a note of this
problem and ensure that fsck can fix up the error and if we need to use
this field in future, then we'll take into account that there may be
some filesystems with the incorrect format number.

I think its fairly unlikely that we will need to use it in the near
future though... Its original purpose was to allow future changes in the
metadata format, but this is also allowed for by the mh_format field in
the common metadata header, so I'm not entirely sure why a second format
field was included in this structure (the directory leaf header).

Steve.


