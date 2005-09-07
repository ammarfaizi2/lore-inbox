Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVIGVHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVIGVHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 17:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVIGVHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 17:07:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19132 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932258AbVIGVHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 17:07:05 -0400
Date: Wed, 7 Sep 2005 23:06:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
Subject: Re: swsusp doesn't suspend devices
Message-ID: <20050907210651.GA2878@elf.ucw.cz>
References: <431ECCE3.8080408@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431ECCE3.8080408@drzeus.cx>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It would seem that swsusp doesn't properly suspend devices, or more
> precisely it wakes them up again before suspending the machine.

Yes, and that's okay.

 What happens to devices during swsusp? They seem to be resumed
during system suspend?

A: That's correct. We need to resume them if we want to write image to
disk. Whole sequence goes like

      Suspend part
      ~~~~~~~~~~~~
      running system, user asks for suspend-to-disk

      user processes are stopped

      suspend(PMSG_FREEZE): devices are frozen so that they don't
interfere
                      with state snapshot

      state snapshot: copy of whole used memory is taken with
interrupts disabled

      resume(): devices are woken up so that we can write image to
swap

      write image to swap

      suspend(PMSG_SUSPEND): suspend devices so that we can power off

      turn the power off

      Resume part
      ~~~~~~~~~~~
      (is actually pretty similar)

      running system, user asks for suspend-to-disk

      user processes are stopped (in common case there are none, but
with resume-from-initrd, noone k\nows)

      read image from disk

      suspend(PMSG_FREEZE): devices are frozen so that they don't
interfere
                      with image restoration

      image restoration: rewrite memory with image

      resume(): devices are woken up so that system can continue

      thaw all user processes

-- 
if you have sharp zaurus hardware you don't need... you know my address
