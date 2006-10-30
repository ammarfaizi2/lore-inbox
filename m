Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbWJ3O50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbWJ3O50 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbWJ3O50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:57:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13499 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964977AbWJ3O5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:57:25 -0500
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
From: Arjan van de Ven <arjan@infradead.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Mark Lord <liml@rtr.ca>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
In-Reply-To: <20061030144315.GG4563@kernel.dk>
References: <45460D52.3000404@rtr.ca>  <20061030144315.GG4563@kernel.dk>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 30 Oct 2006 15:57:19 +0100
Message-Id: <1162220239.2948.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> which has always been considered safe, while not very pretty.


actually it's different I think (based on a brief inspection of the
code, I could well be wrong): 
get_request_wait() causes a get_request() call with a GFP_NOIO gfp_mask
which perculates upto cfq_set_request() as argument.
cfq_set_request() then calls the inline cfq_get_queue() (which isn't in
the backtrace due to inlining) which does
                } else if (gfp_mask & __GFP_WAIT) {
                        /* 
                         * Inform the allocator of the fact that we will
                         * just repeat this allocation if it fails, to allow
                         * the allocator to do whatever it needs to attempt to
                         * free memory.
                         */
                        spin_unlock_irq(cfqd->queue->queue_lock);

which enables interrupts right smack in the middle of holding a whole
bunch of locks.....

so to me it looks like lockdep at least has the appearance of moaning
about a reasonably fishy situation...



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org


