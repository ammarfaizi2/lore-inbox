Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281926AbRL1QXq>; Fri, 28 Dec 2001 11:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279768AbRL1QXh>; Fri, 28 Dec 2001 11:23:37 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:22797 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S282413AbRL1QXY>;
	Fri, 28 Dec 2001 11:23:24 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sound fails to build when non-modular with new binutils 
In-Reply-To: Your message of "Fri, 28 Dec 2001 16:16:08 BST."
             <20011228151608.GA1870@telia.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 29 Dec 2001 03:23:11 +1100
Message-ID: <4841.1009556591@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001 16:16:08 +0100, 
=?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com> wrote:
>The new binutils in Debian uncovered a few bugs in the kernel, but I
>have not yet seen anyone post a patch for the problem where building
>sound with via82cxxx_audio set as non-modular fails with:
>
>drivers/sound/sounddrivers.o(.data+0xb4): undefined reference to `local symbols in discarded section .text.exit'

Run this, it will say precisely where the problem lies:

#!/usr/bin/perl -w
#
# reference_discarded.pl (C) Keith Owens 2001 <kaos@ocs.com.au>
#
# List dangling references to vmlinux discarded sections.

use strict;
die($0 . " takes no arguments\n") if($#ARGV >= 0);

my %object;
my $object;
my $line;
my $ignore;

$| = 1;

printf("Finding objects, ");
open(OBJDUMP_LIST, "find . -name '*.o' | xargs objdump -h |") || die "getting objdump list failed";
while (defined($line = <OBJDUMP_LIST>)) {
	chomp($line);
	if ($line =~ /:\s+file format/) {
		($object = $line) =~ s/:.*//;
		$object{$object}->{'module'} = 0;
		$object{$object}->{'size'} = 0;
		$object{$object}->{'off'} = 0;
	}
	if ($line =~ /^\s*\d+\s+\.modinfo\s+/) {
		$object{$object}->{'module'} = 1;
	}
	if ($line =~ /^\s*\d+\s+\.comment\s+/) {
		($object{$object}->{'size'}, $object{$object}->{'off'}) = (split(' ', $line))[2,5]; 
	}
}
close(OBJDUMP_LIST);
printf("%d objects, ", scalar keys(%object));
$ignore = 0;
foreach $object (keys(%object)) {
	if ($object{$object}->{'module'}) {
		++$ignore;
		delete($object{$object});
	}
}
printf("ignoring %d module(s)\n", $ignore);

# Ignore conglomerate objects, they have been built from multiple objects and we
# only care about the individual objects.  If an object has more than one GCC:
# string in the comment section then it is conglomerate.  This does not filter
# out conglomerates that consist of exactly one object, can't be helped.

printf("Finding conglomerates, ");
$ignore = 0;
foreach $object (keys(%object)) {
	if (exists($object{$object}->{'off'})) {
		my ($off, $size, $comment, $l);
		$off = hex($object{$object}->{'off'});
		$size = hex($object{$object}->{'size'});
		open(OBJECT, "<$object") || die "cannot read $object";
		seek(OBJECT, $off, 0) || die "seek to $off in $object failed";
		$l = read(OBJECT, $comment, $size);
		die "read $size bytes from $object .comment failed" if ($l != $size);
		close(OBJECT);
		if ($comment =~ /GCC\:.*GCC\:/m) {
			++$ignore;
			delete($object{$object});
		}
	}
}
printf("ignoring %d conglomerate(s)\n", $ignore);

printf("Scanning objects\n");
foreach $object (keys(%object)) {
	my $from;
	open(OBJDUMP, "objdump -r $object|") || die "cannot objdump -r $object";
	while (defined($line = <OBJDUMP>)) {
		chomp($line);
		if ($line =~ /RELOCATION RECORDS FOR /) {
			($from = $line) =~ s/.*\[([^]]*).*/$1/;
		}
		if (($line =~ /\.text\.exit$/ ||
		     $line =~ /\.data\.exit$/ ||
		     $line =~ /\.exitcall\.exit$/) &&
		    ($from !~ /\.text\.exit$/ &&
		     $from !~ /\.data\.exit$/ &&
		     $from !~ /\.exitcall\.exit$/)) {
			printf("Error: %s %s refers to %s\n", $object, $from, $line);
		}
	}
	close(OBJDUMP);
}
printf("Done\n");

