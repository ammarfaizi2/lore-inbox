Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269262AbUJFNPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269262AbUJFNPd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 09:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269265AbUJFNPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 09:15:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8406 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269262AbUJFNPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 09:15:19 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16739.61314.102521.128577@segfault.boston.redhat.com>
Date: Wed, 6 Oct 2004 09:13:38 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, sct@redhat.com
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
In-Reply-To: <20041005112752.GA21094@logos.cnet>
References: <16733.50382.569265.183099@segfault.boston.redhat.com>
	<20041005112752.GA21094@logos.cnet>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch rfc] towards supporting O_NONBLOCK on regular files; Marcelo Tosatti <marcelo.tosatti@cyclades.com> adds:

marcelo.tosatti> On Fri, Oct 01, 2004 at 04:57:50PM -0400, Jeff Moyer
marcelo.tosatti> wrote:
>> This patch makes an attempt at supporting the O_NONBLOCK flag for
>> regular files.  It's pretty straight-forward.  One limitation is that we
>> still call into the readahead code, which I believe can block.  However,
>> if we don't do this, then an application which only uses non-blocking
>> reads may never get it's data.
>> 
>> Comments welcome.

marcelo.tosatti> Hi Jeff,

marcelo.tosatti> Curiosity: Is this defined in any UNIX standard?

marcelo.tosatti> Adv. Programming in the UNIX environment says:

marcelo.tosatti> 12.2 Nonblocking I/O

marcelo.tosatti> "Nonblocking I/O lets us issue an I/O operation, such as
marcelo.tosatti> open, read, or write and not have it block forever. If the
marcelo.tosatti> operation cannot be completed, return is made immediately
marcelo.tosatti> with an error noting that the operation would have
marcelo.tosatti> blocked."

marcelo.tosatti> He is talking about read's on descriptors (pipe's,
marcelo.tosatti> devices, etc) which block in case of no data present, not
marcelo.tosatti> about filesystem IO.

marcelo.tosatti> But here we create our own semantics of O_NONBLOCK on
marcelo.tosatti> read() of fs IO. As you say page_cache_readahead can block
marcelo.tosatti> for one trying to allocate pages, possibly while
marcelo.tosatti> submitting IO too.

marcelo.tosatti> The patch is cool - might be nice to check if SuS or
marcelo.tosatti> someone else specificies behaviour and try to match if so?

Hi, Marcelo,

The text below was taken from the following standard:

IEEE Std 1003.1, 2004 Edition
The Open Group Technical Standard
Base Sepcifications, Issue 6
Includes IEEE Std 1003.1-2001, IEEE Std 1003.1-2001/Cor 1-2002


open()

O_NONBLOCK When opening a FIFO with O_RDONLY or O_WRONLY set:
 o If O_NONBLOCK is set, an open( ) for reading-only shall return without
   delay. An open( ) for writing-only shall return an error if no process
   currently has the file open for reading.
 o If O_NONBLOCK is clear, an open( ) for reading-only shall block the
   calling thread until a thread opens the file for writing. An open( ) for
   writing-only shall block the calling thread until a thread opens the file
   for reading.

When opening a block special or character special file that supports non-
blocking opens:
 o If O_NONBLOCK is set, the open( ) function shall return without blocking
   for the device to be ready or available. Subsequent behavior of the device
   is device-specific.
 o If O_NONBLOCK is clear, the open( ) function shall block the calling
   thread until the device is ready or available before returning.

 Otherwise, the behavior of O_NONBLOCK is unspecified.

read()

When attempting to read a file (other than a pipe or FIFO) that supports
non-blocking reads and has no data currently available:
 o If O_NONBLOCK is set, read( ) shall return -1 and set errno to [EAGAIN].
 o If O_NONBLOCK is clear, read( ) shall block the calling thread until
   some data becomes available.
 o The use of the O_NONBLOCK flag has no effect if there is some data
   available.

write()

When attempting to write to a file descriptor (other than a pipe or FIFO)
that supports non- blocking writes and cannot accept the data immediately:
  o If the O_NONBLOCK flag is clear, write( ) shall block the calling
    thread until the data can be accepted.
  o If the O_NONBLOCK flag is set, write( ) shall not block the thread. If
    some data can be written without blocking the thread, write( ) shall
    write what it can and return the number of bytes written. Otherwise, it
    shall return -1 and set errno to [EAGAIN].


Thanks!

Jeff
