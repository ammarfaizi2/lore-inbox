Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265096AbUGGMrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265096AbUGGMrX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 08:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265095AbUGGMrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 08:47:23 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:30084 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265099AbUGGMrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:47:21 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6
Date: Wed, 7 Jul 2004 07:47:16 -0500
User-Agent: KMail/1.6.2
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>
References: <20040705023120.34f7772b.akpm@osdl.org> <200407070015.39507.dtor_core@ameritech.net> <20040707063733.GD21066@holomorphy.com>
In-Reply-To: <20040707063733.GD21066@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407070747.16512.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 July 2004 01:37 am, William Lee Irwin III wrote:
> On Wed, Jul 07, 2004 at 12:15:37AM -0500, Dmitry Torokhov wrote:
> > The only suspicious thing that I see is that sunzilog tries to register its
> > serio ports with spinlock held and interrupts off. I wonder if that is what
> > causing a deadlock. Could you please try applying this patch on top of the
> > changes to the drivers/Makefile that I sent earlier.
> 
> This suspicion is correct. It boots normally with the patch you posted
> to do that registration outside the interrupts-off critical section
> applied. Bootlog below.
> 

Great! I am still somewhat confused why it started locking up with sysfs
patch - even before sunzilog was calling serio_register_port with interrupts
off and serio core was downing it's serio_sem as the very first thing. Since
at the time sunzilog registers its ports no serio drivers have been registered
yet, effectively the only change introduced by sysfs patch is the call to
device_register which takes bus' subsystem rwsem and there really should not
be any congestion.

Maybe rwsems can not be touched with interrupts off? Sparc only? Everywhere?
(I know that you should not normally call functions that may sleep with
interrupts off).

-- 
Dmitry
