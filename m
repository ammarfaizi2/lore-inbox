Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbVKPPEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbVKPPEJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbVKPPEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:04:09 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:57838 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030358AbVKPPEH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:04:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SetuVvOpc0TRsun6fFdZFHu9wf9o9d/oSWMbcvT3tcMaW3usNNwxGxQu+skD0o6RhgqJ2sytPp8elcDQ425JZmDg/WntflwD3Q/9dyVJ1VtYOPAQKhuzryfLeXuvhXhtw5C++L0vZRJQ89SKKEoLfumgDQdJVuTXukhHzVReaNQ=
Message-ID: <58cb370e0511160704w4803a085h7bd6ab352d8c94e6@mail.gmail.com>
Date: Wed, 16 Nov 2005 16:04:05 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
Cc: Mike Christie <michaelc@cs.wisc.edu>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20051116124035.GX7787@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051114195717.GA24373@havoc.gtf.org>
	 <20051115074148.GA17459@htj.dyndns.org> <4379AA5B.1060900@pobox.com>
	 <4379B28E.9070708@gmail.com> <4379C062.3010302@pobox.com>
	 <20051115120016.GD7787@suse.de> <437A2814.1060308@cs.wisc.edu>
	 <20051115184131.GJ7787@suse.de> <20051116124035.GX7787@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/05, Jens Axboe <axboe@suse.de> wrote:

> I updated that patch, and converted IDE and SCSI to use it. See the
> results here:
>
> http://brick.kernel.dk/git/?p=linux-2.6-block.git;a=shortlog;h=blk-softirq

I like it but:

* "we know it's either an FS or PC request" assumption in
  ide_softirq_done() is really wrong
* same with "uptodate = rq->errors"
* blk_complete_request() is called with ide_lock hold but
  ide_softirq_done() also takes ide_lock - is this correct?

"There's still room for improvement, as __ide_end_request() really
could drop the lock after getting HWGROUP->rq (why does it need to
hold it in the first place? If ->rq access isn't serialized, we are
screwed anyways)."

ide_preempt?  and yes we are screwed...

Bartlomiej
