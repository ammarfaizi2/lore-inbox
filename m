Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946701AbWKANcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946701AbWKANcN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 08:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752195AbWKANcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 08:32:13 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:15691 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1752180AbWKANcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 08:32:11 -0500
Message-ID: <4548A1D3.9070409@sw.ru>
Date: Wed, 01 Nov 2006 16:32:03 +0300
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: David Howells <dhowells@redhat.com>, Kirill Korotaev <dev@sw.ru>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Olaf Hering <olh@suse.de>, Jan Blunck <jblunck@suse.de>
Subject: Re: [Devel] Re: [PATCH 2.6.19-rc3] VFS: per-sb dentry lru list
References: <17734.54114.192151.271984@cse.unsw.edu.au>	<4541BDE2.6050703@sw.ru>	<45409DD5.7050306@sw.ru>	<453F6D90.4060106@sw.ru>	<453F58FB.4050407@sw.ru>	<20792.1161784264@redhat.com>	<21393.1161786209@redhat.com>	<19898.1161869129@redhat.com>	<22562.1161945769@redhat.com>	<24249.1161951081@redhat.com>	<4542123E.4030309@sw.ru>	<20061030042419.GW8394166@melbourne.sgi.com>	<45459B92.400@sw.ru>	<25762.1162291214@redhat.com> <17736.16278.85405.497875@cse.unsw.edu.au>
In-Reply-To: <17736.16278.85405.497875@cse.unsw.edu.au>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Neil,

Neil Brown wrote:
> On Tuesday October 31, dhowells@redhat.com wrote:
>> Neil Brown <neilb@suse.de> wrote:
>>
>>> When we unmount a filesystem we need to release all dentries.
>>> We currently
>>>   - move a collection of dentries to the end of the dentry_unused list
>>>   - call prune_dcache to prune that number of dentries.
>> This is not true anymore.
> 
> True.  That should read:
> 
>  When we remount a filesystem or invalidate a block device which has a
>  mounted filesystem we call shrink dcache_sb which currently:
>      - moves a collection of dentries to the end of the dentry_unused list
>      - calls prune_dcache to prune that number of dentries.
> 
> but the patch is still valid.
> 
> Any objections to it going in to -mm  and maybe .20 ??

Currently we have 3 type of functions that works with dentry_unused list:

1) prune_dcache(NULL) -- called from shrink_dcache_memory, frees the memory and
requires global LRU. works well in current implementation.
2) prune_dcache(sb)  -- called from shrink_dcache_parent(), frees subtree, LRU
is not need here.  Current implementation uses global LRU for these purposes, it
is ineffective, and patch from Neil Brown fixes this issue.
3) shrink_dcache_sb() -- called when we need to free the unused dentries for
given super block. Current implementation is not effective too, and per-sb LRU
would be the best solution here. On the other hand patch from Neil Brown is much
better than current implementation.

In general I think that we should approve Neil Brown's patch. We (I and Kirill
Korotaev) are ready to acknowledge it when the following remarks fill be fixed:

- it seems for me list_splice() is not required inside prune_dcache(),
- DCACHE_REFERENCED dentries should not be removed from private list to
dentry_unused list, this flag should be ignored if the private list is used,
- count argument should be ignored in this case too, we want to free all the
dentries in private list,
- when we shrink the whole super block we should free per-sb anonymous dentries
too (please see Kirill Korotaev's letter)

Then I'm going to prepare new patch that will enhance the shrink_dcache_sb()
performance:
- we can add new list head into struct superblock and use it in
shrink_dcache_sb() instead of temporal private list. We will check is it empty
in dput() and add the new unused dentries to per-sb list instead of
dentry_unused list.

thank you,
	Vasily Averin

SWsoft Virtuozzo/OpenVZ Linux kernel team
