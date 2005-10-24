Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVJXI4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVJXI4u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 04:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVJXI4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 04:56:50 -0400
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:51850 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750771AbVJXI4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 04:56:49 -0400
Message-ID: <435CA1CF.3070204@gmail.com>
Date: Mon, 24 Oct 2005 03:56:47 -0500
From: Hareesh Nagarajan <hnagar2@gmail.com>
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [TRIVIAL] Error checks omitted in init_tmpfs() in mm/tiny-shmem.c
References: <435C7149.3010004@gmail.com> <20051024070921.GW26160@waste.org>
In-Reply-To: <20051024070921.GW26160@waste.org>
Content-Type: multipart/mixed;
 boundary="------------020002010101040603090306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020002010101040603090306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Matt Mackall wrote:
> On Mon, Oct 24, 2005 at 12:29:45AM -0500, Hareesh Nagarajan wrote:
>> The existing code in init_tmpfs() in mm/tiny-shmem.c does not handle the 
>> cases when the calls to register_filesystem() and kern_mount() fail. 
>> This patch adds those checks.
> 
> Hmm. Did you actually encounter this?

No, I haven't. I was just reading the source code when I chanced upon 
these trivial error checking omissions.

> I'd rather use BUG_ON. Passing up errors is only useful when the code
> above can and will do something useful with the information. 

[ Snip ]

> And what could the higher level, which is simply looping through init
> functions, do to handle the error? Retry? Print a warning? Better to
> stop everything outright when we encounter a problem we expect should
> never happen so it doesn't go by undiagnosed.

Makes sense. New patch attached.

Signed-off-by: Hareesh Nagarajan <hnagar2@gmail.com>

--------------020002010101040603090306
Content-Type: text/x-patch;
 name="tiny-shmmem-fix-ver2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tiny-shmmem-fix-ver2.patch"

--- linux-2.6.13.4/mm/tiny-shmem.c	2005-10-10 13:54:29.000000000 -0500
+++ linux-2.6.13.4-edit/mm/tiny-shmem.c	2005-10-24 03:43:38.614071000 -0500
@@ -31,12 +31,18 @@
 
 static int __init init_tmpfs(void)
 {
-	register_filesystem(&tmpfs_fs_type);
+	int error;
+
+	error = register_filesystem(&tmpfs_fs_type);
+	BUG_ON(error);
+
 #ifdef CONFIG_TMPFS
 	devfs_mk_dir("shm");
 #endif
 	shm_mnt = kern_mount(&tmpfs_fs_type);
-	return 0;
+	BUG_ON(IS_ERR(shm_mnt));
+
+	return error;
 }
 module_init(init_tmpfs)
 

--------------020002010101040603090306--
