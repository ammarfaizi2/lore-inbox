Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVCWRoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVCWRoH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVCWRoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:44:07 -0500
Received: from digitalimplant.org ([64.62.235.95]:62086 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261698AbVCWRoB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:44:01 -0500
Date: Wed, 23 Mar 2005 09:43:52 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: linux-kernel@vger.kernel.org, "" <greg@kroah.com>
Subject: Re: [6/9] [RFC] Steps to fixing the driver model locking
In-Reply-To: <8764zicxzu.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.50.0503230941300.17099-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0503211245530.20647-100000@monsoon.he.net>
 <8764zicxzu.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Mar 2005, OGAWA Hirofumi wrote:

> Patrick Mochel <mochel@digitalimplant.org> writes:
>
> > +void klist_del(struct klist_node * n)
> > +{
> > +	struct klist * k = n->n_klist;
> > +
> > +	spin_lock(&k->k_lock);
> > +	klist_dec_and_del(n);
> > +	spin_unlock(&k->k_lock);
> > +}
>
> Can't we use atomic_dec_and_lock()?

No. It uses the kref_inc() and kref_dec(), which do not have the
equivalent atomic_dec_and_lock() primitives.

> [...]
>
> > +void klist_remove(struct klist_node * n)
> > +{
> > +	spin_lock(&n->n_klist->k_lock);
> > +	klist_dec_and_del(n);
> > +	spin_unlock(&n->n_klist->k_lock);
> > +	wait_for_completion(&n->n_removed);
> > +}
>
> Why isn't those going into drivers/base/?  Personally, klist seems
> drivers/base stuff rather than generic stuff...

Could be for now. I'd like to convert more of the kobject/kest mess to use
a cleaner, and rwsem-free locking mechanism, which would nearly justify it
in lib/. All in all, that change is purely cosmetic.


	Pat
