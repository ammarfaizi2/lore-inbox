Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWGMQZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWGMQZT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 12:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWGMQZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 12:25:19 -0400
Received: from chen.mtu.ru ([195.34.34.232]:5394 "EHLO chen.mtu.ru")
	by vger.kernel.org with ESMTP id S932484AbWGMQZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 12:25:18 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: confusion and case problems: utf8 <-> iocharset
To: Eduard Bloch <edi@gmx.de>, linux-kernel@vger.kernel.org
Date: Thu, 13 Jul 2006 20:25:14 +0400
References: <20060713075617.GA9429@rotes76.wohnheim.uni-kl.de>
User-Agent: KNode/0.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8Bit
Message-Id: <20060713162515.465575472A6@chen.mtu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduard Bloch wrote:

> Hello (to whom it may concern),
> 
> I try to understand how the charset mapping with VFAT/Joliet and I found
> some inconsistencies between the user expectations, the docs, and the
> actuall behaviour.
> 
> Users view:
> 
> VFAT, NTFS and Joliet use a Unicode charset for storing the names
> internaly. 

Nope. VFAT is using short name as long as it complies with MSDOS; this name
is stored in codepage character set.

[...]
> 
> Second:
> there is the "utf8" option. How does that exactly differ from
> iocharset=utf8? There is not clear explanation in vfat.txt. What happens
> if you use both options, especially if iocharset!=utf8? Which one is
> prefered?
>

You actually need both; utf8 just says it is OK not to try to mangle names;
it does not substitute iocharset option.
 
> Third:
> how can I disable all that funny letter case conversions? They are not
> described anywhere properly,

man mount

> nor the way to disable them. 

man mount

> IMO there are  
> two problems:
> 
>  - what you write to the FS is not the same what "ls" shows you later.
>    Eg. ABW becomes "abw" but "ABWÖ" becomes "ABWÖ". Abcd becomes "Abcd"
>    but "ABC" becomes "abc".  Does it make sense? NO.

tell this to Microsoft. It is how VFAT works. Although umlaut should
probably be considered as MSDOS-safe, at least with proper codepage option.


>    I would like to stop the kernel playing such games, I had enough of
>    such trouble back in my Windows 98 times.
> 
>  - this case conversion can actually break things. When iocharset=utf-8
>    and utf8 are used, then you cannot access the data with the same
>    name after storing it.
> 

mount shortname=mixed is probably what you want.

> zombie:/tmp# mkdir test/TEST
> zombie:/tmp# ls test
> test
> zombie:/tmp# ls test/test
> zombie:/tmp# ls test/TEST
> ls: test/TEST: No such file or directory

{pts/1}% sudo mount -t vfat -o
loop,shortname=mixed,utf8,uid=bor /var/tmp/test.dos /tmp/x
{pts/1}% LC_ALL=C ll /tmp/x/test
total 2
drwxr-xr-x  2 bor root 2048 Jul 13 20:06 TEST/
{pts/1}% LC_ALL=C ll /tmp/x/test/TEST
total 0
-rwxr-xr-x  1 bor root 0 Jul 13 20:06 ?*
-rwxr-xr-x  1 bor root 0 Jul 13 20:06 ?*
-rwxr-xr-x  1 bor root 0 Jul 13 20:06 ?*
-rwxr-xr-x  1 bor root 0 Jul 13 20:06 ?*

The filesystem is foobared already because it contains both capital and
lowercase versions of the same names. This is what happens when you try to
use wrong codepage.

-andrey

