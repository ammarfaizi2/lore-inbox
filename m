Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751846AbWJ3Of7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbWJ3Of7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWJ3Of7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:35:59 -0500
Received: from raven.upol.cz ([158.194.120.4]:52445 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1751846AbWJ3Of6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:35:58 -0500
To: "Jan Beulich" <jbeulich@novell.com>, Oleg Verych <olecom@flower.upol.cz>,
       <dsd@gentoo.org>, <kernel@gentoo.org>, <draconx@gmail.com>,
       <jpdenheijer@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       "Sam Ravnborg" <sam@ravnborg.org>, "Andi Kleen" <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
X-Posted-To: gmane.linux.kernel
Subject: Re: [PATCH -mm] replacement for broken	kbuild-dont-put-temp-files-in-the-source-tree.patch
Organization: Palacky University in Olomouc, experimental physics department.
In-Reply-To: <45460E6C.76E4.0078.0@novell.com>
References: <20061028230730.GA28966@quickstop.soohrt.org>
 <200610281907.20673.ak@suse.de>
 <20061029120858.GB3491@quickstop.soohrt.org>
 <200610290816.55886.ak@suse.de> <slrnek9qv0.2vm.olecom@flower.upol.cz>
 <20061029225234.GA31648@uranus.ravnborg.org>
 <4545C2D8.76E4.0078.0@novell.com> <slrnekbv60.2vm.olecom@flower.upol.cz>
Date: Mon, 30 Oct 2006 14:42:16 +0000
Message-ID: <slrnekc3q8.2vm.olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-10-30, Jan Beulich wrote:
>
>>>gcc does not delete files specified with -o - but binutils does.
>>>So using /dev/null in this case is not an option.
>>
>>Hmm. What's the preblem to invoke `as' via the GNU C compiler, then?
>
>Older gas, whether invoked from gcc or the command line or elsewhere,
>deletes its output on error, regardless of whether this is a special file
>(device). gcc can't make gas not do so.

So, how about (using your btmp directory) create symlink to /dev/null in
the (dev) sub-directory and then set no write permission? No tmp,
things are local to build output, old gas's happy:
,__
|olecom@flower:/tmp/_build_2.6.19-rc3/btmp
!__$ mkdir dev
,__
|olecom@flower:/tmp/_build_2.6.19-rc3/btmp
!__$ cd dev ; ln -s /dev/null null ; chmod u-w . ; ls -la
total 0
dr-xr-x--- 2 olecom root 60 2006-10-30 15:34 .
drwxr-x--- 3 olecom root 80 2006-10-30 15:34 ..
lrwxrwxrwx 1 olecom root  9 2006-10-30 15:34 null -> /dev/null
,__
|olecom@flower:/tmp/_build_2.6.19-rc3/btmp/dev
!__$ cd .. ; rm dev/null
rm: cannot remove dev/null': Permission denied
,__
|olecom@flower:/tmp/_build_2.6.19-rc3/btmp
!__$ echo ok > dev/null
,__
|olecom@flower:/tmp/_build_2.6.19-rc3/btmp
!__$

New featured dev/null may be set in some kind of make variable, say
$(null) in scripts/Kbuild.include.
____
