Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422707AbWJ3WgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422707AbWJ3WgL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 17:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422710AbWJ3WgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 17:36:11 -0500
Received: from mx1.mandriva.com ([212.85.150.183]:208 "EHLO mx1.mandriva.com")
	by vger.kernel.org with ESMTP id S1422707AbWJ3WgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 17:36:09 -0500
Date: Mon, 30 Oct 2006 18:33:19 -0300
From: Arnaldo Carvalho de Melo <acme@mandriva.com>
To: linux-kernel@vger.kernel.org
Cc: lwn@lwn.net
Subject: [ANNOUNCE] pahole and other DWARF2 utilities
Message-ID: <20061030213318.GA5319@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I've been working on some DWARF2 utilities and thought that it
is about time I announce it to the community, so that what is already
available can be used by people interested in reducing structure sizes
and otherwise taking advantage of the information available in the elf
sections of files compiled with 'gcc -g' or in the case of the kernel
with CONFIG_DEBUG_INFO enabled, so here it goes the description of said
tools:

pahole: Poke-a-Hole is a tool to find out holes in structures, holes
being defined as the space between members of functions due to alignemnt
rules that could be used for new struct entries or to reorganize
existing structures to reduce its size, without more ado lets see what
that means:

[acme@newtoy net-2.6]$ pahole kernel/sched.o task_struct
/* include2/asm/system.h:11 */
struct task_struct {
        volatile long int       state;          /*     0     4 */
        struct thread_info *    thread_info;    /*     4     4 */
        atomic_t                usage;          /*     8     4 */
        long unsigned int       flags;          /*    12     4 */

	<SNIP>

        short unsigned int         ioprio;      /*    52     2 */

        /* XXX 2 bytes hole, try to pack */

        long unsigned int          sleep_avg;   /*    56     4 */ */
        unsigned char              fpu_counter; /*   388     1 */

        /* XXX 3 bytes hole, try to pack */

        int                        oomkilladj;  /*   392     4 */

	<SNIP>

}; /* size: 1312, sum members: 1287, holes: 3, sum holes: 13, padding: 12 */

	It doesn't uses any source code files, just the DWARF2
information in ELF sections, inserted by 'gcc -g', to print out the
above information, current goodies being just to show where are holes
that can be used to reduce the struct size, which is even more useful as
we transition to 64bit architectures, where such holes are more
frequent, as we can see in this example:

[acme@newtoy ~]$ file kdump.debug
kdump.debug: ELF 64-bit LSB executable, AMD x86-64, version 1 (SYSV),
dynamically linked (uses shared libs), not stripped
[acme@newtoy ~]$ pahole kdump.debug _IO_FILE | head -7
/* /usr/include/stdio.h:46 */
struct _IO_FILE {
        int   _flags;               /*     0     4 */

        /* XXX 4 bytes hole, try to pack */

        char *_IO_read_ptr;         /*     8     8 */
[acme@newtoy ~]$


	The columns in the comments are (offset, sizeof(member).

	Tons more information is available in the DWARF2 ELF sections,
making it possible to use it for other purposes, and thats where the
next dwarf comes in, pfunct:

[acme@newtoy net-2.6]$ pfunct net/ipv4/tcp_ipv4.o tcp_v4_rcv
/* /pub/scm/linux/kernel/git/acme/net-2.6/net/ipv4/tcp_ipv4.c:1054 */
int tcp_v4_rcv(struct sk_buff * skb);
/* size: 2175 */

	pfunct uses the DWARF2 information to get function details, such
as its full prototype and function size, that allows us to do some more
interesting queries, such as:

[acme@newtoy net-2.6]$ pfunct --size net/ipv4/netfilter/ip_conntrack.ko
| sort -k 2 -nr | head -10
tcp_packet: 3349
ip_conntrack_in: 1146
icmp_error: 874
ip_conntrack_expect_related: 804
__ip_conntrack_confirm: 586
tcp_new: 527
ip_conntrack_init: 525
tcp_error: 508
ip_conntrack_helper_unregister: 482
ip_conntrack_alloc: 469
[acme@newtoy net-2.6]$

	The top ten functions by size (in bytes) in any ELF file with
debugging information!

	The code is available in a git repository at:

git://git.kernel.org/pub/scm/linux/kernel/git/acme/pahole.git

	Just for browsing the cset comments that may well provide hints
on how this thingy can be useful:

http://www.kernel.org/git/?p=linux/kernel/git/acme/pahole.git;a=summary

	Further ideas on how to use the DWARF2 information include tools
that will show where inlines are being used, how much code is added by
inline functions, possibly rewriting asm-offsets.c, converting ostra
(callgraph tool) to use this information, correlate valgrind's
cachegrind information to suggest struct member reorganization to
exploit cacheline locality and more.

	Documentation is very much a disaster, but I guess the current
state of things is useful for interested hackers, so that I thought it
was time got announce this.

	Ideas for additional tools are more than welcome!

- Arnaldo
Mandriva Labs
http://www.mandriva.com
