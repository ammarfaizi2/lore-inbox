Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbTGCLR7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 07:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbTGCLR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 07:17:59 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:45003
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265108AbTGCLR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 07:17:58 -0400
Date: Thu, 3 Jul 2003 13:31:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030703113144.GY23578@dualathlon.random>
References: <20030702171159.GG23578@dualathlon.random> <461030000.1057165809@flay> <20030702174700.GJ23578@dualathlon.random> <20030702214032.GH20413@holomorphy.com> <20030702220246.GS23578@dualathlon.random> <20030702221551.GH26348@holomorphy.com> <20030702222641.GU23578@dualathlon.random> <20030702231122.GI26348@holomorphy.com> <20030702233014.GW23578@dualathlon.random> <20030702235540.GK26348@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702235540.GK26348@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 04:55:40PM -0700, William Lee Irwin III wrote:
> it from; we don't unmap it from all processes, just the current one, and

if this is the case, this also means mlock isn't enough to guarantee to
drop the pte_chains: you also will need everybody else mapping the file
to mlock after every mmap or the pte_chains will stay there.

Last but not the least mlock is a privilegied operations and it in turn
it *can't* be used. Those apps strictly runs as normal user for all the
good reasons. so at the very least you need a sysctl to allow anybody to
run mlock.

Yet another issue is that mlock at max locks in half of the physical
ram, this makes it unusable (google is patching it too for their
internal usage that skips the more costly page faults), so you would
need another sysctl to select the max amount of mlockable memory (or you
could share the same sysctl that makes mlock a non privilegied
operation, it's up to you).

Bottom line is that you will still need a sysctl for security reasons
(equivalent to my sysctl to make remap_file_pages runnable as normal
user with my proposal), and my proposal is an order of magnitude simpler
to implement and maintain, and it doesn't affect mlock and it doesn't
create any complication with the rest of VM, since the rest of the VM
will never see those populated-pages via remap_file_pages, they will be
threated like pages under I/O via kiobuf etc... (so anonymous ones)

Your only advantage for the VM complications is that the emulator won't
need to use the sysctl (and well, most emulators needs root privilegies
anyways for kernel modules for nat etc..) and that it will be allowed to
swap heavily without the vma overhead (that IMHO is negligeable anyways
during heavy swapping with the box idle, especially after mmap will
always run in O(log(N)) where N is the number of vmas, currently it's
O(N) but it'll be improved).

Andrea
