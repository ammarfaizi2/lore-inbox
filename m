Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbTFKFpp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 01:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbTFKFpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 01:45:45 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:49659 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S264151AbTFKFpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 01:45:44 -0400
Subject: Re: OOPS w83781d during rmmod (2.5.70-bk1[1234])
From: Martin Schlemmer <azarah@gentoo.org>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@Stimpy.netroedge.com>
In-Reply-To: <1055224269.5280.217.camel@workshop.saharacpt.lan>
References: <20030524183748.GA3097@earth.solarsys.private>
	 <3ED8067E.1050503@paradyne.com>
	 <20030601143808.GA30177@earth.solarsys.private>
	 <20030602172040.GC4992@kroah.com>
	 <20030605023922.GA8943@earth.solarsys.private>
	 <20030605194734.GA6238@kroah.com>
	 <1055136870.5280.196.camel@workshop.saharacpt.lan>
	 <20030610054107.GA22719@earth.solarsys.private>
	 <1055224269.5280.217.camel@workshop.saharacpt.lan>
Content-Type: text/plain
Organization: 
Message-Id: <1055310242.5280.1564.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 11 Jun 2003 07:44:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 07:51, Martin Schlemmer wrote:
> On Tue, 2003-06-10 at 07:41, Mark M. Hoffman wrote:
> > * Martin Schlemmer <azarah@gentoo.org> [2003-06-09 07:34:30 +0200]:
> > > 
> > > Anyhow, Only change I have made to the w83781d driver, is one line
> > > (just tell it to that if the chip id is 0x72, its also of type
> > > w83726HF), but now (2.5.70-bk1[123]) it segfaults for me on rmmod, where
> > > it did not with 2.5.68 kernels when I still had the other board.  I will
> > > attach a oops tomorrow or such when I get home.
> > 
> > I reproduced the segfault here.  It looks like i2c_del_driver() tries
> > to call w83781d_detach_client() more than once now, partly because of
> > the safe list fix in 2.5.70-bk11.  But that function should only be
> > called for the "primary" client, not the subclients.
> > 
> > The quick/ugly patch below fixes the symptom, but maybe not the disease.
> > There might be more fundamental brokenness in the whole subclient scheme.
> > I'll keep looking when I get the chance.
> > 
> 

Nope, It does not fix it.  It basically happens when i2c_del_driver is
called for w83781d_driver.  I did add a few printk's, but it do not
seem to be anything that w83781d_detach_client does.  Rather, it
looks to be while i2c_del_driver is walking the clients for the
adapter, after it ran w83781d_detach_client for the chip (and not the
two clients).  I am assuming it grabs the client for the main chip,
calls w83781d_detach_client which then in turn free all the memory for
the main client and the two lm75 clients, return, and then check the
next client for the adapter, which happens to be one of the lm75 clients
for who we already freed the structures ....

I hope that was sort of comprehensible.  Anyhow, I will poke at it more
tonight, if thoughts, let me know.


Regards,

-- 
Martin Schlemmer


