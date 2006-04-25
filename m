Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWDYDIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWDYDIW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 23:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWDYDIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 23:08:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932095AbWDYDIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 23:08:21 -0400
Date: Mon, 24 Apr 2006 20:06:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com, hzhong@gmail.com
Subject: Re: [PATCH] Profile likely/unlikely macros
Message-Id: <20060424200657.0af43d6a.akpm@osdl.org>
In-Reply-To: <200604250257.k3P2vlEb012502@dwalker1.mvista.com>
References: <200604250257.k3P2vlEb012502@dwalker1.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker <dwalker@mvista.com> wrote:
>
>  +	if (likeliness->type & LIKELY_UNSEEN) {
>  +		if (atomic_dec_and_test(&likely_lock)) {
>  +			if (likeliness->type & LIKELY_UNSEEN) {
>  +				likeliness->type &= (~LIKELY_UNSEEN);
>  +				likeliness->next = likeliness_head;
>  +				likeliness_head = likeliness;
>  +			}
>  +		}
>  +		atomic_inc(&likely_lock);

hm, good enough I guess.  It does need a comment explaining why we
don't just do spin_lock().

It'd be a bit saner to do

	if (!test_and_set_bit(&foo, 0)) {
		...
		clear_bit(&foo, 0);
	}

