Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVGPXOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVGPXOV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 19:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVGPXOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 19:14:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:44735 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261845AbVGPXOO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 19:14:14 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17113.38067.551471.862551@tut.ibm.com>
Date: Sat, 16 Jul 2005 18:13:55 -0500
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: Tom Zanussi <zanussi@us.ibm.com>, linux-kernel@vger.kernel.org,
       karim@opersys.com, varap@us.ibm.com, richardj_moore@uk.ibm.com,
       relayfs-devel@lists.sourceforge.net
Subject: Re: relayfs documentation sucks?
In-Reply-To: <20050716210759.GA1850@outpost.ds9a.nl>
References: <17107.6290.734560.231978@tut.ibm.com>
	<20050716210759.GA1850@outpost.ds9a.nl>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert writes:
 > Ok, I'm working furiously on my OLS presentation (Wednesday, 3pm, be
 > there), but I'm running into a wall with relayfs, which I intend to use to
 > convey large amounts of disk statistics towards userspace.
 > 
 > Now, I've read Documentation/filesystems/relayfs.txt many times over, and I
 > don't get it.
 > 
 > It appears there is relayfs, and 'klog' on top of that. It also appears that
 > to access relayed data from the kernel in userspace there is librelay.c.
 > 
 > On reading librelay.c, I find code sending and receiving netlink
 > messages, but relayfs.txt doesn't even contain the word netlink!

Hi,

relayfs itself only provides the buffering and file operations along
with the kernel API for clients as documented in
Documentation/filesystems/relayfs.txt.  Applications still need some
kind of communication between the kernel and user space in order to
know when data is ready and how much is ready - the relay-apps stuff
tries to make this easy to do by allowing clients to ignore all those
details.  It happens to use netlink for this, but clients can use
whatever they want to do this communication.

The klog patch just makes a couple of utility logging functions
available for use from anywhere within the kernel which allow the
client to not have to worry about whether or not there's a relayfs
channel ready to receive the data - you could just as well use
relay_write directly in say the IO function you want to trace, but
you'd have to do something like if(relay_channel) relay_write().  It
just allows you to uncondionally log regardless of whether there's a
channel ready or not.

If you just want to get something up and running without worrying
about the netlink channel and all that stuff, you can just modify the
kleak example as follows:

- apply the klog.patch

- in kleak.c, change init_relay_app("kleak", "cpu", NULL) to
init_relay_app("diskstat", "cpu", NULL).  The relayfs files will be
created as /mnt/relay/diskstat/cpu0...cpuX, if you've mounted relayfs
at /mnt/relay.

- in kleak-app.c, change

static char *kleak_filebase = "/mnt/relay/kleak/cpu";

to

static char *kleak_filebase = "/mnt/relay/diskstat/cpu";

- log the data from the kernel functions using klog() or
klog_printk().  The kleak.patch file shows how to do this for
kmalloc/kfree, just do something similar in the functions you actually
want to instrument.  You can also use klog_printk() if you want to log
as text.

Then just run the kleak app, and when it finishes, you should have a
set of files, cpu0l...cpuX in your current directory containing all
the data you've logged.

If you still have problems and would be willing to share your code,
I'd be happy to get it going myself.  Just let me know.

 > 
 > I then launched the 'kleak-app' sample program, but told it to look at
 > /relay/diskstat* instead of its own file, but it gives me unspecified
 > netlink errors.

Can you give me more details about these errors?

 > 
 > Things I need to know, and which I hope to find documented somewhere:
 > 
 > 1) Do I need to do the netlink thing?

No, the example code uses netlink, but you could use anything you want
to communicate between the kernel and daemon.

 > 2) What kind of messages do I need to send/receive?

Basically, the daemon needs to know, for a given per-cpu buffer, how
many sub-buffers have been produced and consumed, in order to know
which sections of the mmapped buffer to read.  It also needs to notify
the kernel client of how many sub-buffers it's consumed.  Basically
that's it - the rest is application management e.g. the buffer sizes
to use, when to start/stop logging, etc.

 > 3) What is the exact format userspace sees in the relayfs file? Iow, can I
 >    access that file w/o using librelay.c?

The format is whatever the client writes into it - relayfs itself
doesn't impose any format at all.  The client doesn't need librelay.c
to read the data itself - librelay.c is for managing the daemon side
of the application and writing ready data to disk as it becomes
available.  It doesn't know anything about the actual data being written.

 > 4) What are the semantics for reading from that file?

The file is a buffer broken up into sub-buffers.  The client reads the
sub-buffers it knows are ready directly from the mmapped buffer.
The file can only be mmap()ed - there is no read() available.

 > 5) When using klog, is there only one channel?

There is only one channel, which is represented in the filesytem as a
set of per-cpu files.

 > 6) does librelay.c talk to regular relayfs or to klog?

librelay.c talks to the client code in relay-app.h, which in turn uses
the relayfs kernel API to talk to relayfs.

BTW, there's also documentation in relay-app.h, don't know if you saw
that.

Hope that helps,

Tom


