Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWESULo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWESULo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 16:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWESULo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 16:11:44 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:34189 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S964800AbWESULn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 16:11:43 -0400
Date: Fri, 19 May 2006 14:11:42 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: linux-scsi@vger.kernel.org, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: dev_printk output
Message-ID: <20060519201142.GB2826@parisc-linux.org>
References: <20060511150015.GJ12272@parisc-linux.org> <20060512170854.GA11215@us.ibm.com> <20060513050059.GR12272@parisc-linux.org> <20060518183652.GM1604@parisc-linux.org> <20060518200957.GA29200@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518200957.GA29200@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2006 at 01:09:57PM -0700, Patrick Mansfield wrote:
> Funky how loading sd after sg changes the output ... and using the driver
> name as a prefix sometimes messes this up for scsi.
> 
> i.e. scan without sd_mod or sg loaded (and distro I'm using loads sg
> before sd_mod via udev rules):
> 
>  0:0:0:0: Attached scsi generic sg0 type 0
>  0:0:0:1: Attached scsi generic sg1 type 0
> 
> Then remove/add those devices, and sg lines become:
> 
> sd 1:0:0:0: Attached scsi generic sg0 type 0
> sd 1:0:0:1: Attached scsi generic sg1 type 0

I find that a bit confusing too.  Obviously, we should distinguish
different kinds of bus_id from each other somehow -- but isn't the
obvious thing to use the bus name?  That must already be unique as sysfs
relies on it.  ie this patch:

(seems that dev->bus isn't always set; I got a null ptr dereference when
booting without that check).

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

Index: include/linux/device.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/device.h,v
retrieving revision 1.25
diff -u -p -r1.25 device.h
--- include/linux/device.h	13 May 2006 04:12:30 -0000	1.25
+++ include/linux/device.h	19 May 2006 19:54:04 -0000
@@ -412,7 +412,7 @@ extern void firmware_unregister(struct s
 
 /* debugging and troubleshooting/diagnostic helpers. */
 #define dev_printk(level, dev, format, arg...)	\
-	printk(level "%s %s: " format , (dev)->driver ? (dev)->driver->name : "" , (dev)->bus_id , ## arg)
+	printk(level "%s %s: " format , (dev)->bus ? (dev)->bus->name : "", (dev)->bus_id , ## arg)
 
 #ifdef DEBUG
 #define dev_dbg(dev, format, arg...)		\
