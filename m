Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293182AbSCFD5w>; Tue, 5 Mar 2002 22:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293181AbSCFD5o>; Tue, 5 Mar 2002 22:57:44 -0500
Received: from rj.sgi.com ([204.94.215.100]:12206 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S293175AbSCFD5k>;
	Tue, 5 Mar 2002 22:57:40 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: init_idle reaped before final call 
In-Reply-To: Your message of "05 Mar 2002 17:06:43 CDT."
             <1015366005.1157.776.camel@thanatos> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Mar 2002 14:57:12 +1100
Message-ID: <13805.1015387032@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Mar 2002 17:06:43 -0500, 
Thomas Hood <jdthood@mail.com> wrote:
>I think you're right.  To prevent the mistake from
>happening again, I'd suggest you add a comment to your
>patch for init_idle(), explaining that it can't be __init 
>because it is called by cpu_idle, which is called
>by rest_init(), which ...
>
>I wonder if an automated __init consistency checker 
>would be helpful.

Looks like it will, I found a lot of dubious code by running
reference_init.pl (below).

Unfortunately I had to exclude references from read only data to .init
sections, almost all of these are false positives, they are created by
gcc.  The downside of excluding rodata is that there really are some
user references from rodata to init code, e.g. drivers/video/vgacon.c

const struct consw vga_con = {
        con_startup:            vgacon_startup,

where vgacon_startup is __init.  If you want to wade through the false
positives, take out the check for rodata.


#!/usr/bin/perl -w
#
# reference_init.pl (C) Keith Owens 2002 <kaos@ocs.com.au>
#
# List references to vmlinux init sections from non-init sections.

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
foreach $object (sort(keys(%object))) {
	my $from;
	open(OBJDUMP, "objdump -r $object|") || die "cannot objdump -r $object";
	while (defined($line = <OBJDUMP>)) {
		chomp($line);
		if ($line =~ /RELOCATION RECORDS FOR /) {
			($from = $line) =~ s/.*\[([^]]*).*/$1/;
		}
		if ($line =~ /\.init$/ &&
		    ($from !~ /\.init$/ && $from !~ /\.stab$/ && $from !~ /\.rodata$/ && $from !~ /\.text\.lock$/)) {
			printf("Error: %s %s refers to %s\n", $object, $from, $line);
		}
	}
	close(OBJDUMP);
}
printf("Done\n");

