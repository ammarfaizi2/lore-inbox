Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286790AbRL1Jn0>; Fri, 28 Dec 2001 04:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286794AbRL1JnH>; Fri, 28 Dec 2001 04:43:07 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:17931 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286790AbRL1JnB>;
	Fri, 28 Dec 2001 04:43:01 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Legacy Fishtank <garzik@havoc.gtf.org>
Cc: Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Fri, 28 Dec 2001 04:26:48 CDT."
             <20011228042648.A7943@havoc.gtf.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Dec 2001 20:42:44 +1100
Message-ID: <2705.1009532564@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001 04:26:48 -0500, 
Legacy Fishtank <garzik@havoc.gtf.org> wrote:
>On Fri, Dec 28, 2001 at 01:54:42AM +0100, Dave Jones wrote:
>> How far down the list was "make it not take twice as long
>> to build the kernel as kbuild 2.4" ? Keith mentioned O(n^2)
>> effects due to each compile operation needing to reload
>> the dependancies etc.
>
>Each compile needs to reload deps???
>
>Ug.  IMHO if you are doing to shake up the entire build system, you
>should Do It Right(tm) and build a -complete- dependency graph -once-.

We have one complete dependency graph for the explicit dependencies.
What is slow is extracting the implicit dependencies after an object
has been compiled, i.e. the files that it includes.  Actually
extracting the implicit dependencies is fast, converting them to
standard names is fast, what is slow is _reading_ the big list that
maps from absolute names to standardized names.

I need the big list in order to remove absolute names in the dependency
trees.  kbuild 2.4 forces a complete recompile if you rename a tree,
including if you build on one system then try to install via NFS on a
second system.  kbuild 2.5 can cope with trees being renamed and trees
having different names on local and NFS mounted systems.  That
flexibility comes at a cost.

"All" I need to do is have one server process that reads the big list
once and the other client processes talk to the server.  Much less data
involved means faster conversion from absolute to standardized names.

