Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751830AbWJGWbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbWJGWbF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 18:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932874AbWJGWbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 18:31:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:1842 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751830AbWJGWbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 18:31:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QBPfM/1JFiPd1R33K0RJvUvayg/FtGbd2BCYxqnMZ/CrUgbjpgtM9cRX00AKdK7BKeOVrjNVh+ezdUXemDGwn41oQL4PhE0MkSYmUeBLFKeROjvVuqzQk4ftfbHw8sWO5zqhDVDPbzICUoWaXOqEa/WajLSPlRcxZ4NT1GKajQI=
Message-ID: <6b4e42d10610071531v24b09695j3842df0534905c34@mail.gmail.com>
Date: Sat, 7 Oct 2006 15:31:01 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: "Yoichi Yuasa" <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [-mm PATCH] fixed PCMCIA au1000_generic.c
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200610060731.k967Vaes094416@mbox33.po.2iij.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061003001115.e898b8cb.akpm@osdl.org>
	 <20061004224406.46a9d05c.yoichi_yuasa@tripeaks.co.jp>
	 <6b4e42d10610052318h53102e73h64766a7cb677be1b@mail.gmail.com>
	 <200610060731.k967Vaes094416@mbox33.po.2iij.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/06, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> On Thu, 5 Oct 2006 23:18:44 -0700
> "Om Narasimhan" <om.turyx@gmail.com> wrote:
>
> > On 10/4/06, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > > Hi,
> > >
> > Sorry for the late reply.
> > > pcmcia-au1000_generic-fix.patch has a problem.
> > > It needs more fix.
>         for (i = 0; i < nr; i++) {
>                 struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i); <-- 1st skt definition
> <snip>
>                 ret = pcmcia_register_socket(&skt->socket);
>                 if (ret)
>                         goto out_err;
>
>                 WARN_ON(skt->socket.sock != i);
>
>                 add_timer(&skt->poll_timer);
>         }
> <snip>
>
> out_err:
>         flush_scheduled_work();
>         ops->hw_shutdown(skt); <-- skt undeclared
I am sorry. I did not find this.
Please find the corrected patch.
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
+	struct au1000_pcmcia_socket *skt;
 	int ret, i;

 	sinfo = kzalloc(sizeof(struct skt_dev_info), GFP_KERNEL);
@@ -365,7 +366,7 @@ int au1x00_pcmcia_socket_probe(struct de
 	 * Initialise the per-socket structure.
 	 */
 	for (i = 0; i < nr; i++) {
-		struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
+		skt = PCMCIA_SOCKET(i);
 		memset(skt, 0, sizeof(*skt));

 		skt->socket.resource_ops = &pccard_static_ops;
@@ -438,17 +439,19 @@ #endif
 	dev_set_drvdata(dev, sinfo);
 	return 0;

-	do {
-		struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
+
+out_err:
+	flush_scheduled_work();
+	ops->hw_shutdown(skt);
+	while (i-- > 0) {
+		skt = PCMCIA_SOCKET(i);

 		del_timer_sync(&skt->poll_timer);
 		pcmcia_unregister_socket(&skt->socket);
-out_err:
 		flush_scheduled_work();
 		ops->hw_shutdown(skt);

-		i--;
-	} while (i > 0);
+	}
 	kfree(sinfo);
 out:
 	return ret;
