Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSEZAU0>; Sat, 25 May 2002 20:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315476AbSEZAUZ>; Sat, 25 May 2002 20:20:25 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:44811 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S315472AbSEZAUT> convert rfc822-to-8bit; Sat, 25 May 2002 20:20:19 -0400
Date: Sun, 26 May 2002 02:20:13 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: lk-changelog.pl 0.17/Call for help with mail addresses
Message-ID: <20020526002013.GA5298@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I updated lk-changelog.pl again, it's now at v0.17.

Apart from the usual set of address updates, it now detects I/O errors
on write and read (although I could not test read errors now, does
anyone have a "bad disk simulator" file system or pipe or something that
throws EIO on read(2) sporadically?), works even without Pod::Usage
installed (but does not give a useful --help in that case), reads quote
characters in the LINUXKERNEL_BK_FMT environment variable (which
requires Perl 5.005 or newer, on the down side).

The script is below the signature.

Some versions (also the one below) and the RCS ,v file (to let you
extract intermediate versions) are also available for HTTP download from
http://mandree.home.pages.de/linux/kernel/

However, I need your help. If you know the full name of the person who
uses one of the addresses below to send kernel patches, let me know.
lbdbq (by Roland Rosenfeld, www.spinnaker.de) helped me find many of the
addresses.

These are missing addresses of ChangeLogs 2.5.11 to 2.5.18, without
those that are obviously hosed like (none) domain or something. Some
seem obvious, but I want to avoid nasty surprises.

<asit.k.mallick@intel.com>
<beattie@beattie-home.net>
<borisitk@fortunet.com>
<ch@hpl.hp.com>
<davidm@wailua.hpl.hp.com> - Is this David Malone?
<hch@sb.bsdonline.org> - is this Christoph Hellwig?
<k.kasprzak@box43.pl>
<kanoj@vger.kernel.org>
<miltonm@bga.com>
<mufasa@sis.com.tw>
<os@emlix.com>
<petkan@mastika.lnxw.com>
<santiago@newphoenix.net>
<shaggy@kleikamp.austin.ibm.com>
<skyrelighten@yahoo.co.kr>
<spse@secret.org.uk>
<tetapi@utu.fi>
<wolfgang.fritz@gmx.net> - Is it Wolfang Fritz, Fritz Wolfgang? Is the
                           name complete?


-- 
Matthias Andree

#! /usr/bin/perl -wT

# This Perl script is meant to simplify/beautify BK ChangeLogs for the linux
# kernel.
#
# (C) Copyright 2002 by Matthias Andree <matthias.andree@gmx.de>
#			Marcus Alanen <maalanen@abo.fi>
#			Tomas Szepe <szepe@pinerecords.com>
#
# $Id: lk-changelog.pl,v 0.17 2002/05/25 23:32:49 emma Exp $
# ----------------------------------------------------------------------
# Distribution of this script is permitted under the terms of the
# GNU General Public License (GNU GPL) v2.
# ----------------------------------------------------------------------

# This program expects its input in the following format:
# (E-Mail Addresses MUST NOT bear leading whitespace!)
#
# <email@ddr.ess>
#	changelog text
#	more changelog text
# <email@ddr.ess>
#	yet another changelog
# <another@add.ress>
#	changelog #3
#	more lines
#
# and discards all changelog lines but the first after an email address,
# and groups and sorts the entries by email address:
#
# another@add.ress:
#	changelog #3
# email@ddr.ess
#	changelog text
#	yet another changelog

require 5.005;
use strict;

use Carp;
use Getopt::Long;
use IO::File;
eval 'use Pod::Usage;';
if ($@) {
  eval 'sub pod2usage {
    print STDERR "Usage information would be presented here if you had Pod::Usage installed.\n"
      . "Try: perl -MCPAN -e \'install Pod::Usage\'\nAbort.\n";
    exit 2;
  }';
}
use Text::ParseWords;
use Text::Wrap;

# --------------------------------------------------------------------
# customize the following line to change the indentation of the change
# lines, $indent1 is used for the first line of an entry, $indent for
# all subsequent lines. $indent is auto-generated from $indent1.
my $indent1 = "  o ";
my $indent  = " " x length($indent1);
# change this to enable some debugging stuff:
my $debug = 0;
# --------------------------------------------------------------------

