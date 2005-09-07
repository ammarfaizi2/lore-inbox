Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbVIGMLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVIGMLY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 08:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVIGMLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 08:11:24 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:18389 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751205AbVIGMLX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 08:11:23 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: ncpfs: Connection invalid / Input-/Output Errors
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: =?ISO-8859-1?Q?sch=F6nfeld?= / in-medias-res 
	<schoenfeld@in-medias-res.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <431ECA16.8040104@in-medias-res.com>
References: <S932080AbVIGI45/20050907085657Z+286@vger.kernel.org>
	 <431ECA16.8040104@in-medias-res.com>
Content-Type: text/plain; charset=utf-8
Organization: Computing Service, University of Cambridge, UK
Date: Wed, 07 Sep 2005 13:11:19 +0100
Message-Id: <1126095079.28456.18.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-07 at 13:08 +0200, schönfeld / in-medias-res wrote:
> At one of our sites we run a Novell Fileserver with some DOS Clients
> and a linux server. The linux server is running an older SuSE version
> with Linux 2.4.29 kernel, as well as various custom applications.
> It is running quiet stable so far without bigger problems.
> 
> As we want to migrate our servers to Debian their is another system
> running Debian, a Linux 2.6.12 kernel build from debianized sources and
> the same custom applications as on the SuSE system. But for a reason,
> we can't figure out, the novell connection on that system fails in
> a random matter. It just "disappears" and logfiles (syslog and kern.log)
> state that the ncpfs connection is invalid. First we thought of a
> hardware problem, but that does not seem to be the reason, as we swapped
> the responsible NIC and the problem keeps happening. Then we thought
> it may be a kernel bug, which is maybe fixed in a newer version,
> upgraded the kernel, but the situation did not change. I thought one
> special application may be the point of failure, but it does run on
> the other host, too - without any problem. Anyways i straced the
> application to see whats happening when the connection breaks. Nothing,
> that could help. It's just normal operation until it gets into an
> "Input/Output Error" loop.
> 
> At the current point i don't know what to do. I don't see possibilites
> to trace down the problem, nor can i find some hints via google or in
> this mailinglist so i want to ask if somebody can tell me how to trace
> down that problem, or give me some hints in any other way.

Are you using IPX or TCP/IP or UDP?  Are you using the same on both?
Are the two boxes in the same place and on the same connection/the same
speed?  For example if one box is sitting close to the netware server
and the other further away, on a congested network, it is much more
likely to loose the connection.  Also IPX is much worse than UDP.  Our
connection loss problems decreased a lot when we moved from IPX to UDP.
Haven't had much experience with TCP/IP yet.  Also so far we have not
seen any connection loss problems since we switched from 2.4 to 2.6
kernels (suse 9.3, i.e. 2.6.11.4-21.9).

One of the reasons for a connection disappearing is that the NCP
sequence numbers on the netware server and the linux client become out
of sync.  When the netware server detects this it shuts down the
connetion.  Linux can't do reconnects so you get exactly the errors you
see and the connection is gone.  The fix is to umount and to mount again
when this happens.

To see if this is your problem, insert some printk()s in the relevant
ncpfs code (depends whether you are using ipx or tcp/udp as to where)
and see if they are triggered.  We have been trying to track this down
for years and have failed so far...  We were hoping the problems had
gone away with the 2.6 kernel but if you are seeing them maybe we will
start seing them once term starts and Linux is used more again...  (We
only switched to 2.6 this summer.)

> The ncpfs software running on the server is 2.2.6, while the server
> without problems is running 2.2.0.18.

That is irrelevant.  Only the kernel driver version matters.

Hope this is useful.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

