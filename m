Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265387AbUEZJn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265387AbUEZJn5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 05:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265386AbUEZJn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 05:43:56 -0400
Received: from aun.it.uu.se ([130.238.12.36]:19680 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265385AbUEZJnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 05:43:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16564.26285.431229.665902@alkaid.it.uu.se>
Date: Wed, 26 May 2004 11:43:09 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: AKIYAMA Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI trigger switch support for debugging
In-Reply-To: <40B400D1.1080602@jp.fujitsu.com>
References: <40B1BEAC.30500@jp.fujitsu.com>
	<20040524023453.7cf5ebc2.akpm@osdl.org>
	<40B3F484.4030405@jp.fujitsu.com>
	<20040525184148.613b3d6e.akpm@osdl.org>
	<40B400D1.1080602@jp.fujitsu.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AKIYAMA Nobuyuki writes:
 > +int unknown_nmi_panic = 0;

It's a kernel coding standard to _not_ explicitly initialise
static-extent data to zero.

 > +/*
 > + * proc handler for /proc/sys/kernel/unknown_nmi_panic
 > + */
 > +int proc_unknown_nmi_panic(ctl_table *table, int write,
 > +                struct file *file, void __user *buffer, size_t *length)
 > +{
 > +	int old_state;
 > +
 > +	old_state = unknown_nmi_panic;
 > +	proc_dointvec(table, write, file, buffer, length);
 > +	if (!old_state == !unknown_nmi_panic)
 > +		return 0;

This conditional looks terribly obscure.
Can you simplify it or explain your intention here?

 > +	if (unknown_nmi_panic) {
 > +		if (reserve_lapic_nmi() < 0) {
 > +			unknown_nmi_panic = 0;
 > +			return -EBUSY;
 > +		} else {
 > +			set_nmi_callback(unknown_nmi_panic_callback);
 > +		}
 > +	} else {
 > +		release_lapic_nmi();

You're invoking release_lapic_nmi() in response to user
input, without having verified that _you_ had done a
reserve_lapic_nmi() before.

It looks like the code will do horrible things if the
operator invokes the sysctl incorrectly. Such errors do
happen, so code should include basic sanity checks.

/Mikael
