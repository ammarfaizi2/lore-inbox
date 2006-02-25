Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWBYLom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWBYLom (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 06:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWBYLom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 06:44:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17563 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030228AbWBYLol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 06:44:41 -0500
Date: Sat, 25 Feb 2006 03:43:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christian Neumair <chris@gnome-de.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using fsync() to synchronize a USB mass storage device failed
Message-Id: <20060225034348.497b9d37.akpm@osdl.org>
In-Reply-To: <1139589818.7769.10.camel@localhost.localdomain>
References: <1139589818.7769.10.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Neumair <chris@gnome-de.org> wrote:
>
> I've seen various postings on the lkml on the issue of fsync()ing block
> devices and the expected behavior. Some claim that fsync()ing the mount
> point of a block device will flush its buffers, a HOWTO I read claims
> that one has to apply it to the device node, because it is the
> representation of the block device.
> 
> The POSIX standard demands [1]:
> 
> "The fsync() function shall request that all data for the open file
> descriptor named by fildes is to be transferred to the storage device
> associated with the file described by fildes."
> 
> To my interpretation this means that all buffers of a mass storage
> device should be flushed when calling fsync() on its file
> representation, i.e. /dev/foo.
> 
> I've tried various Ubuntu-packaged kernel releases (2.6.12 and later),
> and none of it seems to actually assert that the data is written when
> using code like
> 
> int fd = open ("/dev/sdb1", O_RDONLY); /* I also tried O_WRONLY */
> 
> or
> 
> int fd = open ("/media/usbdisk", O_DIRECTORY | O_RDONLY);
> 
> and then doing
> 
> fsync (fd);
> close (fd);
> 
> Unfortunately, none of the code really blocked until the whole buffer
> was written, and a diode on the mass storage indicated that data was
> still being written to it after my testing application terminated, while
> for a simple sync() call (or "sync" program invocation) the whole
> process really blocked until the data was on disk, as proven by the
> non-flashing diode.
> 
> I haven't investigated the code in detail, but fs/buffer.c suggests that
> sync_inodes is invoked on sync() but not on fsync(), and the latter does
> not lookup the block device the file refers to, thus not ensuring that
> fsync_bdev() is called on it.
> 
> If you wonder why this is needed - over at GNOME we're having issues
> where USB sticks are unmounted and the users have no clue when it's
> ready to be removed [1]. We'd like to fsync() in a thread and tell the
> users that an unmount operation is going on and still needs some time.
> Because there may be multiple storage device attached, it isn't a good
> idea to sync() all devices, but just that one which is about to be
> ejected.
> 
> 
> [1] http://www.opengroup.org/onlinepubs/009695399/functions/fsync.html
> [2] http://bugzilla.gnome.org/show_bug.cgi?id=329098

It works for me.  Using
http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz:

sleep 10000 < /dev/hda5 &  # Keep bdev open - coz last close() syncs it

# This doesn't sync the device:
write-and-fsync -m 20 /dev/hda5 ; read-and-fsync -m 20 /dev/hda5

# This does:
write-and-fsync -m 20 /dev/hda5 ; read-and-fsync -f -m 20 /dev/hda5

It's a bit odd to do an fsync() on an O_RDONLY fd, but it does the fsync.
