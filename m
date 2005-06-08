Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVFHKRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVFHKRH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 06:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVFHKRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 06:17:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24474 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262149AbVFHKRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 06:17:04 -0400
Date: Wed, 8 Jun 2005 11:16:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Eugeny S. Mints" <emints@ru.mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: race in usbnet.c in full RT
Message-ID: <20050608101658.GA3303@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Eugeny S. Mints" <emints@ru.mvista.com>,
	Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	David Brownell <david-b@pacbell.net>
References: <42A6C6B3.2000303@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A6C6B3.2000303@ru.mvista.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 02:21:39PM +0400, Eugeny S. Mints wrote:
> in non-RT case spin_lock_irqsave (&dev->txq.lock, flags) disables 
> interrupts and thus code from usb_submit_urb() call upto 
> __skb_queue_tail (&dev->txq, skb) executes atomically. But in RT case 
> interrupts are not disabled and usb_submit_urb() triggers an interrupt 
> which may cause tx_complete() execution before __skb_queue_tail () call. 
> And since skb->list gets initialized just at __skb_queue_tail(), call to 
> tx_complete() (via defer_bh() which thus executes before 
> __skb_queue_tail) dereferences NULL (skb->list) pointer.
> 
> Thus looks tx_complete() and usbnet_start_xmit() require a 
> serialization. Please find proposed fix attached though not sure the 
> patch will apply cleanly to the latest kernel.

Please fix whatever patch you use for "full RT mode" to not break valid
assupmtions in drivers.
