Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283680AbRLWFTN>; Sun, 23 Dec 2001 00:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283658AbRLWFTE>; Sun, 23 Dec 2001 00:19:04 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:9995 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S283680AbRLWFSv>;
	Sun, 23 Dec 2001 00:18:51 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: nveber@pyre.virge.net (Norbert Veber)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17] net/network.o(.text.lock+0x1a88): undefined reference to `local symbols... 
In-Reply-To: Your message of "Sat, 22 Dec 2001 22:22:13 CDT."
             <20011223032213.GA20031@pyre.virge.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Dec 2001 16:18:39 +1100
Message-ID: <22315.1009084719@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2001 22:22:13 -0500, 
nveber@pyre.virge.net (Norbert Veber) wrote:
>net/network.o(.text.lock+0x1a88): undefined reference to `local symbols in discarded section .text.exit'

Got bored, wrote some Perl (Oh hang on, I've used that before).

net/network.o is not much help, it is a conglomerate object.  I need
the individual object that is failing.  cd linux and run
reference_discarded.pl below.

Any other patches applied?


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

