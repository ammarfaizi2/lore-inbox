Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTLIKyx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 05:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbTLIKxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 05:53:02 -0500
Received: from maclaurence.math.u-psud.fr ([129.175.50.15]:55424 "EHLO
	perso.free.fr") by vger.kernel.org with ESMTP id S262762AbTLIKwl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 05:52:41 -0500
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Tue, 9 Dec 2003 11:36:07 +0100
User-Agent: KMail/1.5.4
Cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312091136.07183.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is another solution by the way, which involves changes in the core:
make dev->serialize into a read/write semaphore, and have disconnect
be called with a READ lock taken on dev->serialize.  Then in usbfs, I can
take a read lock on dev->serialize whenever I want to rummage around
in the device configuration.  This way things can be left as they are (i.e.
keep ps->devsem) and deadlock will not occur as long as usbfs only
takes read locks on dev->serialize.  Of course calls to usb_set_configuration
may deadlock as now unless you drop ps->devsem before calling, but I'm
sure this can be dealt with (this is because it needs a write lock on
dev->serialize).  I quite like this solution because it makes
things more robust: as long as device drivers only take a read lock on
dev->serialize, they should not deadlock for this reason.  (These deadlock
possibilities are a fundamental problem because drivers call into the
core (which makes itself atomic using dev->serialize and friends), but
the core also calls back into drivers via disconnect methods which it
wants to make atomic by holding the same lock).

Ciao,

Duncan.
