Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbVIAOHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbVIAOHs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbVIAOHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:07:48 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:24669 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965118AbVIAOHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:07:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Yy4CjeYK1OyjpWaYrb5KVTPJPD6V0zzqbdSe8M/ZV0dg0TsUFikX+dNlGAhS+4RjZXUOtSPScLI6WBCNJZsjCdWw36zaCaqKUYGypICggf9kSnSBs32I+rT0Vh0fbMRRcMfyLmB1aX0hE8cdynxU+X3p+zDHodt17C1tIK5p9iU=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Memory reclaim: permanently pinned dentries (aka libfs/sysfs) and the blunderbuss effect
Date: Thu, 1 Sep 2005 15:23:22 +0200
User-Agent: KMail/1.8.1
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509011523.23168.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh described at OLS the "blunderbuss effect", i.e. the 
inefficiency of the dentry cache shrinker at freeing whole pages, since we 
could leave (worst-case) one dentry per page because it's at the end of the 
LRU list.

Pinned dentries (in first place libfs ones, but he also includes directories 
one - I think they are just hard to free, not really pinned) are allocated 
from the common dentry_cache, i.e. mixed with normal ones - why don't we fix 
that?

It seems that adding an (optional) flag to a new __d_alloc (with d_alloc 
becoming its wrapper) would be enough, since dentries are always allocated 
directly by filesystems (either on lookup or on creation of the pinned 
dentry). Or call it d_alloc_lively().

Also, it seems that the slab allocator willl allocate objects at fixed 
locations inside a page (even with page colouring, colour_offset is fixed 
per-slab and saved)*, once that slab has been allocated... so if we add a 
"DCACHE_FREED" flag and zero slabs content on alloc (at least for this slab), 
we could maybe enumerate all dentries in a page and try to free them, to 
finally free the whole slab.

* Otherwise this problem could probably be fixed some way.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
