Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754556AbWKNFo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbWKNFo6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 00:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755383AbWKNFo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 00:44:58 -0500
Received: from mail.suse.de ([195.135.220.2]:32213 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1754556AbWKNFo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 00:44:56 -0500
From: Neil Brown <neilb@suse.de>
To: Vasily Averin <vvs@sw.ru>
Date: Tue, 14 Nov 2006 16:44:46 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17753.22478.650633.368773@cse.unsw.edu.au>
Cc: David Howells <dhowells@redhat.com>, Kirill Korotaev <dev@sw.ru>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Olaf Hering <olh@suse.de>, Jan Blunck <jblunck@suse.de>
Subject: Re: [Devel] Re: [PATCH 2.6.19-rc3] VFS: per-sb dentry lru list
In-Reply-To: message from Vasily Averin on Wednesday November 1
References: <17734.54114.192151.271984@cse.unsw.edu.au>
	<4541BDE2.6050703@sw.ru>
	<45409DD5.7050306@sw.ru>
	<453F6D90.4060106@sw.ru>
	<453F58FB.4050407@sw.ru>
	<20792.1161784264@redhat.com>
	<21393.1161786209@redhat.com>
	<19898.1161869129@redhat.com>
	<22562.1161945769@redhat.com>
	<24249.1161951081@redhat.com>
	<4542123E.4030309@sw.ru>
	<20061030042419.GW8394166@melbourne.sgi.com>
	<45459B92.400@sw.ru>
	<25762.1162291214@redhat.com>
	<17736.16278.85405.497875@cse.unsw.edu.au>
	<4548A1D3.9070409@sw.ru>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 1, vvs@sw.ru wrote:
> 
> Currently we have 3 type of functions that works with dentry_unused list:
> 
> 1) prune_dcache(NULL) -- called from shrink_dcache_memory, frees the memory and
> requires global LRU. works well in current implementation.
> 2) prune_dcache(sb)  -- called from shrink_dcache_parent(), frees subtree, LRU
> is not need here.  Current implementation uses global LRU for these purposes, it
> is ineffective, and patch from Neil Brown fixes this issue.
> 3) shrink_dcache_sb() -- called when we need to free the unused dentries for
> given super block. Current implementation is not effective too, and per-sb LRU
> would be the best solution here. On the other hand patch from Neil Brown is much
> better than current implementation.
> 
> In general I think that we should approve Neil Brown's patch. We (I and Kirill
> Korotaev) are ready to acknowledge it when the following remarks fill be fixed:


> 
> - it seems for me list_splice() is not required inside
>   prune_dcache(),

Yes, the list should be empty when we finish so you are right.

> - DCACHE_REFERENCED dentries should not be removed from private list to
> dentry_unused list, this flag should be ignored if the private list is used,

Agreed.

> - count argument should be ignored in this case too, we want to free all the
> dentries in private list,

Agreed.

> - when we shrink the whole super block we should free per-sb anonymous dentries
> too (please see Kirill Korotaev's letter)
> 

Yes.  Unfortunately I don't think it is as easy as it sounds.
I'll have a closer look.


> Then I'm going to prepare new patch that will enhance the shrink_dcache_sb()
> performance:
> - we can add new list head into struct superblock and use it in
> shrink_dcache_sb() instead of temporal private list. We will check is it empty
> in dput() and add the new unused dentries to per-sb list instead of
> dentry_unused list.

I think that makes sense.  It means that you end up doing less work in
select_parent, because the work has already been done in dput.

How is the patch going?

NeilBrown
