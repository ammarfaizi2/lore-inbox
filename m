Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbTJOKdN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 06:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbTJOKbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 06:31:20 -0400
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:36759 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S262572AbTJOKa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 06:30:28 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [NFS] RE: [autofs] multiple servers per automount
Date: Wed, 15 Oct 2003 12:28:02 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>,
       linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>,
       linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>,
       linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>
References: <Pine.LNX.4.44.0310142131090.3044-100000@raven.themaw.net> <bmhn7t$odm$1@cesium.transmeta.com> <3F8C82EF.2010104@sun.com>
In-Reply-To: <3F8C82EF.2010104@sun.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310151228.02741.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 October 2003 01:12, Mike Waychison wrote:
> The problem still remains in 2.6 that we limit the count to 256.  I've
> attached a quick patch that I've compiled and tested.  I don't know if
> there is a better way to handle dynamic assignment of minors (haven't
> kept up to date in that realm), but if there is, then we should probably
>   use it instead.


In your patch you allocate inside the spinlock.

I would suggest to do sth. like the following:

void *local;
if (!unamed_dev_inuse) {
    local = get_zeroed_page(GFP_KERNEL);

    if (!local) 
        return -ENOMEM;
}

spinlock(&unamed_dev_lock);
mb();
if (!unamed_dev_inuse) {
    unamed_dev_inuse = local;

    /* Used globally, don't free now */
    local = NULL;
}

/* 
  Do the lookup and alloc
 */

spinunlock(&unamed_dev_lock);

/* Free page, because of race on allocation. */
if (local) 
    free_page(local);


Which will swap the pointers atomically and still alloc outside the
non-sleeping locking.


Regards

Ingo Oeser


