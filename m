Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264508AbTDXVmD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbTDXVmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:42:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10932 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264505AbTDXVmB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:42:01 -0400
Date: Thu, 24 Apr 2003 22:54:10 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jamie Lokier <jamie@shareable.org>
Cc: Ian Jackson <ijackson@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: rename("a","b") succeeds multiple times race
Message-ID: <20030424215410.GX10374@parcelfarce.linux.theplanet.co.uk>
References: <16039.53523.533498.354359@chiark.greenend.org.uk> <20030424143058.GC23247@spackhandychoptubes.co.uk> <20030424213418.GJ30082@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424213418.GJ30082@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 10:34:18PM +0100, Jamie Lokier wrote:
> That would be most reliable, and you want to do that in case the
> filesystem is NFS, too.  (On the other hand, there are filesystems
> that support rename(2) but not link(2)).
> 
> However rename(2) should not successfully rename from the _old_ path
> more than once, whether the new names are all the same or not.

It shouldn't, but it's a known problem with 2.2.  Unfixable without
massive change of locking scheme.

What happens is that "from" lookup of second rename() succeeds
before the first one is over.  As the result, you get an old
dentry of "a", _then_ second lookup gives you the same dentry -
renamed to "b" by then.  Then you get rename() done with
old and new dentries being identical.  Which is required to
return 0 and do nothing.

It's b0rken and 2.3/2.4/2.5 prevent that crap from happening by
saner locking rules (we keep the parent director{y,ies} locked
across the entire "do lookups for last components and proceed
with actual rename" sequence; see Documentation/filesystem/ for
more details).

2.2 is hopeless in that respect - to fix that nest of races we would
need to replace the locking of directories in namei.c and friends.
I doubt that Alan is happy with that idea...
