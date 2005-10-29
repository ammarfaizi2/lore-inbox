Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbVJ2QCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVJ2QCK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 12:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVJ2QCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 12:02:09 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:53778 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751214AbVJ2QCI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 12:02:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HlPZ/8q9o43xWydVdS2B6ji2XLBqD6FOLinBcUyBhJjqEvffNENDnykTTt6MlsvKWjLWJQ+pnlGFQmXSEA+vCtmO2vW7Kv2SGthOhK5Z2KUxE09kLra3uaMqgRbpAtQI6L9RszFf1OHeEj/rF2e9zVqcz4LfYvdHU9cDjJWYUrU=
Message-ID: <35fb2e590510290902y2152f703t56d0cc688f3c64cb@mail.gmail.com>
Date: Sat, 29 Oct 2005 17:02:03 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
Subject: Re: Weirdness of "mount -o remount,rw" with write-protected floppy
Cc: linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <4360C0A7.4050708@weizmann.ac.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4360C0A7.4050708@weizmann.ac.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/05, Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il> wrote:

> # mount /dev/fd0 /mnt/floppy/
> mount: block device /dev/fd0 is write-protected, mounting read-only
> # mount -o remount,rw /mnt/floppy
> # echo $?
> 0

Ok. The problem is in the remounting. Both cases rely on the mount
syscall doing the work and the "fault" is that it is returning
successfully in both cases.

When remounting, Linux /does/ check if the corresponding block device
is read-only and won't remount rw onto that (so if the permissions of
the bdev corresponded to the real state of the floppy then all would
be good) but it will if the block dev is writeable but the device is
not. There isn't a generic VFS way to ask if a backing device is
writeable (or do_remount_sb would be using it) - or is there?

The /only/ way I can see to "fix" this is to do a pointless open on
the block device and see if that returns EROFS before allowing a
remount. But I don't know what other hassle that will cause - I'll
make the hack, but someone (Al?) who knows the code will need to
comment because this might completely fuck up a lock somewhere.

Jon.
