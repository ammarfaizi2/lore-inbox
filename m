Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316127AbSETQnf>; Mon, 20 May 2002 12:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316130AbSETQne>; Mon, 20 May 2002 12:43:34 -0400
Received: from air-2.osdl.org ([65.201.151.6]:33423 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316127AbSETQnc>;
	Mon, 20 May 2002 12:43:32 -0400
Date: Mon, 20 May 2002 09:39:27 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
cc: <linux-kernel@vger.kernel.org>, Arnd Bergmann <arndb@de.ibm.com>
Subject: Re: driverfs problem
In-Reply-To: <200205171408.g4HE8tK65272@d12relay02.de.ibm.com>
Message-ID: <Pine.LNX.4.33.0205200750490.820-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi. Sorry about the delay in responding..

> - If I register 'struct device's for my devices and unregister them at 
> module unload time with put_device, the memory for the d_entries
> is never freed because the refcount is still '3' (or '7' for directories) at 
> the beginning of  'driverfs_unlink()'. Consequently, 
> 'driverfs_d_delete_file()' never gets called at all. So far, I could not
> find the place where the refcount is incremented and not decremented
> again. Any idea?

This is interesting. It appears that I need to do an extra dput() when 
removing files to push the refcount to 0. This counters the lookup_hash() 
that is done when creating the files and directories, and is analogous to 
the path_release() call in sys_unlink() and sys_rmdir(). Please try the 
attached patch, and let me know if it fixes the problem.

Note: I _think_ this is right. Can anyone confirm or deny this? 

> - When using many devices, a lot of memory seems to be wasted by 
> identical files. When I simulated 65536 devices, which would be the
> architectural limit of the channel subsystem, my ~200MB free mem were 
> immediately filled and the out of memory handler started killing my
> user space programs. More investigation showed that each dummy devices
> needs between 3 and 4 kb on a 31 bit s390 system. That is probably not too 
> much if you assume that people who can afford thousands of devices typically 
> also have much RAM, but I could imagine that there is still room for improval.

Yes, that was the assumption. However, there is much room for improvement. 
We shouldn't require that much memory.

> Would it be feasable to allocate the dentries for standard files 
> (name/power/status plus the ones provided by architecture and bus driver) 
> only when the parent directory is accessed?

Theoretically, I believe that's possible. Al Viro has also spoken of a 
per-device filesystem, which could help in that area. Althoygh, I have not 
pursued either option. Though I hate to say it, there is other progress to 
be made before I have a chance to seriously investigate these options.

> - I'm not sure about how to name the device directories. I don't have anything
> like a hierarchical structure (except for something like scsi devices behind
> a channel device) but rather a flat list of up to 65536 devices that are 
> accessed by a device number that was defined by the system administrator. 
> Each device also has a control unit type, comparable to a PCI ID, and in the 
> general case each device driver knows about one control unit type. A 
> hypothetical system might have
> - one console, control unit type 0x3215, device number 0x0000
> - three network devices, control unit type  0x1732, devno 0x0100 to 0x0102
> - 1024 storage devices, control unit type 0x3390, devno 0x1000 to 0x13ff

The control unit types are irrelevant at this point, as they dictate the 
type of device. You want to accurately represent the physical layout of 
the system. 

I honestly don't know how the controllers look on the s390, so I will go 
off what I do know about x86 PCI SCSI contollers. You typically have a 
hierarchy like:

.
`-- controller
    |-- chan0
    |   |-- 0
    |   |-- 1
    |   |-- 2
    |   `-- 3
	...
    `-- chan1
        |-- 0
        |-- 1
        |-- 2
        `-- 3
	...

right? (Note: naming is fictional here) I would think the layout would 
similar, but that's only a guess. How many devices can be on a channel? 
Does splitting them up like this help with the large directories?

Thanks,

	-pat

===== fs/driverfs/inode.c 1.18 vs edited =====
--- 1.18/fs/driverfs/inode.c	Tue Mar 12 14:22:16 2002
+++ edited/fs/driverfs/inode.c	Mon May 20 09:25:48 2002
@@ -592,6 +592,7 @@
 		if (!strcmp(entry->name,name)) {
 			list_del_init(node);
 			vfs_unlink(entry->dentry->d_parent->d_inode,entry->dentry);
+			dput(entry->dentry);
 			put_mount();
 			break;
 		}
@@ -616,7 +617,6 @@
 	if (!dentry)
 		goto done;
 
-	dget(dentry);
 	down(&dentry->d_parent->d_inode->i_sem);
 	down(&dentry->d_inode->i_sem);
 
@@ -627,6 +627,7 @@
 
 		list_del_init(node);
 		vfs_unlink(dentry->d_inode,entry->dentry);
+		dput(entry->dentry);
 		put_mount();
 		node = dir->files.next;
 	}

