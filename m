Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSH0MmT>; Tue, 27 Aug 2002 08:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSH0MmT>; Tue, 27 Aug 2002 08:42:19 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:59582 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315779AbSH0MmS>; Tue, 27 Aug 2002 08:42:18 -0400
Date: Tue, 27 Aug 2002 13:46:35 +0100 (BST)
From: Anton Altaparmakov <aia21@cantab.net>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: kernel@bonin.ca, linux-kernel@vger.kernel.org
Subject: Re: Loop devices under NTFS
In-Reply-To: <200208271240.FAA04753@adam.yggdrasil.com>
Message-ID: <Pine.SOL.3.96.1020827134148.4013A-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2002, Adam J. Richter wrote:
> At 05:48 27/08/02, Andre Bonin wrote:
> >"mount -o loop -r -t iso9660 /mnt/win_d/Source/Iso/Red\ Hat\ 
> >7.3/valhalla-i386-disc1.iso /mnt/rh7.3/cd1"
> >
> >It gives me an error
> >"ioctl: LOOP_SET_FD: Invalid argument"
> 
> 	I believe that NTFS does not provide
> address_space_operations->{prepare,commit}_write for plain files, so
> the version of loop.c in stock 2.5.31 will not work.

He is mounting read-only which does not require prepare,commit_write and
it works fine. I have done it myself. Both in 2.4 and 2.5.

Further the NTFS updates I posted a few days ago actually implement
prepare,commit write so they make loop work completely.

> 	I posted an update for loop.c that I posted on August 15th:
> ( http://marc.theaimsgroup.com/?l=linux-kernel&m=102941520919910&w=2 ).
> That update included a hack (originally conceived by Andrew Morton and
> originally implemented Jari Ruusu) to use file_operations->{read,write}
> for mounting files on file systems that do not provide
> {prepare,commit}_write, although this involves an extra data copy if
> a transformation (such as encryption) is selected.
> 
> 	I submitted the loop.c update to Linus at least a week ago, but
> I have not seen it appear in
> ftp://ftp.kernel.org/pub/linux/kernel/people/dwmw2/bk-2.5.
> 
> Side note:
> 
> 	There are only a few file systems that provide writable files
> without aops->{prepare,commit}_write.  I think they are just tmpfs,
> ntfs and intermezzo.  If all file systems that provided writable files

NTFS doesn't provide write access at all. My posted updates implement
write in the new driver and they do it using prepare,commit write.

> could be expected to provide {prepare,commit}_write, I could eliminate
> the file_ops->{read,write} code from loop.c.  I wish I understood if
> there really is a need for a file system to be able to provide a
> writable random access file (as opposed to /dev/tty) that does not
> have aops->{prepare,commit}_write.  I would be interesting in knowing
> if there is anything preventing implementation of
> {prepare,commit}_wriet in ntfs.

No, and it is in fact implemented already. As soon as Linus pulls from my
bk repository (http://linux-ntfs.bkbits.net/ntfs-2.5) the stock kernel
will have prepare,commit write in ntfs.

For the old ntfs driver still present in 2.4.x, there are no address space
operations at all, the page cache is in fact not used at all, so that
prevents the loop driver from working at all...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

