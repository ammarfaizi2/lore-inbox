Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312411AbSDCWQK>; Wed, 3 Apr 2002 17:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312412AbSDCWQD>; Wed, 3 Apr 2002 17:16:03 -0500
Received: from reef.structbio.Vanderbilt.Edu ([160.129.152.246]:39949 "EHLO
	structbio.vanderbilt.edu") by vger.kernel.org with ESMTP
	id <S312411AbSDCWPt>; Wed, 3 Apr 2002 17:15:49 -0500
Date: Wed, 3 Apr 2002 16:15:48 -0600
From: "Brandon D. Valentine" <bandix@structbio.vanderbilt.edu>
To: linux-kernel@vger.kernel.org
Subject: block device issues
Message-ID: <Pine.SGI.4.43.0204031516440.110414-100000@coral.structbio.vanderbilt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Not subscribed so please keep me in the Cc list]

Greetings,

This past weekend one of our Linux 2.4/XFS fileservers crashed pretty
badly.  I am attempting to diagnose the cause of the crash so that I may
prevent it from recurring.  My analysis so far follows.  I am hoping
that a few of you out there might have seen this before or have ideas on
its cause.

The symptoms:

Saturday morning I discovered the machine had stopped responding to NFS
requests.  It was still responding to ICMP and I could ssh in.  I logged
in and found out the load average was at 34.  Top revealed no processes
using any appreciable amount of CPU time.  I tried to tail the logs, but
everytime I launched a process like tail, which hit the disk, the
process and the terminal it was attached to hung.  I attempted the
reboot command, but it segfaulted when invoked.  Eventually the ssh
daemon stopped responding and I was unable to login again.  I drug
myself into the office on a Saturday morning to find out what was up.
When I arrived on the scene and pulled up a console I found the screen
littered with a mess of printk's and various other log messages.  Most
of it was indecipherable due to a healthy smattering of hex addresses
and control characters.  Since I was unable to get any sort of response
on the console, I hit the big red button and waited.  The machine came
back up, everything appeared to be working, and I went home.  When I got
there I began diagnosis, which follows, and the machine has been running
without incident ever since.

The diagnosis:

An analysis of the logs reveals that the printk's I had been unable to
decipher were in fact triggered by calls to BUG() on line 1033 of
linux/drivers/block/ll_rw_blk.c.  This particular BUG occurs inside
ll_rw_block() as follows:

void ll_rw_block(int rw, int nr, struct buffer_head * bhs[])
{
...
		if (buffer_delay(bh) || !buffer_mapped(bh))
			BUG();
...
}

Instances of this BUG were logged 22 times before the machine became
unresponsive, though it doesn't appear to have ever actually oops'd,
just become so heavily loaded that nothing, not even getty at the
console, was responding.  All of the BUGs that were logged appear to
have happened inside processes which would have been heavy on disk io.
Some examples include bdflush, amanda's dumper binary (there happened to
be a backup run happening at the time), gzip (also via amanda),
kupdated, lpd, and updatedb (from locate).  I have posted an excerpt of
the logs containing all 22 BUGs plus a full dmesg from the reboot here
if anyone wants to take a closer look:

http://structbio.vanderbilt.edu/~bandix/linux/messages

You can also see the amount of time between when syslog quit logging and
when the machine was rebooted in that log excerpt.

A bit of background on the machine:

It's a SuperMicro SuperServer 6041G, in very good shape.  We have had no
previous problems with it, or with the Linux installation on it.  It is
presently running RedHat 7.1 XFS (using SGI's install ISO) and the
kernel is a known good copy of 2.4.7/XFS pulled from SGI's CVS at the
time that this fileserver was setup.  At that time 2.4.7 was HEAD in
SGI's CVS.  This machine had over a 100 day uptime when the crash
occured, and had previoulsy only gone down for scheduled maintainence at
my discretion.  This same combination (RH71 + 2.4.7/XFS) is in use on
quite a few of our fileservers here at the Center without incident.
It was under fairly heavy disk io at the time the problem developed, but
not any amount of disk io that is unusual to this fileserver, it is
pretty heavily used.

I am not presently familiar with the particulars of linux kernel
internals, but I would like to figure out why my fileserver crashed, and
if possible, prevent it from happening again.  Do any of you have any
ideas on what would have caused those kernel BUGs or the subsequent
crash?  Unfortunately I don't have an Oops.file, since it never actually
Oops'd.

Awaiting your thoughts,

-- 
Brandon D. Valentine <bandix@structbio.vanderbilt.edu>
Computer Geek, Center for Structural Biology

"This isn't rocket science -- but it _is_ computer science."
	- Terry Lambert on current@FreeBSD.org.


