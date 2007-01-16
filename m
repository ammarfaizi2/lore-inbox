Return-Path: <linux-kernel-owner+w=401wt.eu-S1750847AbXAPSgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbXAPSgv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 13:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbXAPSgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 13:36:51 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:38357 "HELO
	smtp110.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750847AbXAPSgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 13:36:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=0m6IK3fXn5onpoEBekZqYcs7yHK/EeZ425uOXOHbHaO2ck3RrZfGmPNhKxlAYeWIhlcJO5Xo5pOut4cc/Xe2FBHbzjyMUiWf/wYfQ5zitvhNNiYZXj3vZXWrVr5ZBXPEpx/TPAq3RT5vPeiS1MZFXYRoF5SZ7BsoDDFhKweNMGQ=  ;
X-YMail-OSG: fcEJhzgVM1kC6Z1d1Vu3_3wTlB0F4UcJO2KA5ZOeTFE_wdaOH_QPVBaDYOnczz9slnSHhLRUtMBYfgne8.HtMddgMypYjQj..pyHFDgAI959XiUnf4x6I2pQZDY6jrJEM_22pBoTrQg23XBey.QAiwIdNweonyK.bEaDF..CYEjHrVwDK1RPvw6dQdZH
From: David Brownell <david-b@pacbell.net>
To: "Nate Diller" <nate.diller@gmail.com>
Subject: Re: [PATCH -mm 9/10][RFC] aio: usb gadget remove aio file ops
Date: Tue, 16 Jan 2007 10:36:42 -0800
User-Agent: KMail/1.7.1
Cc: "Nate Diller" <nate@agami.com>, "Andrew Morton" <akpm@osdl.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       "Benjamin LaHaise" <bcrl@kvack.org>,
       "Alexander Viro" <viro@zeniv.linux.org.uk>,
       "Suparna Bhattacharya" <suparna@in.ibm.com>,
       "Kenneth W Chen" <kenneth.w.chen@intel.com>,
       "David Brownell" <dbrownell@users.sourceforge.net>,
       "Christoph Hellwig" <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, linux-aio@kvack.org,
       xfs-masters@oss.sgi.com
References: <20070116015450.9764.62432.patchbomb.py@nate-64.agami.com> <200701152205.46089.david-b@pacbell.net> <5c49b0ed0701160113i8866879y3a134461c4ae7974@mail.gmail.com>
In-Reply-To: <5c49b0ed0701160113i8866879y3a134461c4ae7974@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701161036.45771.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 January 2007 1:13 am, Nate Diller wrote:
> On 1/15/07, David Brownell <david-b@pacbell.net> wrote:
> > What's needed is an async, non-sleeeping, interface ... with I/O
> > overlap.  That's antithetical to using read()/write() calls, so
> > your proposed approach couldn't possibly work.
> 
> haha, wow ok you convinced me :)

Good.  :)


> I got a bit impatient when I was working on this, it took some time
> just to figure out the intention of the code, and I'm trying to hold
> to a bit of a schedule here.  Without any clear (to me) reason, I
> didn't want to spend a lot of effort fixing this up.

Thing is, it's not OK to break other subsystems like that.

 
> There's really no big difference between the usb drivers here and the
> disk I/O scheduler queue, AFAICT,

The disk scheduler queue is more complex, as I understand things,
since it can combine operations.  For USB, "combining" would break
essential semantics relied on by both sides of the transaction.

Maybe the best way to view this is to accept that with USB, all
scheduler operations (e.g. for bandwidth reservation management)
are out of scope of the AIO request model.  AIO requests are no
more (or less) than "append this to the endpoint's I/O queue",
with the (host side) I/O scheduling handled separately.


> so it seems like the solution I want 
> is to do a kmap() on the user buffer and then do the I/O straight out
> of that.  That will eliminate the need for the bounce buffer.  I'll
> post a new version along with the iodesc changes later this week.

Sounds more complex, but it would be nice to have that code become
zero-copy instead of single-copy.  That'd let some platforms work
with high bandwidth ISO from userspace, which previously would not
have had enough CPU bandwidth.  ("High bandwidth" means sustained
8-24 MByte/sec data streaming.  Processing pixels at that rate may
require a companion DSP...)  Testing will be different issue though.

- Dave
