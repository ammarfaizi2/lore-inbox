Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUDEIyd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 04:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUDEIyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 04:54:33 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:2468 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263167AbUDEIy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 04:54:29 -0400
Date: Mon, 5 Apr 2004 10:54:21 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040405085421.GG28924@wohnheim.fh-wedel.de>
References: <20040320083411.GA25934@wohnheim.fh-wedel.de> <s5gznab4lhm.fsf@patl=users.sf.net> <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <m1isggonbl.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m1isggonbl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 April 2004 12:47:58 -0700, Eric W. Biederman wrote:
> 
> And a few scenarios to hopefully make things clear.
> 
> So your fs starts out as:
> 
> /file1 -> ino1 (link count 2) -> data block #1
> /file2 -> ino1 (link count 2) -> data block #1
> 
> file1 is only 4K long, so I only need to describe one data block.
> 
> Actions:
> 
> cowcopy(file2, file3):
> 
> /file1 -> ino1 (link count 2) -> ino2 (link count 2) -> data block #1
> /file2 -> ino1 (link count 2) -> ino2 (link count 2) -> data block #1
> /file3 -> ino3 (link count 1) -> ino2 (link count 2) -> data block #1
> 
> 
> copyfile(file3, file4):
> 
> /file1 -> ino1 (link count 2) -> ino2 (link count 3) -> data block #1
> /file2 -> ino1 (link count 2) -> ino2 (link count 3) -> data block #1
> /file3 -> ino3 (link count 1) -> ino2 (link count 3) -> data block #1
> /file4 -> ino4 (link count 1) -> ino2 (link count 3) -> data block #1
> 
> unlink(file2):
> 
> /file1 -> ino1 (link count 1) -> ino2 (link count 3) -> data block #1
> /file3 -> ino3 (link count 1) -> ino2 (link count 3) -> data block #1
> /file4 -> ino4 (link count 1) -> ino2 (link count 3) -> data block #1
> 
> link(file4, file5):
> 
> /file1 -> ino1 (link count 1) -> ino2 (link count 3) -> data block #1
> /file3 -> ino3 (link count 1) -> ino2 (link count 3) -> data block #1
> /file4 -> ino4 (link count 2) -> ino2 (link count 3) -> data block #1
> /file5 -> ino4 (link count 2) -> ino2 (link count 3) -> data block #1
> 
> write(file3):
> 
> /file1 -> ino1 (link count 1) -> ino2 (link count 2) -> data block #1
> /file3 -> ino3 (link count 1) -> data block #2
> /file4 -> ino4 (link count 2) -> ino2 (link count 2) -> data block #1
> /file5 -> ino4 (link count 2) -> ino2 (link count 2) -> data block #1
> 
> write(file5):
> 
> /file1 -> ino1 (link count 1) -> ino2 (link count 1) -> data block #1
> /file3 -> ino3 (link count 1) -> data block #2
> /file4 -> ino4 (link count 2) -> data block #3
> /file5 -> ino4 (link count 2) -> data block #3
> 
> write(file1):
> 
> /file1 -> ino1 (link count 1) -> data block #1 (with modified contents)
> /file3 -> ino3 (link count 1) -> data block #2
> /file4 -> ino4 (link count 2) -> data block #3
> /file5 -> ino4 (link count 2) -> data block #3
> 
> Does this make things clear?

Almost.  What exactly do cowcopy() and copyfile() do?  They look the
same, so why the difference?

Jörn

-- 
The story so far:
In the beginning the Universe was created.  This has made a lot
of people very angry and been widely regarded as a bad move.
-- Douglas Adams?
