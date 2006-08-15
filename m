Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWHOUjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWHOUjM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 16:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWHOUjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 16:39:12 -0400
Received: from mga03.intel.com ([143.182.124.21]:49831 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751205AbWHOUjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 16:39:08 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,128,1154934000"; 
   d="scan'208"; a="103370093:sNHT20697565"
Date: Tue, 15 Aug 2006 13:39:03 -0700
From: Mitch Williams <mitch.a.williams@intel.com>
X-X-Sender: mawilli1@mawilli1-desk2.amr.corp.intel.com
To: Bill Nottingham <notting@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: bonding: cannot remove certain named devices
In-Reply-To: <20060815194856.GA3869@nostromo.devel.redhat.com>
Message-ID: <Pine.CYG.4.58.0608151331220.3272@mawilli1-desk2.amr.corp.intel.com>
References: <20060815194856.GA3869@nostromo.devel.redhat.com>
ReplyTo: "Mitch Williams" <mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Aug 2006, Bill Nottingham wrote:

> 2.6.17-rc4+.
>
> Trivial example:
>
> # modprobe bonding (creates bond0)
> # ip link set bond0 name "a b"
> # echo "-a b" > /sys/class/net/bonding_masters
> bonding: unable to delete non-existent bond a
> bash: echo: write error: No such device
>

Yuck.  The problem here is the space in the interface name, which the
sysfs code chokes on.  The code just does

	sscanf(buffer, "%16s", command); /* IFNAMSIZ*/

and goes from there.  Because of the space, it only gets the first half of
the interface name.

Suggestions?  Do we just omit the sscanf and copy up to the newline (or
EOF)?  Should there be another delimiter here?

Are spaces allowed in interface names anyway?  I can't believe that
bonding is the only area affected by this.

-Mitch

BTW this will also break if you try to add/remove a slave with a space in
the name through sysfs.
