Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSEMLxY>; Mon, 13 May 2002 07:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313114AbSEMLxX>; Mon, 13 May 2002 07:53:23 -0400
Received: from infa.abo.fi ([130.232.208.126]:58642 "EHLO infa.abo.fi")
	by vger.kernel.org with ESMTP id <S313113AbSEMLxW>;
	Mon, 13 May 2002 07:53:22 -0400
Date: Mon, 13 May 2002 14:52:40 +0300
From: Marcus Alanen <marcus@infa.abo.fi>
Message-Id: <200205131152.OAA05817@infa.abo.fi>
To: riel@conectiva.com.br, Johnny Mnemonic <johnny@themnemonic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
In-Reply-To: <Pine.LNX.4.44L.0205122146310.32261-100000@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  - changedescription                         (author)
>So, is there anybody willing to put together the scripts to
>generate this changelog format automatically ?

Combining the efforts, the following almost makes coffee.

- Short mode
- Full mode
- Original mode

The original mode you requested prints the e-mail address, I guess
it should be the author's real name to look more nice.


#!/usr/bin/perl -w

use strict;


# 0 for short, 1 for full, 2 for "original changelog"
my $mode = 2;



# minimum space between entry and author for the original mode
my $space = 5;


my %people = ();
my $addr = "";
my @cur = ();
my $comment = 0;


sub append_item() {
        if (!$addr) {
                return;
        }
        if (!$people{$addr}) {
                @{$people{$addr}} = ();
        }
        push @{$people{$addr}}, [@cur];

        @cur = ();
}

while (<>) {
        # Match address
        if (/^\s*<([^>]+)>/) {
                # Add old item (if any) before beginning new
                append_item();
                $addr = $1;
                $comment = 1;
        } elsif ($addr) {
                # Add line to patch
                s/^\s*(.*)\s*$/$1/;
                $_ =~ s/\[PATCH\] //g;
                $_ =~ s/\s*PATCH //g;
                if ($comment == 1 or $mode != 0) {
                        push @cur, "$_\n";
                        $comment = 0;
                }
        } else {
                # Header information
                print;
        }
}
append_item();


sub print_items($) {
        my $person = $_[0];
        my @items = @{$people{$person}};
        # Vain attempt to sort patches from one address
        @items = sort @items;
	if ($mode == 0 or $mode == 1) {
                print "<$person>\n";
	} else {
	        $person = "($person)";
	}
        while ($_ = shift @items) {
	        if ($mode == 0) {
		        print "\to " . @$_[0];
	        } elsif ($mode == 1) {
		        print "\t------------------------------------------------------------\n";
                        foreach $_ (@$_) {
			        print "\t$_";
			}
		} elsif ($mode == 2) {
		        $_ = @$_[0];
			chop;
			$_ = "- $_";
			# Split it onto two lines if necessary
		        if (length("$_ . $person") > 76 - $space) {
			        print ("$_\n" . " " x (76-length($person)) . "$person\n");
			} else {
			        print ("$_" . " " x (76-length($person)-length($_)) . "$person\n");
			}
		}
        }
}

# Print the information
foreach $addr (sort keys %people) {
        print_items($addr);
        if ($mode != 2) { print "\n"; }
}



-- 
Marcus Alanen
maalanen@abo.fi
