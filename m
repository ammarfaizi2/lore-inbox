Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161313AbWASKHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161313AbWASKHX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 05:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161327AbWASKHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 05:07:23 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:24943 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1161313AbWASKHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 05:07:22 -0500
Message-ID: <43CF6518.4080002@sw.ru>
Date: Thu, 19 Jan 2006 13:08:24 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jan Blunck <jblunck@suse.de>, olh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
References: <20060116223431.GA24841@suse.de>	<43CC2AF8.4050802@sw.ru>	<20060118224953.GA31364@hasse.suse.de> <20060118151054.7c781c45.akpm@osdl.org>
In-Reply-To: <20060118151054.7c781c45.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>On Tue, Jan 17, Kirill Korotaev wrote:
>>
>>
>>>Olaf, can you please check if my patch for busy inodes from -mm tree 
>>>helps you?
>>>Patch name is fix-of-dcache-race-leading-to-busy-inodes-on-umount.patch
>>>http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm4/broken-out/fix-of-dcache-race-leading-to-busy-inodes-on-umount.patch
>>
>>This patch is just wrong. It is hiding bugs in file systems. The problem is
>>that somewhere the reference counting on the vfsmount objects is wrong. The
>>file system is unmounted before the last dentry is dereferenced. Either you
>>didn't hold a reference to the proper vfsmount objects at all or you
>>dereference it too early. See Al Viros patch series (search for "namei fixes")
>>on how to fix this issues.
> 
> 
> The only reason I've been carrying that patch is as a reminder that there's
> a bug that we need to fix.  It'd be good news if that bug had been fixed by
> other means.
> 
> Kirill, do you know whether the bug is still present in 2.6.16-rc1?

it exists in 2.6.15 and I see no changes in 2.6.16-rc1 except for 
cosmetics :(
checked the git tree, dput() etc. the bug is definetely still here - 
nothing changed in this area.

Sorry for bad news.

The patch can be probably remade via introducing "notlocked_refs" 
counter on dentry. if shrinker()/umount() see such a dentry() with 
non-zero refcnt it can sleep as it is done in current patch. It would be 
a little bit cleaner/simpler. What do you think?
If someone suggest any brilliant/helpfull idea I would be happy to 
improve it.

Kirill

