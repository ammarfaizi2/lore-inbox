Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264442AbUA0OOr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 09:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264485AbUA0OOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 09:14:47 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:65528 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264442AbUA0OOo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 09:14:44 -0500
Date: Tue, 27 Jan 2004 19:47:44 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 2/2] vfsmount_lock / mnt_parent
Message-ID: <20040127141744.GA7357@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <40159DC7.9080504@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40159DC7.9080504@sun.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 11:11:31PM +0000, Mike Waychison wrote:
> The attached patch ensures that we grab vfsmount_lock when grabbing a 
> reference to mnt_parent in follow_up and follow_dotdot.
> 
> We also don't need to access ->mnt_parent in follow_mount and 
> __follow_down to mntput because we already the parent pointer on the stack.
> 
> 

As pointed by Viro on IRC, there are other places where we access/use 
mnt_parent without any protection. IIUC this needs either vfsmount_lock or the
namespace sem for protection. I did audit such places and hope not missed
anything else.

One such place is in autofs4's is_vfsmnt_tree_busy() routine. I hope Ian still 
has the expire patch which corrects it. Didn't know why this patch never hit
lkml.

IMO do_kern_mount() probably don't need any protection for mnt_parent as it is 
still initializing the vfsmount struct.

The other remaining place is m68k/atari/stram.c:swap_init() where it is
initializing a static vfsmount struct, so again IMO no lock required here.

Thanks,
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
