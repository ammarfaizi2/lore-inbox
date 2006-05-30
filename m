Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWE3RDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWE3RDE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWE3RDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:03:04 -0400
Received: from [64.62.168.36] ([64.62.168.36]:35237 "EHLO gigablast.com")
	by vger.kernel.org with ESMTP id S932339AbWE3RDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:03:02 -0400
Message-ID: <447C7B49.4010003@gigablast.com>
Date: Tue, 30 May 2006 11:05:13 -0600
From: Javier Olivares <jolivares@gigablast.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug Fix for 2GB core limit in 2.4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We were having problems when running programs that used over 2GB of ram 
not being able to generate core files over 2GB, these are some very 
simple changes that fixed the problem.

linux-2.4.31/fs/binfmt_elf.c
1024c1024
< static int dump_seek(struct file *file, off_t off)
---
 > static int dump_seek(struct file *file, loff_t off)

Changed the function parameter "off" from type "off_t" to "loff_t".  The 
parameter was truncating the incoming long long type to a long, causing 
the seek to fail and kill the dump when off grew above 2GB.

/kernels/2.4.31/linux-2.4.31/fs/exec.c
1151c1151
<     file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW, 0600);
---
 >     file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW | 
O_LARGEFILE, 0600);

Included the O_LARGEFILE flag in order to create files over 2GB.

The changes have been running on many Debian systems for a couple of 
months.  Valid core files just over 3GB have been created without any 
problem.  I have never submitted anything like this before so please 
excuse any lack of proper protocol.
Thank you.

-Javier Olivares
