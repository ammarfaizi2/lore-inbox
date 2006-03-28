Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWC1NpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWC1NpM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 08:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWC1NpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 08:45:12 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:2667 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932206AbWC1NpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 08:45:10 -0500
Date: Tue, 28 Mar 2006 15:45:06 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Valerie Henson <val.henson@intel.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: Load average calculation?
Message-ID: <20060328134506.GF6351@harddisk-recovery.com>
References: <20060328105612.GA17094@flint.arm.linux.org.uk> <20060328110637.GB16173@goober>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328110637.GB16173@goober>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 03:06:39AM -0800, Valerie Henson wrote:
> On Tue, Mar 28, 2006 at 11:56:12AM +0100, Russell King wrote:
> > 
> > So, the question becomes - should a lot of network activity contribute
> > to the system load average, thereby denying other services from
> > performing their usual business.
> 
> Another case where simply counting up all processes in D state results
> in an unreasonable load average is the "NFS server stops responding"
> case.  Even though all threads doing I/O to the NFS server are totally
> inactive until the server comes back, they are all stuck in D state -
> and counting towards the load average.

Or the other way around:

An NFS client writing 50 MB/s to a server. The NFS server keeps up with
the amount of traffic (i.e.: no "NFS server stops responding" on the
client) and manages to write the data to the disks but the load average
on the server goes to ~16 without any major CPU usage.

> What these cases have in common is interesting: in both cases, the
> thread is throttled by an external machine.  We're not waiting on I/O
> that is taking up resources locally and therefore should be counted as
> part of load average; we're waiting for some other machine to free up
> enough resources that we can push some data down the pipe.

I get the impression it's not only a network problem. You can also
increase the load by copying a large file from one disk to another (of
course using a large blocksize to eliminate a high number of syscalls),
so it looks like waiting on local I/O is the problem.

With modern disk subsystems (i.e.: anything except IDE in PIO mode) a
high IO load shouldn't really burn many CPU cycles. IMHO the load
average should account this differently.

The current load average calculation is a great way for a DoS attack
for programs that look at the load average like Exim and Sendmail: just
generate enough IO load on the machine to get the load above a certain
threshold and you will get a temporary error on SMTP. One way to do
such a thing (and effectively creating a remote DoS) is what Russell
said: lots of people downloading FC5 images through vsftpd. Vsftpd uses
sendfile() to pump out files, which (among other things) was made in
order to work around large system loads. It certainly does, but
unfortunately it's not accounted as such.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
