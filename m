Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752115AbWJ1KyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbWJ1KyR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 06:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbWJ1KyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 06:54:16 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:37824 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1752115AbWJ1KyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 06:54:15 -0400
Date: Sat, 28 Oct 2006 14:53:40 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Subject: Re: [take21 1/4] kevent: Core files.
Message-ID: <20061028105340.GC15038@2ka.mipt.ru>
References: <11619654011980@2ka.mipt.ru> <454330BC.9000108@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <454330BC.9000108@cosmosbay.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 28 Oct 2006 14:53:41 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 12:28:12PM +0200, Eric Dumazet (dada1@cosmosbay.com) wrote:
> +/*
> + * Called under kevent_user->ready_lock, so updates are always protected.
> + */
> +int kevent_user_ring_add_event(struct kevent *k)
> +{
> +	unsigned int pidx, off;
> +	struct kevent_mring *ring, *copy_ring;
> +	
> +	ring = k->user->pring[0];
> +
> +	if ((ring->kidx + 1 == ring->uidx) ||
> +			((ring->kidx + 1 == KEVENT_MAX_EVENTS) && ring->uidx 
> == 0)) {
> +		if (k->user->overflow_kevent == NULL)
> +			k->user->overflow_kevent = k;
> +		return -EAGAIN;
> +	}
> +
> 
> 
> I really dont understand how you manage to queue multiple kevents in the 
> 'overflow list'. You just queue one kevent at most. What am I missing ?

There is no overflow list - it is a pointer to the first kevent in the
ready queue, which was not put into ring buffer. It is an optimisation, 
which allows to not search for that position each time new event should 
be placed into the buffer, when it starts to have an empty slot.
 
> 
> >+
> >+	for (i=0; i<KEVENT_MAX_PAGES; ++i) {
> >+		u->pring[i] = (struct kevent_mring 
> >*)__get_free_page(GFP_KERNEL);
> >+		if (!u->pring[i])
> >+			break;
> >+	}
> >+
> >+	if (i != KEVENT_MAX_PAGES)
> >+		goto err_out_free;
> 
> Why dont you use goto directly ?
> 
> 	if (!u->pring[i])
> 		goto err_out_free;
> 
 
I used a fallback mode here which allowed to use smaller number of pages
for kevent ring buffer, but then decided to drop it.
So it is possible to use goto directly.
 
> >+
> >+	u->pring[0]->uidx = u->pring[0]->kidx = 0;
> >+
> >+	return 0;
> >+
> >+err_out_free:
> >+	for (i=0; i<KEVENT_MAX_PAGES; ++i) {
> >+		if (!u->pring[i])
> >+			break;
> >+
> >+		free_page((unsigned long)u->pring[i]);
> >+	}
> >+	return k;
> >+}
> >+
> 
> 
> 
> 
> >+static int kevent_user_ctl_add(struct kevent_user *u, unsigned int num, 
> >void __user *arg)
> >+{
> >+	int err, cerr = 0, knum = 0, rnum = 0, i;
> >+	void __user *orig = arg;
> >+	struct ukevent uk;
> >+
> >+	mutex_lock(&u->ctl_mutex);
> >+
> >+	err = -EINVAL;
> >+	if (num > KEVENT_MIN_BUFFS_ALLOC) {
> >+		struct ukevent *ukev;
> >+
> >+		ukev = kevent_get_user(num, arg);
> >+		if (ukev) {
> >+			for (i = 0; i < num; ++i) {
> >+				err = kevent_user_add_ukevent(&ukev[i], u);
> >+				if (err) {
> >+					kevent_stat_im(u);
> >+					if (i != rnum)
> >+						memcpy(&ukev[rnum], 
> >&ukev[i], sizeof(struct ukevent));
> >+					rnum++;
> >+				} else
> >+					knum++;
> 
> 
> Why are you using/counting knum ?
 
It should go avay. 
 
> >+			}
> >+			if (copy_to_user(orig, ukev, rnum*sizeof(struct 
> >ukevent)))
> >+				cerr = -EFAULT;
> >+			kfree(ukev);
> >+			goto out_setup;
> >+		}
> >+	}
> >+
> >+	for (i = 0; i < num; ++i) {
> >+		if (copy_from_user(&uk, arg, sizeof(struct ukevent))) {
> >+			cerr = -EFAULT;
> >+			break;
> >+		}
> >+		arg += sizeof(struct ukevent);
> >+
> >+		err = kevent_user_add_ukevent(&uk, u);
> >+		if (err) {
> >+			kevent_stat_im(u);
> >+			if (copy_to_user(orig, &uk, sizeof(struct ukevent))) 
> >{
> >+				cerr = -EFAULT;
> >+				break;
> >+			}
> >+			orig += sizeof(struct ukevent);
> >+			rnum++;
> >+		} else
> >+			knum++;
> >+	}
> >+
> >+out_setup:
> >+	if (cerr < 0) {
> >+		err = cerr;
> >+		goto out_remove;
> >+	}
> >+
> >+	err = rnum;
> >+out_remove:
> >+	mutex_unlock(&u->ctl_mutex);
> >+
> >+	return err;
> >+}
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
	Evgeniy Polyakov
