Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267291AbUIJInY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267291AbUIJInY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267294AbUIJInY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:43:24 -0400
Received: from asplinux.ru ([195.133.213.194]:46348 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S267291AbUIJInV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:43:21 -0400
Message-ID: <41416BCA.3020005@sw.ru>
Date: Fri, 10 Sep 2004 12:54:34 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: William Lee Irwin III <wli@holomorphy.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding per sb inode list to make invalidate_inodes()
 faster
References: <4140791F.8050207@sw.ru>	<Pine.LNX.4.58.0409090844410.5912@ppc970.osdl.org>	<20040909171927.GU3106@holomorphy.com>	<20040909110622.78028ae6.akpm@osdl.org>	<20040909181818.GF3106@holomorphy.com> <20040909120818.7f127d14.akpm@osdl.org>
In-Reply-To: <20040909120818.7f127d14.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> William Lee Irwin III <wli@holomorphy.com> wrote:
>>On Thu, Sep 09, 2004 at 11:06:22AM -0700, Andrew Morton wrote:
>> > Yes.
>> > I have not merged it up because it seems rather dopey to add eight bytes to
>> > the inode to speed up something as rare as umount.
>> > Is there a convincing reason for proceeding with the change?
>>
>> The only motive I'm aware of is for latency in the presence of things
>> such as autofs. It's also worth noting that in the presence of things
>> such as removable media umount is also much more common. I personally
>> find this sufficiently compelling. Kirill may have additional ammunition.

> Well.  That's why I'm keeping the patch alive-but-unmerged.  Waiting to see
> who wants it.

> There are people who have large machines which are automounting hundreds of
> different NFS servers.  I'd certainly expect such a machine to experience
> ongoing umount glitches.  But no reports have yet been sighted by this
> little black duck.
I think It's not always evident where the problem is. For many people 
waiting 2 seconds is ok and they pay no much attention to this small 
little hangs.

1. I saw the bug in bugzilla from NFS people you pointed to me last time 
yourself where the same problem was detected.

2. We come across this problem accidentally. After we started using 4GB 
split in production systems we faced small hangs of umount and quota 
on/off. We have hundreds of super blocks in the systems and do 
mount/umount, quota on/off quite often, so it was quite a noticable 
hangs for us though unfatal.

We extracted the problem in the test case and resolved the issue. The 
patch I posted here a year ago (for 2.4 kernels) was used by us about 
for a year in ALL our production systems.

Well for sure this bug can be triggered only on really big servers with
a huge amount of memory and cache size.
It's up to you whether to apply it or not. I understand your position 
about 8 bytes, but probably it's just a question of using kernel, 
whether it's a user or server system.
Probably we can introduce some config option which would trigger 
features such as this one for enterprise systems.

>> Also, the additional sizeof(struct list_head) is only a requirement
>> while the global inode LRU is maintained. I believed it would have
>> been beneficial to have localized the LRU to the sb also, which would
>> have maintained sizeof(struct inode0 at parity with current mainline.
> 
> Could be.  We would give each superblock its own shrinker callback and
> everything should balance out nicely (hah).
heh, and how do you plan to make per-sb LRU to be fair?

Kirill

