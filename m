Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbTE2Q2K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbTE2Q2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:28:10 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:21547 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S262165AbTE2Q2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:28:09 -0400
Date: Thu, 29 May 2003 12:38:31 -0400
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
Subject: Re: ppp problems in 2.5.69-bk14 - devfs related?
In-reply-to: <20030528214047.GE14138@parcelfarce.linux.theplanet.co.uk>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Kernel List <linux-kernel@vger.kernel.org>
Reply-to: Matthew Harrell 
	  <mharrell-dated-1054658315.8d343f@bittwiddlers.com>
Message-id: <20030529163831.GA13769@bittwiddlers.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.4i
X-Delivery-Agent: TMDA/0.75 (Ponder)
X-Primary-Address: mharrell@bittwiddlers.com
References: <Pine.LNX.4.44.0305211051100.22168-100000@bad-sports.com>
 <20030528125503.GA2745@bittwiddlers.com>
 <20030528212708.GA11432@bittwiddlers.com>
 <20030528214047.GE14138@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, this does stop the oops but it also prevents ppp from working.  I now get
this when I execute pppd

  pppd: This system lacks kernel support for PPP.  This could be because
  the PPP kernel module could not be loaded, or because PPP was not
  included in the kernel configuration.  If PPP was included as a
  module, try `/sbin/modprobe -v ppp'.  If that fails, check that
  ppp.o exists in /lib/modules/`uname -r`/net.
  See README.linux file in the ppp distribution for more details.

and the kernel logs show this

  CSLIP: code copyright 1989 Regents of the University of California
  PPP generic driver version 2.4.2
  devfs_mk_cdev: could not append to parent for ppp


: Fsck knows why devfs_mk_cdev() fails, but what follows that is obvious -
: int __init ppp_init(void)
: {
:         int err;
: 
:         printk(KERN_INFO "PPP generic driver version " PPP_VERSION "\n");
:         err = register_chrdev(PPP_MAJOR, "ppp", &ppp_device_fops);
:         if (!err) {
:                 err = devfs_mk_cdev(MKDEV(PPP_MAJOR, 0),
:                                 S_IFCHR|S_IRUSR|S_IWUSR, "ppp");
:         }
: 
:         if (err)
:                 printk(KERN_ERR "failed to register PPP device (%d)\n", err);
:         return err;
: }
: clearly leaves device registered after failed insmod.  open() afterwards
: happily finds the device and dies on attempt to do anything with it
: (the module is not there, pointers go to hell knows where).

-- 
  Matthew Harrell                          Life is like a diaper -
  Bit Twiddlers, Inc.                       short and loaded.
  mharrell@bittwiddlers.com     
