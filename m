Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbTE1V1e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 17:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTE1V1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 17:27:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21135 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261166AbTE1V1d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 17:27:33 -0400
Date: Wed, 28 May 2003 22:40:47 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Matthew Harrell 
	<mharrell-dated-1054589229.f149f8@bittwiddlers.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ppp problems in 2.5.69-bk14 - devfs related?
Message-ID: <20030528214047.GE14138@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0305211051100.22168-100000@bad-sports.com> <20030528125503.GA2745@bittwiddlers.com> <20030528212708.GA11432@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030528212708.GA11432@bittwiddlers.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 05:27:08PM -0400, Matthew Harrell wrote:
> 
> My oops output is just marginally different under 2.5.70-bk2.
> Unfortunately, I don't seem to have a /proc/ksyms so I don't know what
> to point ksymoops to.  I can make this one happen over and over by
> just running pppd.  It does not kill the system but it does make it
> rather unuseable.

Fsck knows why devfs_mk_cdev() fails, but what follows that is obvious -
int __init ppp_init(void)
{
        int err;

        printk(KERN_INFO "PPP generic driver version " PPP_VERSION "\n");
        err = register_chrdev(PPP_MAJOR, "ppp", &ppp_device_fops);
        if (!err) {
                err = devfs_mk_cdev(MKDEV(PPP_MAJOR, 0),
                                S_IFCHR|S_IRUSR|S_IWUSR, "ppp");
        }

        if (err)
                printk(KERN_ERR "failed to register PPP device (%d)\n", err);
        return err;
}
clearly leaves device registered after failed insmod.  open() afterwards
happily finds the device and dies on attempt to do anything with it
(the module is not there, pointers go to hell knows where).

I'd suggest to change that to
	err = devfs_mk_cdev(...)
	if (!err) {
		err = register_chrdev(...)
		if (!err)
			return 0;
		devfs_remove(...)
	}
	printk(...)
	return err;

That will _not_ solve the devfs problem, whatever it is, but it will make sure
that any errors are handled correctly.
	
