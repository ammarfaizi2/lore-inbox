Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbVKTPiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVKTPiF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 10:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVKTPiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 10:38:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32187 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751251AbVKTPiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 10:38:03 -0500
Subject: Re: I made a patch and would like feedback/testers
	(drivers/cdrom/aztcd.c)
From: Arjan van de Ven <arjan@infradead.org>
To: Daniel =?ISO-8859-1?Q?Marjam=E4ki?= <daniel.marjamaki@comhem.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43809652.8000904@comhem.se>
References: <43809652.8000904@comhem.se>
Content-Type: text/plain
Date: Sun, 20 Nov 2005 16:38:00 +0100
Message-Id: <1132501080.2857.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   static void op_ok(void)
>   {
> -	aztTimeOutCount = 0;
> +	aztTimeOut = jiffies + 2;
>   	do {
>   		aztIndatum = inb(DATA_PORT);
> -		aztTimeOutCount++;
> -		if (aztTimeOutCount >= AZT_TIMEOUT) {
> +		if (time_after(jiffies, aztTimeOut)) {
>   			printk("aztcd: Error Wait OP_OK\n");
>   			break;
>   		}
> +		schedule_timeout_interruptible(1);

this I think is not quite right; schedule_timeout_*() doesn't do
anything unless you set current->state to something. And at that point
you might as well start using msleep()!


but what you're doing is generally a good idea; busy waits as the
original code did is quite wrong...


