Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281179AbRKHA3O>; Wed, 7 Nov 2001 19:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281181AbRKHA3F>; Wed, 7 Nov 2001 19:29:05 -0500
Received: from smtp2.libero.it ([193.70.192.52]:46732 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S281179AbRKHA2u>;
	Wed, 7 Nov 2001 19:28:50 -0500
Date: Thu, 8 Nov 2001 01:20:51 +0100
From: antirez <antirez@invece.org>
To: "Brenneke, Matthew Jeffrey (UMR-Student)" <mbrennek@umr.edu>
Cc: "'H. Peter Anvin'" <hpa@zytor.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Yet another design for /proc. Or actually /kernel.
Message-ID: <20011108012051.C568@blu>
Reply-To: antirez <antirez@invece.org>
In-Reply-To: <6CAC36C3427CEB45A4A6DF0FBDABA56D59C91D@umr-mail03.cc.umr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <6CAC36C3427CEB45A4A6DF0FBDABA56D59C91D@umr-mail03.cc.umr.edu>; from mbrennek@umr.edu on Wed, Nov 07, 2001 at 03:13:25PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 03:13:25PM -0600, Brenneke, Matthew Jeffrey (UMR-Student) wrote:
> /dev/hda1 /home/mbrennek/stuff\040and vfat rw 0 0
[snip]
> 
> Are you refering to the 040?

This works but, if /proc will really be replaced, another
idea can be to organize the stuff to get something of more
coherent than:

value1a value1b value1c
value2a value2b value2c

that's more human readable than machine parsable.
Something that can fix both the problems (quoting and format) is
the following:

put every string inside () and only quotes ( and ) with \
and quotes \ itself with \\, than use brackets to delimit
string _and_  provide information about the format:

((dev/hda1)(/home/mbrennek/stuff and)(vfat)(rw)(0)(0))
((/dev/hda2)(/var/tmp)(ext2)(rw)(0)(0))

and so on. With a simple parser you get a safe delimiter
for a single element and you know that there are two "objects"
of 6 elements.

An extension may be to use the first row to describe the
elements inside every object. After this the output of
/proc/mounts will be:

((device)(mountpoint)(type)(option)(dump)(fsck))
((dev/hda1)(/home/mbrennek/stuff and)(vfat)(rw)(0)(0))
((/dev/hda2)(/var/tmp)(ext2)(rw)(0)(0))

Good userspace software will never fail if you add more information.
If you need to change the format of something it's just possible
to add a new field and leave the old one for some time for backward
compatibility.

With some simple extension you can add comments or the ability
to redefine the fileds description for the next elements.
With the last improvments it looks like:

((type)(field0)(field1)...(fieldN))

/proc/mounts will be:

((rem)(mounted filesystems))
((format)(device)(mountpoint)(type)(option)(dump)(fsck))
((data)(dev/hda1)(/home/mbrennek/stuff and)(vfat)(rw)(0)(0))
((data)(/dev/hda2)(/var/tmp)(ext2)(rw)(0)(0))
((rem)(number of filesystems mounted))
((format)(mount_count))
((data)(2))

Last fix can be to surround all this with (), to detect
truncated outputs, since it seems that often the /proc outputs
can only use one page.

It looks a bit too complex, but actually it's very simple to
generate and parse. Expecially if someone release a "standard"
userspace library to parse it.

I'm sure all here already thought at something like it, and
probably there is a good reason to do it different, sorry if I
missed the point.

regards,
Salvatore
