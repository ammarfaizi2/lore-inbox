Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVAJXdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVAJXdJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 18:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVAJX3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 18:29:21 -0500
Received: from mail.inter-page.com ([207.42.84.180]:2066 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S262615AbVAJXXq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 18:23:46 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'Oleg Nesterov'" <oleg@tv-sign.ru>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Make pipe data structure be a circular list of pages, rather than
Date: Mon, 10 Jan 2005 15:23:26 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAA4vBrU0wpKES+ohZ9LdwHOwEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <Pine.LNX.4.58.0501070936500.2272@ppc970.osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

This entire discussion of the pipe and splice() is very much the same (issue,
problem, approach) as the STREAMS interface from UNIX SVR4, which had the pipe device
as its trivial example device.  [This is all from vague recall, so forgive the
sketchiness 8-)]

[Note: check out this STREAMS programmers guide
http://docs-pdf.sun.com/802-1933/802-1933.pdf from Sun's documentation site.]

A Message was a fixed-size Message structure with a linked list of Buffers attached
to it. The Buffers were a structure-and-payload arrangement as in (over-expressed
here).  The whole arrangement could be zero-copy or self condensing as needed.
  
In Linux parlance each file descriptor was basically a reference to a pair of linked
list headers (one for messages available for reading and one to accept data from
writes), a pointer to the driver below the head, and an optional tasklet.  The driver
itself was virtually the same data structure.

STREAMS was a little over done and could have used some of the Linuxisims like
tasklets (instead of "the STREAMS Scheduler"), and the bulk of the nonsense for
getting Message and Buffer and STREAMS Head structures just screams Slab Cache, but
it has a lot of interesting bits.

The reason I bring it up is four-fold.

1) They had push and pop ioctl operations on the streams so that you could actually
interpose translators and multiplexors in the streams, so you could use the design to
do the splice() operation directly by building something that basically looked like:

fd0a   fd0b
    mux
 pipe-driver
    fd1

basically by pushing the mux into stream head and then pushing connecting the second
and subsequent fds to the mux object.

2) The Messages had type fields so you could do interesting things like pass an open
file descriptor to another process across a pipe because the special "this is an FD
message" could arrive unmolested and trigger the necessary file table manipulations
at the receiving end.

3) The optional tasklet (equivelant) at the various points in the STREAM could do
things like buffer consolidation, which in the Linux model could compete with actual
data consumption fairly easily/cheaply.

4) Some of the things that I have run into dealing with line disciplines and
streaming data through character devices (and USB) could gain a lot from the
Message/Buffer/STREAM paradigm.  [e.g. the fixed-size flip buffers in ntty would be
rendered moot by having the linked lists above and below the line discipline.]

Anyway, thick as it is, I think the pdf referenced above might be interesting reading
vis a vi the pipe() discussion.

Rob White,
Casabyte, Inc.


