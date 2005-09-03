Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVICULv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVICULv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 16:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVICULv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 16:11:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61931 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751263AbVICULu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 16:11:50 -0400
Subject: Re: [WATCHDOG] v2.6.13 watchdog-patches
From: Arjan van de Ven <arjan@infradead.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "P @ Draig Brady" <P@draigBrady.com>, Ben Dooks <ben-linux@fluff.org>,
       Dimitry Andric <dimitry.andric@tomtom.com>, Olaf Hering <olh@suse.de>,
       Deepak Saxena <dsaxena@plexity.net>,
       Christer Weinigel <wingel@nano-system.com>
In-Reply-To: <20050903200443.GO19487@infomag.infomag.iguana.be>
References: <20050903200443.GO19487@infomag.infomag.iguana.be>
Content-Type: text/plain
Date: Sat, 03 Sep 2005 22:11:41 +0200
Message-Id: <1125778302.3223.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.0 (++++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (4.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 SUBJ_HAS_UNIQ_ID       Subject contains a unique ID
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-03 at 22:04 +0200, Wim Van Sebroeck wrote:
> Author: Chuck Ebbert <76306.1226@compuserve.com>
> Date:   Fri Aug 19 14:14:07 2005 +0200
> 
>     [WATCHDOG] softdog-timer-running-oops.patch
>     
>     The softdog watchdog timer has a bug that can create an oops:
>     
>     1.  Load the module without the nowayout option.
>     2.  Open the driver and close it without writing 'V' before close.
>     3.  Unload the module.  The timer will continue to run...
>     4.  Oops happens when timer fires.
>     
>     Reported Sun, 10 Oct 2004, by Michael Schierl <schierlm@gmx.de>
>     
>     Fix is easy: always take a reference on the module on open.
>     Release it only when the device is closed and no timer is running.
>     Tested on 2.6.13-rc6 using the soft_noboot option.  While the
>     timer is running and the device is closed, the module use count
>     stays at 1.  After the timer fires, it drops to 0.  Repeatedly
>     opening and closing the driver caused no problems.  Please apply.


this looks ENTIRELY like the wrong solution!
Isn't it a LOT easier to just del_timer_sync() the timer from the module
exit code? Mucking with module refcounts in a driver is almost always a
sign of a bug or at least really bad design, and I think that is the
case here.....


