Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267026AbTCBEyw>; Sat, 1 Mar 2003 23:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268809AbTCBEyw>; Sat, 1 Mar 2003 23:54:52 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:6159 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S267026AbTCBEyp>; Sat, 1 Mar 2003 23:54:45 -0500
Date: Sun, 2 Mar 2003 00:04:20 -0500
From: Ben Collins <bcollins@debian.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: andrea@e-mind.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed BitKeeper clone
Message-ID: <20030302050420.GA22169@phunnypharm.org>
References: <20030226200208.GA392@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20030226200208.GA392@elf.ucw.cz>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2003 at 09:02:12PM +0100, Pavel Machek wrote:
> Hi!
> 
> I've created little project for read-only (for now ;-) bitkeeper
> clone. It is available at www.sf.net/projects/bitbucket (no tar balls,
> just get it fresh from CVS).

In case it may be of some help, here's a script that is the result of my
own reverse engineering of the bitkeeper SCCS files. It can output a
diff, almost exactly the same as BitKeeper's gnupatch output from a
BitKeeper repo.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bitsubversion.pl"

#!/usr/bin/perl -w

#
# Licensed under the GNU General Public License v2
#
# Copyright (C) 2002 Ben Collins <bcollins@debian.org>
#

#
# This script will take one arg, that of a BitKeeper ChangeSet ID. It will
# then extract information from the current directory (expected to be a
# BitKeeper repository) to export a GNU Patch style output of the
# ChangeSet. It tries to be as close as possible to the gnupatch output
# from BitKeeper itself.
#
# This program requires the GNU CSSC suite to operate on the files. It
# also requires a patch to that suite so that it interoperates better with
# a BitSCCS style repository.
#
# You can get a list of ChangeSet ID's with this command:
#
# sccs prs -e -d:I: ChangeSet | less
#

use File::Basename;
use strict;

# Forward declerations
sub print_comment($;$;$;$);
sub get_prev_rev($;$);
sub resolve_sccs_loc($;$;$);

if (@ARGV != 1) {
	print STDERR "Usage: bitsubversion <sid>\n";
	exit 1;
}

if (not -f "SCCS/s.ChangeSet") {
        print STDERR "Must be in a BitKeeper repo for this script to work\n";
        exit 1;
}

my $rev = shift @ARGV;
my $prevrev = get_prev_rev("ChangeSet", $rev);

# Get the comments for this rev
open (COMMENTS, "sccs prs -r$rev '-d:D:\\n:P:\\n:C:' ChangeSet |") or die "opening sccs prs";
my $comments = "";
my $revdate = <COMMENTS>;
my $revperp = <COMMENTS>;
chomp $revdate;
chomp $revperp;
while (<COMMENTS>) {
	last if m/^C: $/;
	$comments = $comments . "# $_";
}
close COMMENTS;

my @changes = ();
my $revuser = "";

open (PROJ, "sccs get -p BitKeeper/etc/config |") or die "opening BitKeeper/etc/config";
my $desc = "";
while (<PROJ>) { $desc = $1 if m/^description: (.*)/; }
close PROJ;

print "# This is a BitSubversion generated patch for the following project:\n";
print "# Project Name: $desc\n";
print "# This patch format is intended for GNU patch command version 2.5 or higher.\n";
print "# This patch includes the following deltas:\n";

print_comment("ChangeSet", $prevrev, $rev, "ChangeSet");

