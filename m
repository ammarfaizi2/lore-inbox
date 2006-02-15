Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWBOVOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWBOVOS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 16:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWBOVOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 16:14:17 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:62298 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932176AbWBOVOR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 16:14:17 -0500
In-Reply-To: <20060214190909.GA20527@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@osdl.org>, heicars2@de.ibm.com,
       Horst Hummel <horst.hummel@de.ibm.com>, ihno@suse.de,
       kernel <linux-kernel@vger.kernel.org>, mschwid2@de.ibm.com
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] new dasd ioctl patchkit
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF03D42CD3.ED0C5E43-ONC1257116.0060C556-C1257116.00749AFB@de.ibm.com>
From: Stefan Weinhuber <WEIN@de.ibm.com>
Date: Wed, 15 Feb 2006 22:14:17 +0100
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 15/02/2006 22:14:17,
	Serialize complete at 15/02/2006 22:14:17
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote on 14.02.2006 20:09:09:

>  (1) devices have pretty clear ownership.  Implementing ioctls in
>      different modules means we get a very undefined API.  Given that
>      ioctls are generally deprecated adding extensions to that is
>      a bad idea.

So you are saying: 'If it's a dasd function, do it in the dasd 
driver!'. Right? 
Well, I can understand that point. As the invocation of the new 
ioctls is actually changing the behavior of a dasd device, I'm
looking into moving that part from dasd_eer into the main dasd module. 
Since this will remove the dynamic ioctl registration as well, it
will also remove the conflict with your cleanup code.

>  (4) adding new ioctls is not okay in general, you should be using
>      better APIs.

Hm, you suggested sysfs in a previous mail. Once I have moved
the eerset/eerget logic into the main dasd driver, I could provide
a sysfs interface instead of the ioctls (right now that would be
difficult).

But I'd like to know why an ioctl is so bad. I know that the ioctl
interface as such can be error prone, but in our case we just 
transfer an integer back and forth. Sysfs always struck me as an
end user interface, something that a human can use with echo and 
cat instead of specialized tools. The new ioctls however should not
be used directly, but by a tool or daemon that knows what it does
and can handle the changed behavior of the dasd device. 
Until now we have always implemented functionality like that as
ioctls (e.g. quiesce/resume, reserve/release) so the new ioctls are
more consistent with the existing interface, and I'd like to keep it
that way. 

>  (5) you're not just adding new ioctls but also add them using the
>      dynamic registration facility that I NACKed before and remove in
>      earlier sent patches, but you copletly ignored all objections
>      and just resent the patches anyway

As I said, the dynamic ioctls can be removed from my code.
(I don't want to dwell on it, but your first NACK against dasd_eer
was because it added code to compat_ioctl.c. I wasn't aware of your
discussion with Martin about the dynamic ioctls.) 

>  (6) in addition to the dynamic ioctls it's also adding a misc device,
>      leading to a totally incoherent interface.

Well, the dasd ioctl will be moved so the misc device will be the
only interface implemented by dasd_eer. 

> that's totally fine with me.  As long as we backout the bogus eer
> patch before 2.6.16 all the cleanups and even the eckd ioctl fix
> can wait.  But don't put this crappy interface into 1.6.16 and thus
> SLES10 so that applications start to rely on it.

As said above, I still prefer the ioctls over a sysfs interface.
Since the other issues do not cause interface changes I would 
prefer to keep the code in. 

Best Regards /  Mit freundlichen Grüßen

Stefan Weinhuber

-------------------------------------------------------------------
IBM Deutschland Entwicklung GmbH
Linux for zSeries Development & Services
