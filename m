Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVCCS00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVCCS00 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 13:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVCCSZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 13:25:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26774 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261241AbVCCSXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:23:54 -0500
Message-ID: <4227562C.70503@pobox.com>
Date: Thu, 03 Mar 2005 13:23:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Waitz <tali@admingilde.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: script to send changesets per mail
References: <20050303105950.GH8617@admingilde.org>
In-Reply-To: <20050303105950.GH8617@admingilde.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Waitz wrote:
> hoi :)
> 
> I just tested my little script that can send changesets per mail.
> okok, it still had a bug when I first tested it but that should be
> fixed now.
> 
> If anyone is interested (perhaps for Documentation/BK-usage), here it
> is:

Putting this in Documentation/BK-usage would be fine.


> #!/usr/bin/perl -w
> 
> # after sending an announcement (created by Documentation/BK-usage/bk-make-sum)
> # just pipe your mail through this script.
> # It will create one new mail per Changeset, properly threaded.
> 
> # Copyright © 2005 Martin Waitz <tali@admingilde.org>
> 
> use strict;
> 
> my $from;
> my $to;
> my $cc;
> my $references;
> 
> # all local repositories are in ~/src/.
> # you have to adjust this function if you keep them elsewhere.
> sub local_repository($) {
> 	my $repo;
> 	
> 	$repo= shift;
> 
> 	$repo =~ s,.*/,"$ENV{HOME}/src/",e;
> 	return $repo;
> }
> 
> # this checks if we are allowed to send mails with this sender
> # please modify the regexp to check for your adress!
> sub check_from($) {
> 	my $from = shift;
> 
> 	exit 1 unless $from =~ /insert-your-email-here/; #FIXME
> }

Move 'insert email here' into a default variable, a variable that can be 
overridden by an environment variable.


> # send one changeset.
> # Parameters: the cset number, description prefix and the actual description.
> sub send_cset($$$$) {
> 	my ($cset, $serial, $desc, $longdesc) = @_;
> 
> 	open (MAIL, "| /usr/sbin/sendmail -t") or die "fork sendmail: $!";
> 	print MAIL "From: $from\n";
> 	print MAIL "To: $to\n";
> 	print MAIL "Cc: $cc\n" if $cc;
> 	print MAIL "References: $references\n" if $references;
> 	print MAIL "Subject: [PATCH $serial] $desc\n";
> 	print MAIL "\n";
> 	print MAIL "$desc\n";
> 	print MAIL "$longdesc\n";
> 	print MAIL "\n";
> 	print MAIL `bk export -tpatch -du -r $cset`;
> 	close (MAIL) or die "could not send mail: error code $?";

I would suggest '-hdu' to avoid the patch header, but some may disagree.


> # Parse header
> while (<>) {
> 	chomp;
> 	last if /^$/;
> 
> 	if (/^From:\s+(.+)$/i) {
> 		$from = $1;
> 	} elsif (/^To:\s+(.+)$/i) {
> 		$to = $1;
> 	} elsif (/^Cc:\s+(.+)$/i) {
> 		$cc = $1;
> 	} elsif (/^Message-Id:\s+(.+)$/i) {
> 		$references = $1;
> 	}

note that this misses multi-line headers.  multi-line headers are those 
where the second, and succeeding lines begin with whitespace.


