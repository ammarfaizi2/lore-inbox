Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbTDQV3e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 17:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbTDQV3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 17:29:34 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:49824 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262623AbTDQV3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 17:29:33 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16031.7829.215702.474821@lepton.softprops.com>
Date: Thu, 17 Apr 2003 16:37:25 -0500
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'karim@opersys.com'" <karim@opersys.com>,
       "'Martin Hicks'" <mort@wildopensource.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>, "'hpa@zytor.com'" <hpa@zytor.com>,
       "'pavel@ucw.cz'" <pavel@ucw.cz>,
       "'jes@wildopensource.com'" <jes@wildopensource.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'wildos@sgi.com'" <wildos@sgi.com>,
       "'Tom Zanussi'" <zanussi@us.ibm.com>
Subject: RE: [patch] printk subsystems
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780C2630D5@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C780C2630D5@orsmsx116.jf.intel.com>
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Perez-Gonzalez, Inaky writes:
 > > 
 > > relayfs is there to solve the data transfer problems for the most
 > > demanding of applications. Sending a few messages here and there
 > > isn't really a problem. Sending messages/events/what-you-want-to-call-it
 > > by the thousand every second, while using as little locking as possible
 > > (lockless-logging is implemented in the case of relayfs' buffer handling
 > > routines), and providing per-cpu buffering requires a different beast.
 > 
 > Well, you are doing an IRQ lock (relay_lock_channel()), so it is not
 > lockless. Or am I missing anything here? Please let me know, I am
 > really interested on how to reduce locking in for logging to the 
 > minimal.

relayfs actually uses 2 mutually-exclusive schemes internally -
'lockless' and 'locking', depending on the availability of a cmpxchg
instruction (lockless needs cmpxchg).  If the lockless scheme is being
used, relay_lock_channel() does no locking or irq disabling of any
kind i.e. it's basically a no-op in that case.  It's only when the
'locking' scheme is in use that relay_lock_channel() does locking/irq
disabling.  Normally the lockless scheme would be in use - the locking
scheme is there mainly as a fallback, so normally relay_lock_channel()
would indeed cause no locking.

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

