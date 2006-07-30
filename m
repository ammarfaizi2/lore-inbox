Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWG3Tg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWG3Tg6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 15:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWG3Tg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 15:36:57 -0400
Received: from [72.14.214.193] ([72.14.214.193]:13831 "EHLO
	hu-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932462AbWG3Tg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 15:36:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Y/XWlSQiAnB/z4353F9wB4YTnCU16slgRavwTT3XVZF5QQIgSewcQ1mbYTHdez3peUs/UCrsyAR7AFHDzWYOEUmk14+/3cvocGSHkeYwIXzWGEaDG2z3p+2yr07ToAvtHNFn2lC7ZoGe4BQQGGIZSA0q+qrXG6brFX11Avy3wlk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org, Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       James Morris <jmorris@namei.org>,
       Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
       Pekka Savola <pekkas@netcore.fi>, Patrick McHardy <kaber@coreworks.de>,
       netdev@vger.kernel.org
Subject: [PATCH] fix memory leak in net/ipv4/tcp_probe.c::tcpprobe_read()
Date: Sun, 30 Jul 2006 21:38:02 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607302138.02855.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's an obvious memory leak in net/ipv4/tcp_probe.c::tcpprobe_read()
We are not freeing 'tbuf' on error.
Patch below fixes that.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 net/ipv4/tcp_probe.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.18-rc3-orig/net/ipv4/tcp_probe.c	2006-07-30 13:21:53.000000000 +0200
+++ linux-2.6.18-rc3/net/ipv4/tcp_probe.c	2006-07-30 21:32:04.000000000 +0200
@@ -129,8 +129,10 @@ static ssize_t tcpprobe_read(struct file
 
 	error = wait_event_interruptible(tcpw.wait,
 					 __kfifo_len(tcpw.fifo) != 0);
-	if (error)
+	if (error) {
+		vfree(tbuf);
 		return error;
+	}
 
 	cnt = kfifo_get(tcpw.fifo, tbuf, len);
 	error = copy_to_user(buf, tbuf, cnt);



