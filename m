Return-Path: <linux-kernel-owner+w=401wt.eu-S1751083AbWLXM0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWLXM0M (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 07:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWLXM0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 07:26:12 -0500
Received: from [85.204.20.254] ([85.204.20.254]:36369 "EHLO megainternet.ro"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751083AbWLXM0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 07:26:11 -0500
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
	corruption on ext3)
From: Andrei Popa <andrei.popa@i-neo.ro>
Reply-To: andrei.popa@i-neo.ro
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Martin Michlmayr <tbm@cyrius.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1166962478.7442.0.camel@localhost>
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	 <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
	 <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org>
	 <20061222100004.GC10273@deprecation.cyrius.com>
	 <20061222021714.6a83fcac.akpm@osdl.org> <1166790275.6983.4.camel@localhost>
	 <20061222123249.GG13727@deprecation.cyrius.com>
	 <20061222125920.GA16763@deprecation.cyrius.com>
	 <1166793952.32117.29.camel@twins>
	 <20061222192027.GJ4229@deprecation.cyrius.com>
	 <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com>
	 <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org>
	 <20061224005752.937493c8.akpm@osdl.org> <1166962478.7442.0.camel@localhost>
Content-Type: text/plain
Organization: I-NEO
Date: Sun, 24 Dec 2006 14:26:01 +0200
Message-Id: <1166963161.7042.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-24 at 14:14 +0200, Andrei Popa wrote:
> On Sun, 2006-12-24 at 00:57 -0800, Andrew Morton wrote: 
> > On Sun, 24 Dec 2006 00:43:54 -0800 (PST)
> > Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > > I now _suspect_ that we're talking about something like
> > > 
> > >  - we started a writeout. The IO is still pending, and the page was 
> > >    marked clean and is now in the "writeback" phase.
> > >  - a write happens to the page, and the page gets marked dirty again. 
> > >    Marking the page dirty also marks all the _buffers_ in the page dirty, 
> > >    but they were actually already dirty, because the IO hasn't completed 
> > >    yet.
> > >  - the IO from the _previous_ write completes, and marks the buffers clean 
> > >    again.
> > 
> > Some things for the testers to try, please:
> > 
> > - mount the fs with ext2 with the no-buffer-head option.  That means either:
> > 
> >   grub.conf:  rootfstype=ext2 rootflags=nobh
> >   /etc/fstab: ext2 nobh
> 
> ierdnac ~ # mount
> /dev/sda7 on / type ext2 (rw,noatime,nobh)
> 
> I have corruption.
> 
> > 
> > - mount the fs with ext3 data=writeback, nobh
> > 
> >   grub.conf:  rootfstype=ext3 rootflags=nobh,data=writeback  (I hope this works)
> >   /etc/fstab: ext2 data=writeback,nobh
> 
> ierdnac ~ # mount
> /dev/sda7 on / type ext3 (rw,noatime,nobh)
> 
> ierdnac ~ # dmesg|grep EXT3
> EXT3-fs: mounted filesystem with writeback data mode.
> EXT3 FS on sda7, internal journal
> 
> I don't have corruption. I tested twice.
> 

I also tested with ext3 ordered, nobh  and I have file corruption...

> > 
> > if that still fails we can rule out buffer_head funnies.
> > 

