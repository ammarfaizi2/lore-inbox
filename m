Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbVJ2ECS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbVJ2ECS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 00:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVJ2ECR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 00:02:17 -0400
Received: from ms-smtp-03-smtplb.rdc-nyc.rr.com ([24.29.109.7]:45257 "EHLO
	ms-smtp-03.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S1750984AbVJ2ECQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 00:02:16 -0400
Subject: Re: Fw: zoran drivers: absense of locking?
From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
To: Michael Krufky <mkrufky@m1k.net>
Cc: Johannes Stezenbach <js@linuxtv.org>, Andrew Morton <akpm@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Mauro Carvalho Chehab <mauro_chehab@yahoo.com.br>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4362D420.5040809@m1k.net>
References: <20051028163219.340fa347.akpm@osdl.org>
	 <20051029013252.GC15903@linuxtv.org>  <4362D420.5040809@m1k.net>
Content-Type: text/plain
Date: Sat, 29 Oct 2005 00:02:36 -0400
Message-Id: <1130558556.2822.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I maintain the drivers. So, let's see:

On Fri, 2005-10-28 at 21:45 -0400, Michael Krufky wrote:
> >>From: Alexey Dobriyan <adobriyan@gmail.com>
> >>I've tried to read random part of a tree and now scratching my head
> >>with a question:
> >>
> >>	what protects the number and a list of registered codecs in
> >>	zoran drivers?
> >>
> >>Example: drivers/media/video/zr36050.c:
> >>
> >>	/* amount of chips attached via this driver */
> >>	static int zr36050_codecs = 0;
> >>
> >>Decremented in zr36050_unset().
> >>Checked for maximum value, used and incremented in zr36050_setup().
> >>
> >>[Assigment to 0 in zr36050_init_module is not needed. dprintk() in
> >>zr36050_cleanup_module() should be converted to BUG_ON, so I'll ignore
> >>them.]
> >>
> >>	zr36050_codecs
> >>		zr36050_unset()	= struct videocodec::unset
> >>		zr36050_setup()	= struct videocodec::setup
> >>
> >>The only place where ->unset and ->setup methods are called is
> >>drivers/media/video/videocodec.c:
> >>
> >>	zr36050_codecs
> >>		zr36050_unset()
> >>			videocodec_detach()
> >>		zr36050_setup()
> >>			videocodec_attach()
> >>
> >>Both videocodec functions are exported.
> >>
> >>No spinlocks or semaphores in sight.
> >>
> >>Does anybody know what protects the list of registered codecs in zoran
> >>drivers?

So, you're theoretically right, this is indeed a theory problem. Now, in
practice it isn't. Why? Because this isn't an actually exported
documented interface. This means two things: userspace cannot access it
(so no security issue), and other drivers than the ones I maintain won't
use it (so locking issues are limited to my own driver set).

It's an internal interface to the zoran driver (zoran_*.c / zr36067.ko).
The zoran driver uses publically exported interfaces (v4l/v4l2), and
those can be accessed from userspace. The zoran driver uses proper
locking everywhere and ensures that nothing goes wrong (or, well, so I
hope). So since the zoran driver is the only driver accessing zr36050.ko
(through videocodec.ko) and uses proper locking itself already, all's
fine in practice.

If other projects intend to use the videocodec interface, I'll consider
adding locking everywhere. But for now, it's fine, I guess.

Cheers,
Ronald

