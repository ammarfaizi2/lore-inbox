Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbULPR4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbULPR4H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 12:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbULPR4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 12:56:07 -0500
Received: from falcon30.maxeymade.com ([24.173.215.190]:3715 "EHLO
	falcon30.maxeymade.com") by vger.kernel.org with ESMTP
	id S261949AbULPRzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 12:55:19 -0500
Message-Id: <200412161755.iBGHt9Mm028966@falcon30.maxeymade.com>
X-Mailer: exmh version 2.7.1.1 10/09/2004 with nmh-1.1
In-reply-to: <41C1BA38.60304@osdl.org> 
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       willy@debian.org
Subject: Re: [PATCH] add legacy I/O port & memory APIs to /proc/bus/pci 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-2797784600"
Date: Thu, 16 Dec 2004 11:55:09 -0600
From: Doug Maxey <dwm@maxeymade.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-2797784600
Content-Type: text/plain; charset=us-ascii


On Thu, 16 Dec 2004 08:39:20 PST, "Randy.Dunlap" wrote:
>Jesse Barnes wrote:
>> This patch documents the /proc/bus/pci interface and adds some optional 
>> architecture specific APIs for accessing legacy I/O port and memory space.  
>> This is necessary on platforms where legacy I/O port space doesn't 'soft 
>> fail' like it does on PCs, and is useful for systems that can route legacy 
>> space to different PCI busses.
>> 
>> I've incorporated all the feedback I've received so far, so I think it's ready 
>> to send on to Andrew for inclusion, if someone could give the proc-pci.txt 
>> documentation a last read (and/or comment on other stuff I may have missed).
>
>meta-comment:
>Would you (and not just you :) include a diffstat summary so we
>can see which files are being changed?  something like this:
>
>
>  Documentation/filesystems/proc-pci.txt |  126 
>+++++++++++++++++++++++++++++++++
>  arch/ia64/pci/pci.c                    |  105 
>+++++++++++++++++++++++++++
>  arch/ia64/sn/pci/pci_dma.c             |   74 +++++++++++++++++++
>  drivers/pci/proc.c                     |  100 +++++++++++++++++++++++---
>  include/asm-ia64/machvec.h             |   24 ++++++
>  include/asm-ia64/machvec_init.h        |    3
>  include/asm-ia64/machvec_sn2.h         |    6 +
>  include/asm-ia64/pci.h                 |    4 +
>  include/asm-ia64/sn/sn_sal.h           |   47 ++++++++++++
>  include/linux/pci.h                    |   12 ++-
>  10 files changed, 488 insertions(+), 13 deletions(-)
>
>-- 
>~Randy
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

Here is a little perl diddy that accomplishes same:


--==_Exmh_-2797784600
Content-Type: text/plain ; name="ds"; charset=us-ascii
Content-Description: ds

#!/usr/bin/env perl
# ds
# Created Fri Oct 22 2004 by dwm@austin.ibm.com
# $Id: ds,v 1.11 2004/11/05 23:24:06 dwm Exp $

require 5.6.1;
use Getopt::Long 2.33;
use Pod::Usage;
use Data::Dumper;
use Config;


### variables and subroutines ##
$opt_debug = 0;
$opt_help = 0;
$opt_man = 0;

$stat_flags = "";
$diff_flags = "-Nwupa";
@dirs = ();
@tops = ();

sub infer_orig ( $ ) {
    my $suf = "$_[0]\$";
    my $x = $ENV{PWD};
    my $basedir;
    ($basedir = $x) =~ s,.*/,,;
    if ($basedir =~ m{$suf}) {
        ($tops[0] = $basedir) =~ s{$suf}{};
	$tops[1] = $basedir;
	return 1;
    }
    return 0;
}


#############  main  ####################
GetOptions (
            'debug'       => \$opt_debug,
            'diffflags=s' => \$diff_flags,
            'dirs=s'      => \@dirs,
            'help|?'      => \$opt_help,
            'man'         => \$opt_man,
            'statflags=s' => \$stat_flags,
            'tops=s'      => \@tops,
            'verbose+'    => \$verbose,
	   )
    or pod2usage(2);

pod2usage (1) if $opt_help;
pod2usage (-verbose => 2) if $opt_man;
( $prog = $0 ) =~  s{.*/}{}o;

## If no arguments were given, then allow STDIN to be used only
## if it's not connected to a terminal (otherwise print usage)
pod2usage ("$prog: No files given.")  if ((@ARGV == 0) && (-t STDIN));

# setbuf on STDERR.
$ofh = select (STDERR); $| = 1; select ($ofh);

@diffout = ();
$kill_errs = ($verbose) ? "" : "2>/dev/null";

#
# if tops is not set, infer the older directory.  Long Term - find out if cvs file.
#
if (not scalar @tops) {
    my @os = ( "\.edit" );

    while ($od = shift @os) {
	last if (infer_orig $od);
    }
}

if (not scalar @tops) {
    pod2usage ("$prog: could not infer, need to define tops.");
}

if (not -d $tops[0]) {
    if (-d "../$tops[0]") {
	chdir '..';
	print STDERR qx{pwd} if $verbose;
    }
    else {
	die "could not find $tops[0]\n";
    }
}

while ($path = shift @ARGV) {
    my $recurse = (-d "$tops[0]/$path") ? 'r' : '';
    $cmd = "diff $diff_flags${recurse} $tops[0]/$path $tops[1]/$path $kill_errs";
    print "tops={@tops}\n$cmd\n" if $opt_debug;
    open DIFFIN, "$cmd |" or die "open {$cmd}\n";
    while (<DIFFIN>) {
	next if (m{^Common});
	push @diffout, $_;
    }
}

open DSI, "|diffstat $stat_flags" or die "open stat pipe\n";
print DSI @diffout;
print while (<DSI>);
close DSI;
print "\n", @diffout;

__END__

=head1 NAME

B<ds> - diffstat + diff from one command

=head1 SYNOPSIS

B<ds> [options] ...

=head1 OPTIONS

=over 4

=item B<--debug>

run without action, printing debug messages.

=item B<--diffflags>

flags to pass to diff.  default -Nwupa.

=item B<--help>

print the synopsis only.  see B<--man>.

=item B<--man>

print the complete manpage.

=item B<--statflags>

flags to pass to diffstat.  default is {$stat_flags}.

=item B<--tops>

Top level directories to diff with the appended paths.  If not specified,
infer from current directory if possible.

=item B<--verbose>

whistle while we work.  multiple calls increase the verbosity level.

=back

=head1 DESCRIPTION

Runs diff over the list of files, collecting the output.  When complete, outputs
the stats followed by the diffs to stdout.

=head1 EXAMPLES

examples

=head1 NOTE

note

=head1 BUGS

Undoubtedly.  Contact the author with the particulars if this is stopping your progress.

=head1 FILES

B<ds> - perl script

=head1 AUTHOR

Doug Maxey <dwm@austin.ibm.com>

=cut

--==_Exmh_-2797784600--


