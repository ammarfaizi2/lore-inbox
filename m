Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbSJSN6P>; Sat, 19 Oct 2002 09:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265604AbSJSN6P>; Sat, 19 Oct 2002 09:58:15 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:43015 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265603AbSJSN6O>;
	Sat, 19 Oct 2002 09:58:14 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: reference_discarded.pl updated for 2.5.44
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 Oct 2002 00:04:03 +1000
Message-ID: <11237.1035036243@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Summary of changes from v2.5.43 to v2.5.44
>============================================
>Matthew Wilcox <willy@debian.org>:
>  o Allow compilation with -ffunction-sections

If you get linker error 'undefined reference to local symbols in
discarded section' then run this script (reference_discarded.pl) in the
kernel object tree.  It has been updated for kernel 2.5.44, this
updated version will also work on older kernels.

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
		     $line =~ /\.exit\.text$/ ||
		     $line =~ /\.data\.exit$/ ||
		     $line =~ /\.exit\.data$/ ||
		     $line =~ /\.exitcall\.exit$/) &&
		    ($from !~ /\.text\.exit$/ &&
		     $from !~ /\.exit\.text$/ &&
		     $from !~ /\.data\.exit$/ &&
		     $from !~ /\.exit\.data$/ &&
		     $from !~ /\.exitcall\.exit$/ &&
		     $from !~ /\.stab$/)) {
			printf("Error: %s %s refers to %s\n", $object, $from, $line);
		}
	}
	close(OBJDUMP);
}
printf("Done\n");

