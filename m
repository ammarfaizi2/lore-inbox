Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVEFOeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVEFOeu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 10:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVEFOeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 10:34:50 -0400
Received: from soundwarez.org ([217.160.171.123]:35022 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261168AbVEFOeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 10:34:21 -0400
Subject: Re: Empty partition nodes not created (was device node issues with
	recent mm's and udev)
From: Kay Sievers <kay.sievers@vrfy.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, chrisw@osdl.org,
       aebr@win.tue.nl, "Randy.Dunlap" <rddunlap@osdl.org>,
       Greg KH <greg@kroah.com>, joecool1029@gmail.com,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1115388767.4989.2.camel@mulgrave>
References: <d4757e6005050219514ece0c0a@mail.gmail.com>
	 <20050503031421.GA528@kroah.com>
	 <20050502202620.04467bbd.rddunlap@osdl.org>
	 <20050506080056.GD4604@pclin040.win.tue.nl>
	 <20050506081009.GX23013@shell0.pdx.osdl.net>
	 <20050506084259.GB25418@apps.cwi.nl>
	 <20050506020518.0b0afdc3.akpm@osdl.org>  <1115388767.4989.2.camel@mulgrave>
Content-Type: multipart/mixed; boundary="=-7hGaa0cYIw7mY+z90f8v"
Date: Fri, 06 May 2005 16:34:19 +0200
Message-Id: <1115390059.32065.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7hGaa0cYIw7mY+z90f8v
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-05-06 at 09:12 -0500, James Bottomley wrote:
> On Fri, 2005-05-06 at 02:05 -0700, Andrew Morton wrote:
> > > Should it be backed out of 2.6.11.8? Possibly - but if it will be
> > > part of 2.6.12 or 2.6.13 then I would be inclined to leave it.
> > > 
> > > Andrew asks whether it should be removed from -mm.
> > 
> > It was merged into Linus's tree on March 8th (via bk, thank gawd.  How do
> > you find out that sort of info using git?  Generating a full log is
> > cheating).
> 
> Well, moving offtopic, but it is of relevance to people who use git.
> The answer is that the information exists (we can use the commit tree to
> reconstruct the file data) but that no-one has yet come up with a file
> history viewing tool.  I think David Woodhouse is the closest to
> producing one of these, David?

Here (replace f=<file>):
  http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;f=lib/kobject.c

Or use Chris Mason's perl script:
  http://marc.theaimsgroup.com/?l=git&m=111468881317040&w=2

I've attached it, updated to the recent git-* rename.

Thanks,
Kay

--=-7hGaa0cYIw7mY+z90f8v
Content-Disposition: inline; filename=file-changes
Content-Type: application/x-perl; name=file-changes
Content-Transfer-Encoding: 7bit

#!/usr/bin/perl

use strict;

my $ret;
my $i;
my @wanted = ();
my $argc = scalar(@ARGV);
my $commit;
my $stop;
my $file_list = "";

sub print_usage() {
    print STDERR "usage: file-changes [-c commit] [-s stop commit] file_list\n";
    exit(1);
}

sub print_commit($) {
    my ($c) = @_;
    print "git-cat-file commit $c\n";
    open(COMMIT, "git-cat-file commit $c|") || die "git-cat-file $c failed";
    while(<COMMIT>) {
	print "    $_";
    }
    close(COMMIT);
    if ($? && ($ret = $? >> 8)) {
	die "git-cat-file failed with $ret";
    }
    print "\n";
}

sub test_diff($$) {
    my ($a, $b) = @_;
    my $matched = 0;
    open(DT, "git-diff-tree -r $a $b $file_list|") || die "git-diff-tree failed";
    while(<DT>) {
        chomp;
	my @words = split;
	my $file = $words[3];
	# if the filename has whitespace, suck it in
	if (scalar(@words) > 4) {
	    if (m/$file(.*)/) {
	        $file .= $1;
	    }
	}
	foreach my $m (@wanted) {
	    if ($file =~ m/^$m/) {
		if (!$matched) {
		    print "git-diff-tree -r $a $b\n";
		}
		print "$words[2] $file\n";
		$matched = 1;
	    }
	}
    }
    close(DT);
    if ($? && ($ret = $? >> 8)) {
	die "git-diff-tree failed with $ret";
    }
    return $matched;
}

if ($argc < 1) {
    print_usage();
}

for ($i = 0 ; $i < $argc ; $i++)  {
    if ($ARGV[$i] eq "-c") {
    	if ($i == $argc - 1) {
	    print_usage();
	}
	$commit = $ARGV[++$i];
    } elsif ($ARGV[$i] eq "-s") {
    	if ($i == $argc - 1) {
	    print_usage();
	}
	$stop = $ARGV[++$i];
    } else {
	push @wanted, $ARGV[$i];
	$file_list .= "$ARGV[$i] ";
    }
}

if (!defined($commit)) {
    $commit = `commit-id`;
    if ($?) {
    	print STDERR "commit-id failed, try using -c to specify a commit\n";
	exit(1);
    }
    chomp $commit;
}

open(RL, "git-rev-list $commit|") || die "git-rev-list failed";
while(<RL>) {
    chomp;
    my $cur = $_;
    my $matched = 0;
    open(PARENT, "git-cat-file commit $cur|") || die "git-cat-file failed";
    while(<PARENT>) {
        chomp;
	my @words = split;
	if ($words[0] eq "tree") {
	    next;
	} elsif ($words[0] ne "parent") {
	    last;
	}
	$matched += test_diff($words[1], $cur);
    }
    close(PARENT);
    if ($? && ($ret = $? >> 8)) {
        die "cat-file failed with $ret";
    }
    if ($matched) {
        print_commit($cur);
    }
    if ($cur eq $stop) {
        last;
    }
}
close(RL);

if ($? && ($ret = $? >> 8)) {
    die "git-rev-list failed with $ret";
}


--=-7hGaa0cYIw7mY+z90f8v--

