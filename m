Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbUCKBpc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 20:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbUCKBoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 20:44:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:36013 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262949AbUCKBnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 20:43:50 -0500
Date: Wed, 10 Mar 2004 17:29:11 -0800
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Patch to hook up PPP to simple class sysfs support
Message-ID: <20040311012911.GA13045@kroah.com>
References: <200403032328.i23NSwlv009796@orion.dwf.com> <22370000.1078362205@w-hlinder.beaverton.ibm.com> <20040303195539.S22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303195539.S22989@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 07:55:39PM -0800, Chris Wright wrote:
> * Hanna Linder (hannal@us.ibm.com) wrote:
> > +		ppp_class = class_simple_create(THIS_MODULE, "ppp");
> > +		class_simple_device_add(ppp_class, MKDEV(PPP_MAJOR, 0), NULL, "ppp");
> 
> What happens if that class_simple_create() fails?  Actually,
> class_simple_device_add could fail too, but doesn't seem anybody is
> checking for that.
> 
> >  		err = devfs_mk_cdev(MKDEV(PPP_MAJOR, 0),
> >  				S_IFCHR|S_IRUSR|S_IWUSR, "ppp");
> > -		if (err)
> > +		if (err) {
> >  			unregister_chrdev(PPP_MAJOR, "ppp");
> > +			class_simple_device_remove(MKDEV(PPP_MAJOR,0));
> > +		}
> 
> need to destroy the class on error path to avoid leak.
> 
> > @@ -2540,6 +2547,7 @@ static void __exit ppp_cleanup(void)
> >  	if (unregister_chrdev(PPP_MAJOR, "ppp") != 0)
> >  		printk(KERN_ERR "PPP: failed to unregister PPP device\n");
> >  	devfs_remove("ppp");
> > +	class_simple_device_remove(MKDEV(PPP_MAJOR, 0));
> 
> ditto.  this will leak and would cause oops on reload of module.
> 
> something like below.

Applied, thanks.

greg k-h
