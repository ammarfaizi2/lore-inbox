Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVBGKVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVBGKVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 05:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVBGKVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 05:21:52 -0500
Received: from [220.248.27.114] ([220.248.27.114]:7342 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261395AbVBGKVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 05:21:48 -0500
Date: Mon, 7 Feb 2005 18:19:14 +0800
From: hugang@soulinfo.com
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>
Subject: Re: [PATCH] raw1394 : Fix hang on unload
Message-ID: <20050207101914.GA16686@hugang.soulinfo.com>
References: <1107718875.4378.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <1107718875.4378.25.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 06, 2005 at 02:41:15PM -0500, Parag Warudkar wrote:
> I was seeing rmmod getting stuck consistently in D state while removing
> raw1394. Looking at raw1394.c:cleanup_raw1394 - the order of doing
> things seemed incorrect to me after comparing other places in raw1394.c
> which do the same thing but with a different order.
> 
> bash          R  running task       0  4319   3884                3900
> (NOTLB)
> rmmod         D 0000008428792a16     0  4490   3900
> (NOTLB)
> ffff81001cff9dd8 0000000000000082 0000000000000000 0000000100000000
>        0000007400000000 ffff8100211c9070 000000000000097b
> ffff81002c8a2800
>        ffffffff80397c97 ffff81002b6f9360
> Call Trace:<ffffffff80379d25>{__down+421}
> <ffffffff80133510>{default_wake_function+0}
>        <ffffffff8037cd8c>{__down_failed+53}
> <ffffffff801c0e40>{generic_delete_inode+0}
>        <ffffffff8029e540>{.text.lock.driver+5}
> <ffffffff885a8260>{:raw1394:cleanup_raw1394+16}
>        <ffffffff8015eb31>{sys_delete_module+497}
> <ffffffff8021a692>{__up_write+514}
>        <ffffffff80183efb>{sys_munmap+107} <ffffffff8010ecda>{system_call
> +126}
> 
> Attached patch fixes the rmmod raw1394 hang. Tested.

I think sbp2 also need do this, attached patch will fix sbp2 rmmod
hang, But not tested.

-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=fix_sbp2_hang

--- 2.6.10-mm1-axg-swap_mem/drivers/ieee1394/sbp2.c~hang	2005-02-07 18:17:12.000000000 +0800
+++ 2.6.10-mm1-axg-swap_mem/drivers/ieee1394/sbp2.c	2005-02-07 18:17:22.000000000 +0800
@@ -2845,9 +2845,9 @@ static void __exit sbp2_module_exit(void
 {
 	SBP2_DEBUG("sbp2_module_exit");
 
-	hpsb_unregister_protocol(&sbp2_driver);
-
 	hpsb_unregister_highlevel(&sbp2_highlevel);
+
+	hpsb_unregister_protocol(&sbp2_driver);
 }
 
 module_init(sbp2_module_init);

--vkogqOf2sHV7VnPd--