open(CSETDIFF, "sccs sccsdiff -u -r$prevrev -r$rev ChangeSet |") or die "opening sccs sccsdiff";
while (<CSETDIFF>) {
	chomp;
	next if not m/^\+.*\|.*/;

	my ($origcset, $csetkey) = split / /;
	my $new = {};

	# user@host|path/in/repo|YYYYMMDDHHMMSS|key
	my ($userhost, $file, $date, $key) = split /\|/, $csetkey;

	# user@host|path/in/repo|YYYYMMDDHHMMSS|key|crc?
	my ($prevuserhost, $origfile, $junk2, $origkey, $crc) = split /\|/, $origcset;

	$revuser = $userhost if $revuser eq "";

	$new->{'file'} = $file;
	$new->{'origfile'} = $origfile;
	$new->{'origkey'} = $origkey;
	$new->{'crc'} = $crc;

	# Resolve the location of the file
	$new->{'sccsfile'} =
		resolve_sccs_loc($new->{'file'}, $new->{'origkey'}, $new->{'crc'});

	my ($usr1) = split /\@/, $userhost;
	my ($usr2) = split /\@/, $prevuserhost;

	# Get the current and previous SID
	open(PRS, "sccs prs '-dCSET: :I:\\n:P:\\n:C:' -e $new->{'sccsfile'} |") or
		die "opening sccs prs";
	$new->{'sid'} = "";
	$new->{'parentfile'} = "(none)";
	while (<PRS>) {
		if (m/^P: (.*)$/) {
			if ($new->{'sid'} ne "" and $new->{'parentfile'} eq "") {
				$new->{'parentfile'} = $1;
			} elsif ($new->{'parentfile'} eq "(none)") {
				$new->{'parentfile'} = "";
			}
		}

		next if not m/^CSET: (.*)$/;
		my $sid = $1;

		my $perp = <PRS>;
		chomp $perp;

		if ($new->{'sccsfile'} =~ m/^BitKeeper\/deleted\/\.del-/) {
			$new->{'parentfile'} = <PRS>;
			chomp $new->{'parentfile'};
			$new->{'parentfile'} = s/^Deleted: //;
		}

		my $thiskey = "";
		while (<PRS>) {
			if (m/^K: (.*)$/) {
				$thiskey = $1;
				last;
			}
		}

		# This can be tricky folks. Even though we have a key, it
		# is not unique. There's two other parts of the ChangeSet
		# that BK uses as the complete key.
		#
		# One of the other parts is the date, given in
		# YYYYMMDDHHMMSS. However it's totally useless it seems. I
		# tried comparing it, and sometimes the date of the delta
		# is a few seconds off from this date. I could do an
		# approximation, but I'm too lazy. Also, CSSC is not very
		# good at using this date to limit prs output.
		#
		# The second part of the key is the user (perp, or :P:
		# under SCCS). This gives us a good chance at hitting the
		# right delta.
		next if $thiskey ne $key or
			($perp ne $revperp and $perp ne $usr1 and $perp ne $usr2);

		$new->{'sid'} = $sid;
	}
	close PRS;

	$new->{'parentfile'} = $new->{'file'} if $new->{'parentfile'} eq "" or
		$new->{'parentfile'} eq "(none)";

	$new->{'prevsid'} = get_prev_rev($new->{'sccsfile'}, $new->{'sid'});

	print_comment($new->{'file'}, $new->{'prevsid'}, $new->{'sid'}, $new->{'parentfile'});

	unshift @changes, $new;
}

close CSETDIFF;

print "#\n";
print "# The following is the ChangeSet Log\n";
print "# --------------------------------------------\n";
print "# $revdate\t$revuser\t$rev\n";
print $comments;
print "# --------------------------------------------\n";
print "#\n";

open(DATE, "date '+%a %b %e %T %G' |") or die "opening data";
my $diffdate = <DATE>;
chomp $diffdate;
close DATE;

foreach my $entry (@changes) {
	my $sid = $entry->{'sid'};
	my $prevsid = $entry->{'prevsid'};
	my $sccsfile = $entry->{'sccsfile'};
	my $diffpath;
	my $moving = 0;

	die "$entry->{'file'} has illegal empty sid/prevsid" if $sid eq "" or $prevsid eq "";

	if ($entry->{'file'} =~ m/^BitKeeper\/deleted\/\.del-/) {
		# SCCS will handle this by saying the revs are alike
		# (which they are), so we use our hacked sccsdiff and pass
		# 1 as the second sid.
		$sid = "1";
		$diffpath = $entry->{'parentfile'};
	} elsif ($entry->{'parentfile'} ne $entry->{'file'}) {
		$moving = 1;
	} else {
		$diffpath = $entry->{'file'};
	}

	while (1) {
		my ($mysid, $myprevsid);

		if ($moving) {
			if ($moving == 1) {
				# Delete first
				$diffpath = $entry->{'file'};
				$mysid = 1;
				$myprevsid = $prevsid;
				# Print an informative header
				print "ByteSubvert: move\n";
				print "FromFile: $entry->{'file'}\n";
				print "ToFile: $entry->{'parentfile'}\n";
				$moving = 2;
			} else {
				# Now create the new file
				$diffpath = $entry->{'parentfile'};
				$mysid = $sid;
				$myprevsid = 1;
				$moving = 0;
			}
		} else {
			$mysid = $sid;
			$myprevsid = $prevsid;
		}

		open(DIFF, "sccs sccsdiff -u -r$myprevsid -r$mysid $sccsfile |")
			or die "opening sccs sccsdiff";

		while (<DIFF>) {
			if (m/^$sccsfile/) {
				print "diff -Nru a/$diffpath b/$diffpath\n";
				next;
			}
			if (m/^--- \/tmp/) {
				# For new files, we hack the date so that patch
				# treats it correctly. Without this, patch would
				# allow this "new" diff to be applied onto an
				# existing file. This way, patch knows that it is
				# dealing with a new file, and errors if the file
				# exists.
				if ($myprevsid eq "1") {
					print "--- /dev/null\tWed Dec 31 16:00:00 1969\n";
				} else {
					print "--- a/$diffpath\t$diffdate\n";
				}
				next;
			} elsif (m/^\+\+\+ \/tmp/) {
				# For deleted files, we do the same thing, but on
				# the "removed" side.
				if ($mysid eq "1") {
					print "+++ /dev/null\tWed Dec 31 16:00:00 1969\n";
				} else {
					print "+++ b/$diffpath\t$diffdate\n";
				}
				next;
			}
			print $_;
		}

		last if not $moving;
	}
	close (DIFF);
}

