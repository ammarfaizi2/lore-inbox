Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVFDFt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVFDFt5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 01:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVFDFt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 01:49:57 -0400
Received: from mail.dvmed.net ([216.237.124.58]:30913 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261248AbVFDFtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 01:49:43 -0400
Message-ID: <42A140F1.5070707@pobox.com>
Date: Sat, 04 Jun 2005 01:49:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: 'shortlog' script for git
Content-Type: multipart/mixed;
 boundary="------------090208020504090108090000"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090208020504090108090000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


I've been wanting a shortlog script for summarizing my kernel 
submissions to Linus for a while.  This is now written, and the results 
are attached.  Simply use like

	git-shortlog < changes.txt
		or
	git-shortlog changes.txt

The changeset format the Perl script parses is that of
http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-changes-script

I'll change it to parse the git-whatchanged output format sometime soon; 
Linus hates it when I use git-changes-script since he thinks its ugly :)

	Jeff




--------------090208020504090108090000
Content-Type: text/plain;
 name="git-shortlog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-shortlog"

#!/usr/bin/perl -w

use strict;

my ($author, $desc, %map);
my $pstate = 1;

while (<>) {
	# skip to '^commit '
	if ($pstate == 1) {
		next unless /^commit /;
		$pstate++;
	}

	# get author
	elsif ($pstate == 2) {
		next unless /^author (.*) \S+ \S+ \S+ \S+ \S+ \S+\s*$/;
		$author = $1;
		$pstate++;
	}

	# skip to blank line
	elsif ($pstate == 3) {
		next unless /^\s*$/;
		$pstate++;
	}

	# skip to non-blank line
	elsif ($pstate == 4) {
		next if /^\s*$/;
		chomp;
		$desc = $_;

		&shortlog_entry($author, $desc);

		$pstate = 1;
	}

	else {
		die "invalid parse state $pstate";
	}
}

&shortlog_output;
exit(0);


sub shortlog_entry($$) {
	my ($tmp_author, $tmp_desc) = @_;
	my ($obj);

	$tmp_desc =~ s#/pub/scm/linux/kernel/git/#/.../#g;
	$tmp_desc =~ s/^\[PATCH] //g;
	$tmp_desc =~ s/^\s+//g;

	if (exists $map{$tmp_author}) {
		# grab ref
		$obj = $map{$tmp_author};

		# add desc to array
		push(@$obj, $tmp_desc);
	} else {
		# create ref to new array
		my @arr = ($tmp_desc);
		$obj = \@arr;

		# store new entry in author map
		$map{$tmp_author} = $obj;
	}
}

sub shortlog_output {
	my ($obj);

	foreach $author (sort keys %map) {
		print "$author:\n";

		$obj = $map{$author};
		foreach $desc (@$obj) {
			print "  $desc\n";
		}

		print "\n";
	}
}


--------------090208020504090108090000--
