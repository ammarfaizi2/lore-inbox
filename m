Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUDAO4d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 09:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUDAO4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 09:56:21 -0500
Received: from ida.rowland.org ([192.131.102.52]:4612 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262260AbUDAO4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 09:56:17 -0500
Date: Thu, 1 Apr 2004 09:56:16 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Maneesh Soni <maneesh@in.ibm.com>
cc: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       <viro@math.psu.edu>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
In-Reply-To: <20040401051740.GA1291@in.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0404010945210.838-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2004, Maneesh Soni wrote:

> On Wed, Mar 31, 2004 at 10:11:37AM -0500, Alan Stern wrote:
> > 
> > Here's a suggestion.  At the start of check_perm() grab the dentry 
> > semaphore, then check whether d_fsdata is NULL, if it isn't then do the 
> > kobject_get(), then unlock the semaphore.
> > 
> 
> I have tried this with no luck. I still get 
> (Badness in kobject_get at lib/kobject.c:42) which means it is not correct fix.

Did you remember to set dentry->d_fsdata to NULL?  This has to be done in
sysfs_remove_dir() sometime during the period when dentry->d_inode->i_sem
is held.  Right now the pointer to the kobject never gets erased.  That 
Badness message is an indication that you are using a valid pointer to a 
kobject whose refcount is 0.

Alan Stern

