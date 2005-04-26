Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVDZP6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVDZP6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVDZP6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:58:47 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:10543 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261650AbVDZP6B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:58:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QDNsHCR4eiINgf8YjK1JLC11Vv8zqTzLm6OvcAv8sHrwGOTpKUMP0EtkFpZiHsMD+V83EyMLdlcpidalNUuVUGccazsjuMpf28JTn0S66iQxb+9Qk0uVLqmSIdGFxQYMfdvaJGvwfm0Sa2MY+yCHPTaZL4z+tYP0btAzzqr7C1w=
Message-ID: <d120d5000504260857cb5f99e@mail.gmail.com>
Date: Tue, 26 Apr 2005 10:57:55 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number next.
Cc: netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
In-Reply-To: <20050411125932.GA19538@uganda.factory.vocord.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evgeniy,

On 4/11/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> /*****************************************/
> Kernel Connector.
> /*****************************************/
...
> +static int cn_call_callback(struct cn_msg *msg, void (*destruct_data) (void *), void *data)
> +{
> +       struct cn_callback_entry *__cbq;
> +       struct cn_dev *dev = &cdev;
> +       int found = 0;
> +
> +       spin_lock_bh(&dev->cbdev->queue_lock);
> +       list_for_each_entry(__cbq, &dev->cbdev->queue_list, callback_entry) {
> +               if (cn_cb_equal(&__cbq->cb->id, &msg->id)) {
> +                       __cbq->cb->priv = msg;
> +
> +                       __cbq->ddata = data;
> +                       __cbq->destruct_data = destruct_data;
> +
> +                       queue_work(dev->cbdev->cn_queue, &__cbq->work);

It looks like there is a problem with the code. As far as I can see
there is only one cn_callback_entry associated with each callback. So,
if someone sends netlink messages with the same id at a high enough
rate (so cbdev's work queue does not get a chance to get scheduled and
process pending requests) ddata and the destructor will be overwritten
which can lead to memory leaks and non-delivery of some messages.

Am I missing something?

-- 
Dmitry
