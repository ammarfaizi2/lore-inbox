Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313293AbSEMN2R>; Mon, 13 May 2002 09:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313299AbSEMN2R>; Mon, 13 May 2002 09:28:17 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:13830 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313293AbSEMN2P>; Mon, 13 May 2002 09:28:15 -0400
Date: Mon, 13 May 2002 15:27:34 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: "Dave Gilbert (Home)" <gilbertd@treblig.org>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020513132734.GA5134@louise.pinerecords.com>
In-Reply-To: <20020512145802Z313578-22651+30503@vger.kernel.org> <Pine.LNX.4.44L.0205122146310.32261-100000@imladris.surriel.com> <20020513115800.GC4258@louise.pinerecords.com> <3CDFB41A.6070701@treblig.org> <20020513140158.B6024@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 18:42)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Alright, another one.
> > > 
> > > $ ./fmtcl2.pl /usr/src/ChangeLog-2.5.14
> > > 
> > > Summary of changes from v2.5.13 to v2.5.14
> > > ============================================
> > > 
> > > o  kd.h                                                                             (Andries.Brouwer@cwi.nl)
> > > o  NTFS: Release 2.0.6 - Major bugfix to make compatible with other kernel changes. (aia21@cantab.net)
> > > o  mm/memory.c:                                                                     (aia21@cantab.net)
> > > o  suppress allocation warnings for radix-tree allocations                          (akpm@zip.com.au)
> > 
> > <snip>
> > 
> > Ah - thats it!
> 
> Not quite.  In mutt, it looks like this:
> 
> o  kd.h
> +(Andries.Brouwer@cwi.nl)
> o  NTFS: Release 2.0.6 - Major bugfix to make compatible with other kernel
> +changes. (aia21@cantab.net)
> o  mm/memory.c:
> +(aia21@cantab.net)
> o  suppress allocation warnings for radix-tree allocations
> +(akpm@zip.com.au)
> o  radix-tree locking fix
> +(akpm@zip.com.au)
> o  Allow truncate to discard unmapped buffers
> +(akpm@zip.com.au)
> o  decouple swapper_space treatment from other address_spaces
> 
> NOT easy to read.

Hmm, now that's true.

How's this for another try? (logwidth = 38, adjustable per taste)
Myself I'd say this is crap and a nice 140-char xterm will do much
better (you're going to see "long" lines anyway, look at the NTFS
entry below).

$ ./fmtcl3.pl /usr/src/ChangeLog-2.5.14

Summary of changes from v2.5.13 to v2.5.14
============================================

o  kd.h                                (Andries.Brouwer@cwi.nl)
o  NTFS: Release 2.0.6 - Major bugfix to make compatible with other kernel changes.
                                       (aia21@cantab.net)
o  mm/memory.c:                        (aia21@cantab.net)
o  suppress allocation warnings for radix-tree allocations
                                       (akpm@zip.com.au)
o  radix-tree locking fix              (akpm@zip.com.au)
o  Allow truncate to discard unmapped buffers
                                       (akpm@zip.com.au)
o  decouple swapper_space treatment from other address_spaces
                                       (akpm@zip.com.au)
o  Allow ext3 pages to be written back by VM pressure
                                       (akpm@zip.com.au)
o  Fix SMP race in truncate            (akpm@zip.com.au)
o  handle concurrent block_write_full_page and set_page_dirty
                                       (akpm@zip.com.au)
o  Fix PG_launder                      (akpm@zip.com.au)
o  Fix concurrent writepage and readpage
                                       (akpm@zip.com.au)
<snip>


#!/usr/bin/perl -w

use strict;

my $logwidth = 38;

my %people = ();
my $addr = "";
my @cur = ();

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
		my $len = length(@$_[0]);
		my $fill = ($len <= $logwidth) ? (" " x ($logwidth - $len + 1)) : ("\n" . (" " x ($logwidth + 1)));
		print "@$_[0]$fill($_[0])\n";
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
		if (scalar(@cur) < 1) { push @cur, "$_"; }
	} else {
		# Header information
		print;
	}
}

append_item();
foreach $addr (sort keys %people) {
	print_terse_items($addr);
}
