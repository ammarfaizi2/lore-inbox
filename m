Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVAZGdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVAZGdq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 01:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVAZGdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 01:33:46 -0500
Received: from mxc.rambler.ru ([81.19.66.31]:13586 "EHLO mxc.rambler.ru")
	by vger.kernel.org with ESMTP id S262360AbVAZGde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 01:33:34 -0500
Date: Wed, 26 Jan 2005 09:30:36 +0300
From: Pavel Fedin <sonic_amiga@rambler.ru>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Russian encoding support for MacHFS
Message-Id: <20050126093036.5aed40bd.sonic_amiga@rambler.ru>
In-Reply-To: <Pine.LNX.4.61.0501251545540.6118@scrub.home>
References: <20050124125756.60c5ae01.sonic_amiga@rambler.ru>
	<81b0412b05012410463c7fd842@mail.gmail.com>
	<20050125123516.7f40a397.sonic_amiga@rambler.ru>
	<Pine.LNX.4.61.0501251545540.6118@scrub.home>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Auth-User: sonic_amiga, whoson: (null)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 16:34:57 +0100 (CET)
Roman Zippel <zippel@linux-m68k.org> wrote:

> I'm not quite sure, what problem you're trying to solve here.

 I am trying to implement character sets conversion for MacHFS. I have some CD s with russian file names. Currently they are not displayed properly because Linux uses KOI8-R character set for russian letters and Macintosh uses its own character set called Mac-cyrillic or codepage 10007.
 Firstly i tried to implement character set conversion using NLS tables. It was done using "iocharset" and "codepage" arguments. "Iocharset" specified Linux's local character set and "codepage" specified HFS's character set. So to convert a character i needed to process it twice: convert from "codepage" to Unicode and then convert from Unicode to "iocharset".
 The problem with this is that some characters will be lost during this conversion. Not all characters from source ("codepage") charset are present in destination ("iocharset") charset table (for example "Folder" sign). But for proper operation of dir.c/hfs_lookup() function we need to be able to convert the name back from KOI8-R to CP10007 otherwise searching algorythm will fail. This will lead to that we won't be able to operate with any file which contains such a characters.
 A solution was to use my own conversion table which ensures that no characters will be lost during conversion in both directions. Every unique source character is translated to some unique destination character. Of course Mac-specific characters are not displayed properly but they're not lost either. "codepage" argument was omitted for simplicity because specific "iocharset" implies specific "codepage" (for example if iocharset is koi8-r then we can assume that Macintosh codepage is mac-cyrillic). But some people said that this patch can't be approved because not using NLS is bad solution. So i'd like to talk to you, may be we'll find a better solution (because you know HFS better than me) or we can come to a conclusion that there is really no solution and push the patch upstream.

> If you want to store unicode characters use HFS+, I plan to implement nls 
> support real soon for it (especially because to also fix the missing 
> decomposition support). 

 Would be nice. I also thought about it but i have no HFS+ disks with russian names so i can't test it. And i decided not to do a "blind" implementation in order not to break the filesystem. Currently my patch adds "iocharset" argumnent to HFS+ also (so that i can specify both filesystems in one /etc/fstab line, this is useful for CD-ROM) but it is ignored there.

-- 
Best regards,
Pavel Fedin,									mailto:sonic_amiga@rambler.ru
