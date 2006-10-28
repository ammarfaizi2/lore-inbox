Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWJ1K2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWJ1K2O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 06:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWJ1K2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 06:28:13 -0400
Received: from sp604001mt.neufgp.fr ([84.96.92.60]:34809 "EHLO Smtp.neuf.fr")
	by vger.kernel.org with ESMTP id S1751159AbWJ1K2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 06:28:12 -0400
Date: Sat, 28 Oct 2006 12:28:12 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [take21 1/4] kevent: Core files.
In-reply-to: <11619654011980@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Message-id: <454330BC.9000108@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
References: <11619654011980@2ka.mipt.ru>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+/*
+ * Called under kevent_user->ready_lock, so updates are always protected.
+ */
+int kevent_user_ring_add_event(struct kevent *k)
+{
+	unsigned int pidx, off;
+	struct kevent_mring *ring, *copy_ring;
+	
+	ring = k->user->pring[0];
+
+	if ((ring->kidx + 1 == ring->uidx) ||
+			((ring->kidx + 1 == KEVENT_MAX_EVENTS) && ring->uidx == 0)) {
+		if (k->user->overflow_kevent == NULL)
+			k->user->overflow_kevent = k;
+		return -EAGAIN;
+	}
+


I really dont understand how you manage to queue multiple kevents in the 
'overflow list'. You just queue one kevent at most. What am I missing ?



> +
> +	for (i=0; i<KEVENT_MAX_PAGES; ++i) {
> +		u->pring[i] = (struct kevent_mring *)__get_free_page(GFP_KERNEL);
> +		if (!u->pring[i])
> +			break;
> +	}
> +
> +	if (i != KEVENT_MAX_PAGES)
> +		goto err_out_free;

Why dont you use goto directly ?

	if (!u->pring[i])
		goto err_out_free;




> +
> +	u->pring[0]->uidx = u->pring[0]->kidx = 0;
> +
> +	return 0;
> +
> +err_out_free:
> +	for (i=0; i<KEVENT_MAX_PAGES; ++i) {
> +		if (!u->pring[i])
> +			break;
> +
> +		free_page((unsigned long)u->pring[i]);
> +	}
> +	return k;
> +}
> +




> +static int kevent_user_ctl_add(struct kevent_user *u, unsigned int num, void __user *arg)
> +{
> +	int err, cerr = 0, knum = 0, rnum = 0, i;
> +	void __user *orig = arg;
> +	struct ukevent uk;
> +
> +	mutex_lock(&u->ctl_mutex);
> +
> +	err = -EINVAL;
> +	if (num > KEVENT_MIN_BUFFS_ALLOC) {
> +		struct ukevent *ukev;
> +
> +		ukev = kevent_get_user(num, arg);
> +		if (ukev) {
> +			for (i = 0; i < num; ++i) {
> +				err = kevent_user_add_ukevent(&ukev[i], u);
> +				if (err) {
> +					kevent_stat_im(u);
> +					if (i != rnum)
> +						memcpy(&ukev[rnum], &ukev[i], sizeof(struct ukevent));
> +					rnum++;
> +				} else
> +					knum++;


Why are you using/counting knum ?



> +			}
> +			if (copy_to_user(orig, ukev, rnum*sizeof(struct ukevent)))
> +				cerr = -EFAULT;
> +			kfree(ukev);
> +			goto out_setup;
> +		}
> +	}
> +
> +	for (i = 0; i < num; ++i) {
> +		if (copy_from_user(&uk, arg, sizeof(struct ukevent))) {
> +			cerr = -EFAULT;
> +			break;
> +		}
> +		arg += sizeof(struct ukevent);
> +
> +		err = kevent_user_add_ukevent(&uk, u);
> +		if (err) {
> +			kevent_stat_im(u);
> +			if (copy_to_user(orig, &uk, sizeof(struct ukevent))) {
> +				cerr = -EFAULT;
> +				break;
> +			}
> +			orig += sizeof(struct ukevent);
> +			rnum++;
> +		} else
> +			knum++;
> +	}
> +
> +out_setup:
> +	if (cerr < 0) {
> +		err = cerr;
> +		goto out_remove;
> +	}
> +
> +	err = rnum;
> +out_remove:
> +	mutex_unlock(&u->ctl_mutex);
> +
> +	return err;
> +}
