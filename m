Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUC0WZM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 17:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbUC0WZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 17:25:12 -0500
Received: from netrider.rowland.org ([192.131.102.5]:16648 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S261904AbUC0WZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 17:25:08 -0500
Date: Sat, 27 Mar 2004 17:25:07 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Maneesh Soni <maneesh@in.ibm.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: BUG: Problem with your patches for sysfs from 2 weeks ago
Message-ID: <Pine.LNX.4.44L0.0403271705250.32373-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh:

I've been tracing a problem with sysfs that starting showing up just
recently, and it seems likely to have originated with your patches from a
couple of weeks ago.  I can't tell exactly what's wrong or fix it because
I don't understand the filesystem layer well enough.

The problem I found (there may be others) shows up when trying to delete a 
nonexistent symlink -- presumably trying to delete a nonexistent file 
would have a similar result.  The code in sysfs_hash_and_remove() does a 
lookup on the nonexistent name and sysfs_get_dentry() returns a 
newly-allocated dentry.  Creating the new entry increments the parent 
directory's d_count, of course.  But at the end of the routine, when 
dput() is called for the new dentry, the parent's d_count does _not_ get 
decremented.  The new dentry is placed on the dentry_unused list and the 
parent is left with an anomalously large d_count.  This doesn't ever seem 
to get resolved, and when the directory's kobject is deleted the reference 
you added doesn't get dropped.

Alan Stern

