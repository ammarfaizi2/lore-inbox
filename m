Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUACUPZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 15:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbUACUPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 15:15:25 -0500
Received: from users.ccur.com ([208.248.32.211]:4445 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S263772AbUACUPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 15:15:23 -0500
Date: Sat, 3 Jan 2004 15:15:15 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       albert.cahalan@ccur.com, jim.houston@ccur.com
Subject: Re: siginfo_t fracturing, especially for 64/32-bit compatibility mode
Message-ID: <20040103201515.GA4115@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <20040102194909.GA2990@rudolph.ccur.com> <20040103012433.6aa4cafb.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040103012433.6aa4cafb.ak@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I decided to do a more systematic search.

The below table summarizes all user-mode si_code values declared
and sent by either the kernel or by glibc.

Method was simple grep.  Therefore tricky uses were not accounted
for.

  code name	value	glibc-2.3.2 send-usage		2.6.1-rc2 send-usage
  ------------	------	----------------------------	--------------------
  SI_ASYNCNL	-6	si_pid, si_uid, si_value	never sent
  SI_TKILL	-6	never sent			si_pid, si_uid
  SI_SIGIO	-5	never sent			never sent
  SI_ASYNCIO	-4	si_pid, si_uid, si_value	si_addr
  SI_MESGQ	-3	never sent			never sent
  SI_QUEUE	-1	si_pid, si_uid, si_value	never sent

Observations:

  glibc only sends siginfo_t's with si_pid, si_uid, and si_value set.
  This makes trivial the conversion of 32bit user-space-originated
  siginfo_t's to the 64-bit form.

  The SI_ASYNCNL and SI_TKILL values collide but this collision is
  conversion-safe, as the fields used are compatible.  However
  applications may on occasion have trouble determining which
  subsystem sent a received siginfo_t of this type.

  SI_ASYNCIO uses are incompatible.  This prevents the kernel from
  being able to determine which fields to convert when a 64-bit
  siginfo_t of this type is to be sent to a 32-bit application.
  
  SI_SIGIO is not used by either the kernel or glibc.  This was
  somewhat suprising given the extensive coverage of SI_SIGIO in the
  man pages.

  The kernel likes to send user siginfo_t's to applications, rather
  the restrict itself to kernel siginfo_t types.  This is a misuse of
  the user-siginfo_t concept, though (so far) largely harmless.

Joe
