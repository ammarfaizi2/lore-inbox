Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSEMXlk>; Mon, 13 May 2002 19:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314723AbSEMXlj>; Mon, 13 May 2002 19:41:39 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:18436 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S314707AbSEMXlg>; Mon, 13 May 2002 19:41:36 -0400
Date: Tue, 14 May 2002 01:41:25 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Changelogs on kernel.org
Message-ID: <20020513234125.GD713@louise.pinerecords.com>
In-Reply-To: <20020513144519.GC5134@louise.pinerecords.com> <Pine.LNX.4.44.0205131759480.5254-100000@alumno.inacap.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 1:40)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Added an usage note
> - Changed CMODE environment variable for a command line argument

Thanks, but the idea behind CMODE is that it's possible to set the
output mode and still have the script act both as a filter and file
eater (multiple changelogs on cmdline are ok of course) w/o having
to handle the eating "explicitly."

Plus one can put "export CMODE=something" in ~/.profile and forget
about the modes entirely.

Here comes 0.92 (s/LOWER CAPS/lower case/ as pointed out by
Kai Henningsen). Let's call it a candidate for inclusion in
scripts/. Linus?

Take care,
T.


#!/usr/bin/perl -w
#
# This Perl script is meant to simplify/beautify BK ChangeLogs
# for the linux kernel.
#
# (C) Copyright 2002 by Matthias Andree <matthias.andree@gmx.de>,
#			Marcus Alanen <maalanen@abo.fi>,
#			Tomas Szepe <szepe@pinerecords.com>
#
# Version 0.92.
# (Please don't bump this if you've just added another email-to-name
# mapping entry to the db.)
#
# ------------------------------------------------------------------
# Distribution of this script is permitted under the terms of the
# GNU General Public License (GNU GPL) v2.
# ------------------------------------------------------------------
#
# This program expects its input in the following format:
# (E-Mail Addresses MUST NOT bear leading whitespace!)
#
# <email@ddr.ess>
#	changelog text
#	more changelog text
# <email@ddr.ess>
#	yet another changelog
# <another@add.ress>
#	changelog #3
#	more lines
#
# Groups and sorts the entries by email address:
#
# another@add.ress:
#	changelog #3
# email@ddr.ess
#	changelog text
#	yet another changelog
#
# There are three different modes:
# - Short mode (one changelog == one line)
# - Full mode (changelogs separated by dashed line)
# - Original mode (one line consisting of changelog and author)
#
# Where possible, also adds the real name of the author using
# a static hash %addresses
#

use strict;

# CMODE environment variable selects output mode:
# 0 for short, 1 for full, 2 for "original changelog"
# (default is 2 if $CMODE unset)
#
my $mode = 2;
foreach my $en (keys(%ENV)) {
	if ($en eq "CMODE") {
		$mode = $ENV{CMODE};
		if ($mode ne "0" && $mode ne "1" && $mode ne "2") {
			print "CMODE has to be 0 for short, 1 for full, 2 for orig. Undefined defaults to 2.\n";
			die();
		}
		last;
	}
}

# minimum space between entry and author for the original mode
my $space = 5;

# The key is the email address *in lower case*,
# the value is the real name of the person.
#
my %addresses = (
	'aia21@cantab.net'			=> 'Anton Altaparmakov',
	'ak@muc.de'				=> 'Andi Kleen',
	'akpm@zip.com.au'			=> 'Andrew Morton',
	'alan@lxorguk.ukuu.org.uk'		=> 'Alan Cox',
	'andrea@suse.de'			=> 'Andrea Arcangeli',
	'ankry@green.mif.pg.gda.pl'		=> 'Andrzej Krzysztofowicz',
	'axboe@suse.de'				=> 'Jens Axboe',
	'bgerst@didntduck.org'			=> 'Brian Gerst',
	'dalecki@evision-ventures.com'		=> 'Martin Dalecki',
	'davem@redhat.com'			=> 'David S. Miller',
	'davidel@xmailserver.org'		=> 'Davide Libenzi',
	'green@namesys.com'			=> 'Oleg Drokin',
	'hch@infradead.org'			=> 'Christoph Hellwig',
	'jgarzik@mandrakesoft.com'		=> 'Jeff Garzik',
	'jsimmons@heisenberg.transvirtual.com'	=> 'James Simmons',
	'jsimmons@transvirtual.com'		=> 'James Simmons',
	'kaos@ocs.com.au'			=> 'Keith Owens',
	'lm@bitmover.com'			=> 'Larry McVoy',
	'manfred@colorfullife.com'		=> 'Manfred Spraul',
	'neilb@cse.unsw.edu.au'			=> 'Neil Brown',
	'paulus@samba.org'			=> 'Paul Mackerras',
	'perex@suse.cz'				=> 'Jaroslav Kysela',
	'rgooch@ras.ucalgary.ca'		=> 'Richard Gooch',
	'rmk@arm.linux.org.uk'			=> 'Russell King',
	'szepe@pinerecords.com'			=> 'Tomas Szepe',
	'torvalds@transmeta.com'		=> 'Linus Torvalds',
	'viro@math.psu.edu'			=> 'Alexander Viro',
	'~~~~thisentrylastforconvenience~~~~'	=> 'Cesar Brutus Anonymous'
);

my %people = ();
my $addr = "";
my @cur = ();

sub append_item()
{
	if (!$addr) {
		return;
	}
	if (!$people{$addr}) {
		@{$people{$addr}} = ();
	}
	push @{$people{$addr}}, [@cur];

	@cur = ();
}

# get name associated to an email address
sub rmap_address
{
	my @o = map {defined $addresses{lc $_} ? $addresses{lc $_} : $_ } @_;
	return wantarray ? @o : $o[0];
}

sub print_items($)
{
	my $person = $_[0];
	my $realname = rmap_address($person);
	my @items = @{$people{$person}};

	# Vain attempt to sort patches from one address
	@items = sort @items;
	if ($mode == 0 or $mode == 1) {
		if ($realname ne $person) {
			print "$realname ";
		}
		print "<$person>\n";
	}
	while ($_ = shift @items) {
		if ($mode == 0) {
			print "\to " . @$_[0];
		} elsif ($mode == 1) {
			print "\t------------------------------------------------------------\n";
			foreach $_ (@$_) {
				print "\t$_";
			}
		} elsif ($mode == 2) {
			$_ = @$_[0];
			chop;
			$_ = "o $_";
			# Split it onto two lines if necessary
			if (length("$_ . $realname") > 76 - $space) {
				print "$_\n" . " " x (76 - length($realname)) . "$realname\n";
			} else {
				print "$_" . " " x (76 - length($realname) - length($_)) . "$realname\n";
			}
		}
	}
}

while (<>)
{
	# Match address
	if (/^<([^>]+)>/) {
		# Add old item (if any) before beginning new
		append_item();
		$addr = $1;
	} elsif ($addr) {
		# Add line to patch
		s/^\s*(.*)\s*$/$1/;
		s/\[?PATCH\]?\s*//i;
		push @cur, "$_\n";
	} else {
		# Header information
		print;
	}
}
append_item();

# Print the information
foreach $addr (sort keys %people) {
	print_items($addr);
	if ($mode != 2) { print "\n"; }
}
