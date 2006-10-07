Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932891AbWJGX0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932891AbWJGX0m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 19:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932892AbWJGX0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 19:26:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:45960 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932891AbWJGX0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 19:26:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=I3z9OjeAhc7lJVLdkuQKlRYH8X1PWIOiBGcI5Alg9fixu4Jv0S9B/Gmemb1m0JeJ1wpn1rG5bk9oLyv+jboGmaP8liN+xrKkA+ktYNi6mIO8FZ6xMRv2nPNWfX9iOO9D7EjTs+qJ+mVdEqRTxJ8lAczo5BT+Q8VgyDjrzhLZnD8=
Message-ID: <6b4e42d10610071626v22ca2dafpd88d689429313a98@mail.gmail.com>
Date: Sat, 7 Oct 2006 16:26:40 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: "Yoichi Yuasa" <yoichi_yuasa@tripeaks.co.jp>
Subject: fixed PCMCIA au1000_generic.c potential crash.
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Please find the corrected patch.
This patch fixes the following issues in drivers/pcmcia/au1000_generic.c.

1. On the error path, skt would not contain a valid value for the
first iteration (skt is masked by uninitialized automatic variable
skt) which would cause a crash.
2. does not do hw_shutdown() for 0th element of PCMCIA_SOCKET.


Applies cleanly to 2.6.18-rc6, rc7, 2.6.18, and 2.6.19-rc1
Regards,
Om.


 drivers/pcmcia/au1000_generic.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pcmcia/au1000_generic.c b/drivers/pcmcia/au1000_generic.c
index d5dd0ce..5387de6 100644
--- a/drivers/pcmcia/au1000_generic.c
+++ b/drivers/pcmcia/au1000_generic.c
@@ -351,6 +351,7 @@ struct skt_dev_info {
 int au1x00_pcmcia_socket_probe(struct device *dev, struct
pcmcia_low_level *ops, int first, int nr)
 {
        struct skt_dev_info *sinfo;
+       struct au1000_pcmcia_socket *skt;
        int ret, i;

        sinfo = kzalloc(sizeof(struct skt_dev_info), GFP_KERNEL);
@@ -365,7 +366,7 @@ int au1x00_pcmcia_socket_probe(struct de
         * Initialise the per-socket structure.
         */
        for (i = 0; i < nr; i++) {
-               struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
+               skt = PCMCIA_SOCKET(i);
                memset(skt, 0, sizeof(*skt));

                skt->socket.resource_ops = &pccard_static_ops;
@@ -438,17 +439,19 @@ #endif
        dev_set_drvdata(dev, sinfo);
        return 0;

-       do {
-               struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
+
+out_err:
+       flush_scheduled_work();
+       ops->hw_shutdown(skt);
+       while (i-- > 0) {
+               skt = PCMCIA_SOCKET(i);

                del_timer_sync(&skt->poll_timer);
                pcmcia_unregister_socket(&skt->socket);
-out_err:
                flush_scheduled_work();
                ops->hw_shutdown(skt);

-               i--;
-       } while (i > 0);
+       }
        kfree(sinfo);
 out:
        return ret;
