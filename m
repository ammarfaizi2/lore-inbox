Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbULKIcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbULKIcA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 03:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbULKIcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 03:32:00 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:9298 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261832AbULKIb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 03:31:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=WajtO8/OfYspJVisCovRK6dvKtD5rRiKor1VHUKIGKqSDwV0NyrSiAztpnNbH/lw7os+AzxtJ+ZyTza0MpNNiyGje7Mb2885u5TCQKH+Plo0jlf8j55LsNL4MinGuvs5VDjw7KSZNtYhunrthYIuxyrXaqw6ylE6h320bWaM++E=
Message-ID: <29495f1d041211003170c94ac2@mail.gmail.com>
Date: Sat, 11 Dec 2004 00:31:57 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Kylie Hall <kjhall@us.ibm.com>
Subject: Re: [PATCH 1/1] driver: Tpm hardware enablement
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com, sailer@watson.ibm.com, leendert@watson.ibm.com,
       Emily Ratliff <emilyr@us.ibm.com>, Tom Lendacky <toml@us.ibm.com>,
       tpmdd-devel@lists.sourceforge.net
In-Reply-To: <1102611986.29492.17.camel@jo.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com>
	 <1102607309.2784.40.camel@laptop.fenrus.org>
	 <1102611986.29492.17.camel@jo.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Dec 2004 11:06:27 -0600, Kylie Hall <kjhall@us.ibm.com> wrote:
> On Thu, 2004-12-09 at 09:48, Arjan van de Ven wrote:
> 
> 
> > On Thu, 2004-12-09 at 09:25 -0600, Kylene Hall wrote:
> > > +   /* wait for status */
> > > +   add_timer(&status_timer);
> > > +   do {
> > > +           schedule();
> > > +           *data = inb(chip->base + 1);
> > > +           if ((*data & mask) == val) {
> > > +                   del_singleshot_timer_sync(&status_timer);
> > > +                   return 0;
> > > +           }
> > > +   } while (!expired);
> >
> > this is busy waiting. Can't you do it with msleep() or some such ?
> > Or like 100 iterations without delays (in case the chip returns fast),
> > and then start sleeping, but please do sleep for a real time, not just
> > yield the cpu. Powermanagement and lots of other things really like to
> > see that.
> I don't see a problem with changing the schedule to an msleep.  I'll
> change it.

Keep in mind that msleep() will ignore all signals & waitqueue events
(the latter doesn't apply here, I don't think) until the specified
number of milliseconds has gone by. msleep_interruptible() may be
preferrable, as you will then receive signals (but still not waitqueue
events). I'm actually not sure if either of these will do what you
need as the existing code does. You may just want to use
schedule_timeout() appropriately, with the remaining time you wish to
sleep for.

-Nish
