Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <974712-231>; Tue, 19 May 1998 23:46:48 -0400
Received: from PACIFIC-CARRIER-ANNEX.MIT.EDU ([18.69.0.28]:3880 "HELO MIT.EDU" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with SMTP id <977261-231>; Tue, 19 May 1998 23:42:04 -0400
Date: Tue, 19 May 1998 23:50:46 -0400
Message-Id: <199805200350.XAA28950@dcl.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: Peter Horton <pdh@berserk.demon.co.uk>
Cc: Alex Buell <alex.buell@tahallah.demon.co.uk>, Linux Kernel <linux-kernel@vger.rutgers.edu>
In-Reply-To: Peter Horton's message of Tue, 19 May 1998 23:54:40 +0100 (BST), <Pine.LNX.3.96.980519234840.462A-100000@berserk.demon.co.uk>
Subject: Re: RPMs :o(
Address: 1 Amherst St., Cambridge, MA 02139
Phone: (617) 253-8091
Sender: owner-linux-kernel@vger.rutgers.edu

   Date: 	Tue, 19 May 1998 23:54:40 +0100 (BST)
   From: Peter Horton <pdh@berserk.demon.co.uk>

   RPMs are basically gzipped cpio archives with a header.

   If you search the file for the byte 0x1f followed by 0x8b (these bytes
   mark a gzip file) and remove everything that precedes them, you will be
   left a gzipped cpio archive, which you can then unzip and unpack.

Since this is so short, I'll take the liberty to repost the following
rpm2cpio perl script.

						- Ted

#!/usr/local/bin/perl

# why does the world need another rpm2cpio?  because the existing one
# won't build unless you have half a ton of things that aren't really
# required for it, since it uses the same library used to extract RPM's.
# in particular, it won't build on the HPsUX box i'm on.

# add a path if desired
$gzip = "gzip";

sub printhelp {
  print "rpm2cpio, perl version by orabidoo <odar\@pobox.com>\n";
  print "use: rpm2cpio [file.rpm]\n";
  print "dumps the contents to stdout as a GNU cpio archive\n";
  exit 0;
}

if ($#ARGV == -1) {
  printhelp if -t STDIN;
  $f = "STDIN";
} elsif ($#ARGV == 0) {
  open(F, "< $ARGV[0]") or die "Can't read file $ARGV[0]\n";
  $f = 'F';
} else {
  printhelp;
}

printhelp if -t STDOUT;

# gobble the file up
undef $/;
$|=1;
$rpm = <$f>;
close ($f);

($magic, $major, $minor, $crap) = unpack("NCC C90", $rpm);

die "Not an RPM\n" if $magic != 0xedabeedb;
die "Not a version 3 RPM\n" if $major != 3;

$rpm = substr($rpm, 96);

while ($rpm ne '') {
  $rpm =~ s/^\c@*//s;
  ($magic, $crap, $sections, $bytes) = unpack("N4", $rpm);
  $smagic = unpack("n", $rpm);
  last if $smagic eq 0x1f8b;
  die "Error: header not recognized\n" if $magic != 0x8eade801;
  $rpm = substr($rpm, 16*(1+$sections) + $bytes);
}

die "bogus RPM\n" if $rpm eq '';

open(ZCAT, "|gzip -cd") || die "can't pipe to gzip\n";
print STDERR "CPIO archive found!\n";

print ZCAT $rpm;
close ZCAT;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