# the key is the email address in ALL LOWER CAPS!
# the value is the real name of the person
my %addresses = (
'abraham@2d3d.co.za' => 'Abraham van der Merwe',
'acher@in.tum.de' => 'Georg Acher',
'acme@brinquedo.oo.ps' => 'Arnaldo Carvalho de Melo',
'acme@conectiva.com.br' => 'Arnaldo Carvalho de Melo',
'adam@yggdrasil.com' => 'Adam J. Richter',
'adilger@clusterfs.com' => 'Andreas Dilger',
'agrover@groveronline.com' => 'Andy Grover',
'aia21@cam.ac.uk' => 'Anton Altaparmakov',
'aia21@cantab.net' => 'Anton Altaparmakov',
'aia21@cus.cam.ac.uk' => 'Anton Altaparmakov',
'ak@muc.de' => 'Andi Kleen',
'akpm@zip.com.au' => 'Andrew Morton',
'alan@lxorguk.ukuu.org.uk' => 'Alan Cox',
'andersg@0x63.nu' => 'Anders Gustafsson',
'andrea@suse.de' => 'Andrea Arcangeli',
'andries.brouwer@cwi.nl' => 'Andries E. Brouwer',
'ankry@green.mif.pg.gda.pl' => 'Andrzej Krzysztofowicz',
'anton@samba.org' => 'Anton Blanchard',
'arjan@redhat.com' => 'Arjan van de Ven',
'arjanv@redhat.com' => 'Arjan van de Ven',
'axboe@burns.home.kernel.dk' => 'Jens Axboe',
'axboe@suse.de' => 'Jens Axboe',
'bcollins@debian.org' => 'Ben Collins',
'bcrl@redhat.com' => 'Benjamin LaHaise',
'bfennema@falcon.csc.calpoly.edu' => 'Ben Fennema',
'bgerst@didntduck.org' => 'Brian Gerst',
'bjorn_helgaas@hp.com' => 'Bjorn Helgaas',
'brett@bad-sports.com' => 'Brett Pemberton',
'brownfld@irridia.com' => 'Ken Brownfield',
'bunk@fs.tum.de' => 'Adrian Bunk',
'buytenh@gnu.org' => 'Lennert Buytenhek',
'ccaputo@alt.net' => 'Chris Caputo',
'chessman@tux.org' => 'Samuel S. Chessman',
'chris@wirex.com' => 'Chris Wright',
'christopher.leech@intel.com' => 'Christopher Leech',
'colin@gibbs.dhs.org' => 'Colin Gibbs',
'cph@zurich.ai.mit.edu' => 'Chris Hanson',
'cr@sap.com' => 'Christoph Rohland',
'cruault@724.com' => 'Charles-Edouard Ruault',
'cyeoh@samba.org' => 'Christopher Yeoh',
'dalecki@evision-ventures.com' => 'Martin Dalecki',
'davej@suse.de' => 'Dave Jones',
'davem@nuts.ninka.net' => 'David S. Miller',
'davem@redhat.com' => 'David S. Miller',
'david-b@pacbell.net' => 'David Brownell',
'david@gibson.dropbear.id.au' => 'David Gibson',
'davidel@xmailserver.org' => 'Davide Libenzi',
'davidm@hpl.hp.com' => 'David Mosberger',
'davidm@napali.hpl.hp.com' => 'David Mosberger',
'ddstreet@us.ibm.com' => 'Dan Streetman',
'dhowells@redhat.com' => 'David Howells',
'dirk.uffmann@nokia.com' => 'Dirk Uffmann',
'dledford@redhat.com' => 'Doug Ledford',
'dmccr@us.ibm.com' => 'Dave McCracken',
'dok@directfb.org' => 'Denis Oliver Kropp',
'dougg@torque.net' => 'Douglas Gilbert',
'dwmw2@infradead.org' => 'David Woodhouse',
'ebrower@usa.net' => 'Eric Brower',
'efocht@ess.nec.de' => 'Erich Focht',
'elenstev@mesatop.com' => 'Steven Cole',
'erik_habbinga@hp.com' => 'Erik Habbinga',
'fdavis@si.rr.com' => 'Frank Davis',
'fero@sztalker.hu' => 'Bakonyi Ferenc',
'fischer@linux-buechse.de' => 'Jürgen E. Fischer',
'focht@ess.nec.de' => 'Erich Focht',
'ganesh@veritas.com' => 'V. Ganesh',
'ganesh@vxindia.veritas.com' => 'V. Ganesh',
'george@mvista.com' => 'George Anzinger',
'gilbertd@treblig.org' => 'Dr. David Alan Gilbert',
'gl@dsa-ac.de' => 'Guennadi Liakhovetski',
'go@turbolinux.co.jp' => 'Go Taniguchi',
'green@namesys.com' => 'Oleg Drokin',
'greg@kroah.com' => 'Greg Kroah-Hartman',
'grundler@cup.hp.com' => 'Grant Grundler',
'hannal@us.ibm.com' => 'Hanna Linder',
'haveblue@us.ibm.com' => 'Dave Hansen',
'hch@caldera.de' => 'Christoph Hellwig',
'hch@infradead.org' => 'Christoph Hellwig',
'henrique@cyclades.com' => 'Henrique Gobbi',
'hirofumi@mail.parknet.co.jp' => 'Ogawa Hirofumi',
'hoho@binbash.net' => 'Colin Slater',
'hugh@veritas.com' => 'Hugh Dickins',
'ink@jurassic.park.msu.ru' => 'Ivan Kokshaysky',
'ionut@cs.columbia.edu' => 'Ion Badulescu',
'jack@suse.cz' => 'Jan Kara',
'jaharkes@cs.cmu.edu' => 'Jan Harkes',
'jamagallon@able.es' => 'J. A. Magallon',
'jamey@crl.dec.com' => 'Jamey Hicks',
'jbglaw@lug-owl.de' => 'Jan-Benedict Glaw',
'jdavid@farfalle.com' => 'David Ruggiero',
'jdr@farfalle.com' => 'David Ruggiero',
'jes@wildopensource.com' => 'Jes Degn Sørensen',
'jgarzik@mandrakesoft.com' => 'Jeff Garzik',
'jhammer@us.ibm.com' => 'Jack Hammer',
'jmorris@intercode.com.au' => 'James Morris',
'johannes@erdfelt.com' => 'Johannes Erdfelt',
'john@deater.net' => 'John Clemens',
'john@larvalstage.com' => 'John Kim',
'jsimmons@heisenberg.transvirtual.com' => 'James Simmons',
'jsimmons@transvirtual.com' => 'James Simmons',
'jt@bougret.hpl.hp.com' => 'Jean Tourrilhes',
'jt@hpl.hp.com' => 'Jean Tourrilhes',
'kaber@trash.net' => 'Patrick McHardy',
'kai.reichert@udo.edu' => 'Kai Reichert',
'kai@tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
'kanojsarcar@yahoo.com' => 'Kanoj Sarcar',
'kaos@ocs.com.au' => 'Keith Owens',
'kasperd@daimi.au.dk' => 'Kasper Dupont',
'key@austin.ibm.com' => 'Kent Yoder',
'knan@mo.himolde.no' => 'Erik Inge Bolsø',
'kraxel@bytesex.org' => 'Gerd Knorr',
'kraxel@suse.de' => 'Gerd Knorr',
'kuebelr@email.uc.edu' => 'Robert Kuebel',
'kuznet@ms2.inr.ac.ru' => 'Alexey Kuznetsov',
'laforge@gnumonks.org' => 'Harald Welte',
'liyang@nerv.cx' => 'Liyang Hu',
'lm@bitmover.com' => 'Larry McVoy',
'macro@ds2.pg.gda.pl' => 'Maciej W. Rozycki',
'manfred@colorfullife.com' => 'Manfred Spraul',
'mason@suse.com' => 'Chris Mason',
'maxk@qualcomm.com' => 'Maksim Krasnyanskiy',
'mec@shout.net' => 'Michael Elizabeth Chastain',
'mikep@linuxtr.net' => 'Mike Phillips',
'mikpe@csd.uu.se' => 'Mikael Pettersson',
'miles@megapathdsl.net' => 'Miles Lane',
'mingo@elte.hu' => 'Ingo Molnar',
'mmcclell@bigfoot.com' => 'Mark McClelland',
'mochel@osdl.org' => 'Patrick Mochel',
'mochel@segfault.osdl.org' => 'Patrick Mochel',
'nahshon@actcom.co.il' => 'Itai Nahshon',
'nathans@sgi.com' => 'Nathan Scott',
'neilb@cse.unsw.edu.au' => 'Neil Brown',
'nico@cam.org' => 'Nicolas Pitre',
'nkbj@image.dk' => 'Niels Kristian Bech Jensen',
'oliendm@us.ibm.com' => 'Dave Olien',
'oliver@neukum.name' => 'Oliver Neukum',
'oliver@neukum.org' => 'Oliver Neukum',
'p_gortmaker@yahoo.com' => 'Paul Gortmaker',
'paulkf@microgate.com' => 'Paul Fulghum',
'paulus@nanango.paulus.ozlabs.org' => 'Paul Mackerras',
'paulus@quango.ozlabs.ibm.com' => 'Paul Mackerras',
'paulus@samba.org' => 'Paul Mackerras',
'pavel@ucw.cz' => 'Pavel Machek',
'pazke@orbita1.ru' => 'Andrey Panin',
'perex@perex.cz' => 'Jaroslav Kysela',
'perex@suse.cz' => 'Jaroslav Kysela',
'peter@cadcamlab.org' => 'Peter Samuelson',
'peter@chubb.wattle.id.au' => 'Peter Chubb',
'petero2@telia.com' => 'Peter Osterlund',
'pmenage@ensim.com' => 'Paul Menage',
'quinlan@transmeta.com' => 'Daniel Quinlan',
'quintela@mandrakesoft.com' => 'Juan Quintela',
'rddunlap@osdl.org' => 'Randy Dunlap',
'reality@delusion.de' => 'Udo A. Steinberg',
'reiser@namesys.com' => 'Hans Reiser',
'rem@osdl.org' => 'Bob Miller',
'rgooch@atnf.csiro.au' => 'Richard Gooch',
'rgooch@ras.ucalgary.ca' => 'Richard Gooch',
'riel@conectiva.com.br' => 'Rik van Riel',
'rl@hellgate.ch' => 'Roger Luethi',
'rlievin@free.fr' => 'Romain Lievin',
'rmk@arm.linux.org.uk' => 'Russell King',
'rmk@flint.arm.linux.org.uk' => 'Russell King',
'rml@tech9.net' => 'Robert Love',
'rob@osinvestor.com' => 'Rob Radez',
'robert.olsson@data.slu.se' => 'Robert Olsson',
'romieu@cogenit.fr' => 'François Romieu',
'rth@twiddle.net' => 'Richard Henderson',
'rusty@rustcorp.com.au' => 'Rusty Russell',
'sailer@scs.ch' => 'Thomas Sailer',
'sandeen@sgi.com' => 'Eric Sandeen',
'schwab@suse.de' => 'Andreas Schwab',
'sebastian.droege@gmx.de' => 'Sebastian Dröge',
'sfr@canb.auug.org.au' => 'Stephen Rothwell',
'shaggy@austin.ibm.com' => 'Dave Kleikamp',
'simonb@lipsyncpost.co.uk' => 'Simon Burley',
'sl@lineo.com' => 'Stuart Lynne',
'smurf@osdl.org' => 'Nathan Dabney',
'steiner@sgi.com' => 'Jack Steiner',
'stelian.pop@fr.alcove.com' => 'Stelian Pop',
'szepe@pinerecords.com' => 'Tomas Szepe',
'tai@imasy.or.jp' => 'Taisuke Yamada',
'tcallawa@redhat.com' => 'Tom Callaway',
'thockin@sun.com' => 'Tim Hockin',
'tigran@aivazian.name' => 'Tigran Aivazian',
'tomita@cinet.co.jp' => 'Osamu Tomita',
'tony@cantech.net.au' => 'Anthony J. Breeds-Taurima',
'torvalds@athlon.transmeta.com' => 'Linus Torvalds',
'torvalds@home.transmeta.com' => 'Linus Torvalds',
'torvalds@penguin.transmeta.com' => 'Linus Torvalds',
'torvalds@transmeta.com' => 'Linus Torvalds',
'trini@bill-the-cat.bloom.county' => 'Tom Rini',
'trini@kernel.crashing.org' => 'Tom Rini',
'trond.myklebust@fys.uio.no' => 'Trond Myklebust',
'tvignaud@mandrakesoft.com' => 'Thierry Vignaud',
'twaugh@redhat.com' => 'Tim Waugh',
'urban@teststation.com' => 'Urban Widmark',
'uzi@uzix.org' => 'Joshua Uziel',
'vandrove@vc.cvut.cz' => 'Petr Vandrovec',
'viro@math.psu.edu' => 'Alexander Viro',
'vojtech@suse.cz' => 'Vojtech Pavlik',
'vojtech@twilight.ucw.cz' => 'Vojtech Pavlik',
'vojtechpavlik@bik-gmbh.de' => 'Vojtech Pavlik',
'wim@iguana.be' => 'Wim Van Sebroeck',
'wstinson@infonie.fr' => 'William Stinson',
'xkaspa06@stud.fee.vutbr.cz' => 'Kasparek Tomas',
'zippel@linux-m68k.org' => 'Roman Zippel',
'zwane@commfireservices.com' => 'Zwane Mwaikambo',
'~~~~~~thisentrylastforconvenience~~~~~' => 'Cesar Brutus Anonymous'
);

