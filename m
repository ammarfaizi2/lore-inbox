Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317279AbSGZHeJ>; Fri, 26 Jul 2002 03:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317298AbSGZHeJ>; Fri, 26 Jul 2002 03:34:09 -0400
Received: from p50887AC9.dip.t-dialin.net ([80.136.122.201]:47747 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317279AbSGZHeH>; Fri, 26 Jul 2002 03:34:07 -0400
Date: Fri, 26 Jul 2002 01:36:21 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Andrew Morton <akpm@zip.com.au>
cc: Marc Duponcheel <mduponch@cisco.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.19-rc2 -> 2.4.19-rc3 : no more eth (fwd)
In-Reply-To: <3D404F41.77537E67@zip.com.au>
Message-ID: <Pine.LNX.4.44.0207260134360.14709-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 25 Jul 2002, Andrew Morton wrote:
> This script which someone wrote will break the diff into
> standalone chunks.

This one might work better.

#!/usr/bin/perl -w
#
# Copyright (c) 2002, Thunder from the hill <thunder@ngforever.de>
#
# $ld: split-patches,v 0.10.2 2002/06/01 00:40:49 GMT thunder Exp $
#
# -----------------------------------------------------------------
# Distribution of this script is permitted under the terms of the
# GNU General Public License (GNU GPL) v2.
# -----------------------------------------------------------------
# 
# This perl script splits patch files and sorts them as unified format into
# a tree form which is being taken from the patches.
#

require 5.004;

my @path;

my $i;
my $inbuf;
my $minusline;

my $filename;
my $fullname;
my $plusname;
my $minusname;

my $lines_applied = 0;
my $lines_dropped = 0;
my $lines_converted = 0;

my $fd_open = 0;

while (defined($inbuf = <>)) {
    $inbuf =~ s/\r//g;

    if ($inbuf =~ /^\+\+\+\s+/) {
	# "Control" sequence - decode filename and change it
	local ($shortname,$bigpath, $pdate, $mdate) = (0,"","");

	$plusname = $inbuf;
	$plusname =~ s/^\+\+\+\s+([\w\d\+\-\.\/]+)\s+[\w\d\,\:\s]+[\+\-]?\d*[\w\d\.\,\s\/\(\)\-\+]*$/$1/;

	$minusline =~s/\r//g;
	$minusname = $minusline;
	$minusname =~ s/^\-\-\-\s+([\w\d\+\-\.\/]+)\s+[\w\d\,\:\s]+[\+\-]?\d*[\w\d\.\,\s\/\(\)\-\+]*$/$1/;

	if ($plusname eq "/dev/null") {
	    $filename = $minusname;
	} else {
	    $filename = $plusname;
	}

	$fullname = $filename;
	@path = split("/", $filename);
	shift(@path);
	$filename = join("/", @path);
	$shortname = $path[-1];

	for ($i = 0; $i < scalar(@path)-1; $i++) {
	    if ($i == 0) {
		$bigpath = $path[0];
	    } else {
		$bigpath = sprintf("%s/%s", $bigpath, $path[$i]);
	    }

	    if (! -d $bigpath) {
		printf(STDERR "Creating directory %s\n", $bigpath);
		mkdir($bigpath, 0775);
	    }
	}

	if ($fd_open) {
	    close(FileDescriptor);
	}

	if ($minusname eq "/dev/null") {
	    printf(STDERR "Creating \"%s\"\n", $filename);
	} elsif ($plusname eq "/dev/null") {
	    printf(STDERR "Removing \"%s\"\n", $filename);
	} else {
	    printf(STDERR "Patching \"%s\"\n", $filename);
	}
	if (!open(FileDescriptor, sprintf(">%s.diff", $filename))) {
	    die(sprintf("Error %s opening \"%s\" for writing.\n",$!,$filename));
	} else {
	    $fd_open = 1;
	}

	$pdate = $inbuf;
	$pdate =~ s/^\+\+\+\s+[\w\d\+\-\.\/]+\s+([\w\d\,\:\s]+[\+\-]?\d*)[\w\d\.\,\s\/\(\)\-\+]*$/$1/;

	if (!($pdate =~ /\s[\+\-]\d\d\d\d$/)) {
	    $pdate .= " +0000";
	} else {
	    $pdate =~ s/[\+\-]\d\d\d\d$/\+0000/;
	}

	$mdate = $minusline;
	$mdate =~ s/^\+\+\+\s+[\w\d\+\-\.\/]+\s+([\w\d\,\:\s]+[\+\-]?\d*)[\w\d\.\,\s\/\(\)\-\+]*$/$1/;

	if (!($mdate =~ /\s[\+\-]\d\d\d\d$/)) {
	    $mdate .= " +0000";
	} else {
	    $mdate =~ s/[\+\-]\d\d\d\d$/\+0000/;
	}

	$pdate =~ s/\r//;
	$pdate =~ s/\n//;
	$mdate =~ s/\r//;
	$mdate =~ s/\n//;

	printf(FileDescriptor "diff -Nur %s %s\n--- %s %s\n+++ %s %s\n", $minusname, $plusname, $minusname, $mdate, $plusname, $pdate);
    } elsif ($inbuf =~ /^\-\-\-\s+/) {
	# Header lines, skip (we had our own version at the beginning
	# of the diff split

	$minusline = $inbuf;
    } elsif ($inbuf =~ /^[\+\- ]/) {
	# Unified diff line, just commit
	$inbuf =~ s/\n//g;

	if ($fd_open) {
	    printf(FileDescriptor "%s\n", $inbuf);
	    $lines_applied++;
	} else {
	    if (!$lines_dropped) {
		printf("Junk at beginning of patch\n");
	    }
	    $lines_dropped++;
	}
    } elsif ($inbuf =~ /^[\<\>]/) {
	# Convert to unified diff and apply
	$inbuf =~ s/\n//g;

	$inbuf =~ s/^\</-/;
	$inbuf =~ s/^\>/+/;
	if ($fd_open) {
	    printf(FileDescriptor "%s\n", $inbuf);
	    $lines_converted++;
	} else {
	    if (!$lines_dropped) {
		printf("Junk at beginning of patch\n");
	    }
	    $lines_dropped++;
	}
    } elsif ($inbuf =~ /^@@/) {
	# Line section change; apply please
	$inbuf =~ s/\n//g;

	if ($fd_open) {
	    printf(FileDescriptor "%s\n", $inbuf);
	    $lines_applied++;
	} else {
	    if (!$lines_dropped) {
		printf("Junk at beginning of patch\n");
	    }
	    $lines_dropped++;
	}
    } else {
	$lines_dropped++;
    }
}

if ($fd_open) {
    close(FileDescriptor);
    $fd_open = 0;
}

printf("\nApplied: %i, dropped: %i, converted: %i\n", $lines_applied, $lines_dropped, $lines_converted);

exit(0);

			Thunder
-- 
I promise you one day we'll again have lots of time
If you like, just arrange the sun that day to shine
Upon both of our graves

