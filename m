Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSELWMS>; Sun, 12 May 2002 18:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315441AbSELWMR>; Sun, 12 May 2002 18:12:17 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:50948 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315440AbSELWMP>; Sun, 12 May 2002 18:12:15 -0400
Date: Mon, 13 May 2002 00:12:09 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Marcus Alanen <marcus@infa.abo.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020512221209.GE1020@louise.pinerecords.com>
In-Reply-To: <20020512010709.7a973fac.spyro@armlinux.org> <abmi0f$ugh$1@penguin.transmeta.com> <abmi0f$ugh$1@penguin.transmeta.com> <873cwx2hi4.fsf@CERT.Uni-Stuttgart.DE> <200205122142.AAA26566@infa.abo.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 1:11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [Marcus Alanen <marcus@infa.abo.fi>, May-13 2002, Mon, 00:42 +0300]
> In mailing-lists.linux-kernel, you wrote:
> >torvalds@transmeta.com (Linus Torvalds) writes:
> >
> >> Perl is the obvious choice for doing transformations like these. Is
> >> anybody willing to write a perl script that does the "sort by author"
> >> thing?
>
> [snip]
> Basically the same, this treats each patch separately:

I took the liberty of kicking it up another notch :)

	- allow whitespace at the beginning of email line (strip it, though)

	- remove whitespace at the beginning and the end of "content"
	lines and print everything out with a single tab in front

T.


Will process horrible mess like:
--
 <jsimmons@heisenberg.transvirtual.com> asfd
     A bunch of fixes.

<jsimmons@heisenberg.transvirtual.com>	
	    Pmac updates

<jsimmons@heisenberg.transvirtual.com>	   mmmm
   Some more small fixes.

<rmk@arm.linux.org.uk>
	      [PATCH] 2.5.13: vmalloc link failure

	The following patch fixes this, and also fixes the similar problem in
	 scsi_debug.c:

<trond.myklebust@fys.uio.no>
	[PATCH] in_ntoa link failure

	Nothing serious. Whoever it was that did that global replacemissed a
	spot is all...

<viro@math.psu.edu>
	[PATCH] change_floppy() fix

	Needed both in 2.4 and 2.5

-- into: --

<jsimmons@heisenberg.transvirtual.com>
	--------------------------------------------------------------
	A bunch of fixes.

	--------------------------------------------------------------
	Pmac updates

	--------------------------------------------------------------
	Some more small fixes.


<rmk@arm.linux.org.uk>
	--------------------------------------------------------------
	[PATCH] 2.5.13: vmalloc link failure

	The following patch fixes this, and also fixes the similar problem in
	scsi_debug.c:


<trond.myklebust@fys.uio.no>
	--------------------------------------------------------------
	[PATCH] in_ntoa link failure

	Nothing serious. Whoever it was that did that global replacemissed a
	spot is all...


<viro@math.psu.edu>
	--------------------------------------------------------------
	[PATCH] change_floppy() fix

	Needed both in 2.4 and 2.5

--

#!/usr/bin/perl -w

use strict;

my %people = ();
my $addr = "";
my @cur = ();

sub append_item() {
	if (!$addr) { return; }
	if (!$people{$addr}) { @{$people{$addr}} = (); }
	push @{$people{$addr}}, [@cur];

	@cur = ();
}

while (<>) {
	# Match address
	if (/^\s*<([^>]+)>/) {
		# Add old item (if any) before beginning new
		append_item();
		$addr = $1;
	} elsif ($addr) {
		# Add line to patch
		s/^\s*(.*)\s*$/$1/;
		push @cur, "\t$_\n";
	} else {
		# Header information
		print;
	}
}


sub print_items($) {
	my @items = @{$people{$_[0]}};
	# Vain attempt to sort patches from one address
	@items = sort @items;
	while ($_ = shift @items) {
		# Item separator
		print "\t--------------------------------------------------------------\n";
		print @$_;
	}
}

append_item();
foreach $addr (sort keys %people) {
	print "<$addr>\n";
	print_items($addr);
	print "\n";
}
