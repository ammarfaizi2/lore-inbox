Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423611AbWJaUpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423611AbWJaUpq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 15:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423619AbWJaUpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 15:45:46 -0500
Received: from mx1.mandriva.com ([212.85.150.183]:19119 "EHLO mx1.mandriva.com")
	by vger.kernel.org with ESMTP id S1423611AbWJaUpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 15:45:45 -0500
Date: Tue, 31 Oct 2006 17:45:32 -0300
From: Arnaldo Carvalho de Melo <acme@mandriva.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: Re: [ANNOUNCE] pahole and other DWARF2 utilities
Message-ID: <20061031204532.GG5319@mandriva.com>
References: <20061030213318.GA5319@mandriva.com> <20061030203334.09caa368.akpm@osdl.org> <20061031172237.GD5319@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20061031172237.GD5319@mandriva.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 02:22:37PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Oct 30, 2006 at 08:33:34PM -0800, Andrew Morton wrote:
> > On Mon, 30 Oct 2006 18:33:19 -0300
> > Arnaldo Carvalho de Melo <acme@mandriva.com> wrote:
> > 
> > > 	I've been working on some DWARF2 utilities and thought that it
> > > is about time I announce it to the community, so that what is already
> > > available can be used by people interested in reducing structure sizes
> > > and otherwise taking advantage of the information available in the elf
> > > sections of files compiled with 'gcc -g' or in the case of the kernel
> > > with CONFIG_DEBUG_INFO enabled, so here it goes the description of said
> > > tools:
> > > 
> > > pahole: Poke-a-Hole is a tool to find out holes in structures, holes
> > > being defined as the space between members of functions due to alignemnt
> > > rules that could be used for new struct entries or to reorganize
> > > existing structures to reduce its size, without more ado lets see what
> > > that means:
> > > 
> > > ...
> > >
> > > 	Further ideas on how to use the DWARF2 information include tools
> > > that will show where inlines are being used, how much code is added by
> > > inline functions,
> > 
> > It would be quite useful to be able to identify inlined functions which are
> > good candidates for uninlining.

For now people can take a look at:

http://oops.merseine.nu:81/acme/net.ipv4.tcp.o.pahole

Where all the types in headers included from net/ipv4/tcp.c that have
holes can be seen, for instance:

/* /pub/scm/linux/kernel/git/acme/net-2.6/include/linux/dqblk_xfs.h:143
 * */
struct fs_quota_stat {
        __s8             qs_version;           /*     0     1 */

        /* XXX 1 bytes hole, try to pack */

        __u16            qs_flags;             /*     2     2 */
        __s8             qs_pad;               /*     4     1 */

        /* XXX 3 bytes hole, try to pack */

        fs_qfilestat_t   qs_uquota;            /*     8    20 */
        fs_qfilestat_t   qs_gquota;            /*    28    20 */
        __u32            qs_incoredqs;         /*    48     4 */
        __s32            qs_btimelimit;        /*    52     4 */
        __s32            qs_itimelimit;        /*    56     4 */
        __s32            qs_rtbtimelimit;      /*    60     4 */
        __u16            qs_bwarnlimit;        /*    64     2 */
        __u16            qs_iwarnlimit;        /*    66     2 */
}; /* size: 68, sum members: 64, holes: 2, sum holes: 4 */


	See? two holes, that can be combined and reduce the size of this
struct by 4 bytes, just moving qs_pad to be defined just before
qs_flags, many more holes are there to harvest :-)

	Of course, mistakes from the past for structs that are exported
to userspace have to be kept that way, and in other cases where grouping
members for cacheline locality optimizations, etc.

- Arnaldo
