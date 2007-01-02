Return-Path: <linux-kernel-owner+w=401wt.eu-S932725AbXABRwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbXABRwz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 12:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbXABRwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 12:52:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53408 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932684AbXABRwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 12:52:53 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <65dd6fd50610101705t3db93a72sc0847cd120aa05d3@mail.gmail.com> 
References: <65dd6fd50610101705t3db93a72sc0847cd120aa05d3@mail.gmail.com> 
To: "Ollie Wild" <aaw@google.com>
Cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Arjan van de Ven" <arjan@infradead.org>, "Ingo Molnar" <mingo@elte.hu>,
       linux-mm@kvack.org, "Andrew Morton" <akpm@osdl.org>,
       "Andi Kleen" <ak@muc.de>, linux-arch@vger.kernel.org,
       "David Howells" <dhowells@redhat.com>
Subject: Re: Removing MAX_ARG_PAGES (request for comments/assistance) 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 02 Jan 2007 17:52:14 +0000
Message-ID: <22336.1167760334@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ollie Wild <aaw@google.com> wrote:

> - I haven't tested this on a NOMMU architecture.  Could someone please
> validate this?

There are a number of potential problems with NOMMU:

 (1) The argument data is copied twice (once into kernel memory and once out
     of kernel memory).

 (2) The permitted amount of argument data is governed by the stack size of
     the program to be exec'd.  You should assume that NOMMU stacks cannot
     grow.

 (3) VMAs on NOMMU are a shared resource.

However, we might be able to extend your idea to improve things.  If we work
out the stack size required earlier, we can allocate the VMA and the memory
for the stack *before* we reach the point of no return.  We can then fill in
the stack and load up all the parameters *before* releasing the original
executable.  That would eliminate one of the copied mentioned in (1).  Working
out the stack size earlier may be difficult though, as we may need to load the
interpreter header before we can do so.

Overall, I don't think there should be too many problems with this for NOMMU.

David
