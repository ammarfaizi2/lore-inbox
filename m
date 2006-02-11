Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWBKWCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWBKWCw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 17:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWBKWCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 17:02:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60820 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750749AbWBKWCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 17:02:51 -0500
Date: Sat, 11 Feb 2006 14:02:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [git patch review 1/4] IPoIB: Don't start send-only joins while
 multicast thread is stopped
Message-Id: <20060211140209.57af1b16.akpm@osdl.org>
In-Reply-To: <1139689341370-68b63fa9b8e76d91@cisco.com>
References: <1139689341370-68b63fa9b8e76d91@cisco.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rolandd@cisco.com> wrote:
>
>  +	spin_lock_irq(&priv->lock);
>  +	set_bit(IPOIB_MCAST_STARTED, &priv->flags);
>  +	spin_unlock_irq(&priv->lock);

Strange to put a lock around an atomic op like that.

Sometimes it's valid.   If another cpu was doing:

	spin_lock(lock);

	if (test_bit(IPOIB_MCAST_STARTED))
		something();
	...
	if (test_bit(IPOIB_MCAST_STARTED))
		something_else();

	spin_unlock(lock);

then the locked set_bit() makes sense.

But often it doesn't ;)
