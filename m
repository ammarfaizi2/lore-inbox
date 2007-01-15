Return-Path: <linux-kernel-owner+w=401wt.eu-S1751457AbXAOURo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbXAOURo (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 15:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbXAOURo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 15:17:44 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:34834 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbXAOURn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 15:17:43 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fcIYmJjFnjouY2e3RuL/eRmJK+VY9ldAb5Ods/J3MtVLh08KoIDwRBjIcQnhXLmcuRNOE3vbm893Y9U1tHU7uq+GGlkwsoooS8ku46+Q8VnpUOnPNMDeqZFS+ziZkfTkuRbc6IMRImtz4IIHBl92auWewrIiPaEgOw/mxtmcpsk=
Message-ID: <6bffcb0e0701151217w3b20d24q9df0a54f0a65b99@mail.gmail.com>
Date: Mon, 15 Jan 2007 21:17:30 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: tglx@linutronix.de
Subject: Re: [patch-mm] Workaround for RAID breakage
Cc: "Ingo Molnar" <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>,
       "Neil Brown" <neilb@cse.unsw.edu.au>,
       LKML <linux-kernel@vger.kernel.org>,
       "Jens Axboe" <jens.axboe@oracle.com>
In-Reply-To: <1168884220.2941.144.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6bffcb0e0701120533o609489den9ca02f42e4d4839@mail.gmail.com>
	 <20070115071747.GA31267@elte.hu>
	 <1168848513.2941.100.camel@localhost.localdomain>
	 <1168884220.2941.144.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/07, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 2007-01-15 at 09:08 +0100, Thomas Gleixner wrote:
> > > Thomas saw something similar yesterday and he the partial results that
> > > git.block (between rc2-mm1 and rc4-mm1) breaks certain disk drivers or
> > > filesystems drivers. For me it worked fine, so it must be only on some
> > > combinations. The changes to ll_rw_block.c look quite extensive.
> >
> > Yes. Jens Axboe confirmed yesterday that the plug changes broke RAID.
>
> I tracked this down and found two problems:
>
> - The new plug/unplug code does not check for underruns. That allows the
> plug count (ioc->plugged) to become negative. This gets triggered from
> various places.
>
> AFAICS this is intentional to avoid checks all over the place, but the
> underflow check is missing. All we need to do is make sure, that in case
> of ioc->plugged == 0 we return early and bug, if there is either a queue
> plugged in or the plugged_list is not empty.
>
> Jens ?
>
> - The raid1 code has no bitmap set in remount r/w. So the
> pending_bio_list gets not processed for quite a time. The workaround is
> to kick mddev->thread, so the list is processed. Not sure about that.
>
> Neil ?
>
> At least it boots and behaves normal.

Yes, it works fine now. Thanks!

>         tglx

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
