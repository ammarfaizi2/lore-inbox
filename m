Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbTJAGgK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 02:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTJAGgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 02:36:10 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:38278 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261996AbTJAGgH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 02:36:07 -0400
Date: Wed, 1 Oct 2003 07:35:45 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Klaus Dittrich <kladit@t-online.de>,
       linux mailing-list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, "Hu, Boris" <boris.hu@intel.com>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: 2.6.0-test6 oops futex"
Message-ID: <20031001063545.GG1131@mail.shareable.org>
References: <Pine.LNX.4.44.0309302141220.4388-100000@localhost.localdomain> <20031001054619.976472C105@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001054619.976472C105@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> +again:
> +	key = q->key;
> +	bh = hash_futex(&key);
>  	spin_lock(&bh->lock);
> +	if (unlikely(!match_futex(&key, q->key)) {
> +		/* Race against futex_requeue */
> +		spin_unlock(&bh_lock);
> +		goto again;
> +	}

Bug:

	1. key = q->key copies bad key, while it is being changed.

	2. That makes the spin_lock() irrelevant.

	3. match_futex() compares word by word against another bad
	   key, while it is being changed again (by a second futex_requeue).

	4. It can match even though the key is wrong.

For example, say the first requeue changes q->key from (1,2) to (3,4).
key = q->key could read (1,4).

Say the second requeue changes q->key from (3,4) to (1,5).
match_futex() could read (1,4) and pass the test, even though (1,4)
is never a valid key.

-- Jamie
