Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbUJaW5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUJaW5p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 17:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbUJaW5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 17:57:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63391 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261680AbUJaW5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 17:57:30 -0500
Date: Sun, 31 Oct 2004 14:57:20 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: Paulo da Silva <psdasilva@esoterica.pt>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Re: k 2.6.9: ub module causes /dev/sda and /dev/sda1 not being
 created
Message-ID: <20041031145720.448d2ee9@lembas.zaitcev.lan>
In-Reply-To: <200410312310.43557.cova@ferrara.linux.it>
References: <mailman.1099103401.11097.linux-kernel2news@redhat.com>
	<20041030091522.6f2da605@lembas.zaitcev.lan>
	<200410312310.43557.cova@ferrara.linux.it>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Oct 2004 23:10:43 +0100, Fabio Coatti <cova@ferrara.linux.it> wrote:

> Maybe this is not a problem, but it's supposed that a /dev/uba1 is created, 
> after /dev/uba, instead of sdaX? well, on my system uba is created but 
> not /dev/uba1, and I've reported below a syslog excerpt for usb flash 
> pendrive;
>[...]
> Oct 28 00:32:22 kefk kernel: uba: device 4 capacity nsec 50 bsize 512
> Oct 28 00:32:22 kefk kernel: uba: made changed
> Oct 28 00:32:22 kefk kernel: uba: device 4 capacity nsec 1024000 bsize 512
> Oct 28 00:32:22 kefk kernel: uba: device 4 capacity nsec 1024000 bsize 512
> Oct 28 00:32:22 kefk kernel:  uba: uba1
> Oct 28 00:32:22 kefk kernel:  uba: uba1
> Oct 28 00:32:22 kefk kernel: kobject_register failed for uba1 (-17)

In your case, it's a bug which needs to be fixed. It hasn't got anything to
do with usb-storage or SCSI. But I'm still trying to find an approach which
works well. The basic problem is a combination of:
1. failure to start the device before calling add_disk
2. calling check_disk_change for all opens
3. returning a failure from media_present

If any of these conditions is removed, you will not see the problem.
I tried #1 for so-called "Key Distributed on Kernel Summit", but this
is not general enough, in particular your device appears resilient to that.

#2 would require distinguishing opens coming from user level from opens
called by the partition reading code, called indirectly from do_open.
I do not see how I can do that smoothly.

#3 causes the boolean logics on flags to become too involved.

-- Pete
