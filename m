Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269429AbUIYWTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269429AbUIYWTd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 18:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269430AbUIYWTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 18:19:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:27609 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269429AbUIYWS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 18:18:59 -0400
Date: Sat, 25 Sep 2004 15:18:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeremy Allison <jra@samba.org>
cc: YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= 
	<yoshfuji@linux-ipv6.org>,
       samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
In-Reply-To: <20040925220843.GD580@jeremy1>
Message-ID: <Pine.LNX.4.58.0409251513290.2317@ppc970.osdl.org>
References: <20040925171104.GN580@jeremy1> <20040926.024131.06508879.yoshfuji@linux-ipv6.org>
 <20040925174406.GP580@jeremy1> <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org>
 <20040925182907.GS580@jeremy1> <Pine.LNX.4.58.0409251218170.2317@ppc970.osdl.org>
 <20040925195256.GB580@jeremy1> <Pine.LNX.4.58.0409251317410.2317@ppc970.osdl.org>
 <20040925211055.GC580@jeremy1> <Pine.LNX.4.58.0409251445470.2317@ppc970.osdl.org>
 <20040925220843.GD580@jeremy1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Sep 2004, Jeremy Allison wrote:
> 
> > What kinds of values do different smb servers actually fill this field 
> > with? And what's the value you expect future samba severs will use?
> 
> Ok, right now the only smb server that supports the UNIX
> extensions is smbd (I'm working on getting NetApp to also
> support them, but they don't as yet so we can get them to
> do the right thing, bytes allocated, when they do), so we
> know pretty much what will happen.

Ok. Then we don't have to worry about somebody using a block count instead 
of a byte count anywhere. That simplifies things a bit, at least.

Samuel, does this patch work for you? I'll commit if after somebody 
reports that it works (assuming nobody points out any stupid thinkos 
in it).

This will inevitably get the disk usage a _bit_ wrong if the file really 
_does_ happen to use up an exact multiple of 1MB of disk, but hey, having 
a heuristic that is sometimes a bit wrong is better than having one that 
is always very wrong. 

This is totally untested, btw. For obvious reasons.

		Linus

----
===== fs/smbfs/proc.c 1.40 vs edited =====
--- 1.40/fs/smbfs/proc.c	2004-07-11 02:23:29 -07:00
+++ edited/fs/smbfs/proc.c	2004-09-25 15:15:23 -07:00
@@ -2076,6 +2076,8 @@
 
 void smb_decode_unix_basic(struct smb_fattr *fattr, char *p)
 {
+	u64 size, disk_bytes;
+
 	/* FIXME: verify nls support. all is sent as utf8? */
 
 	fattr->f_unix = 1;
@@ -2093,8 +2095,19 @@
 	/* 84 L permissions */
 	/* 92 L link count */
 
-	fattr->f_size = LVAL(p, 0);
-	fattr->f_blocks = LVAL(p, 8);
+	size = LVAL(p, 0);
+	disk_bytes = LVAL(p, 8);
+
+	/*
+	 * Some samba versions round up on-disk byte usage
+	 * to 1MB boundaries, making it useless. When seeing
+	 * that, use the size instead.
+	 */
+	if (!(disk_bytes & 0xfffff))
+		disk_bytes = size+511;
+
+	fattr->f_size = size;
+	fattr->f_blocks = disk_bytes >> 9;
 	fattr->f_ctime = smb_ntutc2unixutc(LVAL(p, 16));
 	fattr->f_atime = smb_ntutc2unixutc(LVAL(p, 24));
 	fattr->f_mtime = smb_ntutc2unixutc(LVAL(p, 32));
