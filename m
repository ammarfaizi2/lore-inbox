Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSH0Mgn>; Tue, 27 Aug 2002 08:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSH0Mgn>; Tue, 27 Aug 2002 08:36:43 -0400
Received: from h-64-105-35-65.SNVACAID.covad.net ([64.105.35.65]:38303 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315758AbSH0Mgm>; Tue, 27 Aug 2002 08:36:42 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 27 Aug 2002 05:40:52 -0700
Message-Id: <200208271240.FAA04753@adam.yggdrasil.com>
To: kernel@bonin.ca
Subject: Re: Loop devices under NTFS
Cc: aia21@cantab.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:48 27/08/02, Andre Bonin wrote:
>"mount -o loop -r -t iso9660 /mnt/win_d/Source/Iso/Red\ Hat\ 
>7.3/valhalla-i386-disc1.iso /mnt/rh7.3/cd1"
>
>It gives me an error
>"ioctl: LOOP_SET_FD: Invalid argument"

	I believe that NTFS does not provide
address_space_operations->{prepare,commit}_write for plain files, so
the version of loop.c in stock 2.5.31 will not work.

	I posted an update for loop.c that I posted on August 15th:
( http://marc.theaimsgroup.com/?l=linux-kernel&m=102941520919910&w=2 ).
That update included a hack (originally conceived by Andrew Morton and
originally implemented Jari Ruusu) to use file_operations->{read,write}
for mounting files on file systems that do not provide
{prepare,commit}_write, although this involves an extra data copy if
a transformation (such as encryption) is selected.

	I submitted the loop.c update to Linus at least a week ago, but
I have not seen it appear in
ftp://ftp.kernel.org/pub/linux/kernel/people/dwmw2/bk-2.5.

Side note:

	There are only a few file systems that provide writable files
without aops->{prepare,commit}_write.  I think they are just tmpfs,
ntfs and intermezzo.  If all file systems that provided writable files
could be expected to provide {prepare,commit}_write, I could eliminate
the file_ops->{read,write} code from loop.c.  I wish I understood if
there really is a need for a file system to be able to provide a
writable random access file (as opposed to /dev/tty) that does not
have aops->{prepare,commit}_write.  I would be interesting in knowing
if there is anything preventing implementation of
{prepare,commit}_wriet in ntfs.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


	

