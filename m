Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUEOGuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUEOGuJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 02:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264659AbUEOGuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 02:50:09 -0400
Received: from outmx010.isp.belgacom.be ([195.238.3.233]:57005 "EHLO
	outmx010.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264658AbUEOGuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 02:50:04 -0400
Subject: Re: [PATCH 2.6.6-mm2] vfs iput in inode critical region
From: FabF <Fabian.Frederick@skynet.be>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040515063333.GO17014@parcelfarce.linux.theplanet.co.uk>
References: <1084476395.7979.10.camel@bluerhyme.real3>
	 <20040514224722.GL17014@parcelfarce.linux.theplanet.co.uk>
	 <1084460539.7957.5.camel@bluerhyme.real3>
	 <20040515063333.GO17014@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1084516556.13324.7.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 14 May 2004 08:35:59 +0200
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx010.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-05-15 at 08:33, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Thu, May 13, 2004 at 05:02:19PM +0200, FabF wrote:
> > On Sat, 2004-05-15 at 00:47, viro@parcelfarce.linux.theplanet.co.uk
> > wrote:
> > > On Thu, May 13, 2004 at 09:26:36PM +0200, FabF wrote:
> > > > Hi,
> > > > 
> > > > 	AFAICS, block_dev.c : do_open calls bdput after an unlock_kernel.bdput
> > > > calls iput and iput plays with some parameters and locks in iput final
> > > > case only.Here's a patch to have a spinlock around the whole iput.
> > > 
> > > Huh?  Of course iput() is called without BKL (and in a lot more places than
> > > just that, actually), but why does it imply that we suddenly need to hold
> > > inode_lock over the entire function?
> > > 
> > What can avoid inode->i_state to change during fs put_inode is done plus
> > super_operations get assigned something unprotected as well.
> 
> 1) Nothing whatsoever; why does ->put_inode() need protection for ->i_state
> of all things?
Theorical question of atomicity I guess like stat.c set_bytes asking for
"sufficient locking" should use atomic_t values or critical region and
don't ask sub-layer to process the right locking.Btw set_bytes is used
once (in reiser AFAICS).

> 2) ->i_sb never changes through the lifetime of inode; sb->s_op should never
> change too.
Yep, it should'nt ...

