Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbUCXNps (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 08:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263379AbUCXNpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 08:45:47 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:12702 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263365AbUCXNpb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 08:45:31 -0500
Subject: Re: kernel 2.6.4: Bug in JFS file system?
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andreas Theofilu <andreas@TheosSoft.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>
In-Reply-To: <20040323195529.2ac9a207.andreas@TheosSoft.net>
References: <20040323195529.2ac9a207.andreas@TheosSoft.net>
Content-Type: text/plain
Message-Id: <1080135917.29044.80.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Mar 2004 07:45:17 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-23 at 12:55, Andreas Theofilu wrote:
> Hi to all,
> 
> Since kernel 2.6.4 I'm not able to access files with a special character
> in the file name, such as the german umlaute. Every attempt to access such
> a file gives me the error: cannot stat file

I did this to you.  I changed jfs's default character translation
behavior.  jfs stores the file names in ucs-16.  It had used the
character set defined by CONFIG_NLS_DEFAULT to determine how to
translate to or from ucs-16.  This can be overridden with the iocharset=
mount option.

After many complaints about characters that were being rejected by jfs,
and after getting as much feedback as I was able to obtain, I changed
the default behavior so that no translation is done.  Each byte of the
file name is now stored in the lower byte of the ucs-16 character. 
(This is equivalent to iocharset=iso8859-1, which is the default value
of CONFIG_NLS_DEFAULT.)

Unfortunately, existing files with a non-zero high byte in a character
are no longer accessible.  jfs should have printed a syslog message
recommending that the file system be mounted with iocharset=utf8 to
access the file.

> I'm using several partitions with JFS file system and had never seen such
> a strange behavior before. The relevant kernel settings are at the bottom
> of the mail.
> 
> I already unmounted the partition and run fsck on it (fsck.jfs -f
> /dev/hda8), but it told me that everything is ok and I'm still not able to
> access this files. Also a reboot of the machine didn't change anything. I
> booted 2.6.3 again and renamed the files in question (no more special
> characters in the file name). Now I can access these files with 2.6.4
> also.

Another alternative would have been to mount the filesystem with "-o
iocharset=<charset>" where <charset> is the value of
CONFIG_NLS_DEFAULT.  To make that behavior permanent, you can add the
iocharset= flag to /etc/fstab.

> Although I'm a programmer, I'm not a kernel hacker and don't know where
> to start looking for this problem. Could anybody give me a hint where to
> start looking?

I'm sorry this caused you problems.  I knew making this change would
cause some confusion, but I think in the long run, jfs is better off
with a more predictable default behavior.

-- 
David Kleikamp
IBM Linux Technology Center

