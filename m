Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263160AbTEIM6p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 08:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTEIM6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 08:58:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47120 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263160AbTEIM6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 08:58:43 -0400
Date: Fri, 9 May 2003 14:11:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Fwd: Re: 2.5.59-rmk-pxa1 and JFFS2 CRC problems
Message-ID: <20030509141119.A5204@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There appears to be a long standing problem with jffs2 which causes
CRC errors, and therefore causes various updates (via the setattr
filesystem method) to jffs2 filesystems to be ignored.

I have confirmed that this patch does fix the stated problem.

----- Forwarded message from David Woodhouse <dwmw2@infradead.org> -----
From: Frank Becker <fbecker@intrinsyc.com>
To:  moedeker@hmk-gmbh.de
CC:  linux-arm-kernel@lists.arm.linux.org.uk,  dwmw2@infradead.org
Date: Mon, 07 Apr 2003 09:58:27 -0700
Subject: Re: 2.5.59-rmk-pxa1 and JFFS2 CRC problems

moedeker@hmk-gmbh.de wrote:
>>>Hi all!
>>>
>>>I got some errors at jffs2. Please look after creating MTD partitions. We we 
>>
>>Your message seems corrupted in some way. Did one of the lines exceed 80
>>characters or something, or did you not actually finish the sentence
>>starting 'We we' ?
>>
>>
>>>jffs2_scan_dirent_node(): Name CRC failed on node at 0x000001cc: Read 0xd3d6f4fb, calculated 0xaff4c1a6
>>
>>Usually caused by someone screwing up the alignment fixups.
> 
> Sorry for my bad english - Right is:
> 
> "BEFORE WE" have switched from 2.5.30 to 2.5.59 jffs2 worked fine. 
> 
> At the time we have switched from gcc 2.95.03 to gcc 3.2.2. This seems to be better but not good enough. The above  
> error is also reported but "root" is not destroyed. Next step is to have a look to the patches of 2.5.60 to 2.5.65.
> 
> I don't have any idea which alignment fixups we could have smashed.

Long lines aside, jffs2 has been broken for me since 2.5.49.
I dug in yesterday and it turns out some of the inode fields
aren't initialized when doing a jffs2_setattr.

Try the attached patch and see if it makes a difference.

It appear that mtd cvs does the proper initialization.
i.e. looks like a merge error in Linus' tree...

Cheers,
-- 
Frank Becker - Intrinsyc Software, Inc. - http://www.intrinsyc.com/
Need a break? http://criticalmass.sf.net/

diff -ruN linux-2.5.65-rmk1/fs/jffs2/file.c linux-2.5.65-rmk1-cerf1/fs/jffs2/file.c
--- linux-2.5.65-rmk1/fs/jffs2/file.c	2003-03-17 13:44:50.000000000 -0800
+++ linux-2.5.65-rmk1-cerf1/fs/jffs2/file.c	2003-04-06 23:08:25.000000000 -0700
@@ -165,6 +165,10 @@
 	ri->mtime = cpu_to_je32((ivalid & ATTR_MTIME)?iattr->ia_mtime.tv_sec:inode->i_mtime.tv_sec);
 	ri->ctime = cpu_to_je32((ivalid & ATTR_CTIME)?iattr->ia_ctime.tv_sec:inode->i_ctime.tv_sec);
 	ri->compr = JFFS2_COMPR_NONE;
+
+	ri->offset = cpu_to_je32(0);;
+	ri->csize = ri->dsize = cpu_to_je32(mdatalen);
+
 	if (ivalid & ATTR_SIZE && inode->i_size < iattr->ia_size) {
 		/* It's an extension. Make it a hole node */
 		ri->compr = JFFS2_COMPR_ZERO;

----- End forwarded message -----

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

