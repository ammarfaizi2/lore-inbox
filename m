Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278078AbRKXMtB>; Sat, 24 Nov 2001 07:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278081AbRKXMsu>; Sat, 24 Nov 2001 07:48:50 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:7617 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S278078AbRKXMsm>; Sat, 24 Nov 2001 07:48:42 -0500
Date: 24 Nov 2001 12:01:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8DUadXKmw-B@khms.westfalen.de>
In-Reply-To: <20011123185407.A3499@alcove.wittsend.com>
Subject: Re: is 2.4.15 really available at www.kernel.org?
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20011123185407.A3499@alcove.wittsend.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mhw@wittsend.com (Michael H. Warfield)  wrote on 23.11.01 in <20011123185407.A3499@alcove.wittsend.com>:

> 	I typically keep 4 to six fall back versions in each of the
> 2.2 and 2.4 lines active and want (or occasionally need) to target specific
> versions, especially when I'm testing preX kernels and my device driver.
> You are way TOO simple.

I keep more (though I really don't need that many) ... and I *do* add text  
to kernel names myself.

So I wrote a (very quick-and-dirty) little Perl script. Maybe a variant of  
that works for other people, too.

Features: label is (hopefully sensibly) shortened image name. Also, a  
number is used as an alias; it's easier to select "1" than some lengthy  
string. Kernels are (hopefully) sorted chronologically (this doesn't work  
if EXTRAVERSION starts with a letter).

WARNING: this makes some assumptions about my system. You need to adapt  
that part.

WARNING: the sort routine only works on a Debian system. If you live on  
something else, adapt the sorter.

The script asks before overwriting your lilo.conf and keeps backups, so  
you have a chance of looking at the result and tweaking the script before  
committing to it.

License: public domain.

make-lilo.conf.pl:
#! /usr/bin/perl -w

use strict;

open LILO, "> /etc/lilo.conf.gen" or die $!;
print LILO <<headend;
# LILO configuration created by $0 @{[scalar localtime]}

linear
boot = /dev/sda
compact
delay = 100	# optional, for systems that boot very quickly
#vga = normal	# force sane state
vga = ask
root = current	# use "current" root
#root = /dev/sdc1
#other = /dev/sda1
#  table = /dev/sda
#  label = dos

headend

my $sorter = sub {
	my ($aa, $bb) = ($a, $b);
	$aa =~ tr/+/-/;
	$bb =~ tr/+/-/;
	$aa eq $bb? 0:
	system('/usr/bin/dpkg', '--compare-versions', $aa, 'lt', $bb)? -1: 1;
};

opendir BOOT, "/boot/" or die $!;
my @kernels = sort $sorter grep m/linu/i, readdir BOOT;
close BOOT;

my $n = 0;

for my $kernel (@kernels) {
	my ($version) = ($kernel =~ m/^[-a-z]*(.*)$/);
	$version =~ s/.*(.{15})$/$1/ if length($version) > 15;
	$n++;
	if ($n > 9) {
		print "Ignoring $kernel ($n)\n";
		next;
	}
	print LILO <<imageend;
	
image = /boot/$kernel
  label = $version
  alias = $n
  append = " hisax=3,2,10, "

imageend
}

close LILO;

system('/bin/mv', '-vib', '/etc/lilo.conf.gen', '/etc/lilo.conf');

system('/sbin/lilo');


MfG Kai
