Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWECNEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWECNEF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 09:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWECNEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 09:04:05 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:18851 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1030187AbWECNEE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 09:04:04 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17496.43310.4995.299196@gargle.gargle.HOWL>
Date: Wed, 3 May 2006 16:59:26 +0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] kernel facilities for cache prefetching
Newsgroups: gmane.linux.kernel
In-Reply-To: <Pine.LNX.4.64.0605020832570.4086@g5.osdl.org>
References: <346556235.24875@ustc.edu.cn>
	<Pine.LNX.4.64.0605020832570.4086@g5.osdl.org>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > 

[...]

 > 
 > Now, admittedly it has a few downsides:
 > 
 >  - right now "readpage()" is called in several places, and you'd have to 
 >    create some kind of nice wrapper for the most common 
 >    "mapping->a_ops->readpage()" thing and hook into there to avoid 
 >    duplicating the effort.
 > 
 >    Alternatively, you could decide that you only want to do this at the 
 >    filesystem level, which actually simplifies some things. If you 
 >    instrument "mpage_readpage[2]()", you'll already get several of the 
 >    ones you care about, and you could do the others individually.
 > 
 >    [ As a third alternative, you might decide that the only thing you
 >    actually care about is when you have to wait on a locked page, and 
 >    instrument the page wait-queues instead. ]
 > 
 >  - it will miss any situation where a filesystem does a read some other 
 >    way. Notably, in many loads, the _directory_ accesses are the important 
 >    ones, and if you want statistics for those you'd often have to do that 
 >    separately (not always - some of the filesystems just use the same 
 >    page reading stuff).

Another disadvantage is that ->readpage() can only do read-ahead within
single file, which is not helpful for the case of reading a lot of small
files (and this is what happens during startup).

And to implement reasonable multi-file read-ahead at the file system
layer one needs asynchronous inode loading interface implemented for
every file system.

Nikita.
