Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269297AbUJQTkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269297AbUJQTkj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 15:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269358AbUJQTki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 15:40:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54486 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269297AbUJQTiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 15:38:55 -0400
To: Ingo Molnar <mingo@redhat.com>
Cc: jmoyer@redhat.com, "Stephen C. Tweedie" <sct@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
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
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 17 Oct 2004 16:38:45 -0300
In-Reply-To: <Pine.LNX.4.58.0410170715240.16806@devserv.devel.redhat.com>
Message-ID: <orvfd9yw1m.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 17, 2004, Ingo Molnar <mingo@redhat.com> wrote:

> I.e. the readahead-kicking is necessary after all, because
> squid apparently assumes that re-trying a read will eventually succeed.  

I'm not sure it assumes that.  It definitely expects read to succeed
if poll says there is data available from the file, though, and having
poll return that there is data, and then having read fail because
there isn't anything there, so that you go back to poll, is a recipe
for wasting CPU.  I do think read should kick in readahead, yes, but
so should poll, if the process says it wants to read from the file,
and poll should not return (or not say data is available) unless an
immediate, atomic call to read would actually return some data.  Of
course, if the data happens to be elicited from memory between the
poll and read calls, it's legitimate for read to fail with -EAGAIN,
but this shouldn't happen very often.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
