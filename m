Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263175AbVCXTMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263175AbVCXTMp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 14:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbVCXTMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 14:12:44 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:59871 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263170AbVCXTLs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 14:11:48 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16963.4331.617958.820012@tut.ibm.com>
Date: Thu, 24 Mar 2005 13:11:39 -0600
To: Kingsley Cheung <kingsley@aurema.com>
Cc: Tom Zanussi <zanussi@us.ibm.com>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: read() on relayfs channel returns premature 0
In-Reply-To: <20050324012948.GC25134@aurema.com>
References: <20050323090254.GA10630@aurema.com>
	<16961.35656.576684.890542@tut.ibm.com>
	<20050324012948.GC25134@aurema.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kingsley Cheung writes:
 > On Wed, Mar 23, 2005 at 09:29:12AM -0600, Tom Zanussi wrote:
 > > kingsley@aurema.com writes:
 > >  > 
 > >  > Now I understand that this is not the latest release of relayfs (there
 > >  > are the redux patches, which I have yet to try).  Nonetheless I'd like

[...]

 > 
 > I've tested it on 2.6.10 with the pagg and relayfs patches from
 > 
 > http://www.opersys.com/ftp/pub/relayfs/patch-relayfs-2.6.10-050113 
 > 
 > and
 > 
 > ftp://oss.sgi.com/projects/pagg/download/linux-2.6.10-pagg.patch-4
 > 
 > read() gives me a zero still once about a page of data has been read.
 > 

Thanks - I've tried it out and haven't immediately been able to
reproduce the problem yet - I'll do some more pounding on it though
when I get the chance.

BTW, I just want to point out that there aren't any problems with
read() in the version of relayfs included in the -mm tree (i.e. the
'redux' version), since of course it doesn't support read().

I went ahead and did a quick port of your stuff to the new version of
relayfs, which you can find here:

http://prdownloads.sourceforge.net/dprobes/RelayfsModule-new.tar.bz2?download

There's a README in the tarball with some notes on building and
running it.  It includes both the kernel and user-side code, which makes
use of the relay-apps code and documentation found here (I've included
the necessary files in the RelayfsModule-new tarball so you don't have
to actually get this):

http://prdownloads.sourceforge.net/dprobes/relay-apps-0.2.tar.gz?download

Hopefully the new version will still be useful for what you're trying
to do, but it does differ in a couple important ways from the old
version, and points up the fact that the new relayfs really is now
much more specialized for high-volume applications -

- your old version used 'packet' mode with read().  The new relayfs
only supports 'bulk' mode with mmap(), which means it's not really
useful for notification of single events.  I'm not sure how important
that is for your application - if you're mainly interested in
collecting data, you can certainly use it even for low-volume
applications, but the events will be sent to user space in 'blocks'.
You can modify the user space app to process blocks of events as they
come in, and play around with buffer sizes to get them more often, but
it's not quite the same thing.

- your old version used a single buffer, while the new relayfs only
supports per-cpu buffers, which means you'd have to sort out the
events in user space and impose some ordering using timestamps for
instance if your data doesn't already have a natural ordering (BTW,
the new relayfs doesn't have an option any longer to do automatic
timestamping either).

I'll continue maintaining the old relayfs for existing users (so
thanks for the patch and the test code) so if the new version doesn't
fit your needs, you'll still have the old version to fall back on.

Thanks,

Tom





