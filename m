Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbUCIVgV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 16:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbUCIVgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 16:36:21 -0500
Received: from gate.crashing.org ([63.228.1.57]:2258 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262218AbUCIVgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 16:36:15 -0500
Subject: Re: ppc/ppc64 and x86 vsyscalls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <404E33A7.6070800@redhat.com>
References: <1078708647.5698.196.camel@gaston> <404D7AC3.9050207@redhat.com>
	 <1078830318.9746.3.camel@gaston>  <404E33A7.6070800@redhat.com>
Content-Type: text/plain
Message-Id: <1078867992.9745.25.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Mar 2004 08:33:13 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-10 at 08:14, Ulrich Drepper wrote:

> You can create one "big" DSO which covers all the configured processors.
>  Then at kernel start time, you determine the actual processor and
> adjust the symbol table offsets to point to the correct version.  There
> is no requirement that the table used is identical to the one on disk.
> It's loaded into ordinary memory which can be modified.

Ah, interesting.

> The tricky part of this would be to determine the symbol table slots.
> But even this is quite simple.  Just locate the symbol table in the
> ELF-way, then iterate over the entries and use strcmp() for the names
> and act upon match.  What you shouldn't do is to generate pointer to the
> symbol table entries somewhere.  This is probably fragile and not worth
> the few cycles you'll save.

Yes, make sense. I can "pre" prepare bth 32 and 64 bits DSOs at kernel
start time, then I just have to map them. I suppose I should layout my
DSO in such a way:

/* In one place the actual function implementation */
 function_A_vers_1()
 function_A_vers_2()
 function_A_vers_3()
 function_B_vers_1()
 function_B_vers_2()
   etc .../...

/* Then, some empty "stubs" for the symbol table that gets really
 * linked into user binaries. Those are the symbol table entries
 * that get patched
 */
 function_A() {}
 function_B() {}

Sounds right ? It's not completely obvious how I'll do to also map the
64 bits versions of these in the kernel address space, but I can find
a trick.

Ben.



