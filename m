Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264458AbTEPP2D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 11:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTEPP2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 11:28:03 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:19869 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264458AbTEPP2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 11:28:02 -0400
Message-Id: <200305161539.h4GFdLGi018236@locutus.cmf.nrl.navy.mil>
To: Duncan Sands <baldrick@wanadoo.fr>
cc: Greg KH <greg@kroah.com>, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev 
In-reply-to: Your message of "Fri, 16 May 2003 16:40:43 +0200."
             <200305161640.43804.baldrick@wanadoo.fr> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 16 May 2003 11:39:21 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200305161640.43804.baldrick@wanadoo.fr>,Duncan Sands writes:
>I was wondering about ioctl and proc calls.  Can the ATM layer call
>a driver's ioctl routine before opening a vcc?  If so, does it take a

yes

>reference to the module first (I didn't spot anything)?  Also, are

the original atm code used atm_dev_lock to keep the device from
disappearing during the ioctl.  atm_dev_lock was being used to protect
sections of code, like ioctl and atm device (de)registry.  the 2.5
code is getting changes that should improve matters.  atm_dev will
now have a reference count to keep a device from being unregistered
while someone holds a reference (ioctl or otherwise).

>calls to a driver's proc_read routine protected against module
>unloading races (I confess I didn't take the time to look into this,
>because my own driver does not sleep in proc_read)?

i believe proc has always been a troublesome child.  it has never
had any protection (via atm_dev_lock or otherwise).  you can sleep
in the proc function (since it would in user mode).  i have added some
locking to proc in the 2.5 that should make proc safer (but not very
elegant--perhaps elegance with come with the seq conversion).
