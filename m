Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbULJPdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbULJPdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 10:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbULJPdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 10:33:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:64989 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261734AbULJPdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 10:33:11 -0500
Date: Fri, 10 Dec 2004 07:27:28 -0800
From: Greg KH <greg@kroah.com>
To: Josh Boyer <jdub@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [RFC PATCH] convert uhci-hcd to use debugfs
Message-ID: <20041210152728.GA5827@kroah.com>
References: <20041210005055.GA17822@kroah.com> <20041210005514.GB17822@kroah.com> <1102688117.26320.7.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102688117.26320.7.camel@weaponx.rchland.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 08:15:18AM -0600, Josh Boyer wrote:
> On Thu, 2004-12-09 at 18:55, Greg KH wrote:
> >  static int uhci_proc_open(struct inode *inode, struct file *file)
> >  {
> 
> Didn't want to rename this uhci_debug_open?

Yeah, I could :)

> > -#ifdef CONFIG_PROC_FS
> > -	ent = create_proc_entry(hcd->self.bus_name, S_IFREG|S_IRUGO|S_IWUSR, uhci_proc_root);
> > -	if (!ent) {
> > -		dev_err(uhci_dev(uhci), "couldn't create uhci proc entry\n");
> > +	dentry = debugfs_create_file(hcd->self.bus_name, S_IFREG|S_IRUGO|S_IWUSR, uhci_debugfs_root, uhci, &uhci_proc_operations);
> > +	if (!dentry) {
> 
> That won't work if debugfs is not configured.  You'll get back (void *)
> -ENODEV, which is not NULL.

That's exactly correct.  We do _not_ want NULL to be returned if debugfs
is not configured in.  We want to be able to detect if an error
happened, not if the feature was just not configured.  Otherwise, if we
did return NULL if debugfs was not enabled, this code would just fail
and the uhci startup would never happen.

This is why people have to wrap proc functions in #ifdef, and why no one
ever checks the return values from devfs calls.  It's a real problem and
I don't want to duplicate that again.

thanks,

greg k-h
