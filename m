Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268932AbTGJF0o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 01:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268934AbTGJF0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 01:26:44 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:51858 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S268932AbTGJF0n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 01:26:43 -0400
Date: Thu, 10 Jul 2003 06:41:21 +0100
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: NFS client errors with 2.5.74?
Message-ID: <20030710054121.GB27038@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing quite a lot of NFS client errors with 2.5.74, connected to
a server running 2.4.20-18.9 (Red Hat 9's current kernel).

All of the errors that I've observed the form of a write() or close()
returning EIO.  rsync seeems to have a particularly tough time -
could the unusual size of blocks which rsync writes be relevant?

There are some read errors too, as Mozilla failed to find my profile
claiming it couldn't read the file (when I restarted Mozilla, it found
it the second time), and Gnome Terminal was unable to read its
preferences file, but I didn't catch any specific read() errors.

I tried this command to see if the is a protocol error while running
Ethereal:

[jamie@dual jamie]$ cp .mirMail.bjl1/INBOX .mirMail.bjl1/JBOX
cp: closing `.mirMail.bjl1/JBOX': Input/output error

Ethereal shows a long series of NFS WRITEs followed by a single COMMIT
(as expected), and nothing after that.  All of those replies had
status 0, OK - including the reply to the final COMMIT.

Using "md5sum" I checked on both the client and server, and the
contents of "JBOX" have been written correctly despite the
"Input/output error" from "cp".

When I looked at the packets from rsync commands that I saw getting
EIO from write(), I saw that all requests except LOOKUP returned with
status 0 as well, and the LOOKUPs that failed were simply checking
whether a ".nfs..." name exists before renaming another file to that
name.

So as far as I can tell, there is no problem with the packets being
sent and received.  There is, however, a big problem with error
reporting on the client side.

A few extra notes:

  - Running NFS v3.
  - Kernel is vanilla 2.5.74, dual Athlon 1800MP, 768MB RAM
  - Chipset: AMD-760MP/AMD-768.  Board: Asus A7M266-D.

  - I _think_ I noticed this problem once when running 2.4.20-18.9 on
    the client, but generally it is not a problem.  I have been
    mounting my home directory over NFS for weeks with 2.4.20-18.9 as
    client, so I would have noticed networking or server problems.

  - Every so often, the client's kernel log gets:
      kernel: nfs: server 192.168.1.1 not responding, timed out
    I haven't caught one of those with Ethereal to find out what's
    going on the wire.  There are no other regular kernel messages.

    Note!  These are all logged at different times to the EIOs,
    differet as in minutes away.  The EIOs, btw, are reported
    immediately; there is no pause waiting for a response from the
    server.

Any idea about this?  Is it a known problem?

Cheers,
-- Jamie
