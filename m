Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbUB2BjY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 20:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbUB2BjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 20:39:24 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58842
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261955AbUB2BjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 20:39:23 -0500
Date: Sun, 29 Feb 2004 02:39:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040229013923.GV8834@dualathlon.random>
References: <20040227173250.GC8834@dualathlon.random> <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com> <20040227122936.4c1be1fd.akpm@osdl.org> <20040227211548.GI8834@dualathlon.random> <162060000.1077919387@flay> <20040228023236.GL8834@dualathlon.random> <20040228045713.GA388@ca-server1.us.oracle.com> <20040228061838.GO8834@dualathlon.random> <p73eksf4big.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73eksf4big.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 28, 2004 at 01:46:47PM +0100, Andi Kleen wrote:
> Andrea Arcangeli <andrea@suse.de> writes:
> > 
> > we can add a config option to enable together with 2.5:1.5 to drop the
> > gap page in vmalloc, and to reduce the vmalloc space, so that we can
> > sneak another few "free" dozen megs back for the 64G kernel just to get
> > more margin even if we don't strictly need it. (btw, the vmalloc space
> > is also tunable at boot, so this config option would just change the
> > default value)
> 
> Not sure if that would help, but you could relatively easily save
> 8 bytes on 32bit for each vma too. Replace vm_next with rb_next()
> and move vm_rb.color into vm_flags. It would be a lot of editing

the vm_flags rb_color thing is a smart idea indeed, I never thought
about it using vm_flags itself, however it clearly needs a generic
wrapper since we want to keep the rbtree completely generic. David
Woodhouse once suggested me to use the least significant bit of one of
the pointers to save the rb_color, that could work but that really
messes the code up since such a pointer would need to be masked every
time, and it's not self contained. Using vm_flags sounds more
interesting since the pointers are still usable in raw mode, one only
needs to be careful about the locking: vm_flags seems pretty much a
readonly thing so it's probably ok, if there would be other writers
outside the rbtree code then we'd need to sure they're serialized.

you're wrong about s/vm_next/rb_next()/, walking the tree like in
get_unmapped_area would require recurisve algos w/o vm_next, or
significant heap allocations. that's the only thing vm_next is needed
for (i.e. to walk the tree in order efficiently). only if we drop all
tree walks than we can nuke vm_next.

> work though. NUMA API will add new 4 bytes again. 

saving in vmas is partly already accomplished by remap_file_pages, so I
don't rate vma size as critical.
