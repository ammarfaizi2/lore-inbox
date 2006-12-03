Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760113AbWLCV1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760113AbWLCV1U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 16:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760126AbWLCV0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 16:26:55 -0500
Received: from smtp.osdl.org ([65.172.181.25]:23444 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1760107AbWLCV0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 16:26:45 -0500
Date: Sun, 3 Dec 2006 13:26:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: minyard@acm.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Rocky Craig <rocky.craig@hp.com>
Subject: Re: [PATCH 11/12] IPMI: Fix BT long busy
Message-Id: <20061203132636.a7ac969d.akpm@osdl.org>
In-Reply-To: <20061202043921.GG30531@localdomain>
References: <20061202043921.GG30531@localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2006 22:39:21 -0600
Corey Minyard <minyard@acm.org> wrote:

> 
> The IPMI BT subdriver has been patched to survive "long busy"
> timeouts seen during firmware upgrades and resets.  The patch
> never returns the HOSED state, synthesizes response messages with
> meaningful completion codes, and recovers gracefully when the
> hardware finishes the long busy.  The subdriver now issues a "Get BT
> Capabilities" command and properly uses those results.
> More informative completion codes are returned on error from
> transaction starts; this logic was propogated to the KCS and
> SMIC subdrivers.  Finally, indent and other style quirks were
> normalized.
> 
> ...
>
> +	BT_CONTROL(BT_CLR_WR_PTR);	/* always reset */

argh.

#define BT_STATUS	bt->io->inputb(bt->io, 0)
#define BT_CONTROL(x)	bt->io->outputb(bt->io, 0, x)

#define BMC2HOST	bt->io->inputb(bt->io, 1)
#define HOST2BMC(x)	bt->io->outputb(bt->io, 1, x)

#define BT_INTMASK_R	bt->io->inputb(bt->io, 2)
#define BT_INTMASK_W(x)	bt->io->outputb(bt->io, 2, x)

Please don't write macros which require that the caller have a particular
local variable of a particular name.

In fact, please don't write macros.

All the above would be perfectly nice as

static inline void bt_control(struct si_sm_data *bt, int val)
{
	bt->io->outputb(bt->io, val);
}


