Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbUK2RW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbUK2RW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 12:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUK2RW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 12:22:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30430 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261289AbUK2RW4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 12:22:56 -0500
Date: Mon, 29 Nov 2004 17:22:52 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: hugang@soulinfo.com
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: ppcfix.diff
Message-ID: <20041129172252.GN26051@parcelfarce.linux.theplanet.co.uk>
References: <20041129154041.GB4616@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129154041.GB4616@hugang.soulinfo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 11:40:41PM +0800, hugang@soulinfo.com wrote:
>  	if (!cpus_empty(keepmask)) {
> -		cpumask_t irqdest = { .bits[0] = openpic_read(&ISR[irq]->Destination) };
> +		cpumask_t irqdest;
> +		irqdest.bits[0] = openpic_read(&ISR[irq]->Destination);

Not an equivalent replacement.  The former means "set irqdest.bits[0] to
<expression> and set the rest of fields/array elements in them to zero/null".
The latter leaves everything except irqdest.bits[0] undefined.

Short version of the story: out of
a)	cpumask_t irqdest = { .bits[0] = foo() };
b)	cpumask_t irqdest = { .bits = {[0] = foo()} };
c)	cpumask_t irqdest;
	irqdest.bits[0] = foo();
we have
        valid C89  OK for 2.95  OK for 3.x  valid C99  initializes everything
(a)     no         no           yes         yes        yes
(b)     no         yes          yes         yes        yes
(c)     yes        yes          yes         yes        no

IOW, 2.95 implements only a precursor to C99 initializer syntax and that's
why (a) gives an error.  Proper fix is (b) - replace the line in question
with
             cpumask_t irqdest = { .bits = {[0] = openpic_read(&ISR[irq]->Destination)} };
