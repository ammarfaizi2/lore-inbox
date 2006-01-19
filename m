Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161114AbWASKZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbWASKZI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 05:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161179AbWASKZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 05:25:08 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:44571 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1161114AbWASKZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 05:25:06 -0500
Message-ID: <43CF693D.4020104@sw.ru>
Date: Thu, 19 Jan 2006 13:26:05 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Jan Blunck <jblunck@suse.de>
CC: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
References: <20060116223431.GA24841@suse.de> <43CC2AF8.4050802@sw.ru> <20060118224953.GA31364@hasse.suse.de> <43CF6170.3050608@sw.ru> <20060119100443.GD10267@hasse.suse.de>
In-Reply-To: <20060119100443.GD10267@hasse.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>This patch has nothing to do with vfsmount references and doesn't hide 
>>anything. It just adds syncronization barrier between do_umount() and 
>>shrink_dcache() since the latter can work with dentries/inodes without 
>>holding locks.
>>
>>So if you think there is something wrong with it, please, be more specific.
>>
> 
> 
> You can only unmount a file system if there are no references to the vfsmount
> object anymore. Since shrink_dcache*() is called after checking the refcount of
> vfsmount while unmounting the file system, it isn't possible to hold a
> reference to a dentry (and therefore call dput()) after this point in
> time. Therefore your reference counting on the vfsmount is wrong which is the
> root case for your problem of busy inodes.

You didn't take into account shrink_dcache*() on memory pressure. It 
works when it works. And when it calls dput() it detaches dentry from 
the whole tree and starts to work with inode. do_umount() can 
successfully shrink the other part of the tree, since dentry in question 
is detached, complain about busy inode (it is really being put on 
another CPU, but still busy) and destroy super block.

another scenario from patch comment:

CPU 1				CPU 2
~~~~~				~~~~~
umount /dev/sda1
generic_shutdown_super          shrink_dcache_memory()
shrink_dcache_parent            dput dentry
select_parent                   prune_one_dentry()
                                 <<<< child is dead, locks are released,
                                   but parent is still referenced!!! >>>>
skip dentry->parent,
since it's d_count > 0

message: BUSY inodes after umount...
                                 <<< parent is left on dentry_unused list,
                                    referencing freed super block >>>


Kirill


