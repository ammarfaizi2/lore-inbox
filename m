Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTIYSog (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTIYSoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:44:16 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:27820 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261754AbTIYSnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:43:07 -0400
Subject: Re: [PATCH} fix defect with kobject memory leaks during del_gendisk
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0309251023220.947-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0309251023220.947-100000@localhost.localdomain>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1064515384.4763.28.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 25 Sep 2003 11:43:04 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-25 at 10:26, Patrick Mochel wrote:
> > Attached is a patch which fixes a few memory leaks in 2.6.0-test5. 
> > Comments are welcome as to whether or not this patch is the right
> > solution.
> > 
> > I added the ability to linux MD to generate add and remove hotplug calls
> > on RAID START and STOPs.  To achieve this, I use the del_gendisk call
> > which deletes the gendisk, delete the children kobjects, and delete the
> > parent (in this case, mdX) kobject.
> > 
> > Unfortunately it appears that del_gendisk uses kobject_del to delete the
> > kobject.  If the kobject has a ktype release function, it is not called
> > in the kobject_del call path, but only in kobject_unregister.
> > 
> > This patch changes the functionality so the release function (in this
> > case the block device release function in drivers/block/genhd.c) is
> > called by changing the kobject_del to kobject_unregister.
> 
> It is not the right thing to do, as Christoph pointed out. Gendisks have a 
> lifetime longer than the time between add_disk() and del_gendisk(). They 
> are created before they are added, and the objects may persist longer 
> after they have been removed from view. 
> 
> To delete the last reference, the MD layer should be calling put_disk(), 
> which will trigger release to happen. 
> 
> Your patch will actually cause other bugs, since the final put_disk() of 
> other block drivers will now be called on already freed memory.
> 
> 
> 	Pat
> 
> 
Thanks good call..  Didn't see the put_disk call but it makes sense now.

-steve