sub get_prev_rev($;$) {
	my $file = shift;
	my $sid = shift;
	my $prevsid;

	open(PRS, "sccs prs -r$sid -d:DP: $file |") or die "opening sccs prs";
	my $dp = <PRS>;
	chomp $dp;
	close PRS;

	open(PRS, "sccs prs -e -d:I:::DS: $file |") or die "opening sccs prs";
	while (<PRS>) {
		chomp;
		my ($thissid, $ds) = split /:/;
		if ($ds eq $dp) {
			$prevsid = $thissid;
			last;
		}
	}
	close PRS;

	die "could not find prevrev for $file" if not defined($prevsid);

	return $prevsid;
}

sub resolve_sccs_loc($;$;$) {
	my $curpath = shift;
	my $origkey = shift;
	my $crc = shift;
	my ($file, $dir, $sccsfile);

	# The BitKeeper/etc/SCCS/x.id_cache file seems to contain history
	# of how files move around the repo, and possibly eventually
	# become deleted and end up in BitKeeper/deleted/.
	#
	# We'll abuse that file directly to find an arbitrary file at any
	# point during the repo's history. Remember boys and girls, a file
	# can move more than once. We use the initial file key and crc
	# (found from the file entries pertaining to the ChangeSet) to
	# make sure we match things up properly.

	open(ID, "< BitKeeper/etc/SCCS/x.id_cache") or die "opening id_cache";
	while (<ID>) {
		chomp;

		next if not m/\|/;

		my ($tmp, $newloc) = split / /;

		# user@host|path/to/file|YYYYMMDDHHMMSS|key|crc?
		my ($junk1, $prevpath, $junk2, $thiskey, $thiscrc) =
			split /\|/, $tmp;

		next if $origkey ne $thiskey or $curpath ne $prevpath or $crc ne $thiscrc;

		$curpath = $newloc;
	}
	close ID;

	($file,$dir) = fileparse($curpath);
	$dir = "" if $dir eq "./";

	$sccsfile = "${dir}SCCS/s.$file";

	die "could not locate SCCS file for $curpath (via $sccsfile)" if not -f $sccsfile;

	return $sccsfile;
}

sub print_comment($;$;$;$) {
	my $file = shift;
	my $prevrev = shift;
	my $rev = shift;
	my $origfile = shift;
	my ($pathstr1, $pathstr2, $prevrevstr, $revstr);

	my $len1 = 26;	# Padding before first path
	my $len2 = 7;	# Padding between prevrev and "->"
	my $len3 = 8;	# Padding after second rev and following str

	if ($prevrev eq "1" or $prevrev eq "1.0") {		# New
		$pathstr1 = ' 'x($len1-length("(new)")) . "(new)";
		$pathstr2 = $file;
		$prevrevstr = ' 'x$len2;
		$revstr = $rev . ' 'x($len3-length($rev));
	} elsif ($file =~ m/^BitKeeper\/deleted\/\.del-/) {	# Deleted
		$pathstr1 = ' 'x($len1-length($origfile)) . $origfile;
		$pathstr2 = "(deleted)";
		$prevrevstr = $prevrev . ' 'x($len2-length($prevrev));
		$revstr = ' 'x$len3;
	} elsif ($file ne $origfile) {				# Moved
		$pathstr1 = ' 'x($len1-length($origfile)) . $origfile;
		$pathstr2 = "$file (moved)";
		$prevrevstr = $prevrev . ' 'x($len2-length($prevrev));
		$revstr = $rev . ' 'x($len3-length($rev));
	} else {						# Changed
		$pathstr1 = ' 'x($len1-length($file)) . $file;
		$pathstr2 = "";
		$prevrevstr = $prevrev . ' 'x($len2-length($prevrev));
		$revstr = $rev;
	}

	print "# $pathstr1\t$prevrevstr -> $revstr$pathstr2\n";
}

--IS0zKkzwUGydFO0o--
