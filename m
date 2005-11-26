Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422641AbVKZGnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422641AbVKZGnM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 01:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbVKZGnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 01:43:12 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:3852 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1422641AbVKZGnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 01:43:12 -0500
Date: Sat, 26 Nov 2005 07:43:07 +0100
From: Willy Tarreau <willy@w.ods.org>
To: jerome lacoste <jerome.lacoste@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: defective RAM: corrupted ext3 FS. How to identify corrupted files/directories?
Message-ID: <20051126064306.GJ11266@alpha.home.local>
References: <5a2cf1f60511250234p3f00351ah956cb3615e0c1dbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a2cf1f60511250234p3f00351ah956cb3615e0c1dbe@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2005 at 11:34:06AM +0100, jerome lacoste wrote:
> Hi.
> 
> My RAM died, and it corrupted my file system. It seems like this
> machine just wants to die... [1]
> 
> After removing the faulty RAM, I can boot. I made extensive memtest86+ tests.
> I now have my home partition mounted as read-only because of said corruption.
>
> I see a bunch of "ext3_readdir: directory xxxx contains a hole at
> offset xxxxx"  when I try to access some parts of my disk.
> 
> I postponed fscking the FS until I have identified the faulty data.

You had the right reflex. Never ever consider your data bad as long as
you have not recovered them. Hard disks are always cheaper than the
time to rebuild all the lost work so keep the disk under safe conditions.

> I was thinking of doing a rsync --dry-run against a known working
> backup and check the logs. Any better idea? Is there a way to convert
> the directory IDs into file paths?

For this, I've already used a tool that a friend of mine developped
for our distro. It performs file-system signatures (including permissions,
size, date, file names, links and MD5 sums) and can check them with
the ability to ignore differences on some fields (eg: date, size,
perms, ...). It's called 'flx' [1].

The way to proceed is to do a fill sig of your FS to a text file, then
another sig of your backup to another file. For this, you'll have to
restore your old backup somewhere. It's important to put the sigs to
files because you'll be able to edit them to rename the corrupted dirs
once you find the names :

# flx sign bad_fs/. > bad_fs.sig
# flx sign old_fs/. > old_fs.sig

Then you can compare them to find new entries (some of which will be the
corrupted ones) :

# flx check --only-new --ignore-dot --ignore-ldate \
   file:old_fs.sig file:bad_fs.sig > diff-sig-1

Check this file and identify the corrupted directory names. Then look at
their contents in bad_fs.sig, and find the same content in old_fs.sig.
This way, you'll know their name and will be able to s/bad_name/name/
in bad_fs.sig, and iterate the process again. (Hint: note somewhere
the association between <bad_name> and <name>).

Once you have found all your directories names, you can check the
contents. Hint : ignore the date changes because you will know that
they will be new files, or files with recent changes. What you're
interested in are the files with different MD5 while other fields
are the sames (because then only content will have changed) :

# flx check --ignore-date --ignore-ldate --ignore-... file:bad_fs.sig file:old_fs.sig

Manually check those files and remove the destroyed ones from the list.
Then, redo the check ignoring MD5 signatures this time, just to find
files that have 'normally' changed since your backup because you've
worked on them.

At the end of this long process, you should be able to identify the
files and directories you want to keep from your corrupted disk, and
copy them over the backup disk to get a nearly complete restore.

> I have around 500 000 files on that partition. It takes time checking them all.

Of course, that's why using a text file signature considerably helps !
Hint: after the restore, you can regularly sign your FS and you'll be
able to check what change from last backup simply by diffing the sig
files before the crash.

Good luck,
Willy

[1] I've put it online here : http://w.ods.org/flx/flx-0.7.1.tar.gz

> Cheers,
> 
> Jerome
> 
> [1] http://lkml.org/lkml/2005/2/4/51
> -
