Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbVJYAQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbVJYAQz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 20:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbVJYAQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 20:16:55 -0400
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:51310 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751400AbVJYAQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 20:16:54 -0400
Message-ID: <435D7972.7020102@gmail.com>
Date: Mon, 24 Oct 2005 19:16:50 -0500
From: Hareesh Nagarajan <hnagar2@gmail.com>
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [TRIVIAL] Error checks omitted in init_tmpfs() in mm/tiny-shmem.c
References: <435C7149.3010004@gmail.com> <20051024070921.GW26160@waste.org> <435CA1CF.3070204@gmail.com> <20051024204518.GI26160@waste.org>
In-Reply-To: <20051024204518.GI26160@waste.org>
Content-Type: multipart/mixed;
 boundary="------------020701000305000601010104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020701000305000601010104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Matt Mackall wrote:
> On Mon, Oct 24, 2005 at 03:56:47AM -0500, Hareesh Nagarajan wrote:
>> Matt Mackall wrote:
>>> On Mon, Oct 24, 2005 at 12:29:45AM -0500, Hareesh Nagarajan wrote:
>>>> The existing code in init_tmpfs() in mm/tiny-shmem.c does not handle the 
>>>> cases when the calls to register_filesystem() and kern_mount() fail. 
>>>> This patch adds those checks.

[ Snip ]

> A couple more comments..
> 
>> Signed-off-by: Hareesh Nagarajan <hnagar2@gmail.com>
> 
>> --- linux-2.6.13.4/mm/tiny-shmem.c	2005-10-10 13:54:29.000000000 -0500
>> +++ linux-2.6.13.4-edit/mm/tiny-shmem.c	2005-10-24 03:43:38.614071000 -0500
>> @@ -31,12 +31,18 @@
>>  
>>  static int __init init_tmpfs(void)
>>  {
>> -	register_filesystem(&tmpfs_fs_type);
>> +	int error;
>> +
>> +	error = register_filesystem(&tmpfs_fs_type);
>> +	BUG_ON(error);
> 
> Can we just do BUG_ON(register_filesystem() != 0)?
> 
> Strictly speaking, the != 0 is redundant, but as this goes slightly
> against the grain of normal usage, it's a good indicator of intent.

It shows intent well. That goes into my book for good programming 
practices. No more BUG_ON(foo) :)

>>  #ifdef CONFIG_TMPFS
>>  	devfs_mk_dir("shm");
>>  #endif
>>  	shm_mnt = kern_mount(&tmpfs_fs_type);
>> -	return 0;
>> +	BUG_ON(IS_ERR(shm_mnt));
>> +
>> +	return error;
> 
> We can never return non-zero here. Returning error implies we can, so
> it's confusing.

Makes sense again. Patch follows.

Signed-off-by: Hareesh Nagarajan <hnagar2@gmail.com>

--------------020701000305000601010104
Content-Type: text/x-patch;
 name="tiny-shmmem-fix-ver3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tiny-shmmem-fix-ver3.patch"

--- linux-2.6.13.4/mm/tiny-shmem.c	2005-10-10 13:54:29.000000000 -0500
+++ linux-2.6.13.4-edit/mm/tiny-shmem.c	2005-10-24 19:05:28.058897000 -0500
@@ -31,11 +31,14 @@
 
 static int __init init_tmpfs(void)
 {
-	register_filesystem(&tmpfs_fs_type);
+	BUG_ON(register_filesystem(&tmpfs_fs_type) != 0);
+
 #ifdef CONFIG_TMPFS
 	devfs_mk_dir("shm");
 #endif
 	shm_mnt = kern_mount(&tmpfs_fs_type);
+	BUG_ON(IS_ERR(shm_mnt));
+
 	return 0;
 }
 module_init(init_tmpfs)

--------------020701000305000601010104--
