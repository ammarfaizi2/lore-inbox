Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbTFOQ2l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTFOQ2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:28:41 -0400
Received: from netrider.rowland.org ([192.131.102.5]:63750 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S262379AbTFOQ2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:28:36 -0400
Date: Sun, 15 Jun 2003 12:42:26 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Flaw in the driver-model implementation of attributes
Message-ID: <Pine.LNX.4.44L0.0306151221190.32270-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you're already aware of this, please forgive the intrusion.

There's a general problem in the driver model's implementation of 
attribute files, in connection with loadable kernel modules.  The 
sysfs_ops structure stores function pointers with no means for identifying 
the module that contains the corresponding code.  As a result, it's 
possible to call through one of these pointers even after the module has 
been unloaded, causing an oops.

It's not hard to provoke this sort of situation.  A user process can
open a sysfs device file, for instance, and delay trying to read it until 
the module containing the device driver has been removed.  When the read 
does occur, it runs into trouble.

I don't know enough about the innards of the system to be able to fix this
properly.  One possible approach works like this.  Modify fs/sysfs/file.c
to make fill_read_buffer() and flush_write_buffer() acquire some sort of
read lock on file->f_dentry before they set attr =
file->f_dentry->d_fsdata.  Modify sysfs_remove_file() to acquire a write
lock and have it set file->f_dentry->d_fsdata to NULL.  Then it will only
be necessary to avoid calling ops->show() or ops->store() if attr is NULL.  
This guarantees that no caller will execute the show() or store() methods
after syfs_remove_file() has returned, so a driver that cleans up after 
itself correctly will not be invoked after it has been unloaded.

Alan Stern

