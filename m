Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWE0C1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWE0C1U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 22:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWE0C1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 22:27:20 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:48100 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751767AbWE0C1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 22:27:19 -0400
Message-ID: <4477B905.9090806@garzik.org>
Date: Fri, 26 May 2006 22:27:17 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Git Mailing List <git@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [SCRIPT] chomp: trim trailing whitespace
Content-Type: multipart/mixed;
 boundary="------------030305020406070900020809"
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030305020406070900020809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Attached to this email is chomp.pl, a Perl script which removes trailing 
whitespace from several files.  I've had this for years, as trailing 
whitespace is one of my pet peeves.

Now that git-applymbox complains loudly whenever a patch adds trailing 
whitespace, I figured this script may be useful to others.

	Jeff




--------------030305020406070900020809
Content-Type: application/x-perl;
 name="chomp.pl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="chomp.pl"

#!/usr/bin/perl -w
#
# chomp: Trim trailing whitespace from a list of files.
#
# Usage: chomp file1 file2 file3...
#
# NOTE:  Files are modified in-place.  No backups are created.
#
# Files are, of course, not updated if they lack trailing whitespace.
#
#

use strict;

my ($argv_fn);
my $bytes_saved = 0;

while ($argv_fn = shift @ARGV) {
	&chomp_file($argv_fn);
}
printf "%u bytes chomped.\n", $bytes_saved;
exit(0);


sub chomp_file {
	my ($fn) = @_;
	my ($s, $i);
	my $chomped = 0;

	# read entire data file into memory
	open (F, $fn) or die "cannot open $fn: $!\n";
	my @data = <F>;
	close (F);

	# trim trailing whitespace
	foreach $i (0 .. $#data) {
		$s = $data[$i];
		if ($s =~ /\s$/) {
			while (($s) && ($s =~ /\s$/)) {
				chop $s;
				$bytes_saved++;
			}
			$s .= "\n";
			$bytes_saved--;
			if ($s ne $data[$i]) {
				$chomped = 1;
				$data[$i] = $s;
			}
		}
	}

	# dump data back to disk
	if ($chomped) {
		open (F, ">$fn") or die "cannot overwrite $fn: $!\n";
		print F @data;
		close (F);

		print "$fn modified.\n";
	}
}


--------------030305020406070900020809--
