Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263154AbUFXAXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUFXAXL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 20:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUFXAXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 20:23:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:15297 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263154AbUFXAXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 20:23:08 -0400
Subject: Re: [PATCH] retry force umount (was Re: NFS and umount -f)
From: Daniel McNeil <daniel@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, Andy <genanr@emsphone.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040623234712.GM12308@parcelfarce.linux.theplanet.co.uk>
References: <20040608155414.GA3975@thumper2>
	 <1086710357.3896.11.camel@lade.trondhjem.org>
	 <1088034175.2319.11.camel@ibm-c.pdx.osdl.net>
	 <20040623234712.GM12308@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1088036571.2319.36.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jun 2004 17:22:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-23 at 16:47, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Wed, Jun 23, 2004 at 04:42:55PM -0700, Daniel McNeil wrote:
> > This works for me on 2.6.7 as well.  However, I would get EBUSY back
> > if processes were hung doing nfs operations to the downed server.
> > The processes would get unstuck and get EIO, but the umount would
> > still fail.  Doing a 2nd umount -f with no processes waiting for
> > the server would succeed.  This patch retries force umounts in
> > the kernel an extra time after giving them time to wake up and
> > get out of the kernel.  It doesn't seem quite right to fail
> > a bunch of nfs operations and leave the file system mounted.
> 
> Is there any reason to do that in the kernel?  What, umount(8) can't do the
> same?

One reason to do it in the kernel is for consistency at the syscall
layer -- before the syscall it was mounted and after it is unmounted.
The umount syscall can return after causing nfs operations to fail
for processes waiting for a down server with the file system still
mounted.

You're right though, having umount(8) retry the force umount from
user-space might be good enough.  Ideally, force umount should
always succeed and retrying once inside the kernel doesn't guarantee
that.

Daniel

