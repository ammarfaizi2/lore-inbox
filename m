Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275694AbRIZXLm>; Wed, 26 Sep 2001 19:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275692AbRIZXL0>; Wed, 26 Sep 2001 19:11:26 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:13956 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S275691AbRIZXLE>; Wed, 26 Sep 2001 19:11:04 -0400
Date: Wed, 26 Sep 2001 19:11:25 -0400
To: "Eloy A. Paris" <eloy.paris@usa.net>
Cc: webcam@smcc.demon.nl, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH -R] Re: 2.4.10 is toxic to my system when I use my USB webcam (was: More info. on crash)
Message-ID: <20010926191123.A30545@cs.cmu.edu>
Mail-Followup-To: "Eloy A. Paris" <eloy.paris@usa.net>,
	webcam@smcc.demon.nl, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
In-Reply-To: <20010926104354.A2192@antenas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010926104354.A2192@antenas>
User-Agent: Mutt/1.3.22i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 10:43:54AM -0400, Eloy A. Paris wrote:
> I have been doing some tests to determine where the problems is. The
> good news is that the problem is not in your driver. The bad news is
> that 2.4.10 is toxic to my system (at least when I try to use my
> Phillips webcam) and that the problem lies somewhere else.
> 
> Here's a quick summary of the tests I did:
> 
> (0) Stock 2.4.9: rock solid
> (1) Stock 2.4.10: system crash after device is open()'ed
> (2) 2.4.10 + pwc 8.1 (backed out pwc 8.2): system crash as in (1)
> (3) 2.4.10 + changes to usbcore.o and usb-uhci.o backed out: system
>     crash.
> (4) 2.4.9 + pwc 8.2: rock solid

It hit me as well and I found the culprit, the crash happens in
usb-uhci.c:process_iso, where the following code used to be 'safe'

	for (i = 0; p != &urb_priv->desc_list; i++) {
...
	    list_del (p);
	    p = p->next;
	    delete_desc (s, desc);
	}

However, some infidel sneaked the following change into 2.4.10, late in
the testcycle, which is deadly. This patch needs to be reverted. If the
behaviour is wanted all uses of list_del in the kernel need to be looked
at very closely.

Jan

====
diff -u --recursive --new-file v2.4.9/linux/include/linux/list.h linux/include/l
inux/list.h
--- v2.4.9/linux/include/linux/list.h   Fri Feb 16 16:06:17 2001
+++ linux/include/linux/list.h  Sun Sep 23 10:31:02 2001
@@ -90,6 +92,7 @@
 static __inline__ void list_del(struct list_head *entry)
 {
        __list_del(entry->prev, entry->next);
+       entry->next = entry->prev = 0;
 }
 
 /**

