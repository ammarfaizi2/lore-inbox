Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTIVVPW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 17:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263323AbTIVVPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 17:15:22 -0400
Received: from vena.lwn.net ([206.168.112.25]:49094 "HELO lwn.net")
	by vger.kernel.org with SMTP id S263319AbTIVVPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 17:15:14 -0400
Message-ID: <20030922211511.17009.qmail@lwn.net>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: Attributes in /sys/cdev 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Mon, 22 Sep 2003 22:00:21 BST."
             <20030922210021.GH7665@parcelfarce.linux.theplanet.co.uk> 
Date: Mon, 22 Sep 2003 15:15:11 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgive my insistence here...I'm trying to figure out what LDD3 is going to
say on this subject.  If we get it right, hopefully that will head off a
lot of questions in the future...

> > If I embed a struct cdev within my own
> > device structure, how do I know when I can safely free said device
> > structure?  Will there be a release method that gets exposed at the driver
> > level, or am I missing something obvious again?
> 
> Umm...  Any kobject has ->release() method, obviously.  

Actually, as I read it, each kobject has a kobj_type pointer, and in *that*
structure is a release() method.  I had found it...:)

The struct cdev which I, as a driver author, can embed within my own
structure has a kobject in it.  If it's an embedded cdev, its ktype pointer
will be aimed at ktype_cdev_default, which sets up cdev_default_release()
as its release function.

If I understand things correctly, as long as references to the embedded
struct cdev remain, I cannot free the driver-specific structure in which
the struct cdev is embedded.  So, somehow, I need to know when that struct
cdev's release() method is called.  I could do that by changing its ktype
field to my own special type, and remembering to call cdev_purge() in my
own release function.  Somehow, however, that doesn't feel like the right
approach.  It seems to me like we need a release() method in struct cdev
that is called from the struct cdev's own release() method - at least, in
the non-dynamic case.  No?  What am I missing here?

Thanks,

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