# get name associated to an email address
sub rmap_address {
  my @o = map {defined $addresses{$_} ? $addresses{$_} : $_ } map { lc; } @_;
  return wantarray ? @o : $o[0];
}

# case insensitive string comparison
# FIXME: use locale?
sub caseicmp { uc($a) cmp uc($b) };

my ($author, $address, $name);
# * $address is always an email address
# * $author can be the email address or Joe N. Sixpack II <joe6@example.com>
#   (ready formatted to print)
# * $name is the name (Joe N. Sixpack II) or the mail address
#   (<joe6@example.com>) 

sub get_name()   { return $name; }
sub get_author() { return $author; }

# This table maps MODE => { myhash }
# myhash knows the keys "index" and "print" to choose the respective functions
my %table = 
  (
#   'oneline' => { 'index' => \&get_name,
#		  'print' => 'plain' },
   'terse'   => { 'index' => \&get_name,
		  'print' => \&print_terse },
   'grouped' => { 'index' => \&get_author,
		  'print' => \&print_grouped },
   'full'    => { 'index' => \&get_author,
		  'print' => \&print_full }
  );

# temp store
my $indexby;

# Global store #############
# Store log entries.
my %log;
# We store our options here.
my %opt;

# As we are parsing, the log is accumulated in the @cur array.  When
# we are done with one item (end of input or new mail address found),
# stuff a copy of this @cur array into the %log hash.
sub append_item(@)
{
  my @cur = @_;
  return unless @cur;
  return unless &$indexby;
  $log{&$indexby} = () unless defined $log{&$indexby};

  # strip trailing blank lines
  my $t;
  while (($t = pop(@cur)) eq '') { };
  push @cur, $t;

  # store the array
  push @{$log{&$indexby}}, [@cur];
}

