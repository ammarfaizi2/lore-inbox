Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbTIOXaS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 19:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTIOXaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 19:30:18 -0400
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:9654 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id S261675AbTIOXaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 19:30:13 -0400
Date: Tue, 16 Sep 2003 01:30:08 +0200
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22: ide-scsi interfers with APM
Message-ID: <20030915233008.GA2457@darkside.22.kls.lan>
Mail-Followup-To: Mario 'BitKoenig' Holbe <Mario.Holbe@RZ.TU-Ilmenau.DE>,
	linux-kernel@vger.kernel.org
References: <20030914151352.GA1301@darkside.22.kls.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914151352.GA1301@darkside.22.kls.lan>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 05:13:52PM +0200, Mario 'BitKoenig' Holbe wrote:
> ide-scsi works fine, if CONFIG_APM=m is defined:
> it does not, if CONFIG_APM is undefined:
> 
> I have no explanation for this and no idea how to debug it
> down. Hopefully someone else is able to explain it to me.

Okay, now I'm able to explain it myself.
It's a timing issue.

After this it works well even with CONFIG_APM is undefined:

--- kernel-source-2.4.22.old/include/linux/ide.h	2003-09-15 09:49:34.000000000 +0200
+++ kernel-source-2.4.22/include/linux/ide.h	2003-09-15 21:22:57.000000000 +0200
@@ -271,7 +271,7 @@
 #if defined(CONFIG_APM) || defined(CONFIG_APM_MODULE)
 #define WAIT_READY	(5*HZ)		/* 5sec - some laptops are very slow */
 #else
-#define WAIT_READY	(3*HZ/100)	/* 30msec - should be instantaneous */
+#define WAIT_READY	(4*HZ/100)	/* 40msec - should be instantaneous */
 #endif /* CONFIG_APM || CONFIG_APM_MODULE */
 #define WAIT_PIDENTIFY	(10*HZ)	/* 10sec  - should be less than 3ms (?), if all ATAPI CD is closed at boot */
 #define WAIT_WORSTCASE	(30*HZ)	/* 30sec  - worst case when spinning up */

There were no changes from 2.4.20 to 2.4.22 (with 2.4.20
everything worked fine), so I guess, other timings changed.
I *guess* the 30msecs was a bit strong for cd-drives in
2.4.20 too (btw. it doesnt matter, if I compile ide-scsi
as module and insmod/rmmod it a few times) but worked.
Somewhere in 2.4.21 things were changed somehow that
modified the timing hardly enough to cross the border.

> Do I have to expect any other interferences like this?

IMHO some ide-proof should have a look at it to answer
this.


regards,
   Mario
-- 
Ho ho ho! I am Santa Claus of Borg. Nice assimilation all together!
