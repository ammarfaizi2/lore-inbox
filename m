Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264220AbTIIQjG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 12:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264222AbTIIQjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 12:39:05 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:64897
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264220AbTIIQjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 12:39:03 -0400
Date: Tue, 9 Sep 2003 12:38:51 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Greg KH <greg@kroah.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       John Levon <levon@movementarian.org>
Subject: Re: [PATCH][2.6][CFT] rmmod floppy kills box fixes + default_device_remove
In-Reply-To: <Pine.LNX.4.53.0309090739270.14426@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.53.0309091142550.14426@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0309072228470.14426@montezuma.fsmlabs.com>
 <20030908155048.GA10879@kroah.com> <Pine.LNX.4.53.0309081722270.14426@montezuma.fsmlabs.com>
 <20030908230852.GA3320@kroah.com> <Pine.LNX.4.53.0309090739270.14426@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Sep 2003, Zwane Mwaikambo wrote:

> > So an empty release() function is the wrong thing to do in 99.99% of the
> > situations in the kernel (the one exception seems to be the mca release
> > function that recently got added for use when the bus is doing probing
> > logic.)
> > 
> > Does this help out?
> 
> Yes thanks, i was confused over which memory references had to be 
> maintained.

Ok i had another look and i can see why you need a seperate release 
function, as we don't always do the kobject_cleanup immediately.

John and myself had a look and now we have the following race on 
->release() function exit.

my_release_fn()
{
	complete(&my_completion);
	<== [1] stall anywhere here, e.g. preempt/schedule
}

cleanup_module()
{
	wait_for_completion(&my_completion);
	<== [1] this task gets scheduled, free()s module text
}
