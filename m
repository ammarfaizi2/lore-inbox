Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbTJOEdk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 00:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbTJOEdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 00:33:40 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:2016 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262395AbTJOEdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 00:33:38 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Wed, 15 Oct 2003 14:33:29 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16268.52761.907998.436272@notabene.cse.unsw.edu.au>
Subject: Strange dcache memory pressure when highmem enabled
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greetings all.

 I have a fairly busy NFS server which has been having performance
 problems lately.  I have managed to work around the problems, but
 would really like to get the root problem fixed.

 The symptom is sluggish performance.
 A more useful symptom is that the number of entries in dentry_cache
 (as reported by /proc/slabinfo) is hanging around 1000, whereas on
 other fileservers it is typically more like 200,000. (I can
 understand how this would correlate directly with the perceived
 sluggishness)

 The key difference between the problematic fileserver and the happy
 fileservers seems to be that the problematic one has HIGHMEM.  It has
 4Gig or RAM where as the others have 512M or 1G.
 When I boot the problematic server with mem=900M the symptom goes
 away (there are plenty of entries in the dentry_cache).

 I noticed this in 2.4.18, and confirmed that it still happens with
 2.4.22. 

 So my question is:
   Why does 3Gig of highmem impose excessive memory pressure on
   dentry_cache (and inode_cache I think).

 
 I tried having a look and found "shrink_caches" in mm/vmscan.c, and
 "try_to_free_pages_zone" which calls it.
 I noticed that shrink_caches calls shrink_dcache_memory independant
 of the classzone that is being shrunk.  So if we are trying to
 shrink ZONE_HIGHMEM, the dentry_cache is shrunk, even though the
 dentry_cache doesn't live in highmem.  However I'm not sure if I have
 understood the classzones well enough for that observation even to
 make sense.

 Help appreciated.

NeilBrown


