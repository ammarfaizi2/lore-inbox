Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292062AbSBAVUF>; Fri, 1 Feb 2002 16:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292063AbSBAVT5>; Fri, 1 Feb 2002 16:19:57 -0500
Received: from cadre5.com ([216.122.85.20]:19684 "EHLO cadre5.com")
	by vger.kernel.org with ESMTP id <S292062AbSBAVTo>;
	Fri, 1 Feb 2002 16:19:44 -0500
Message-ID: <00fb01c1ab66$2fbc5490$6400a8c0@africa.cadre5.com>
From: "Andrew Tipton" <andrew@cadre5.com>
To: <linux-kernel@vger.kernel.org>
Subject: Tmpfs and loop device don't get along
Date: Fri, 1 Feb 2002 16:19:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I have an image (initrd.img for example) located on a tmpfs filesystem,
when I attempt to mount it:

% mount -o loop /initrd.img /mnt
ioctl: LOOP_SET_FD: Invalid argument

After deciding that it was not due to lack of loop devices (/dev/loop0..7),
an unreadable file, and other common userspace causes,  I dug through the
kernel sources.   When calling LOOP_SET_FD, the single argument is the
filedescriptor of the file (/initrd.img).  The loop_set_fd function (in
drivers/block/loop.c) first gets the inode entry for the file, and then the
address_space_operations struct for that inode.  If there is no readpage
function in that struct, loop_set_fd fails with EINVAL.  The reason for this
check is "if we can't read - sorry" -- apparently testing to see if it's
possible to read from the file/filesystem?

In the tmpfs source (mm/shmem.c), the address_space_operations struct for
this filesystem is defined.  The struct (shmem_aops) is defined statically,
and the only member is writepage.  readpage is missing, causing a guaranteed
failure in loop_set_fd.

Something smells wrong here (why does loop_set_fd care about
address_space_operations, and not file_operations?  it only needs access to
the file....), but I don't know enough about the internal workings of the
page cache/vfs/etc to do much about it.

What is the best way to fix this short-term?  I could bypass the readpage
check in loop_set_fd, or I could add a dummy readpage entry to the
address_space_operations struct for tmpfs.  Would either of these have
serious repercussions?

I'm not subscribed to the linux-kernel mailing list, so I would appreciate
it if you could CC all replies to me as well.

Thanks,
Andrew Tipton
Cadre5, LLC


