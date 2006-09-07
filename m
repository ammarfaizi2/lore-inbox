Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWIGU7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWIGU7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 16:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWIGU7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 16:59:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:11646 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932170AbWIGU7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 16:59:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=aBVgjU3iQhyabUw/Yv9awgZNi/1LzpQwlPeYM9B+mPK+AOf1nPxypCEakTDVeyoNVf7f1vbNEUWmEXHTZ6iiXmDCmG9JnYFuBf/HWFb4R7ynFgsj8a33Dc5kFbf912bkGsvxLd+cKpifGIl3+jnmvYa89D2NRC78G62eHDh5gtw=
Date: Fri, 8 Sep 2006 00:59:27 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Naughty ramdrives
Message-ID: <20060907205927.GA5193@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You'd laugh, but...

Summary:

	After loading and unloading rd.ko many times "ls -l /dev/ram*"
	results are not persistent.

Steps to reproduce:

	# while true; do modprobe rd && rmmod rd; done
		[wait ~10 seconds]
	^C
	# modprobe rd

	# ls -l /dev/ram*
	lrwxrwxrwx 1 root root 5 Sep  8 00:35 /dev/ram12 -> rd/12
	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram6 -> rd/6
	# ls -l /dev/ram*
	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram0 -> rd/0
	lrwxrwxrwx 1 root root 5 Sep  8 00:35 /dev/ram13 -> rd/13
	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram6 -> rd/6
	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram7 -> rd/7
	# ls -l /dev/ram*
	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram0 -> rd/0
	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram1 -> rd/1
	lrwxrwxrwx 1 root root 5 Sep  8 00:35 /dev/ram11 -> rd/11
	lrwxrwxrwx 1 root root 5 Sep  8 00:35 /dev/ram12 -> rd/12
	lrwxrwxrwx 1 root root 5 Sep  8 00:35 /dev/ram14 -> rd/14
	lrwxrwxrwx 1 root root 5 Sep  8 00:35 /dev/ram15 -> rd/15
	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram3 -> rd/3
	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram7 -> rd/7
	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram8 -> rd/8
	lrwxrwxrwx 1 root root 4 Sep  8 00:35 /dev/ram9 -> rd/9

Versions:

	Linux 2.6.18-rc5
	udev 087

P.S.:

This was noticed while investigating #4899
http://bugme.osdl.org/show_bug.cgi?id=4899
where /dev/ram0 when opened, pins module indefinitely. It seems that
adding ->release() which undoes

	inode = igrab(bdev->bd_inode);

should do the trick. Am I right?

