Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVAYD24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVAYD24 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 22:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVAYD24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 22:28:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:4320 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261783AbVAYD2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 22:28:53 -0500
Message-ID: <41F5BB0D.6090006@osdl.org>
Date: Mon, 24 Jan 2005 19:20:45 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tridge@osdl.org
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: memory leak in 2.6.11-rc2
References: <20050120020124.110155000@suse.de>	<16884.8352.76012.779869@samba.org>	<200501232358.09926.agruen@suse.de>	<200501240032.17236.agruen@suse.de>	<16884.56071.773949.280386@samba.org> <16885.47804.68041.144011@samba.org>
In-Reply-To: <16885.47804.68041.144011@samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Tridgell wrote:
> I've fixed up the problems I had with raid, and am now testing the
> recent xattr changes with dbench and nbench.
> 
> The problem I've hit now is a severe memory leak. I have applied the
> patch from Linus for the leak in free_pipe_info(), and still I'm
> leaking memory at the rate of about 100Mbyte/minute.
> 
> I've tested with both 2.6.11-rc2 and with 2.6.11-rc1-mm2, both with
> the pipe leak fix. The setup is:
> 
>  - 4 way PIII with 4G ram
>  - qla2200 adapter with ibm fastt200 disk array 
>  - running dbench -x and nbench on separate disks, in a loop
> 
> The oom killer kicks in after about 30 minutes. Naturally the oom
> killer decided to kill my sshd, which was running vmstat :-) 

Do you have today's memleak patch applied?  (cut-n-paste below).

-- 
~Randy


----
--- 1.40/fs/pipe.c	2005-01-15 12:01:16 -08:00
+++ edited/fs/pipe.c	2005-01-24 14:35:09 -08:00
@@ -630,13 +630,13 @@
  	struct pipe_inode_info *info = inode->i_pipe;

  	inode->i_pipe = NULL;
-	if (info->tmp_page)
-		__free_page(info->tmp_page);
  	for (i = 0; i < PIPE_BUFFERS; i++) {
  		struct pipe_buffer *buf = info->bufs + i;
  		if (buf->ops)
  			buf->ops->release(info, buf);
  	}
+	if (info->tmp_page)
+		__free_page(info->tmp_page);
  	kfree(info);
  }

-
