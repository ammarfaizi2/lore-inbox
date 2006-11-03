Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753283AbWKCPwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbWKCPwD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 10:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753285AbWKCPwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 10:52:01 -0500
Received: from mx1.mandriva.com ([212.85.150.183]:43163 "EHLO mx1.mandriva.com")
	by vger.kernel.org with ESMTP id S1753284AbWKCPwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 10:52:00 -0500
Date: Fri, 3 Nov 2006 12:51:48 -0300
From: Arnaldo Carvalho de Melo <acme@mandriva.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: Re: [ANNOUNCE] pahole and other DWARF2 utilities
Message-ID: <20061103155148.GA25363@mandriva.com>
References: <20061030213318.GA5319@mandriva.com> <20061030203334.09caa368.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20061030203334.09caa368.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 08:33:34PM -0800, Andrew Morton wrote:
> On Mon, 30 Oct 2006 18:33:19 -0300
> Arnaldo Carvalho de Melo <acme@mandriva.com> wrote:
> 
> > Hi,
> > 
> > 	I've been working on some DWARF2 utilities and thought that it
> > is about time I announce it to the community, so that what is already
> > available can be used by people interested in reducing structure sizes
> > and otherwise taking advantage of the information available in the elf
> > sections of files compiled with 'gcc -g' or in the case of the kernel
> > with CONFIG_DEBUG_INFO enabled, so here it goes the description of said
> > tools:
> > 
> > pahole: Poke-a-Hole is a tool to find out holes in structures, holes
> > being defined as the space between members of functions due to alignemnt
> > rules that could be used for new struct entries or to reorganize
> > existing structures to reduce its size, without more ado lets see what
> > that means:
> > 
> > ...
> >
> > 	Further ideas on how to use the DWARF2 information include tools
> > that will show where inlines are being used, how much code is added by
> > inline functions,
> 
> It would be quite useful to be able to identify inlined functions which are
> good candidates for uninlining.

Getting there, next step is to per CU (Compilation Unit, .o files)
inlining stats :-)

Ah, the sizes are different because sometimes just some parts of inline
functions are "sourced", as indicated by the DW_AT_ranges DWARF
attribute.

Repo continues at:

git://git.kernel.org/pub/scm/linux/kernel/git/acme/pahole.git

Another suggested was for a stack hole finding tool, similar to what
pahole does for structs :-)

Another example, this time for schedule():

http://oops.merseine.nu:81/acme/schedule.inlines.txt

Regards,

- Arnaldo

commit a42afe1acffc5e57ab504c008b8b75c124bf07de
Author: Arnaldo Carvalho de Melo <acme@mandriva.com>
Date:   Fri Nov 3 12:41:19 2006 -0300

    [CLASSES]: Add support for DW_TAG_inlined_subroutine

    Output of pfunct using this information (all for a make allyesconfig build):

    Top 5 functions by size of inlined functions in net/ipv4:

    [acme@newtoy guinea_pig-2.6]$ pfunct -I net/ipv4/built-in.o | sort -k3 -nr | head -5
    ip_route_input: 19 7086
    tcp_ack: 33 6415
    do_ip_vs_set_ctl: 23 4193
    q931_help: 8 3822
    ip_defrag: 19 3318
    [acme@newtoy guinea_pig-2.6]$

    And by number of inline expansions:

    [acme@newtoy guinea_pig-2.6]$ pfunct -I net/ipv4/built-in.o | sort -k2 -nr | head -5
    dump_packet: 35 905
    tcp_v4_rcv: 34 1773
    tcp_recvmsg: 34 928
    tcp_ack: 33 6415
    tcp_rcv_established: 31 1195
    [acme@newtoy guinea_pig-2.6]$

    And the list of expansions on a specific function:

    [acme@newtoy guinea_pig-2.6]$ pfunct -i net/ipv4/built-in.o tcp_v4_rcv
    /* net/ipv4/tcp_ipv4.c:1054 */
    int tcp_v4_rcv(struct sk_buff * skb);
    /* size: 2189, variables: 8, goto labels: 6, inline expansions: 34 (1773 bytes) */

    /* inline expansions in tcp_v4_rcv:
    current_thread_info: 8
    pskb_may_pull: 36
    pskb_may_pull: 29
    tcp_v4_checksum_init: 139
    __fswab32: 2
    __fswab32: 2
    inet_iif: 12
    __inet_lookup: 292
    __fswab16: 20
    inet_ehashfn: 25
    inet_ehash_bucket: 18
    prefetch: 4
    prefetch: 4
    prefetch: 4
    sock_hold: 4
    xfrm4_policy_check: 59
    nf_reset: 66
    sk_filter: 135
    __skb_trim: 20
    get_softnet_dma: 68
    tcp_prequeue: 257
    sk_add_backlog: 40
    sock_put: 27
    xfrm4_policy_check: 46
    tcp_checksum_complete: 29
    current_thread_info: 8
    sock_put: 20
    xfrm4_policy_check: 50
    tcp_checksum_complete: 29
    current_thread_info: 8
    current_thread_info: 8
    sock_put: 20
    xfrm4_policy_check: 50
    tcp_checksum_complete: 29
    current_thread_info: 8
    inet_iif: 9
    inet_lookup_listener: 36
    inet_twsk_put: 114
    tcp_v4_timewait_ack: 153
    */
    [acme@newtoy guinea_pig-2.6]$

    Signed-off-by: Arnaldo Carvalho de Melo <acme@mandriva.com>
