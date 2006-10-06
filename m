Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWJFGSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWJFGSr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 02:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWJFGSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 02:18:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:57174 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932229AbWJFGSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 02:18:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J1S7O4iRnfWkaxHNYkJVQXDLwVp08M//gGo1V3GtV42WUZOQf8YeulmjFtHZ3yWw6rMULsXGXK6MW6Cbi0o/sSEoZXyaVni9ciYgiOlkmDlPT7+nWM+ua7wqAbb+OxyYI6CA4NcZ5HsDkk/e+eSbgCTPxuLKT1SBYw/TXekk+jw=
Message-ID: <6b4e42d10610052318h53102e73h64766a7cb677be1b@mail.gmail.com>
Date: Thu, 5 Oct 2006 23:18:44 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: "Yoichi Yuasa" <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [-mm PATCH] fixed PCMCIA au1000_generic.c
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061004224406.46a9d05c.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061003001115.e898b8cb.akpm@osdl.org>
	 <20061004224406.46a9d05c.yoichi_yuasa@tripeaks.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/06, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> Hi,
>
Sorry for the late reply.
> pcmcia-au1000_generic-fix.patch has a problem.
> It needs more fix.
> ops->shutdown(skt), skt is out of definition scope.

Is it so?
After applying the patch, the code would look like,
-----

		skt->status = au1x00_pcmcia_skt_state(skt);

		ret = pcmcia_register_socket(&skt->socket);
		if (ret)
			goto out_err;
<snip>

out_err:
	flush_scheduled_work();
	ops->hw_shutdown(skt);
	while (i-- > 0) {
		struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
		del_timer_sync(&skt->poll_timer);
		pcmcia_unregister_socket(&skt->socket);
		flush_scheduled_work();
		ops->hw_shutdown(skt);
		i--;
	}
	kfree(sinfo);
-----
The  first call to ops->shutdown(skt) would free the skt (of the
function scope). The internal skt to the loop is a placeholder to call
shutdown().
Or did I miss any point?

Regards,
Om.
>
> Yoichi
>
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
>
> diff -pruN -X linux-2.6.18-mm3/Documentation/dontdiff linux-2.6.18-mm3-orig/drivers/pcmcia/au1000_generic.c linux-2.6.18-mm3/drivers/pcmcia/au1000_generic.c
> --- linux-2.6.18-mm3-orig/drivers/pcmcia/au1000_generic.c       2006-10-04 11:24:33.017136250 +0900
> +++ linux-2.6.18-mm3/drivers/pcmcia/au1000_generic.c    2006-10-04 22:32:21.806060500 +0900
> @@ -351,6 +351,7 @@ struct skt_dev_info {
>  int au1x00_pcmcia_socket_probe(struct device *dev, struct pcmcia_low_level *ops, int first, int nr)
>  {
>         struct skt_dev_info *sinfo;
> +       struct au1000_pcmcia_socket *skt;
>         int ret, i;
>
>         sinfo = kzalloc(sizeof(struct skt_dev_info), GFP_KERNEL);
> @@ -365,7 +366,7 @@ int au1x00_pcmcia_socket_probe(struct de
>          * Initialise the per-socket structure.
>          */
>         for (i = 0; i < nr; i++) {
> -               struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
> +               skt = PCMCIA_SOCKET(i);
>                 memset(skt, 0, sizeof(*skt));
>
>                 skt->socket.resource_ops = &pccard_static_ops;
> @@ -442,7 +443,7 @@ out_err:
>         flush_scheduled_work();
>         ops->hw_shutdown(skt);
>         while (i-- > 0) {
> -               struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
> +               skt = PCMCIA_SOCKET(i);
>                 del_timer_sync(&skt->poll_timer);
>                 pcmcia_unregister_socket(&skt->socket);
>                 flush_scheduled_work();
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
