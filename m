Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313818AbSEASMJ>; Wed, 1 May 2002 14:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313824AbSEASMI>; Wed, 1 May 2002 14:12:08 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:9092 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S313818AbSEASMH>; Wed, 1 May 2002 14:12:07 -0400
Date: Wed, 1 May 2002 14:13:41 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Bob_Tracy <rct@gherkin.frus.com>
Cc: system_lists@nullzone.org, linux-kernel@vger.kernel.org
Subject: Re: SEVERE Problems in 2.5.12 at uid0 access
Mail-Followup-To: Bob_Tracy <rct@gherkin.frus.com>,
	system_lists@nullzone.org, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020501130602.00cabaf0@192.168.2.131> <m172xYI-0005khC@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Message-Id: <20020501181128.VFVF1690.out001.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob_Tracy wrote:
> system_lists@nullzone.org wrote:
> > server01:/var/log# ls -laF
> > <snip>
> > drwxr-s---    2 mail     adm           104 Mar 12 23:29 exim/
> > <snip>
> > 
> > server01:/var/log# ls -laF exim
> > ls: exim/.: Permission denied
> 
> Confirmed on a 2.5.11 system as well.  Talk about your basic heart
> attack!  I'd just installed Postfix and found that I couldn't access
> any of the directories under /var/spool/postfix.  Fortunately (?),
> I've got older kernels to fall back on, and that's one of the hazards
> of running on the bleeding edge I reckon.

Al Viro posted a patch to fix this.

diff -urN C12-0/fs/namei.c C12-current/fs/namei.c
--- C12-0/fs/namei.c	Tue Apr 30 20:23:38 2002
+++ C12-current/fs/namei.c	Tue Apr 30 23:37:15 2002
@@ -324,6 +324,12 @@
 	if (mode & MAY_EXEC)
 		return 0;
 
+	if ((inode->i_mode & S_IXUGO) && capable(CAP_DAC_OVERRIDE))
+		return 0;
+
+	if (S_ISDIR(inode->i_mode) && capable(CAP_DAC_READ_SEARCH))
+		return 0;
+
 	return -EACCES;
 }

-- 
Skip
