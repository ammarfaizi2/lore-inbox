Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbTDKTSC (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbTDKTSC (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:18:02 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:39781 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261542AbTDKTR7 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 15:17:59 -0400
Date: Fri, 11 Apr 2003 15:29:20 -0400
From: Havoc Pennington <hp@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: "Kevin P. Fleming" <kpfleming@cox.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411152920.C17638@devserv.devel.redhat.com>
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <20030411190717.GH1821@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030411190717.GH1821@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 12:07:17PM -0700, Greg KH wrote: 
> Problem is I don't think we can use D-BUS messages during early boot,
> before init is called, so we still have to be able to handle startup
> issues.  But hopefully the D-BUS code can be small enough to possibly be
> used in this manner, I haven't checked that out yet.

I'm not sure what the threshold for small enough is, but I'll give you
an analysis of D-BUS size.

The current size is:

# size /usr/lib/libdbus-1.so
   text    data     bss     dec     hex filename
 138905    1548     148  140601   22539 /usr/lib/libdbus-1.so
# size /usr/bin/dbus-daemon-1
   text    data     bss     dec     hex filename
 170756    1616     160  172532   2a1f4 /usr/bin/dbus-daemon-1

The daemon statically links in the whole library, so the 138K is in
fact copied twice; the daemon itself is not that much code.  I'm not
sure if libtool is already doing GC on unused statically-linked-in
code or if -fgc-sections would help.

The library contains some dead/unused code that could be cleaned up,
but there are also a few small things not yet implemented.  So I
expect to stay in approximately the 150K range over time.

We could probably get down to 100K by not handling out of memory (just
aborting on out of memory), but it seems like we need to handle that.
The OOM error codepaths are a pretty substantial percentage of overall
code size, surprisingly so.

The other significant fraction of the library is that D-BUS contains
its own little utility lib that reinvents bits of GLib/Qt - hash
table, linked list, memory pools, etc.

This utility lib API isn't exported from libdbus-1.so, but is used by
the daemon, which is why the daemon is statically linked.

Library code specific to D-BUS functionality, minus generic utility
code, minus OOM handling, is probably on the order of 50K.

There is one external dependency, which is an XML parser. 
libexpat is the smallest one I know of:
  # size /usr/lib/libexpat.so
    text    data     bss     dec     hex filename
  122440    6048       4  128492   1f5ec /usr/lib/libexpat.so

As this dependency is only for the daemon, -fgc-sections and static
linkage could help. We could also cut-and-paste the "gmarkup" 
pseudo-fake-xml-subset parser from GLib, that is about this big:

# size /cvs/gnome-cvs/glib/glib/gmarkup.o
   text    data     bss     dec     hex filename
  13816       4       0   13820    35fc  /cvs/gnome-cvs/glib/glib/gmarkup.o

Finally, as D-BUS is meant to be a well-defined protocol, it would
also be possible to create a "lite" client library perhaps, by
choosing to make certain sacrifices. (e.g. by allowing only a single
connection at a time, not handling OOM, and always blocking instead of
having the ability to integrate into a main loop.) Obviously that
would be a maintenance burden, though.

Havoc
