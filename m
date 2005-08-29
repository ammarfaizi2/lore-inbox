Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbVH2Aw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVH2Aw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 20:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbVH2Aw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 20:52:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:10439 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751044AbVH2Aw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 20:52:57 -0400
Subject: Re: swsusp console change/userspace hang
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20050829002652.GA23582@srcf.ucam.org>
References: <20050829002652.GA23582@srcf.ucam.org>
Content-Type: text/plain
Date: Mon, 29 Aug 2005 10:50:31 +1000
Message-Id: <1125276632.14185.74.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-29 at 01:26 +0100, Matthew Garrett wrote:
> Hi!
> 
> I'm currently working on an entirely userspace bootsplash program. It 
> works quite happily, except in the case of resuming from hibernation. 
> The splash program is launched at the start of initramfs, and at the 
> end of initramfs (after the disk modules have been loaded) we attempt to 
> trigger resume from userspace.
> 
> The code registers a signal that's fired on VT change. If a console
> change is requested when it's currently drawing, it disables drawing and
> schedules an alarm to fire 0.1 seconds later in order to avoid switching
> the console when part-way through a framebuffer operation.
> 
> The problem seems to be that swsusp tries to change the console and then 
> immediately freezes userspace. For reasons I don't entirely understand, 
> this freezes the machine. If I remove the pm_prepare_console call from 
> pm_prepare_processes, resume functions correctly.

Hrm.. it uses pm_prepare_console(), which should wait for the console to
become active... However, it calls vt_waitactive without dealing with
-EINTR. You might be getting a signal or something, can you check what's
going on inside pm_prepare_console ?

> For now I'll probably just work around this by removing the console 
> change from our kernels (we can do that in userspace scripting instead), 
> but this still seems to be a less than ideal situation - I'm guessing 
> that the same would happen if we were displaying the splash on suspend. 
> Any ideas what might be causing this, and how to rectify it?

