Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268711AbTCCSxb>; Mon, 3 Mar 2003 13:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268712AbTCCSxb>; Mon, 3 Mar 2003 13:53:31 -0500
Received: from to-wiznet.redhat.com ([216.129.200.2]:51965 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S268711AbTCCSxa>; Mon, 3 Mar 2003 13:53:30 -0500
Date: Mon, 3 Mar 2003 14:03:56 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Horrible L2 cache effects from kernel compile
Message-ID: <20030303140356.G15363@redhat.com>
References: <3E5BB7EE.5090301@colorfullife.com> <b3gq31$2h8$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <b3gq31$2h8$1@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Feb 25, 2003 at 10:18:09PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 10:18:09PM +0000, Linus Torvalds wrote:
> Right now the "child" list is just a simple linked list, and changing
> that to something more complex might make it possible to get rid of the
> hash entirely. But increasing the size of individual dentries is a bad
> idea, so it would have to be something fairly smart.

Part of it is that some of the dentry is simply just too bloated.  At 
160 bytes, there must be something we can prune:

	qstr.len	- if anyone cares about 4GB long dentries, they 
			  probably have other problems. could be a short
	d_lock		- 1 bit out of 4 bytes
	d_vfs_flags	- 2 bits out of 4 bytes
	d_flags		- 3 bits out of 4 bytes
	d_move_count	- rcu -- is it ever used on UP?
	d_time		- only used by network filesystems
	*d_sb		- rarely used, accessible via inode
	*d_fsdata	- mostly used by exotic/network filesystems
	*d_cookie	- only used when o_profile is active

In short, almost a third can be configured out of existence for some 
setups, and others are candidates for being moved into filesystem specific 
data.

		-ben
-- 
Junk email?  <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
