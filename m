Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313122AbSEML6n>; Mon, 13 May 2002 07:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313114AbSEML6m>; Mon, 13 May 2002 07:58:42 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:58885 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313122AbSEML6k>; Mon, 13 May 2002 07:58:40 -0400
Date: Mon, 13 May 2002 13:58:01 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020513115800.GC4258@louise.pinerecords.com>
In-Reply-To: <20020512145802Z313578-22651+30503@vger.kernel.org> <Pine.LNX.4.44L.0205122146310.32261-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 16:18)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I agree. If developers need that changelog style it's fine, but on kernel.org
> > homepage there should the old changelog format, so everyone can read it.
> > The best changelog i've ever seen is the one used around ~2.4.9 release
> >
> >  - changedescription                         (author)
> 
> So, is there anybody willing to put together the scripts to
> generate this changelog format automatically ?

Alright, another one.

$ ./fmtcl2.pl /usr/src/ChangeLog-2.5.14

Summary of changes from v2.5.13 to v2.5.14
============================================

o  kd.h                                                                             (Andries.Brouwer@cwi.nl)
o  NTFS: Release 2.0.6 - Major bugfix to make compatible with other kernel changes. (aia21@cantab.net)
o  mm/memory.c:                                                                     (aia21@cantab.net)
o  suppress allocation warnings for radix-tree allocations                          (akpm@zip.com.au)
o  radix-tree locking fix                                                           (akpm@zip.com.au)
o  Allow truncate to discard unmapped buffers                                       (akpm@zip.com.au)
o  decouple swapper_space treatment from other address_spaces                       (akpm@zip.com.au)
o  Allow ext3 pages to be written back by VM pressure                               (akpm@zip.com.au)
o  Fix SMP race in truncate                                                         (akpm@zip.com.au)
o  handle concurrent block_write_full_page and set_page_dirty                       (akpm@zip.com.au)
o  Fix PG_launder                                                                   (akpm@zip.com.au)
o  Fix concurrent writepage and readpage                                            (akpm@zip.com.au)
o  Documentation update                                                             (akpm@zip.com.au)
o  remove PRD_SEGMENTS                                                              (axboe@suse.de)
o  2.5.13 IDE 50                                                                    (dalecki@evision-ventures.com)
o  2.5.13 IDE 51                                                                    (dalecki@evision-ventures.com)
o  2.5.13 IDE 52                                                                    (dalecki@evision-ventures.com)
o  2.5.13 IDE 53                                                                    (dalecki@evision-ventures.com)
o  [PATCH 2.5.13 IDE 54                                                             (dalecki@evision-ventures.com)
o  remove global_bufferlist_lock                                                    (hch@infradead.org)
o  fix config.in syntax errors.                                                     (hch@infradead.org)
<snip>


#!/usr/bin/perl -w

use strict;

my %people = ();
my $addr = "";
my @cur = ();
my $len = 60;

sub append_item()
{
	if (!$addr) { return; }
	if (!$people{$addr}) { @{$people{$addr}} = (); }
	push @{$people{$addr}}, [@cur];

	@cur = ();
}

sub print_terse_items($)
{
	my @items = @{$people{$_[0]}};
	while ($_ = shift @items) {
		my $fill = (" " x ($len - length(@$_[0]) + 1));
		print "@$_$fill($_[0])\n";
	}
}

while (<>) {
	# Match address
	if (/^\s*<([^>]+)>/) {
		# Add old item (if any) before beginning new
		append_item();
		$addr = $1;
	} elsif ($addr) {
		# Add line to patch
		# strip whitespace at start & end
		s/^\s*(.*)\s*$/$1/;
		# kill starting 'PATCH' captions
		s/\s*\[?PATCH\]?\s*//;
		# insert a bullet
		s/^(.*)$/o  $1/;
		# Only save 1 line
		if (scalar(@cur) < 1) {
			push @cur, "$_";
			# save record line length
			if ((my $nlen = length($_)) > $len) { $len = $nlen; }
		}
	} else {
		# Header information
		print;
	}
}

append_item();
foreach $addr (sort keys %people) {
	print_terse_items($addr);
}
