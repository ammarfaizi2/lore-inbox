Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266878AbUJRQwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUJRQwy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 12:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUJRQwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 12:52:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41152 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266878AbUJRQwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 12:52:51 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16755.62608.19034.491032@segfault.boston.redhat.com>
Date: Mon, 18 Oct 2004 12:51:28 -0400
To: Alexandre Oliva <aoliva@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
In-Reply-To: <orvfd9yw1m.fsf@livre.redhat.lsd.ic.unicamp.br>
References: <16733.50382.569265.183099@segfault.boston.redhat.com>
	<20041005112752.GA21094@logos.cnet>
	<16739.61314.102521.128577@segfault.boston.redhat.com>
	<20041006120158.GA8024@logos.cnet>
	<1097119895.4339.12.camel@orbit.scot.redhat.com>
	<20041007101213.GC10234@logos.cnet>
	<1097519553.2128.115.camel@sisko.scot.redhat.com>
	<16746.55283.192591.718383@segfault.boston.redhat.com>
	<1097531370.2128.356.camel@sisko.scot.redhat.com>
	<16749.15133.627859.786023@segfault.boston.redhat.com>
	<16751.61561.156429.120130@segfault.boston.redhat.com>
	<orzn2lpyfc.fsf@livre.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0410170715240.16806@devserv.devel.redhat.com>
	<orvfd9yw1m.fsf@livre.redhat.lsd.ic.unicamp.br>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch rfc] towards supporting O_NONBLOCK on regular files; Alexandre Oliva <aoliva@redhat.com> adds:

aoliva> On Oct 17, 2004, Ingo Molnar <mingo@redhat.com> wrote:
>> I.e. the readahead-kicking is necessary after all, because squid
>> apparently assumes that re-trying a read will eventually succeed.

aoliva> I'm not sure it assumes that.  It definitely expects read to
aoliva> succeed if poll says there is data available from the file, though,
aoliva> and having poll return that there is data, and then having read
aoliva> fail because there isn't anything there, so that you go back to
aoliva> poll, is a recipe for wasting CPU.  I do think read should kick in
aoliva> readahead, yes, but so should poll, if the process says it wants to
aoliva> read from the file, and poll should not return (or not say data is
aoliva> available) unless an immediate, atomic call to read would actually
aoliva> return some data.  Of course, if the data happens to be elicited
aoliva> from memory between the poll and read calls, it's legitimate for
aoliva> read to fail with -EAGAIN, but this shouldn't happen very often.

Select, pselect, and poll will always return data ready on a regular file.
As such, I would argue that squid's behaviour is broken.  Additionally, I
don't think it's a good idea to modify any polling mechanism to kick off
I/O, if simply because I'm not sure how much data to request!

Since it wasn't supported before, I see no need to extend select/poll to
change behaviour for regular files.  After all, the POSIX spec explicitly
says that select and friends will always return data ready for regular
files.  To make O_NONBLOCK on regular files a workable implementation, Uli
suggestsed extending epoll.  I will look into this.

I am in favor of kicking off I/O for reads that would block.

-Jeff
