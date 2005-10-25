Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVJYOAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVJYOAn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 10:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVJYOAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 10:00:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:63680 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932149AbVJYOAm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 10:00:42 -0400
Date: Tue, 25 Oct 2005 15:00:41 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: "Schupp Roderich (extern) BenQ MD PD SWP 2 CM MCH" 
	<Roderich.Schupp.extern@mch.siemens.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Race between "mount" uevent and /proc/mounts?
Message-ID: <20051025140041.GO7992@ftp.linux.org.uk>
References: <0AD07C7729CA42458B22AFA9C72E7011C8EF@mhha22kc.mchh.siemens.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0AD07C7729CA42458B22AFA9C72E7011C8EF@mhha22kc.mchh.siemens.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2005 at 03:20:10PM +0200, Schupp Roderich (extern) BenQ MD PD SWP 2 CM MCH wrote:
> Hi,
> 
> the 2.6.13 and 2.6.14-* kernels seem susceptible to a race condition
> between the sending of a "mount" uevent and the actual mount becoming
> visible thru /proc/mounts, at least when the kernel is configured
> with voluntary preemption. 
> 
> The following scenario: 
> - system is using the HAL daemon, configured to monitor kernel uvents
> - someone (usually some kind of volume manager in response to
>   a device hotplug, but could also a manual mount) mounts a filesystem
> - "mount" uevent is emitted

... said event happens to be a piece of junk with ill-defined semantics.

> - HAL daemon reads the event, then opens and reads /proc/mounts

real useful, since
	a) we have no idea if mount() is being done in the same namespace
	b) we have no idea if mount() actually succeeds
	c) even if we manage to find a mountpoint, we have no idea if it
gets e.g. mount --move just as we'd finished reading from /prov/mounts
	d) if the goal is to see which devices are held by mounted fs,
you'll miss such things as e.g. external journals.

>   (in order to determine the corresponding mount point, since the uevent

*the* corresponding mountpoint?  Which one?  There might be any number
of those...
