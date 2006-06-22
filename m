Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030430AbWFVWuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbWFVWuI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 18:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbWFVWuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 18:50:07 -0400
Received: from barracuda.s2io.com ([72.1.205.138]:46315 "EHLO
	barracuda.mail.s2io.com") by vger.kernel.org with ESMTP
	id S932668AbWFVWuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 18:50:05 -0400
X-ASG-Debug-ID: 1151013778-10070-54-0
X-Barracuda-URL: http://72.1.205.138:8000/cgi-bin/mark.cgi
X-ASG-Whitelist: Client
Reply-To: <ravinandan.arakali@neterion.com>
From: "Ravinandan Arakali" <ravinandan.arakali@neterion.com>
To: "'Andrew Morton'" <akpm@osdl.org>,
       "'Ananda Raju'" <Ananda.Raju@neterion.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <dgc@sgi.com>, <balbir@in.ibm.com>,
       <viro@zeniv.linux.org.uk>, <neilb@suse.de>, <jblunck@suse.de>,
       <tglx@linutronix.de>, <ananda.raju@neterion.com>,
       <leonid.grossman@neterion.com>, <alicia.pena@neterion.com>
X-ASG-Orig-Subj: RE: [patch 2.6.17] s2io driver irq fix
Subject: RE: [patch 2.6.17] s2io driver irq fix
Date: Thu, 22 Jun 2006 14:50:56 -0700
Message-ID: <001f01c69645$f1762740$4110100a@pc.s2io.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
In-Reply-To: <20060621211534.b740d0f8.akpm@osdl.org>
Importance: Normal
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
My understanding is that MSI-X vectors are not usually shared. We don't want
to spend cycles checking if the interrupt was indeed from our card or
another device on same IRQ.
In fact, current driver shares IRQ for the MSI case which I think is a bug.
That should also be non-shared. Our MSI handler just runs thru' the Tx/Rx
completions and returns IRQ_HANDLED. In case of IRQ sharing, we could be
falsely claiming the interrupt as our own.

Ravi

-----Original Message-----
From: netdev-owner@vger.kernel.org
[mailto:netdev-owner@vger.kernel.org]On Behalf Of Andrew Morton
Sent: Wednesday, June 21, 2006 9:16 PM
To: Ananda Raju
Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
linux-fsdevel@vger.kernel.org; dgc@sgi.com; balbir@in.ibm.com;
viro@zeniv.linux.org.uk; neilb@suse.de; jblunck@suse.de;
tglx@linutronix.de; ananda.raju@neterion.com;
leonid.grossman@neterion.com; ravinandan.arakali@neterion.com;
alicia.pena@neterion.com
Subject: Re: [patch 2.6.17] s2io driver irq fix


On Wed, 21 Jun 2006 15:50:49 -0400 (EDT)
Ananda Raju <Ananda.Raju@neterion.com> wrote:

> +	if (sp->intr_type == MSI_X) {
> +		int i;
>
> -				free_irq(vector, arg);
> +		for (i=1; (sp->s2io_entries[i].in_use == MSIX_FLG); i++) {
> +			if (sp->s2io_entries[i].type == MSIX_FIFO_TYPE) {
> +				sprintf(sp->desc[i], "%s:MSI-X-%d-TX",
> +					dev->name, i);
> +				err = request_irq(sp->entries[i].vector,
> +					  s2io_msix_fifo_handle, 0, sp->desc[i],
> +						  sp->s2io_entries[i].arg);

Is it usual to prohibit IRQ sharing with msix?

-
To unsubscribe from this list: send the line "unsubscribe netdev" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

