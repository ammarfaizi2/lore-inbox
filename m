Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317602AbSG3BMi>; Mon, 29 Jul 2002 21:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318165AbSG3BMh>; Mon, 29 Jul 2002 21:12:37 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:25798 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S317602AbSG3BMg>; Mon, 29 Jul 2002 21:12:36 -0400
Date: Mon, 29 Jul 2002 18:15:52 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, binutils@sources.redhat.com
Subject: Re: Compiling kernel with -g may confuse binutils
Message-ID: <20020729181552.A21941@lucon.org>
References: <16624.1027989316@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16624.1027989316@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Tue, Jul 30, 2002 at 10:35:16AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 10:35:16AM +1000, Keith Owens wrote:
> Building the kernel with -g confuses binutils 2.12.90.0.1-4.  This
> error message (reported by Ramesh Panuganty)
> 
> drivers/built-in.o: In function `isapnp_peek':
> /usr/src/linux-2.5.28/drivers/pnp/isapnp.c:267: undefined reference to
> `local symbols in discarded section .text.exit'
> 
> was really caused by de_remove_one() in drivers/net/tulip/de2104x.c.

Please show how to exactly reproduce it with gcc 3.1.1.

> 
> Building with -g also generates false positives in my script that homes
> in on which object is causing the problem.  New version of
> reference_discarded.pl below, run it when you get 'discarded section'
> messages.
> 
> #!/usr/bin/perl -w
> #
> # reference_discarded.pl (C) Keith Owens 2001 <kaos@ocs.com.au>
> #
> # List dangling references to vmlinux discarded sections.
> 
> use strict;
> die($0 . " takes no arguments\n") if($#ARGV >= 0);
> 
> my %object;
> my $object;
> my $line;
> my $ignore;
> 
> $| = 1;
> 
> printf("Finding objects, ");
> open(OBJDUMP_LIST, "find . -name '*.o' | xargs objdump -h |") || die "getting objdump list failed";
> while (defined($line = <OBJDUMP_LIST>)) {
> 	chomp($line);
> 	if ($line =~ /:\s+file format/) {
> 		($object = $line) =~ s/:.*//;
> 		$object{$object}->{'module'} = 0;
> 		$object{$object}->{'size'} = 0;
> 		$object{$object}->{'off'} = 0;
> 	}
> 	if ($line =~ /^\s*\d+\s+\.modinfo\s+/) {
> 		$object{$object}->{'module'} = 1;
> 	}
> 	if ($line =~ /^\s*\d+\s+\.comment\s+/) {
> 		($object{$object}->{'size'}, $object{$object}->{'off'}) = (split(' ', $line))[2,5]; 
> 	}
> }
> close(OBJDUMP_LIST);
> printf("%d objects, ", scalar keys(%object));
> $ignore = 0;
> foreach $object (keys(%object)) {
> 	if ($object{$object}->{'module'}) {
> 		++$ignore;
> 		delete($object{$object});
> 	}
> }
> printf("ignoring %d module(s)\n", $ignore);
> 
> # Ignore conglomerate objects, they have been built from multiple objects and we
> # only care about the individual objects.  If an object has more than one GCC:
> # string in the comment section then it is conglomerate.  This does not filter
> # out conglomerates that consist of exactly one object, can't be helped.
> 
> printf("Finding conglomerates, ");
> $ignore = 0;
> foreach $object (keys(%object)) {
> 	if (exists($object{$object}->{'off'})) {
> 		my ($off, $size, $comment, $l);
> 		$off = hex($object{$object}->{'off'});
> 		$size = hex($object{$object}->{'size'});
> 		open(OBJECT, "<$object") || die "cannot read $object";
> 		seek(OBJECT, $off, 0) || die "seek to $off in $object failed";
> 		$l = read(OBJECT, $comment, $size);
> 		die "read $size bytes from $object .comment failed" if ($l != $size);
> 		close(OBJECT);
> 		if ($comment =~ /GCC\:.*GCC\:/m) {
> 			++$ignore;
> 			delete($object{$object});
> 		}
> 	}
> }
> printf("ignoring %d conglomerate(s)\n", $ignore);
> 
> printf("Scanning objects\n");
> foreach $object (keys(%object)) {
> 	my $from;
> 	open(OBJDUMP, "objdump -r $object|") || die "cannot objdump -r $object";
> 	while (defined($line = <OBJDUMP>)) {
> 		chomp($line);
> 		if ($line =~ /RELOCATION RECORDS FOR /) {
> 			($from = $line) =~ s/.*\[([^]]*).*/$1/;
> 		}
> 		if (($line =~ /\.text\.exit$/ ||
> 		     $line =~ /\.data\.exit$/ ||
> 		     $line =~ /\.exitcall\.exit$/) &&
> 		    ($from !~ /\.text\.exit$/ &&
> 		     $from !~ /\.data\.exit$/ &&
> 		     $from !~ /\.exitcall\.exit$/ &&
> 		     $from !~ /\.stab$/)) {
> 			printf("Error: %s %s refers to %s\n", $object, $from, $line);
> 		}
> 	}
> 	close(OBJDUMP);
> }
> printf("Done\n");
> 
