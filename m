Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbTJPNXn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 09:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbTJPNXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 09:23:43 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28854
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262902AbTJPNXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 09:23:41 -0400
Date: Thu, 16 Oct 2003 15:24:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: riel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre VM regression?
Message-ID: <20031016132412.GB1348@velociraptor.random>
References: <Pine.LNX.4.44.0310160949230.2388-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310160949230.2388-100000@logos.cnet>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 09:52:30AM -0200, Marcelo Tosatti wrote:
> 
> Andrea, 
> 
> Martin first reported problems with "gzip -dc file | less" (280MB file).
> less was getting killed. He had no swap... I asked him to add some swap
> and it works now. Fine. 
> 
> The thing is that with 2.4.22 less was being killed, but with 2.4.23-pre
> he gets:

note, that's a true oom, less needs to allocate 280MB and it doesn't fit
in ram. there's no bug as far as I can tell.

a `vmstat 1` could confirm that.

> >> And yes, the app was killed:
> > >
> > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > VM: killing process named
> > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > VM: killing process gpm
> > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > VM: killing process sendmail
> > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > VM: killing process less

here the vm keeps killing until 'less' - the real offender - is nuked.

> So a lot of processes which should not get killed are dying. This is
> really bad. I was afraid it could happen and it did.
> 
> What now? Resurrect OOM-killer? 

the oom killer has the problem I outlined some email ago, with shared
memory it gets fooled badly etc.., though in a desktop with all tiny
tasks except the memory-hog (`less` in this case) it works well.

> 
> > > Hi,
> > >   it's a long time I haven't seen sthis messages, but it just happened that
> > > I did on my laptop ASUS L3880C(1GB RAM). The message show on
> > > 2.4.23-pre5+acpi20030918 and 2.4.23-pre7. The application get's killed on
> > > 2.4.22-acpi20030918 too, just without the "0-order allocation" message.
> > > I enabled in kernel the VM allocation debug option when configuring, but
> > > apparently I have to turn it on also somewhere else. *Documentation* is
> > > missing: 1) the help in "make config/menuconfig" etc. doesn't say anything,
> > > the Documentation subdirectory doesn't say anything except "debug" as
> > > kernel boot option on command-line(I did that too, but no change) and also
> > > linux kernel-FAQ doesn't say either. :(
> > >
> > > How I tested?
> > > `gzip -dc file | less' and pressed `G' to jump to the very end of the file.
> > > The filesize is 280MB only. In a while, the mouse stopps moving for a
> > > while, than the system gets sometimes unloaded, fan is raises it's RPM's up
> > > and down town to time, and mouse cursor eventually does a move and then
> > > less command gets killed. In dmesg I found:
> > >
> > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > VM: killing process less

this time it was killed immediatly even with the new changes.

> 
> With 2.4.22:
> 
> > 2.4.22-acpi-20030918 with HIGHMEM gives only in dmesg:
> >
> > Out of Memory: Killed process 1904 (less).

same here obviously.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
