Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVF0QSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVF0QSV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVF0QRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 12:17:54 -0400
Received: from [80.71.243.242] ([80.71.243.242]:32723 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261296AbVF0QPu (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 27 Jun 2005 12:15:50 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17088.9784.776332.225807@gargle.gargle.HOWL>
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: [PATCH] fs:lock_rename()/unlock_rename() can lead to deadlock in distributed fs.
Date: Mon, 27 Jun 2005 20:15:13 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zuzana Petrova writes:
 > The problem with lock_rename() is that it compares parent directory dentries  
 > when trying to decide how many inode i_sem semaphores to acquire.  That works  
 > fine on a single node system, but not in a distributed environment, on a  
 > distributed filesystem.  
 >   
 > The problem with rename(2) in a cluster, is that there is no guarantee that  
 > path_lookup()s will return a coherent path structure while at the same time  
 > renames, on another node, are executing on that same path hierarchy.  In our  
 > case, in do_rename(), the parent directory path_lookup()s find/create unique  
 > dentries for the old_dir and new_dir, however, because a rename(2) on another  
 > node was executing, both dentries end up pointing to the same inode.  
 >   
 > When lock_rename(new_dir, old_dir) is called, the dentries don't match, so we  
 > end up in a code path that tries to acquire the inode i_sem of both the  
 > old_dir and new_dir, but since they point to the same inode, the second  
 > attempt to acquire the same i_sem results in a deadlock.  
 >   
 > A fix would be to compare the dentries ->d_inode field instead.  Patch for  
 > kernel 2.6.12.1 attached.

reiser4 had identical patch before pseudo files were disabled. It even
went into -mm:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/broken-out/reiser4-aliased-dir.patch

Nikita.

 > 
 > Author of the patch is Michael Gaughen <mgaughen@polyserve.com>
 > 
 > --
 > Zuzana Petrova

Nikita.
