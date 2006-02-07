Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbWBGU1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWBGU1L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 15:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbWBGU1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 15:27:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45976 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964881AbWBGU1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 15:27:08 -0500
Date: Tue, 7 Feb 2006 15:26:55 -0500
From: Dave Jones <davej@redhat.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] add execute_in_process_context() API
Message-ID: <20060207202655.GD24775@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-scsi <linux-scsi@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <1139342419.6065.8.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139342419.6065.8.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 02:00:19PM -0600, James Bottomley wrote:
 > +int execute_in_process_context(void (*fn)(void *data), void *data)
 > +{
 > +	struct work_queue_work *wqw;
 > +
 > +	if (!in_interrupt()) {
 > +		fn(data);
 > +		return 0;
 > +	}
 > +
 > +	wqw = kmalloc(sizeof(struct work_queue_work), GFP_ATOMIC);
 > +
 > +	if (unlikely(!wqw)) {
 > +		printk(KERN_ERR "Failed to allocate memory\n");
 > +		WARN_ON(1);
 > +		return -ENOMEM;
 > +	}
 > +
 > +	INIT_WORK(&wqw->work, execute_in_process_context_work, wqw);
 > +	wqw->fn = fn;
 > +	wqw->data = data;
 > +	schedule_work(&wqw->work);
 > +
 > +	return 1;
 > +}

After the workqueue has run, what free's wqw ?

		Dave

