Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753941AbWKGCCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbWKGCCc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 21:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753945AbWKGCCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 21:02:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44494 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753941AbWKGCCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 21:02:31 -0500
Date: Mon, 6 Nov 2006 17:59:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       bunk@stusta.de
Subject: Re: [patch] Regression in 2.6.19-rc microcode driver
Message-Id: <20061106175914.a9491eab.akpm@osdl.org>
In-Reply-To: <1162862427.22565.4.camel@sli10-conroe.sh.intel.com>
References: <1162822538.3138.28.camel@laptopd505.fenrus.org>
	<1162862427.22565.4.camel@sli10-conroe.sh.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2006 09:20:27 +0800
Shaohua Li <shaohua.li@intel.com> wrote:

> On Mon, 2006-11-06 at 15:15 +0100, Arjan van de Ven wrote:
> > Hi,
> > 
> > if the microcode driver is built in (rather than module) there are some,
> > ehm, interesting effects happening due to the new "call out to
> > userspace" behavior that is introduced.. and which runs too early. The
> > result is a boot hang; which is really nasty.
> > 
> > The patch below is a minimally safe patch to fix this regression for
> > 2.6.19 by just not requesting actual microcode updates during early
> > boot. (That is a good idea in general anyway)
> > 
> > The "real" fix is a lot more complex given the entire cpu hotplug
> > scenario (during cpu hotplug you normally need to load the microcode as
> > well); but the interactions for that are just really messy at this
> > point; this fix at least makes it work and avoids a full detangle of
> > hotplug.
> Yes, this is an issue which I documented in my patch. It's not a hang,
> but a long delay if you have many cpus.

Due to the timeout?  So it should come back after 10*num_online_cpus seconds?

Does Arjan have a lot of CPUs?

> Other drivers with firmware
> request have the same issue if they are built-in. Maybe we should fix
> the firmware request mechanism itself. I hope no distribution has
> microcode driver built-in.

But what would a fix look like?  I think things would work OK if all the
appropriate stuff is present in initramfs, yes?  We wouldn't want to break
that.

hm.  kobject_uevent() stupidly returns void.  If we were to fix that, is
there any reason why _request_firmware() should still wait for ten seconds
if kobject_uevent() returned a synchronous error?  (ie:
__call_usermodehelper failed?)

Answer: yes.  That won't work because request_firmware() uses
call_usermodehelper(wait=0) (iirc this bad thing was done because of
deadlock problems which were hard to fix properly).

But all it not lost - because call_usermodehelper() will use CLONE_VFORK I
_think_ we can still work out whether the child thread successfully exec'ed
a new program.  It'd take a bit of hacking on the fork() code to make that
work though.

