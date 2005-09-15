Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbVIOBS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbVIOBS7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbVIOBS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:18:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:10709 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030321AbVIOBS6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:18:58 -0400
Date: Thu, 15 Sep 2005 02:18:50 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Sripathi Kodi <sripathik@in.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, patrics@interia.pl,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
Message-ID: <20050915011850.GZ25261@ZenIV.linux.org.uk>
References: <20050912134954.7bbd15b2.akpm@osdl.org> <4326CFE2.6000908@in.ibm.com> <Pine.LNX.4.58.0509130744070.3351@g5.osdl.org> <20050913165102.GR25261@ZenIV.linux.org.uk> <Pine.LNX.4.58.0509131000040.3351@g5.osdl.org> <20050913171215.GS25261@ZenIV.linux.org.uk> <43274503.7090303@in.ibm.com> <Pine.LNX.4.58.0509131601400.26803@g5.osdl.org> <20050914015003.GW25261@ZenIV.linux.org.uk> <4328C0D0.6000909@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4328C0D0.6000909@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 07:31:12PM -0500, Sripathi Kodi wrote:
> I can move this code from proc_root_link() to proc_check_root(), but it 
> will still not be completely limited to ->permission() path. I can create a 
> separate ->permission() for proc_task_inode_operations, and have this 
> additional code there. If I do that, I think I will have to duplicate much 
> of proc_check_root(). Or else, I will have to split proc_check_root() into 
> two functions to prevent code duplication. Please let me know if any of 
> these makes sense, and I will send another patch.

The last variant would be preferable if we go in that direction...

> If you don't like this idea at all, please let me know if there any other 
> way of solving the invisible threads problem, short of taking out 
> ->permission() altogether from proc_task_inode_operations.

Frankly, I don't see the rationale for combination of
	* allowing anyone see all processes in top-level directory and
visit their directories, chroot or not
	* allowing anyone see /proc/<pid>/task/*, unless separated by
chroot (note that we allow that regardless of process ownership, etc.)
	* disallowing to see /proc/<pid>/task/* if leader is or used to be
outside of our chroot.

IOW, it's either too weak or too strong; current rules make very little
sense, regardless of the behaviour when group leader dies.
