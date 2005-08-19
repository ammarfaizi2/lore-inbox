Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932710AbVHSUad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbVHSUad (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 16:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbVHSUad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 16:30:33 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:2791 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932687AbVHSUac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 16:30:32 -0400
Date: Fri, 19 Aug 2005 13:29:54 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Patrick Mansfield <patmans@us.ibm.com>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata error handling
Message-ID: <20050819202954.GA22563@us.ibm.com>
References: <20050729050654.GA10413@havoc.gtf.org> <20050807054850.GA13335@htj.dyndns.org> <430556BF.5070004@pobox.com> <4306290B.6080608@adaptec.com> <20050819193853.GA1549@us.ibm.com> <43063B03.8050008@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43063B03.8050008@adaptec.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov <luben_tuikov@adaptec.com> wrote:
> On 08/19/05 15:38, Patrick Mansfield wrote:
> The eh_timed_out + eh_strategy_handler is actually pretty perfect,
> and _complete_, for any application and purpose in recovering a
> LU/device/host (in that order ;-) ).
> 
> > The two problems I see with the hook are:
> > 
> > It calls the driver in interrupt context, so the called function can't
> > sleep.
> 
> Consider this: When SCSI Core told you that the command timed out,
> 	A) it has already finished,
> 	B) it hasn't already finished.
> 
> In case A, you can return EH_HANDLED.  In case B, you return
> EH_NOT_HANDLED, and deal with it in the eh_strategy_handler.
> (Hint: you can still "finish" it from there.)
> 

But dealing with it in the eh_strategy_handler means that you may be
stopping all IO on the host instance as the first lun returns
EH_NOT_HANDLED for LUN based canceling.

I still think we can do better here for an LLDD that cannot execute a
cancel in interrupt context.

Having a error handler that works is a plus, I would hope that
some factoring would happen over time from the eh_strategy_handler to
some transport (or other factor point) error handler. I would think from a
testing, support, and block level multipath predictability sharing code
would be a good goal.

-andmike
--
Michael Anderson
andmike@us.ibm.com
