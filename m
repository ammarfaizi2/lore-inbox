Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272596AbVBFGuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272596AbVBFGuM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 01:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266133AbVBFGuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 01:50:12 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:1528 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S272596AbVBFGt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 01:49:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mQKYkWRnIHFJ7sdi0x81K0xbLSXY4xM31jt68QZexHFmaBE7dqVSx2+zEDlavDHBr6nrvfP+x/wlYxkK/ZLmKJYAv559FwkRYBDSp5zMEJpHTpLMQjyjGeV25RSGlxBap0fIvV2zeC3wwT8WFt3kVVuu8k6CzVNLJVb/pfZAMQE=
Message-ID: <9e473391050205224960767ad0@mail.gmail.com>
Date: Sun, 6 Feb 2005 01:49:57 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Jones <davej@redhat.com>, Jon Smirl <jonsmirl@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Intel AGP support attaching to wrong PCI IDs
In-Reply-To: <20050206060839.GA19330@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910502051745c25d6f@mail.gmail.com>
	 <20050206040526.GA2908@redhat.com>
	 <9e4733910502052158491b5ce3@mail.gmail.com>
	 <20050206060839.GA19330@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Feb 2005 01:08:40 -0500, Dave Jones <davej@redhat.com> wrote:
> Why exactly are you trying to write host bridge drivers anyway ?
> Confused.

We're trying to add sysfs attributes for identifying and controlling
legacy address spaces. Desktop x86 has just a single legacy IO/mem
address space but more advanced systems like the IA64 support multiple
ones.  See Documentation/filesystems/sysfs-pci.txt. All architectures
need to provide a consistent API to make it easier to write the user
space app (like video reset). If IA64 is the example then x86 needs to
add legacy_io/mem attributes to the host bus bridge which just passes
the accesses on without change.

Another part of this is VGA control. When there are multiple VGA
devices the bridges have to be set to route VGA appropriately. This is
a different feature than multiple legacy address spaces on the IA64.

> Another way forward (somewhat hacky in one sense, but a lot cleaner in another)
> would be to change the PCI code so that it'll load and init
> multiple drivers that claim to support the same PCI ID.
> This may cause issues for some other drivers however where
> we have an old and a new driver with ID overlap.

This problem already exits in DRM/fbdev. DRM loads like a normal
driver and binds to the PCI IDs. But if it loads and finds fbdev
already bound to the PCI IDs it goes into stealth mode and runs
without binding to the ID.

I would prefer that we stick with the one driver per ID rule and
instead sort out DRM/fbdev to coordinate more. The legacy_io/mem
support can probably be added some place in common AGP code since the
attributes need to be created on all x86 boxes.

> What are you up to?

Putting together a foundation for X on GL.  That involves reworking
video support in Linux so that X can remove all the horrible code that
plays with bridge chips and PCI config space from a user space app.
Right now the foundation is not there to allow X to remove the code.

Several things are needed:
1) Secondary card reset at boot
2) Mode setting on secondary heads - fbdev does not have this
3) A way to set modes without being root
4) Memory management coordination between fbdev/DRM when multiple scan
buffers are active
5) Mouse cursor support in fbdev
6) Fix video reset when resuming from suspend

Something that isn't required but would be nice it to fix things so
that an OOPs will be visible even if X is running.

Once DRM/fbdev is fixed mesa-solo will run on it with full features
(it already runs on fbdev/DRM with limited features).  This will bring
up a standalone OpenGL stack.

X on GL is already written and is part of the xserver project. This
will run on the standalone OpenGL stack. Combine this with Cairo/Glitz
and we have a graphics system that can compete with Windows Longhorn.

-- 
Jon Smirl
jonsmirl@gmail.com
