Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262550AbVEMVBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbVEMVBi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 17:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVEMVBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 17:01:05 -0400
Received: from smtpout.mac.com ([17.250.248.46]:56269 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262543AbVEMU6H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 16:58:07 -0400
In-Reply-To: <20050513122451.GD9255@wohnheim.fh-wedel.de>
References: <20050509183135.GB27743@mary> <20050512121842.GA20388@wohnheim.fh-wedel.de> <20050512164413.GA14099@mary> <2F200E69-465D-46ED-9D3A-5ED5C9FEAC9A@mac.com> <20050513080137.GA9255@wohnheim.fh-wedel.de> <7E4FD3AB-54F6-43D5-9340-ECEEA2E55C0B@mac.com> <20050513122451.GD9255@wohnheim.fh-wedel.de>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <5A04827D-95AF-4AD2-A656-12C66C875F29@mac.com>
Cc: Markus Klotzbuecher <mk@creamnet.de>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [ANNOUNCE] mini_fo-0.6.0 overlay file system
Date: Fri, 13 May 2005 16:57:52 -0400
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 13, 2005, at 08:24:51, Jörn Engel wrote:
> That and replacing the page cache by something different.  Page cache
> is referencing pages by inode,offset pairs.  Having a potentially
> infinite amount of inodes to look at, in order, may require a tiny bit
> of patching. ;)

Why modify the page cache (much)?  In the sparse-nonresident-file case,
when a filesystem is asked to return a page-cache page mapped to the
file, it looks it up in itself.  If that call returns ENONRESIDENT or
similar, the VFS union code would go to the next filesystem in the
stack and attempt a similar lookup.  If any filesystem but the root
returns a page, then the unionfs code would map it read-only and COW.
When the COW triggers, it will call into the VFS union code, which will
either:
     (a) If the topmost filesystem supports sparse-nonresident, then
         have it allocate the new page on-disk.
     (b) Otherwise, copy the whole file and modify the page.

Then it would return the new now-writeable pagecache page.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



