Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbUBYPFk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 10:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbUBYPFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 10:05:40 -0500
Received: from ida.rowland.org ([192.131.102.52]:2308 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261349AbUBYPFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 10:05:39 -0500
Date: Wed, 25 Feb 2004 10:05:37 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Question about (or bug in?) the kobject implementation
Message-ID: <Pine.LNX.4.44L0.0402250955090.790-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it supposed to be legal to repeatedly call kobject_add() and 
kobject_del() for the same kobject?  That is, is

	kobject_add(&kobj);
	...
	kobject_del(&kobj);
	...
	kobject_add(&kobj);
	...
	kobject_del(&kobj);

supposed to work?  The API doesn't forbid it, and there's no apparent 
reason why it should be illegal.

I ask because the current implementation is set up in such a way that
doing this will mess up the reference counting for the kobject's parent.  
The problem is that the parent's refcount is increased each time
kobject_add() is called, but it is only decremented in kobject_cleanup(),
not in kobject_del().  Thus, the statements above will leave the parent's
refcount permanently increased by 1, potentially causing a memory leak.

Why would anyone want to do this, you ask?  Well the USB subsystem does it 
already.  Each USB device can have several configurations, only one of 
which is active at any time.  Corresponding to each configuration is a set 
of struct devices, and they (together with their embedded kobjects) are 
allocated and initialized when the USB device is first detected.  The 
struct devices are add()'ed and del()'ed as configurations are activated 
and deactivated, leading to just the sort of call sequence shown above.

Alan Stern

