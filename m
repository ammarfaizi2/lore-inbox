Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271262AbTHRGCJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 02:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271264AbTHRGCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 02:02:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:33736 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271262AbTHRGCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 02:02:05 -0400
Date: Sun, 17 Aug 2003 23:03:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stefan Foerster <stefan@stefan-foerster.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very bad interactivity with 2.6.0 and SCSI disks (aic7xxx)
Message-Id: <20030817230325.2887ca49.akpm@osdl.org>
In-Reply-To: <20030818054851.GA5252@in-ws-001.cid-net.de>
References: <20030818013243.GB21665@in-ws-001.cid-net.de>
	<20030817192103.798994d8.akpm@osdl.org>
	<20030818054851.GA5252@in-ws-001.cid-net.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Foerster <stefan@stefan-foerster.de> wrote:
>
> * Andrew Morton <akpm@osdl.org> wrote:
> > Stefan Foerster <stefan@stefan-foerster.de> wrote:
> > A kernel profile would be needed to diagnose this.  You could use
> > readprofile, but as it may be an interrupt problem, the NMI-based oprofile
> > output would be better.
> 
> Is this procedure documented anywhere?
> 

Documentation/basic_profiling.txt and oprofile.sourceforge.net.

oprofile is hard to get going and they seem to keep on changing things.

A quick primer would be:

- download the userspace tools, carefully read the INSTALL and README
  files.

- You need to do ./configure --with-kernel-support (something like that).

- build and install.


>From my notes, for a P4:

opcontrol --setup --vmlinux=/boot/vmlinux --ctr0-count=600000 --ctr0-unit-mask=1  --ctr0-event=GLOBAL_POWER_EVENTS 

For a PIII:

opcontrol --setup --vmlinux=/boot/vmlinux --ctr0-count=600000 --ctr0-event=CPU_CLK_UNHALTED

Then:

opcontrol --shutdown
rm -rf /var/lib/oprofile
opcontrol --start-daemon
opcontrol --start
<run test>
opcontrol --stop

oprofpp -l /boot/vmlinux
oprofpp -Lo /boot/vmlinux > /tmp/1


I use this script.

#!/bin/sh
sudo opcontrol --stop
sudo opcontrol --shutdown
sudo rm -rf /var/lib/oprofile
sudo opcontrol --start-daemon
sudo opcontrol --start
time $@
sudo opcontrol --stop
sudo opcontrol --shutdown

