Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276052AbRJ0TN5>; Sat, 27 Oct 2001 15:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276489AbRJ0TNs>; Sat, 27 Oct 2001 15:13:48 -0400
Received: from calais.pt.lu ([194.154.192.52]:58344 "EHLO calais.pt.lu")
	by vger.kernel.org with ESMTP id <S276052AbRJ0TNh>;
	Sat, 27 Oct 2001 15:13:37 -0400
Message-Id: <200110271913.f9RJDup01632@hitchhiker.org.lu>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Reply-To: alain@linux.lu
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Re: Poor floppy performance in kernel 2.4.10 
In-Reply-To: Your message of "Sat, 27 Oct 2001 13:42:32 EDT."
             <Pine.GSO.4.21.0110271320540.21545-100000@weyl.math.psu.edu> 
Date: Sat, 27 Oct 2001 21:13:56 +0200
From: Alain Knaff <Alain.Knaff@hitchhiker.org.lu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> All this begs of course the following question: what kind of
>> idnetifier does the buffer cache code actually use to refer to the
>> block device, if there is no longer a major?
>
>Right now - major:minor, in 2.5 - struct block_device *.

Actually, are you sure about that?

In filemap.c in do_generic_file_read, you have this:

	struct address_space *mapping = filp->f_dentry->d_inode->i_mapping;
	...
		/*
		 * Try to find the data in the page cache..
		 */
		hash = page_hash(mapping, index);

		spin_lock(&pagecache_lock);
		page = __find_page_nolock(mapping, index, *hash);

Looks as if pages are identified by (mapping, index) pairs, rather
than (major:minor, index) triplets.

And "mapping" itself seems to point to i_data of the device's inode
structure (not the device entry's inode, but the device's itself).

Which means that if the inode is put (all references to the block
device closed), and later the same major/minor is reopened, it may
very well be in a different place in memory... Meaning that the
formerly cached pages (if they are still there...) will no longer be
recognized as the same, as mapping is now a different address, even
though major/minor is the same.

The changing nature of mapping can be confirmed easily by inserting a
printk into the open routine of the device.

As long as at least one reference to the device is open, mapping stays
the same for further opens, but as soon as the last ref is closed, the
next open will return a different address...


For the following test, I've inserted the following debugging printk
in floppy_open:

	printk("Mapping=%x data=%x\n", inode->i_mapping, &inode->i_data);

As you see, while the sleep is open, Mapping is always
c25a7a90. However, once the sleep is closed, Mapping changes to
c1ba0cd0 . This seems to explain it things.

> sleep 3600 </dev/fd0 &
[1] 1449
Mapping=c25a7a90 data=cb80dc50
VFS: Disk change detected on device fd(2,0)
> mdir a:
Mapping=c25a7a90 data=cb80dc50
 Volume in drive A has no label
 Volume Serial Number is 63F7-FED8
Directory for A:/

No files
                          1 457 664 bytes free

> mdir a:
Mapping=c25a7a90 data=cb80dc50
 Volume in drive A has no label
 Volume Serial Number is 63F7-FED8
Directory for A:/

No files
                          1 457 664 bytes free
> kill %1
[1]  + 1449 terminated  sleep 3600 < /dev/fd0
> mdir a:
Mapping=c1ba0cd0 data=cb80dc50
 Volume in drive A has no label
 Volume Serial Number is 63F7-FED8
Directory for A:/

No files
                          1 457 664 bytes free



Regards,

Alain
