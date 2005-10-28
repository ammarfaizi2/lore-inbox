Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbVJ1Efs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbVJ1Efs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 00:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbVJ1Efs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 00:35:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15300 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965085AbVJ1Efr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 00:35:47 -0400
Date: Thu, 27 Oct 2005 21:35:15 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com,
       <stern@rowland.harvard.edu>, kuznet@ms2.inr.ac.ru
Subject: Re: Notifier chains are unsafe
Message-Id: <20051027213515.15ace616.zaitcev@redhat.com>
In-Reply-To: <mailman.1130460600.30060.linux-kernel2news@redhat.com>
References: <1130454128.3586.268.camel@linuxchandra>
	<mailman.1130460600.30060.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2005 10:48:00 +1000, Keith Owens <kaos@ocs.com.au> wrote:

> We should be able to call notifier_call_chain() from any context.  That
> includes oops, panic, NMI and other unmaskable machine check events.
> If you can call notifier_call_chain() from an unmaskable context then
> it follows that the callbacks cannot take any locks.  Locks are not
> safe in NMI context.

I understand your need, Keith, but this is impossible, as long as we
meet demands of people who want to unregister notifiers from their
own call-out functions (or other notifiers). Remember that these
functions might sleep. Obviously, those functions which your code calls
from an NMI context are written with that in mind and do not try to
allocate memory with GFP_KERNEL. However, this is not the case for
all notifier call-out functions.

I am inclined to think that we have to split the notifier interface
in two: with locked chain walk and with unlocked chain walk.
The "unlocked" version can be returned to its Linux 2.2 state,
where no locks of any sort were taken at all, even during the
registration. Keith would be using that one. The locked version
would be in use by USB and others.

The claim that unregister_reboot_notifier has not be called from the
notifier call-out was made by Leonard, who is, unfortunately, dead,
so we cannot ask if he changed his mind:
 http://www.ussg.iu.edu/hypermail/linux/kernel/0007.3/0548.html
Perhaps it's not true anymore. Also ANK appeared to observe that the
practice was unsafe anyway.

-- Pete
