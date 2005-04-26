Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVDZSVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVDZSVx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 14:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVDZSVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 14:21:50 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:5900 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261702AbVDZSUJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 14:20:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G/EcQb+mEW3M1rHFiiM31e1Btl30beC0s4Hqiv48zGUehE5m3fkqqZrfqDbbAnDPnEGDqrZHToyrBcO3OSi8MDxVK8jtIQkWShYwsoWQaY1oHhXejXFbhEN0yIBkpd69wsFUogSjOaII3ASzc+neIzA0fHLdQXN6cNdPARoI3Uc=
Message-ID: <d120d50005042611203ce29dd8@mail.gmail.com>
Date: Tue, 26 Apr 2005 13:20:08 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: johnpol@2ka.mipt.ru
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number next.
Cc: netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
In-Reply-To: <20050426220713.7915e036@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
	 <d120d5000504260857cb5f99e@mail.gmail.com>
	 <20050426202437.234e7d45@zanzibar.2ka.mipt.ru>
	 <20050426203023.378e4831@zanzibar.2ka.mipt.ru>
	 <d120d50005042610342368cd72@mail.gmail.com>
	 <20050426220713.7915e036@zanzibar.2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> Yes, I found it too.
> Following patch should be the solution:
> 
> --- orig/drivers/connector/connector.c
> +++ mod/drivers/connector/connector.c
> @@ -146,13 +146,16 @@
>        spin_lock_bh(&dev->cbdev->queue_lock);
>        list_for_each_entry(__cbq, &dev->cbdev->queue_list, callback_entry) {
>                if (cn_cb_equal(&__cbq->cb->id, &msg->id)) {
> -                       __cbq->cb->priv = msg;
> +
> +                       if (!test_bit(0, &work->pending)) {
> +                               __cbq->cb->priv = msg;
> 
> -                       __cbq->ddata = data;
> -                       __cbq->destruct_data = destruct_data;
> +                               __cbq->ddata = data;
> +                               __cbq->destruct_data = destruct_data;
> 

Still not good enough - work->pending bit gets cleared when work has
been scheduled, but before executing payload. You still have the race.

-- 
Dmitry
