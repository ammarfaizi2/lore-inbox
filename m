Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317917AbSGaKOM>; Wed, 31 Jul 2002 06:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317926AbSGaKOM>; Wed, 31 Jul 2002 06:14:12 -0400
Received: from zeus.kernel.org ([204.152.189.113]:19690 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S317917AbSGaKOL>;
	Wed, 31 Jul 2002 06:14:11 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020731115818.A26329@ucw.cz> 
References: <20020731115818.A26329@ucw.cz>  <20020730225736.K7677@flint.arm.linux.org.uk> <20020730122638.A11153@ucw.cz> <20020730122918.A11248@ucw.cz> <20020730152255.A20071@ucw.cz> <20020730152342.B20071@ucw.cz> <20020730221722.A22761@ucw.cz> <20020730225736.K7677@flint.arm.linux.org.uk> <9658.1028109354@redhat.com> 
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: Re: [patch] Fix suspend of the kseriod thread 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 31 Jul 2002 11:07:21 +0100
Message-ID: <10657.1028110041@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


vojtech@suse.cz said:
>  Ok. Is the use in drivers/input/serio.c buggy? 

If it matters that the thread can miss wakeup events and sleep indefinitely 
while there's a 'SERIO_RESCAN' event pending, then yes it looks buggy.

	serio_thread()				serio_rescan()
	--------------				--------------

	serio_handle_events();
						serio->event |= SERIO_RESCAN;
						wake_up(&serio_wait);
	sleep_on(&serio_wait);

	...sleeps...

If both serio_thread() and serio_rescan() hold the BKL you're OK. It looks 
like serio_rescan() doesn't, though.

> What should be it replaced with?

In general, the response 'anything but sleep_on' is considered appropriate.
Try wait_event().

--
dwmw2


