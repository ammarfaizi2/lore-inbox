Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267691AbTAGTcl>; Tue, 7 Jan 2003 14:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267689AbTAGTcG>; Tue, 7 Jan 2003 14:32:06 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:55540 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S267688AbTAGTcD>; Tue, 7 Jan 2003 14:32:03 -0500
Date: Tue, 7 Jan 2003 12:40:16 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] High-speed data relay filesystem
Message-ID: <20030107124016.Z31555@schatzie.adilger.int>
Mail-Followup-To: Karim Yaghmour <karim@opersys.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3E1B17DF.BCC51B3@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E1B17DF.BCC51B3@opersys.com>; from karim@opersys.com on Tue, Jan 07, 2003 at 01:09:35PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 07, 2003  13:09 -0500, Karim Yaghmour wrote:
> The main idea behind the relayfs is that every data flow is put into
> a separate "channel" and each channel is a file. In practice, each
> channel is a separate memory buffer allocated from within kernel
> space upon channel instantiation. Software needing to relay
> data to user space would open a channel or a number of channels,
> depending on its needs, and would log data to that channel. All
> the buffering and locking mechanics are taken care of by the
> relayfs.

We were going to do exactly the same thing for Lustre.  We already have
a circular buffer in the kernel for keeping our debug logs (when debugging
is enabled), which sounds a lot like what you describe for relayfs.  We
were going to export this as a file in /proc whose size just keeps growing.
Flushing _everything_ to userspace via printk is _way_ to slow, but keeping
it in a kernel buffer only for use when we hit a problem at least gives us
acceptable performance with debugging enabled.

The main drawback is that our 5MB buffer fills in about 1 second on a
fast machine, so if we had an efficient file interface to user-space
like relayfs we might be able to keep up and collect longer traces, or
we might just be better off writing the logs directly to a file from
the kernel to avoid 2x crossing of user-kernel interface.  I wonder if
we mmap the relayfs file and write with O_DIRECT if that would be zero
copy from kernel space to kernel space, or if it would just blow up?

In any case, having relayfs would probably allow us to remove a bunch
of excess baggage from our code.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

