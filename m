Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbVJXLTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVJXLTd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 07:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbVJXLTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 07:19:33 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:28139 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750883AbVJXLTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 07:19:32 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: James Hansen <linux-kernel-list@f0rmula.com>
Subject: Re: Information on ioctl32
Date: Mon, 24 Oct 2005 13:20:52 +0200
User-Agent: KMail/1.7.2
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <4358CF73.3020602@f0rmula.com> <200510241132.45334.arnd@arndb.de> <435CBBFF.7000704@f0rmula.com>
In-Reply-To: <435CBBFF.7000704@f0rmula.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510241320.53335.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maandag 24 Oktober 2005 12:48, James Hansen wrote:
> Sorry, I'll explain a little more about I'm doing.

Btw, please don't top-post.

> The kernel I'm running is the default kernel from the (unofficial) 
> debian amd64 distro.  uname says it's 2.6.8-11-amd64-generic.  When 
> running a 32bit app, linked against the 32bit libraries, calling a 64bit 
> driver in, the kernel logs messages saying something along the lines of 
> "ioctl32 not defined".

Ok, that is a little clearer then. It's not missing the infrastructure
but rather a conversion for a specific ioctl number in that device
driver. Actually, the message should print out which number that is,
otherwise, you can probably find out by running the program with
'strace' and looking for ioctl() calls that result in 'EINVAL'
or 'ENOTTY'.

> The headers I'm building my modules against are from the package 
> 'kernel-headers-2.6.8-11-amd64-generic' which leaves me with the 
> directory 'kernel-headers-2.6.8-11-amd64-generic' in /usr/src. 
> 
> My problem is that when I look in the headers at the file_operations 
> struct for compat_ioctl there's no entry there, and I therefore can't 
> define a function for it.  I had no idea there was a dynamic system in 
> place before what's mentioned on lwn.  I'd assumed that as my kernel was 
> trying to call ioctl32, that it would have had the patch applied, and 
> it's headers should have contained an appropriate entry in file_operations.
> 
> So it looks like I'll have implement both ways of doing things, one for 
> pre-2.6.11 and another for post 2.6.11 kernels.
> 
> Would you know of anywhere else I could look for information on the 
> dynamic method you mentioned that existed in kernels before 2.6.11.

Actually, you should not implement anything for old kernels, they are
just not supported. The only thing that helps is that you find out
which driver is missing the conversion and (find someone to) add the
compat_ioctl method to the device driver for 2.6.15.

The interesting information here is
- name of the device driver
- name of the application
- all the ioctl numbers that are missing (can be found out from
  the other two)

If you really want to do the extra work to get it running on kernels
older than 2.6.11, look for register_ioctl32_conversion(). Just know
that we had a good reason to replace that and I don't think you will
have much lock in getting the handler for your driver into the
Debian 2.6.8 kernel.

	Arnd <><
