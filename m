Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316455AbSEORzG>; Wed, 15 May 2002 13:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316456AbSEORzF>; Wed, 15 May 2002 13:55:05 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:58119 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316455AbSEORzC>;
	Wed, 15 May 2002 13:55:02 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200205151749.g4FHnkt183716@saturn.cs.uml.edu>
Subject: Re: [RFC] FAT extension filters
To: hirofumi@mail.parknet.co.jp (OGAWA Hirofumi)
Date: Wed, 15 May 2002 13:49:46 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        msmith@operamail.com (Malcolm Smith), linux-kernel@vger.kernel.org,
        chaffee@cs.berkeley.edu
In-Reply-To: <87u1p960va.fsf@devron.myhome.or.jp> from "OGAWA Hirofumi" at May 15, 2002 09:39:53 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi writes:
> "Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

>> Also I found a bug in the vfat code. It doesn't
>> properly handle old (pre-vfat) files with names
>> that start with 0xE5; these are stored on disk
>> with 0x05 as the first character.
>
> Umm... why? 0xE5 is free entry mark.

That is exactly why! You can store a name that
starts with 0xE5 by substituting 0x05. You can
not store a file that starts with 0x05, because
it would appear to start with 0xE5 when you
read it back.

Using plain old MS-DOS, or Linux right before the
vfat code was merged, create a file with this name:

E5 44 05 44 E5 44 44 44   44 E5 05

On disk it gets stored as this:

05 44 05 44 E5 44 44 44   44 E5 05
^^

Now remount or reboot so you don't cheat by
accident. Do an "ls -l" and note that you
see the original filename. The 0xE5 is at
the beginning of the name, and the 0x05 in
the middle has not been mangled.

Using vfat is not supposed to make old msdos
files inaccessible. I discovered this problem
while trying to make a backup of my old FAT
partition. Even "ls -l" would fail.

I think the problem is in fs/fat/dir.c where
it does:

        for (i = 0; i < 8; i++) {
                /* see namei.c, msdos_format_name */
                if (de->name[i] == 0x05)
                        work[i] = 0xE5;
                else
                        work[i] = de->name[i];
        }

That should be:

        for (i = 0; i < 8; i++) work[i] = 0xE5;
         /* see namei.c, msdos_format_name */
        if (*work == 0x05) *work = 0xE5;
