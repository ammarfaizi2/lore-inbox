Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbUK2SM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbUK2SM7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 13:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUK2SMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 13:12:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45797 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261462AbUK2SMU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 13:12:20 -0500
Date: Mon, 29 Nov 2004 18:12:12 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ppcfix.diff
Message-ID: <20041129181210.GO26051@parcelfarce.linux.theplanet.co.uk>
References: <20041129154041.GB4616@hugang.soulinfo.com> <20041129172252.GN26051@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.53.0411291843360.9120@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0411291843360.9120@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 06:44:14PM +0100, Jan Engelhardt wrote:
> >>  	if (!cpus_empty(keepmask)) {
> >> -		cpumask_t irqdest = { .bits[0] = openpic_read(&ISR[irq]->Destination) };
> >> +		cpumask_t irqdest;
> >> +		irqdest.bits[0] = openpic_read(&ISR[irq]->Destination);
> >
> >Not an equivalent replacement.  The former means "set irqdest.bits[0] to
> ><expression> and set the rest of fields/array elements in them to zero/null".
> 
> Really? I thought zero'ing only happens for static storage.

Two different issues - behaviour when no initializer is given and behaviour
when initializer does not cover everything.

IOW,

static int a1[4];		/* all zeroes, since it's non-auto */
static int a2[4] = {1,0,0,0}	/* 1 0 0 0, we have initialized them all */
static int a3[4] = {1}		/* 1 0 0 0, missing members are zeroed */
void f(void)
{
	int b1[4];		/* undefined contents */
	int b2[4] = {1,0,0,0}	/* 1 0 0 0, we have initialized them all */
	int b3[4] = {1}		/* 1 0 0 0, missing members are zeroed */

C99 6.7.8(21) and 6.7.8(10) deal with "not covers everything" and
"no initializer at all" resp.
