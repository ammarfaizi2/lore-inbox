Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319112AbSHMTzs>; Tue, 13 Aug 2002 15:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319128AbSHMTzs>; Tue, 13 Aug 2002 15:55:48 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:33041 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319112AbSHMTzr>;
	Tue, 13 Aug 2002 15:55:47 -0400
Date: Tue, 13 Aug 2002 12:55:40 -0700
From: Greg KH <greg@kroah.com>
To: Scott Murray <scottm@somanetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pcihpfs problems in 2.4.19
Message-ID: <20020813195539.GA22408@kroah.com>
References: <Pine.LNX.4.33.0208091547280.32159-100000@rancor.yyz.somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0208091547280.32159-100000@rancor.yyz.somanetworks.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 16 Jul 2002 18:49:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 04:18:02PM -0400, Scott Murray wrote:
> I just started testing the cPCI hotplug driver I'm working on against
> 2.4.19 after upgrading the kernel in SOMA's in-house distribution,
> and I'm now getting the attached oops code when trying to access the
> pcihpfs (e.g. with ls) after mounting it.  I backed out the couple of
> changes I made last night that might have been remotely connected
> (added hardware_test and get_power_status hotplug ops in my driver),
> and I'm still getting it in the same place, so it looks like maybe a
> VFS change somewhere in 2.4.19 broke pcihpfs.  Any ideas?

Ah, looks like a change with readdir.c in 2.4.19-pre2 caused this
problem.  Please try the attached patch, it fixes the problem for me.

Thanks to Dan Stekloff for helping in finding this fix.

thanks,

greg k-h


diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Tue Aug 13 12:57:16 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Tue Aug 13 12:57:16 2002
@@ -76,7 +76,6 @@
 };
 
 static struct super_operations pcihpfs_ops;
-static struct file_operations pcihpfs_dir_operations;
 static struct file_operations default_file_operations;
 static struct inode_operations pcihpfs_dir_inode_operations;
 static struct vfsmount *pcihpfs_mount;	/* one of the mounts of our fs for reference counting */
@@ -122,7 +121,7 @@
 			break;
 		case S_IFDIR:
 			inode->i_op = &pcihpfs_dir_inode_operations;
-			inode->i_fop = &pcihpfs_dir_operations;
+			inode->i_fop = &dcache_dir_ops;
 			break;
 		}
 	}
@@ -234,11 +233,6 @@
 
 	return 0;
 }
-
-static struct file_operations pcihpfs_dir_operations = {
-	read:		generic_read_dir,
-	readdir:	dcache_readdir,
-};
 
 static struct file_operations default_file_operations = {
 	read:		default_read_file,
