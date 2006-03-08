Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWCHHyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWCHHyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 02:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWCHHyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 02:54:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:6539 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932439AbWCHHyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 02:54:12 -0500
Date: Tue, 7 Mar 2006 23:53:42 -0800
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
Subject: problem with duplicate sysfs directories and files
Message-ID: <20060308075342.GA17718@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I spent some time tonight trying to track down how to fix the issue of
duplicate sysfs files and/or directories.  This happens when you try to
create a kobject with the same name in the same directory.  The creation
of the second kobject will fail, but the directory will remain in sysfs.

Now I know this isn't a normal operation, but it would be good to fix
this eventually.  I traced the issue down to fs/sysfs/dir.c:create_dir()
and the check for:
	if (error && (error != -EEXIST)) {

Problem is, error is set to -EEXIST, so we don't clean up properly.  Now
I know we can't just not check for this, as if you do that error
cleanup, the original kobject's sysfs entry gets very messed up (ls -l
does not like it at all...)

But I can't seem to figure out what exactly we need to do to clean up
properly here.

Do you, or anyone else, have any pointers or ideas?

thanks,

greg k-h