# Remove duplicates from hash, without changing the order.
# Prefix duplicates with the count.
sub countdups(@) {
  my %t;
  croak "do not call removedups() in scalar context" unless wantarray;
  my @u = grep (!$t{lc $_}++, @_);
  return map {
    $t{lc $_} > 1 ? sprintf("%d x ", $t{lc $_}) . $_ : $_; 
  } @u;
}

# Remove duplicates from array, without changing the order. The
# duplicates need not follow each other, so A B A is properly
# stripped down to A B
sub removedups(@) {
  my %t;
  croak "do not call removedups() in scalar context" unless wantarray;
  return grep (!$t{lc $_}++, @_);
}

# Compress the hash passed in, depending on the --compress and --count
# options in the %opt hash.
sub compress(@) {
  croak "do not call compress() in scalar context" unless wantarray;
  if ($opt{compress}) {
    if ($opt{count}) {
      return countdups(@_);
    } else {
      return removedups(@_);
    }
  } else {
    return @_;
  }
}

# report write error, exit
# do not return
sub write_error() {
  croak "Write error: $!\nAborting";
  exit (1);
}

# implementation of "grouped" output:
# author:
#   first line of log1
#   first line of log2
sub print_grouped() {
  for (sort caseicmp keys %log) {
    my @lines = compress(map { $_->[0] . "\n"; } @{$log{$_}});
    if ($opt{width}) {
      @lines = map { wrap($indent1, $indent, ($_)); } @lines;
    } else {
      @lines = map { "$indent1$_" } @lines;
    }
    printtag($_) or write_error();
    print join("", @lines), "\n" or write_error();
  }
}

