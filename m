Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWDAUxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWDAUxh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 15:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWDAUxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 15:53:37 -0500
Received: from gate.ebshome.net ([64.81.67.12]:5808 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S932191AbWDAUxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 15:53:37 -0500
Date: Sat, 1 Apr 2006 12:53:36 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Jan Beulich <jbeulich@novell.com>,
       linuxppc-dev@ozlabs.org
Subject: "tvec_bases too large for per-cpu data" commit broke early_serial_setup()
Message-ID: <20060401205336.GA5748@gate.ebshome.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Jan Beulich <jbeulich@novell.com>,
	linuxppc-dev@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Commit 
a4a6198b80cf82eb8160603c98da218d1bd5e104 
"[PATCH] tvec_bases too large for per-cpu data"

broke early_serial_setup() and maybe other code which uses 
init_timer() before init_timers_cpu() is called.

This commit introduced run-time initialization dependence which never 
existed before, namely, tvec_bases was always valid before this 
change, but now it's a pointer which should be initialized prior to 
use of any timer function.

If init_timer() is called before such initialization (in my case this 
happens when PPC440GX board support code calls early_serial_setup to 
register UARTs, serial8250_isa_init_ports() calls init_timer()), 
"base" field in the timer_list struct is set to NULL.

When later mod_timer() is called for such timer it hangs in 
lock_timer_base().

Rolling back this commit fixes the problem, although, this is 
obviously not a proper fix.

I don't a fix I like, so I'll leave it to people more familiar with 
this matter :)

-- 
Eugene



