Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWFZMa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWFZMa7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 08:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWFZMa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 08:30:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51591 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751097AbWFZMa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 08:30:59 -0400
Subject: Re: Drivers statically linked in the wrong order
From: Arjan van de Ven <arjan@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200606261259.25959.dj@david-web.co.uk>
References: <200606261259.25959.dj@david-web.co.uk>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 14:30:55 +0200
Message-Id: <1151325055.3185.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> How can I get the I2C bus driver to be linked before the main driver? I've 
> tried re-ordering things in Makefiles, but nothing I've tried seems to make 
> any difference.

Hi,

there are 2 levels of ordering;
1) the initcall level
2) the Makefile order

at equal initcall level, the Makefile order really is the order that
matters, however... if there is not the same initcall level, then that
level overrules. 

So to your problem, you have 2 choices
1) try to fix the makefile issue some more (will fail if there are
different initcall levels)
2) Use initcall levels yourself...

see
#define core_initcall(fn)               __define_initcall("1",fn)
#define postcore_initcall(fn)           __define_initcall("2",fn)
#define arch_initcall(fn)               __define_initcall("3",fn)
#define subsys_initcall(fn)             __define_initcall("4",fn)
#define fs_initcall(fn)                 __define_initcall("5",fn)
#define device_initcall(fn)             __define_initcall("6",fn)
#define late_initcall(fn)               __define_initcall("7",fn)

in include/linux.init.h

iirc a normal module_init() is over type "device_initcall", so you can
make your must-be-last one a late_initcall(), or your "must be first" a
subsys_initcall....

(note: you can use late_initcall() and friends instead of module_init;
for the module case these get defined to be module_init() anyway, so no
need for ugly ifdefs in your drivers)

Does this help?

Greetings,
   Arjan van de Ven