# implementation of "full" output
# author:
#   o log1
#     more information on changeset1
#   o log2
#     more information on changeset2 
sub print_full() {
  for (sort caseicmp keys %log) {
    printtag($_) or write_error();
    foreach (compress(@{$log{$_}})) {
      my @lines = map { s/^\t//; "$_\n"; } @$_;
      if ($opt{width}) {
	@lines = wrap($indent1, $indent, @lines);
      } else {
	@lines = map { "$indent$_"; } @lines;
	substr($lines[0], $[, length($indent1)) = $indent1;
      }
      print join("", @lines), "\n"  or write_error();
    }
  }
  print "\n"  or write_error();
}

# implementation of "terse" output
# with --swap          without --swap
# author1: log1        log1    (author1)
# author1: log2        log2    (author2)
# author2: log3        log3    (author3)
sub print_terse() {
  for (sort caseicmp keys %log) {
    my $a = $_;
    if ($opt{width}) {
      if ($opt{swap}) {
	foreach (compress(map { $_->[0]; } @{$log{$_}})) {
	  my @lines = wrap($indent1, $indent, ("$a: $_"));
	  print join("\n", @lines), "\n"  or write_error();
	}
      } else {
	foreach (compress(map { $_->[0]; } @{$log{$_}})) {
	  my @addr = split /\n/, wrap('', $indent, " ($a)");
	  my @lines = split /\n/, wrap($indent1, $indent, ($_));

	  if (length($lines[$#lines]) + length($addr[0]) > $opt{width}) {
	    push @lines, '';
	  }
	  $lines[$#lines] .= sprintf("%*s", $opt{width}
				     - length($lines[$#lines]), $addr[0]);
	  shift @addr;
	  print join("\n", @lines), "\n"  or write_error();
	  foreach (@addr) {
	    printf "%*s\n", $opt{width}, $_  or write_error();
	  }
	}
      }
    } else {
      # using the ?: operator within the map is more maintainable, but
      # less efficient.
      if ($opt{swap}) {
	print join("\n", map { "$indent1$a: $_" }
		   compress(map { $_->[0]; } @{$log{$_}})), "\n"
		     or write_error();
      } else {
	print join("\n", map { "$indent1$_ ($a)" } 
		   compress(map { $_->[0]; } @{$log{$_}})), "\n"
		     or write_error();
      }
    }
  }
}

# Read a file and parse it into the %log hash.
sub parse_file($ ) {
  my @prolog;
  local $_;
  my $fn = shift;
  my $fh;
  # Treat '-'
  if ($fn eq '-') {
    $fh = new IO::Handle;
    $fh->fdopen(fileno(STDIN), "r")
      or die "cannot open stdin: $!\nAborting";
  } else {
    $fh = new IO::File;
    $fh->open($fn, "r")
      or die "cannot open \"$fn\": $!\nAborting";
  }

  my @cur = ();

  my $first = 0;
  undef $address;

  while($_ = $fh -> getline) {
    chomp;
    if (m|^<([^>]+)>|) {
      append_item(@cur); @cur = ();
      $address = $1;
      $name = rmap_address($address);
      if ($name ne $address) {
	$author = $name . ' <' . $address . '>';
      } else {
	$author = '<' . $address . '>';
      }
      $first = 1;
    } elsif ($first) {
      # kill "PATCH" tag
      s/^\s*\[PATCH\]//;
      s/^\s*PATCH//;
      s/^\s*[-:]+\s*//;
      # strip trailing colon
      s/:\s*$//;
      # kill leading and trailing whitespace for consistent indentation
      s/^\s+//; s/\s+$//;

      push @cur, $_;
      $first = 0;
    } elsif (defined $address) {
      # second or subsequent lines
      push @cur, $_;
    } else {
      # store header
      push @prolog, $_;
    }
  }

  if ($fh -> error) {
    die "Error while reading from \"$fn\": $!";
  }

  # at file end, flush @cur array to %log.
  append_item(@cur);

  croak unless wantarray;
  return @prolog;
}

# print a word-wrapped name or mail address, followed by a trailing colon.
# used by print_grouped and print_full
# passes the return value of print back up
sub printtag($ ) {
  my $a = shift;
  $a .= ':';
  return print $opt{width} ? wrap("", "", ($a)) : $a, "\n";
}

# === MAIN PROGRAM ===============================================
# Command line arguments
# What options do we support?
my @opts = ("help|?|h", "man", "mode=s", "compress!", "count!", "width:i",
	    "swap!", "merge!");

# How do we parse them?
if ($Getopt::Long::VERSION gt '2.24') {
  Getopt::Long::Configure("gnu_getopt");
}

# set default options
$opt{mode} = 'grouped';

# Parse from environment, temporarily storing the original @ARGV.
if (defined $ENV{LINUXKERNEL_BK_FMT}) {
  my @savedargs = @ARGV;
  @ARGV = parse_line('\s+', 0, $ENV{LINUXKERNEL_BK_FMT});
  GetOptions(\%opt, @opts)
    or pod2usage(-verbose => 0,
		 -message => $0 . ': error in $LINUXKERNEL_BK_FMT');
  push @ARGV, @savedargs;
}

# Parse command line. Handle help, check for errors.
GetOptions(\%opt, @opts) or pod2usage(-verbose => 0);
pod2usage(-verbose => 1) if $opt{help};
pod2usage(-verbose => 2) if $opt{man};
pod2usage(-verbose => 0,
	  -message => ("$0: Unknown mode specified.\nValid modes are:\n    "
		       . join(" ", sort keys %table) . "\n"))
  unless defined $table{$opt{mode}};
pod2usage(-verbose => 0, 
	  -message => "$0: No files given, refusing to read from a TTY.")
  if ((@ARGV == 0) && (-t STDIN));

# Shortcut for programmer convenience :-)
$indexby = $table{$opt{mode}}->{'index'};

# --count implies --compress
if ($opt{count}) { $opt{compress} = 1; }

# if --width is without argument or the argument is zero,
# try to figure $COLUMNS or fall back to 80.
if (exists $opt{width} and not $opt{width}) {
  $opt{width} = $ENV{COLUMNS} ? $ENV{COLUMNS} : 80;
}

# Print the passed-in array linewise
# Then call the configured function to print %log formatted
sub doprint(@ ) {
  print join("\n", @_), "\n" or write_error();
  &{$table{$opt{mode}}->{print}};
}

# --------------------------------------------------------------------
# Global initializations
$Text::Wrap::huge = 'wrap';
if ($opt{width}) {
  $Text::Wrap::columns = $opt{width};
}

# Main program
unshift(@ARGV, '-') unless @ARGV;

my @prolog;

# NOTE: if $opt{merge} is set, all file prologs are suppressed.
while ($ARGV = shift) {
  push @prolog, parse_file($ARGV);
  if (not $opt{merge}) {
    doprint(@prolog);
    undef %log;
  }
  undef @prolog;
}

if ($opt{merge}) {
  doprint(());
}

__END__
# --------------------------------------------------------------------
# $Log: lk-changelog.pl,v $
# Revision 0.17  2002/05/25 23:32:49  emma
# Four new addresses.
#
# Revision 0.16  2002/05/22 15:52:26  emma
# Fix deliberate typo in use Pod::Usage that was left over from debugging.
#
# Revision 0.15  2002/05/22 14:05:13  emma
# Sort addresses/names case insensitively (not locale aware).
# Heed quotes when parsing $ENV{LINUXKERNEL_BK_FMT}. As I don't
# currently have Perl 5.004 to test the older Text::ParseWords
# implementation, script now requires Perl 5.005.
# Do not require Pod::Usage, but warn if it's missing.
#
# Revision 0.14  2002/05/22 12:39:59  emma
# Fold the print function dispatcher into %table.
# Parse files on command line individually, but allow to treat them as
# one with a new --merge option.
# Make @cur local to the parse function.
# Die on read errors on input files. Use IO::Handle to read files.
#
# Revision 0.13  2002/05/21 12:42:46  emma
# Add 3 mail addresses.
# Add commentary to the code.
# Check for write errors on STDOUT and die if one happens.
#
# Revision 0.12  2002/05/18 16:54:50  emma
# Make --compress work in terse mode.
# New feature: --swap in terse mode swaps address and log entry.
#
# Revision 0.11  2002/05/18 16:43:30  emma
# Support 'terse' mode.
#
# Revision 0.10  2002/05/18 16:15:10  emma
# Another set of addresses.
#
# Revision 0.9  2002/05/18 16:06:43  emma
# Dozens of new addresses.
#
# Revision 0.8  2002/05/18 15:46:01  emma
# 21 new addresses.
#
# Revision 0.7  2002/05/16 13:57:37  emma
# Add some documentation.
#
# Revision 0.6  2002/05/16 13:55:24  emma
# Fix shift ambiguity in printtag().
#
# Revision 0.5  2002/05/16 13:51:43  emma
# Implement grouped and full modes.
#
# Revision 0.4  2002/05/16 12:07:17  emma
# Add some POD.
# Do options and environment parsing.
# Prepare multiple output modes (only grouped supported at the moment.)
#
# Revision 0.3  2002/05/13 16:11:34  emma
# Compress identical ChangeLog lines (they need not be subsequent, note
# this feature has O(n^2) behaviour, where n is the number of stored
# ChangeLog lines per respective author):
#   Soft-fp fix:
#   Soft-fp fix:
# becomes:
#   2 x Soft-fp fix:
#
# Revision 0.2  2002/05/13 10:40:32  emma
# Only consider e-mail addresses that are left-justified.
# Suggested by Greg K-H <greg@kroah.com>.
#
=head1 NAME

lk-changelog.pl - Reformat BitKeeper ChangeLog for Linux Kernel

=head1 SYNOPSIS

lk-changelog.pl [options] [file [...]]

Try lk-changelog.pl --help or lk-changelog.pl --man for more information.

=head1 OPTIONS

 -h, --help          print this short help
     --man           print the manual page for this program

     --[no]compress  if true, suppress duplicate entries
     --[no]count     if true, fold duplicate entries into one,
                     prefixing it with the count. Implies --compress.
     --[no]swap      in terse and oneline mode, swap address and log entry.
     --[no]merge     treat all files on command line as one big file
                     and suppress the prolog

     --mode=MODE     specify the output format (use --man to find out more)
     --width[=WIDTH] specify the line length, if omitted: $COLUMNS or 80.
                     text lines will not exceed this length.

Warning: Neither --compress nor --count are currently functional with
--mode=full.

=head1 DESCRIPTION

Reformats BitKeeper ChangeLog for Linux Kernel.

=head1 ENVIRONMENT

=over

=item LINUXKERNEL_BK_FMT

Default options. Same as command line options and parsed before
them. If you put --swap here and --noswap on your command line,
--noswap takes precedence.

=back

=head1 AUTHORS

=over

=item * Matthias Andree <matthias.andree@gmx.de>

=item * Marcus Alanen <maalanen@abo.fi>

=item * Tomas Szepe <szepe@pinerecords.com>

=back

=head1 BUGS

=over

=item * The header is not wrapped for --width character wide lines.

=item * The implementation is not yet finished.

=item * This manual page is incomplete.

=item * --compress does not currently work in "full" mode.

=back

=head1 TODO

=over

=item * --compress-me-harder

To merge
  o iget_locked  [1/6]
  o iget_locked  [2/6]
  ...
  o iget_locked  [6/6]
into
  o iget_locked  [1..6/6]

=item * Detect if first line is just a line of a paragraph, or if it's
a paragraph on its own. If it's a line of a paragraph, try to cut at
last full stop or append ellipsis.

=back

=cut
