Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUDEKax (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 06:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbUDEKax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 06:30:53 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:4769 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S261756AbUDEKaX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 06:30:23 -0400
Date: Mon, 5 Apr 2004 12:30:08 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: James Vega <vega_james@lycos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fat32 all upper-case filename problem
Message-ID: <20040405103008.GB12373@localhost>
References: <4070910E.7020808@lycos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4070910E.7020808@lycos.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday April 4th 2004 James Vega wrote:

> I've run across an interesting problem with creating all upper-case 
> files/direcotries on fat32 partitions.  After creating a file in all 
> upper-case, I can access it for a short time using either the all 
> upper-case name or the all lower-case name.  After a short amount of time 
> (or a umount/mount), I can only access the file via the all lower-case 
> name.  I'm currently using kernel 2.6.4, but I've been seeing this since at 
> least November of last year.
> 
> Example:
 
You forgot a 'ls /usbdrive' *before* the 'touch'. Now we don't know
whether it was empty before. We'll assume so.

> debil% touch /usbdrive/CASE
> debil% ls /usbdrive
> case

This suggests that you've mounted your usbdrive (vfat probably?)
_specifically_ with the option to force lowercase filenames. The default
is to preserve the case of the filename (to the filename *should* be CASE here)
and to see both names as equals.

Another possibility is that there *was* already a file called 'case' and
that the actual writing of the 'CASE' file in the directory is postponed
until some sort of 'sync' operation. This also would need a
specific 'case-sensitive' mount option.

> debil% ls /usbdrive/CASE
> /usbdrive/CASE
> debil% ls /usbdrive/case
> /usbdrive/case

The above normally can only happen if there really are *two* files, one
name 'case' and the other 'CASE'. So a case sensitive filesystem.

> debil% umount /usbdrive && mount /usbdrive
> debil% ls /usbdrive/case
> /usbdrive/case
> debil% ls /usbdrive/CASE
> ls: /usbdrive/CASE: No such file or directory

Looks like you have mounted the thing with case-sensitiviy *and* forcing
lowercase filenames always. Either there is a bug in the combination,
or perhaps there is a bug in that the uppercase name is cached for some
time in VFS until the lowercase name is reread from the usbdrive?

When you test this please be very careful to reproduce every start and
end condition *exactly*. <Bad pun alert> It's very easy to look at
Heisenbugs here, with all these virtual filenames in case space. </Bad
pun alert>

In practice I'd suggest using default mount options, except perhaps the
'uid=', 'gid=' and 'umask='.
-- 
Marco Roeland
