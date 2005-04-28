Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVD1QWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVD1QWQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 12:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVD1QWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 12:22:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55982 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262133AbVD1QWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 12:22:11 -0400
Date: Fri, 29 Apr 2005 00:25:52 +0800
From: David Teigland <teigland@redhat.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] dlm: overview
Message-ID: <20050428162552.GH10628@redhat.com>
References: <20050425151136.GA6826@redhat.com> <20050425203952.GE25002@ca-server1.us.oracle.com> <20050425210915.GX32085@marowsky-bree.de> <200504260130.17016.phillips@istop.com> <20050427135635.GA4431@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427135635.GA4431@marowsky-bree.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 03:56:35PM +0200, Lars Marowsky-Bree wrote:

> Questions which need to be settled, or which the API at least needs to
> export so we know what is expected from us:

Here's what the dlm takes from userspace:

- Each lockspace takes a list of nodeid's that are the current members
  of that lockspace.  Nodeid's are int's.  For lockspace "alpha", it looks
  like this:
  echo "1 2 3 4" > /sys/kernel/dlm/alpha/members

- The dlm comms code needs to map these nodeid's to real IP addresses.
  A simple ioctl on a dlm char device passes in nodeid/sockaddr pairs.
  e.g. dlm_tool set_node 1 10.0.0.1
  to tell the dlm that nodeid 1 has IP address 10.0.0.1

- To suspend the lockspace you'd do (and similar for resuming):
  echo 1 > /sys/kernel/dlm/alpha/stop

GFS won't be anything like that.  To control gfs file system "alpha":

- To tell it that its mount is completed:
  echo 1 > /sys/kernel/gfs/alpha/mounted

- To tell it to suspend operation while recovery is taking place:
  echo 1 > /sys/kernel/gfs/alpha/block

- To tell it to recover journal 3:
  echo 3 > /sys/kernel/gfs/alpha/recover

There's a dlm daemon in user space that works with the specific sysfs
files above and interfaces with whatever cluster infrastructure exists.
The same goes for gfs, but the gfs user space daemon does quite a lot more
(gfs-specific stuff).

In other words, these aren't external API's; they're internal interfaces
within systems that happen to be split between the kernel and user-space.

Dave

