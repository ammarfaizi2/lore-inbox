Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWAIUwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWAIUwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWAIUwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:52:20 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:42370 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751329AbWAIUwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:52:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=sKJeXUtUtSuq8pnYw1QXSWtycGqfIDkSjxb6xNOe6Yh7y3XLelxC62Fc0xYE+MYFaB0eme8u2Ft2HdcYD0fTXPyqg9fBjNFjG9HDc7tAe3S72CAoLBU12PUjr2HcxIcvWCBSjuLr200Vu7GvjNnr3Q1+76szo528ImYxYTsWLU0=
Date: Tue, 10 Jan 2006 00:09:16 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kirill Korotaev <dev@openvz.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Dmitry Mishin <dim@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: [PATCH] Fix more "if ((err = foo() < 0))" typos
Message-ID: <20060109210916.GA28806@mipter.zuzino.mipt.ru>
References: <43C27662.2030400@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C27662.2030400@openvz.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another reason to use:

	ret = foo();
	if (ret < 0)
		goto out;

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/kprobes.txt           |    3 ++-
 arch/mips/kernel/vpe.c              |    3 ++-
 drivers/media/dvb/frontends/mt312.c |    3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff -uprN linux-vanilla/Documentation/kprobes.txt linux-1/Documentation/kprobes.txt
--- linux-vanilla/Documentation/kprobes.txt	2006-01-09 16:02:19.000000000 +0300
+++ linux-1/Documentation/kprobes.txt	2006-01-09 23:59:12.000000000 +0300
@@ -411,7 +411,8 @@ int init_module(void)
 		printk("Couldn't find %s to plant kprobe\n", "do_fork");
 		return -1;
 	}
-	if ((ret = register_kprobe(&kp) < 0)) {
+	ret = register_kprobe(&kp);
+	if (ret < 0) {
 		printk("register_kprobe failed, returned %d\n", ret);
 		return -1;
 	}
diff -uprN linux-vanilla/arch/mips/kernel/vpe.c linux-1/arch/mips/kernel/vpe.c
--- linux-vanilla/arch/mips/kernel/vpe.c	2006-01-09 16:02:20.000000000 +0300
+++ linux-1/arch/mips/kernel/vpe.c	2006-01-10 00:00:35.000000000 +0300
@@ -1171,7 +1171,8 @@ static int __init vpe_module_init(void)
 		return -ENODEV;
 	}
 
-	if ((major = register_chrdev(0, module_name, &vpe_fops) < 0)) {
+	major = register_chrdev(0, module_name, &vpe_fops);
+	if (major < 0) {
 		printk("VPE loader: unable to register character device\n");
 		return major;
 	}
diff -uprN linux-vanilla/drivers/media/dvb/frontends/mt312.c linux-1/drivers/media/dvb/frontends/mt312.c
--- linux-vanilla/drivers/media/dvb/frontends/mt312.c	2006-01-09 16:02:22.000000000 +0300
+++ linux-1/drivers/media/dvb/frontends/mt312.c	2006-01-09 23:59:46.000000000 +0300
@@ -501,7 +501,8 @@ static int mt312_set_frontend(struct dvb
 	case ID_VP310:
 	// For now we will do this only for the VP310.
 	// It should be better for the mt312 as well, but tunning will be slower. ACCJr 09/29/03
-		if ((ret = mt312_readreg(state, CONFIG, &config_val) < 0))
+		ret = mt312_readreg(state, CONFIG, &config_val);
+		if (ret < 0)
 			return ret;
 		if (p->u.qpsk.symbol_rate >= 30000000) //Note that 30MS/s should use 90MHz
 		{

