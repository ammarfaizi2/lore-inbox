Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316435AbSFCNkU>; Mon, 3 Jun 2002 09:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316465AbSFCNkT>; Mon, 3 Jun 2002 09:40:19 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:30475 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S316435AbSFCNkL>; Mon, 3 Jun 2002 09:40:11 -0400
Date: Mon, 3 Jun 2002 15:39:59 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: lk-changelog.pl v0.24
Message-ID: <20020603133959.GA29163@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is a new version of lk-changelog.pl, v0.24. As always, it's also
available for HTTP download from
http://mandree.home.pages.de/linux/kernel/

Release highlights:
- now use the first paragraph rather than the first line as short log
  entry (will hopefully detect all lists and leave them out)
- enhanced oneline mode
- bugfixed full mode (indentation was wrong since v0.21)

-- 
Matthias Andree

----------------------------------------------------------------------------
#! /usr/bin/perl -wT

# This Perl script is meant to simplify/beautify BK ChangeLogs for the linux
# kernel.
#
# (C) Copyright 2002 by Matthias Andree <matthias.andree@gmx.de>
#			Marcus Alanen <maalanen@abo.fi>
#			Tomas Szepe <szepe@pinerecords.com>
#
# $Id: lk-changelog.pl,v 0.24 2002/06/03 13:33:00 emma Exp $
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
use Text::Tabs;
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
#
# Unless otherwise noted, the addresses below have been obtained using
# lbdbq.
my %addresses = (
'abraham@2d3d.co.za' => 'Abraham van der Merwe',
'acher@in.tum.de' => 'Georg Acher',
'achirica@ttd.net' => 'Javier Achirica',
'acme@brinquedo.oo.ps' => 'Arnaldo Carvalho de Melo',
'acme@conectiva.com.br' => 'Arnaldo Carvalho de Melo',
'adam@yggdrasil.com' => 'Adam J. Richter',
'adilger@clusterfs.com' => 'Andreas Dilger',
'agrover@dexter.groveronline.com' => 'Andy Grover',
'agrover@groveronline.com' => 'Andy Grover',
'aia21@cam.ac.uk' => 'Anton Altaparmakov',
'aia21@cantab.net' => 'Anton Altaparmakov',
'aia21@cus.cam.ac.uk' => 'Anton Altaparmakov',
'ak@muc.de' => 'Andi Kleen',
'akpm@zip.com.au' => 'Andrew Morton',
'alan@lxorguk.ukuu.org.uk' => 'Alan Cox',
'amunoz@vmware.com' => 'Alberto Munoz',
'andersg@0x63.nu' => 'Anders Gustafsson',
'andrea@suse.de' => 'Andrea Arcangeli',
'andries.brouwer@cwi.nl' => 'Andries E. Brouwer',
'ankry@green.mif.pg.gda.pl' => 'Andrzej Krzysztofowicz',
'anton@samba.org' => 'Anton Blanchard',
'arjan@redhat.com' => 'Arjan van de Ven',
'arjanv@redhat.com' => 'Arjan van de Ven',
'asit.k.mallick@intel.com' => 'Asit K. Mallick', # by Kristian Peters
'axboe@burns.home.kernel.dk' => 'Jens Axboe',
'axboe@suse.de' => 'Jens Axboe',
'barrow_dj@yahoo.com' => 'D. J. Barrow',
'bcollins@debian.org' => 'Ben Collins',
'bcrl@redhat.com' => 'Benjamin LaHaise',
'beattie@beattie-home.net' => 'Brian Beattie', # from david.nelson
'benh@kernel.crashing.org' => 'Benjamin Herrenschmidt',
'bfennema@falcon.csc.calpoly.edu' => 'Ben Fennema',
'bgerst@didntduck.org' => 'Brian Gerst',
'bhards@bigpond.net.au' => 'Brad Hards',
'bjorn.wesen@axis.com' => 'Bjorn Wesen',
'bjorn_helgaas@hp.com' => 'Bjorn Helgaas',
'borisitk@fortunet.com' => 'Boris Itkis', # by Kristian Peters
'brett@bad-sports.com' => 'Brett Pemberton',
'brownfld@irridia.com' => 'Ken Brownfield',
'bunk@fs.tum.de' => 'Adrian Bunk',
'buytenh@gnu.org' => 'Lennert Buytenhek',
'ccaputo@alt.net' => 'Chris Caputo',
'ch@hpl.hp.com' => 'Christopher Hoover', # by Kristian Peters
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
'david.nelson@pobox.com' => 'David Nelson',
'davidel@xmailserver.org' => 'Davide Libenzi',
'davidm@hpl.hp.com' => 'David Mosberger',
'davidm@napali.hpl.hp.com' => 'David Mosberger',
'davidm@wailua.hpl.hp.com' => 'David Mosberger',
'ddstreet@us.ibm.com' => 'Dan Streetman',
'dhowells@redhat.com' => 'David Howells',
'dirk.uffmann@nokia.com' => 'Dirk Uffmann',
'dledford@redhat.com' => 'Doug Ledford',
'dmccr@us.ibm.com' => 'Dave McCracken',
'dok@directfb.org' => 'Denis Oliver Kropp',
'dougg@torque.net' => 'Douglas Gilbert',
'dwmw2@infradead.org' => 'David Woodhouse',
'ebrower@usa.net' => 'Eric Brower',
'edward_peng@dlink.com.tw' => 'Edward Peng',
'efocht@ess.nec.de' => 'Erich Focht',
'elenstev@mesatop.com' => 'Steven Cole',
'eranian@hpl.hp.com' => 'St�phane Eranian',
'erik_habbinga@hp.com' => 'Erik Habbinga',
'fdavis@si.rr.com' => 'Frank Davis',
'fero@sztalker.hu' => 'Bakonyi Ferenc',
'fischer@linux-buechse.de' => 'J�rgen E. Fischer',
'focht@ess.nec.de' => 'Erich Focht',
'ganesh@veritas.com' => 'V. Ganesh',
'ganesh@vxindia.veritas.com' => 'V. Ganesh',
'geert@linux-m68k.org' => 'Geert Uytterhoeven',
'geert@linux-m68k.org.com' => 'Geert Uytterhoeven',
'george@mvista.com' => 'George Anzinger',
'ghoz@sympatico.ca' => 'Ghozlane Toumi',
'gibbs@overdrive.btc.adaptec.com' => 'Justin T. Gibbs',
'gibbs@scsiguy.com' => 'Justin T. Gibbs',
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
'hch@pentafluge.infradead.org' => 'Christoph Hellwig',
'hch@sb.bsdonline.org' => 'Christoph Hellwig', # by Kristian Peters
'henrique@cyclades.com' => 'Henrique Gobbi',
'hermes@gibson.dropbear.id.au' => 'David Gibson',
'hirofumi@mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
'hoho@binbash.net' => 'Colin Slater',
'hugh@veritas.com' => 'Hugh Dickins',
'ink@jurassic.park.msu.ru' => 'Ivan Kokshaysky',
'ionut@cs.columbia.edu' => 'Ion Badulescu',
'ioshadij@hotmail.com' => 'Ishan O. Jayawardena',
'jack@suse.cz' => 'Jan Kara',
'jaharkes@cs.cmu.edu' => 'Jan Harkes',
'jamagallon@able.es' => 'J. A. Magallon',
'jamey@crl.dec.com' => 'Jamey Hicks',
'jani@astechnix.ro' => 'Jani Monoses',
'jbglaw@lug-owl.de' => 'Jan-Benedict Glaw',
'jdavid@farfalle.com' => 'David Ruggiero',
'jdr@farfalle.com' => 'David Ruggiero',
'jes@wildopensource.com' => 'Jes Degn S�rensen',
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
'k.kasprzak@box43.pl' => 'Karol Kasprzak', # by Kristian Peters
'kaber@trash.net' => 'Patrick McHardy',
'kai-germaschewski@uiowa.edu' => 'Kai Germaschewski',
'kai.reichert@udo.edu' => 'Kai Reichert',
'kai@tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
'kanoj@vger.kernel.org' => 'Kanoj Sarcar', # sent by Arnaldo Carvalho de Melo
'kanojsarcar@yahoo.com' => 'Kanoj Sarcar',
'kaos@ocs.com.au' => 'Keith Owens',
'kasperd@daimi.au.dk' => 'Kasper Dupont',
'key@austin.ibm.com' => 'Kent Yoder',
'khalid@fc.hp.com' => 'Khalid Aziz',
'khalid_aziz@hp.com' => 'Khalid Aziz',
'knan@mo.himolde.no' => 'Erik Inge Bols�',
'kraxel@bytesex.org' => 'Gerd Knorr',
'kraxel@suse.de' => 'Gerd Knorr',
'kuebelr@email.uc.edu' => 'Robert Kuebel',
'kuznet@ms2.inr.ac.ru' => 'Alexey Kuznetsov',
'laforge@gnumonks.org' => 'Harald Welte',
'ldb@ldb.ods.org' => 'Luca Barbieri',
'liyang@nerv.cx' => 'Liyang Hu',
'lm@bitmover.com' => 'Larry McVoy',
'macro@ds2.pg.gda.pl' => 'Maciej W. Rozycki',
'manfred@colorfullife.com' => 'Manfred Spraul',
'marc@mbsi.ca' => 'Marc Boucher',
'marcelo@conectiva.com.br' => 'Marcelo Tosatti',
'marcelo@plucky.distro.conectiva' => 'Marcelo Tosatti',
'martin@meltin.net' => 'Martin Schwenke',
'mason@suse.com' => 'Chris Mason',
'maxk@qualcomm.com' => 'Maksim Krasnyanskiy',
'mcp@linux-systeme.de' => 'Marc-Christian Petersen',
'mdharm@one-eyed-alien.net' => 'Matthew Dharm',
'mdharm-usb@one-eyed-alien.net' => 'Matthew Dharm',
'mec@shout.net' => 'Michael Elizabeth Chastain',
'michal@harddata.com' => 'Michal Jaegermann',
'mikep@linuxtr.net' => 'Mike Phillips',
'mikpe@csd.uu.se' => 'Mikael Pettersson',
'miles@megapathdsl.net' => 'Miles Lane',
'miltonm@bga.com' => 'Milton Miller', # by Kristian Peters
'mingo@elte.hu' => 'Ingo Molnar',
'mj@ucw.cz' => 'Martin Mares',
'mlindner@syskonnect.de' => 'Mirko Lindner',
'mmcclell@bigfoot.com' => 'Mark McClelland',
'mochel@geena.pdx.osdl.net' => 'Patrick Mochel',
'mochel@osdl.org' => 'Patrick Mochel',
'mochel@segfault.osdl.org' => 'Patrick Mochel',
'msw@redhat.com' => 'Matt Wilson',
'nahshon@actcom.co.il' => 'Itai Nahshon',
'nathans@sgi.com' => 'Nathan Scott',
'neilb@cse.unsw.edu.au' => 'Neil Brown',
'nemosoft@smcc.demon.nl' => 'Nemosoft Unv.',
'nico@cam.org' => 'Nicolas Pitre',
'nkbj@image.dk' => 'Niels Kristian Bech Jensen',
'olh@suse.de' => 'Olaf Hering',
'oliendm@us.ibm.com' => 'Dave Olien',
'oliver@neukum.name' => 'Oliver Neukum',
'oliver@neukum.org' => 'Oliver Neukum',
'os@emlix.com' => 'Oskar Schirmer', # sent by himself
'p_gortmaker@yahoo.com' => 'Paul Gortmaker',
'paulkf@microgate.com' => 'Paul Fulghum',
'paulus@nanango.paulus.ozlabs.org' => 'Paul Mackerras',
'paulus@quango.ozlabs.ibm.com' => 'Paul Mackerras',
'paulus@samba.org' => 'Paul Mackerras',
'pavel@ucw.cz' => 'Pavel Machek',
'pavel@suse.cz' => 'Pavel Machek',
'pazke@orbita1.ru' => 'Andrey Panin',
'perex@perex.cz' => 'Jaroslav Kysela',
'perex@suse.cz' => 'Jaroslav Kysela',
'peter@cadcamlab.org' => 'Peter Samuelson',
'peter@chubb.wattle.id.au' => 'Peter Chubb',
'petero2@telia.com' => 'Peter Osterlund',
'petr@vandrovec.name' => 'Petr Vandrovec',
'plars@austin.ibm.com' => 'Paul Larson',
'pmenage@ensim.com' => 'Paul Menage',
'prom@berlin.ccc.de' => 'Ingo Albrecht',
'quinlan@transmeta.com' => 'Daniel Quinlan',
'quintela@mandrakesoft.com' => 'Juan Quintela',
'rddunlap@osdl.org' => 'Randy Dunlap',
'reality@delusion.de' => 'Udo A. Steinberg',
'reiser@namesys.com' => 'Hans Reiser',
'rem@osdl.org' => 'Bob Miller',
'rgooch@atnf.csiro.au' => 'Richard Gooch',
'rgooch@ras.ucalgary.ca' => 'Richard Gooch',
'rhirst@linuxcare.com' => 'Richard Hirst',
'riel@conectiva.com.br' => 'Rik van Riel',
'rl@hellgate.ch' => 'Roger Luethi',
'rlievin@free.fr' => 'Romain Lievin',
'rmk@arm.linux.org.uk' => 'Russell King',
'rmk@flint.arm.linux.org.uk' => 'Russell King',
'rml@tech9.net' => 'Robert Love',
'rob@osinvestor.com' => 'Rob Radez',
'robert.olsson@data.slu.se' => 'Robert Olsson',
'romieu@cogenit.fr' => 'Fran�ois Romieu',
'rth@twiddle.net' => 'Richard Henderson',
'rui.sousa@laposte.net' => 'Rui Sousa',
'rusty@rustcorp.com.au' => 'Rusty Russell',
'rwhron@earthlink.net' => 'Randy Hron',
'sailer@scs.ch' => 'Thomas Sailer',
'sandeen@sgi.com' => 'Eric Sandeen',
'santiago@newphoenix.net' => 'Santiago A. Nullo', # sent by self
'sawa@yamamoto.gr.jp' => 'sawa',
'schwab@suse.de' => 'Andreas Schwab',
'scott.feldman@intel.com' => 'Scott Feldman',
'scott_anderson@mvista.com' => 'Scott Anderson',
'sebastian.droege@gmx.de' => 'Sebastian Dr�ge',
'sfr@canb.auug.org.au' => 'Stephen Rothwell',
'shaggy@austin.ibm.com' => 'Dave Kleikamp',
'shaggy@kleikamp.austin.ibm.com' => 'Dave Kleikamp',
'simonb@lipsyncpost.co.uk' => 'Simon Burley',
'sl@lineo.com' => 'Stuart Lynne',
'smurf@osdl.org' => 'Nathan Dabney',
'spse@secret.org.uk' => 'Simon Evans', # by Kristian Peters
'steiner@sgi.com' => 'Jack Steiner',
'stelian.pop@fr.alcove.com' => 'Stelian Pop',
'szepe@pinerecords.com' => 'Tomas Szepe',
'tai@imasy.or.jp' => 'Taisuke Yamada',
'tcallawa@redhat.com' => 'Tom Callaway',
'tetapi@utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
'thockin@sun.com' => 'Tim Hockin',
'tigran@aivazian.name' => 'Tigran Aivazian',
'tim@physik3.uni-rostock.de' => 'Tim Schmielau',
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
'wolfgang.fritz@gmx.net' => 'Wolfgang Fritz', # by Kristian Peters
'wstinson@infonie.fr' => 'William Stinson',
'xkaspa06@stud.fee.vutbr.cz' => 'Kasparek Tomas',
'zaitcev@redhat.com' => 'Pete Zaitcev',
'zippel@linux-m68k.org' => 'Roman Zippel',
'zwane@commfireservices.com' => 'Zwane Mwaikambo',
'~~~~~~thisentrylastforconvenience~~~~~' => 'Cesar Brutus Anonymous'
);

my %address_unknown;

# get name associated to an email address
sub rmap_address {
  my @o = map {defined $addresses{$_} ? $addresses{$_} :
		 scalar (($address_unknown{$_} = 1), $_); }
          map { lc; } @_;
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
   'oneline' => { 'index' => \&get_name,
		  'print' => \&print_oneline },
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
      @lines = map { expand(wrap($indent1, $indent, ($_))); } @lines;
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
	@lines = expand(wrap($indent1, $indent, @lines));
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
	  my @lines = expand(wrap($indent1, $indent, ("$a: $_")));
	  print join("\n", @lines), "\n"  or write_error();
	}
      } else {
	# width, but not swap set
	foreach (compress(map { $_->[0]; } @{$log{$_}})) {
	  my @addr = expand(split(/\n/, wrap('', $indent, " ($a)")));
	  my @lines = expand(split(/\n/, wrap($indent1, $indent, ($_))));

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

# implementation of "oneline" output
# which is similar to terse but reformats to one line exactly
# with --swap          without --swap
# author1: log1        log1    (author1)
# author1: log2        log2    (author2)
# author2: log3        log3    (author3)
sub print_oneline() {
  for (sort caseicmp keys %log) {
    my $a = $_;
    if ($opt{width}) {
      if ($opt{swap}) {
	foreach (compress(map { $_->[0]; } @{$log{$_}})) {
	  my $str = "$a: $_";
	  if (length($str) > $opt{width}) {
	    printf "%-.*s...\n", $opt{width}-3, $indent1 . "$a: $_"
	      or write_error();
	  } else {
	    printf "%-.*s\n", $opt{width}, $indent1 . "$a: $_"
	      or write_error();
	  }
	}
      } else { # not swapping
	foreach (compress(map { $_->[0]; } @{$log{$_}})) {
	  my $l = $opt{width} - length($indent1) - length($a) - 3;
	  if (length($_) > $l) {
	    $l -= 3;
	    printf "%s%-*.*s... (%s)\n", $indent1, $l, $l, $_, $a;
	  } else {
	    printf "%s%-*.*s (%s)\n", $indent1, $l, $l, $_, $a;
	  }
	}
      }
    } else {
      # not $opt{width} -> same as print_terse
      print_terse();
    }
  }
}

sub abbreviate_name($ ) {
  my @a = split /\s+/, $_[0];

  # treat Roman numerals as last part of name
  my $off = 0;
  $off = 1 if ($a[$#a] =~ /^[IVXLCMD]+$/i);

  for (my $i = 0; $i < $#a - $off; $i++) {
    $a[$i] =~ s/^(.).*/$1./;
  }
  return join(" ", @a);
}

# Read a file and parse it into the %log hash.
sub parse_file($ ) {
  croak unless wantarray;
  my @prolog;
  local $_;
  my $fn = shift;
  my $fh;
  # Treat '-' as stdin -- IO::File won't do this.
  if ($fn eq '-') {
    $fh = new IO::Handle;
    $fh->fdopen(fileno(STDIN), "r")
      or die "cannot open stdin: $!\nAborting";
  } else {
    $fh = new IO::File;
    $fh->open($fn, "r")
      or die "cannot open \"$fn\": $!\nAborting";
  }

  # initialize
  my @cur = ();
  my $first = 0;
  my $firstpar = 0;
  undef $address;

  # now go!  

  # NOTE: the first @cur item can consist of multiple lines in the
  # source file which are joined together. This happens when the first
  # paragraph is longer than a single line.
  while($_ = $fh -> getline) {
    chomp;
    # expand all tabs but the first
    $_ = expand($_);
    s/^        /\t/;

    if (defined $address and $opt{multi} and m|^[^<[:space:]]|) {
      # if we are in multi mode, if we encounter a non-address
      # left-justified line, flush all data and print the header. The
      # defined $address trick lets this only trigger to switch back
      # from "log entry" to "prolog" mode
      append_item(@cur); @cur = ();
      doprint(@prolog);
      print "\n" or write_error(); # print blank line between changelogs
      @prolog = ($_);
      undef %log;
      undef $address;
    } elsif (m|^<([^>]+)>|) {
      # go figure if a line starts with an address, if so, take it
      # resolve the address to a name if possible
      append_item(@cur); @cur = ();
      $address = $1;
      $name = rmap_address($address);
      if ($name ne $address) {
	if ($opt{'abbreviate-names'}) {
	  $name = abbreviate_name($name);
	}
	$author = $name . ' <' . $address . '>';
      } else {
	$author = '<' . $address . '>';
      }
      $first = 1;
      $firstpar = 1;
    } elsif ($first) {
      # we have a "first" line after an address, take it, 
      # strip common redundant tags

      # kill "PATCH" tag
      s/^\s*\[PATCH\]//;
      s/^\s*PATCH//;
      s/^\s*[-:]+\s*//;

      # strip trailing colon or period, and if we strip one,
      # we don't parse further lines as part of the first paragraph
      if (s/[:.]+\s*$//) { $firstpar = 0; }

      # kill leading and trailing whitespace for consistent indentation
      s/^\s+//; s/\s+$//;

      push @cur, $_;
      $first = 0;
    } elsif (defined $address) {
      # second or subsequent lines -- if in first paragraph,
      # append this line to the first log line.
      if (m/^\s*$/) { $firstpar = 0; }
      elsif (m/^\s*[-*o\#]/) { $firstpar = 0; }
      if ($firstpar) {
	s/^\s*/ /;
	$cur[0] .= $_;
      } else {
	push @cur, $_;
      }
      # we don't parse further lines as part of the first paragraph
      if (s/[:.]+\s*$//) { $firstpar = 0; }
    } else {
      # store header before a changelog
      push @prolog, $_;
    }
  }

  if ($fh -> error) {
    die "Error while reading from \"$fn\": $!";
  }

  # at file end, flush @cur array to %log.
  append_item(@cur);

  return @prolog;
}

# print a word-wrapped name or mail address, followed by a trailing colon.
# used by print_grouped and print_full
# passes the return value of print back up
sub printtag($ ) {
  my $a = shift;
  $a .= ':';
  return print $opt{width} ? expand(wrap("", "", ($a))) : $a, "\n";
}

# === MAIN PROGRAM ===============================================
# Command line arguments
# What options do we support?
my @opts = ("help|?|h", "man", "mode=s", "compress!", "count!", "width:i",
	    "swap!", "merge!", "warn!", "multi!", "abbreviate-names!");

# How do we parse them?
if ($Getopt::Long::VERSION gt '2.24') {
  Getopt::Long::Configure("gnu_getopt");
}

# set default options
$opt{mode} = 'grouped';
$opt{warn} = 1;

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
pod2usage(-verbose => 0,
	  -message => "$0: You cannot use --merge and --multi at the same time.")
  if ($opt{merge} and $opt{multi});

# Shortcut for programmer convenience :-)
$indexby = $table{$opt{mode}}->{'index'};

# --count implies --compress
if ($opt{count}) { $opt{compress} = 1; }

# if --width is without argument or the argument is zero,
# try to figure $COLUMNS or fall back to 80.
if (exists $opt{width} and not $opt{width}) {
  $opt{width} = $ENV{COLUMNS} ? $ENV{COLUMNS} : 80;
}

# Print the passed-in array linewise, checking for write errors
# Then call the configured function to print %log formatted
sub doprint(@ ) {
  print join("\n", @_), "\n" or write_error();
  &{$table{$opt{mode}}->{print}};
}

# --------------------------------------------------------------------
# Global initializations
$Text::Tabs::tabstop = 8;
$Text::Wrap::huge = 'wrap';
if ($opt{width}) {
  $Text::Wrap::columns = $opt{width};
}

# Main program
unshift(@ARGV, '-') unless @ARGV;

if ($debug) {
  print STDERR "DEBUG: Options summary:\n";
  while (my ($k, $v) = each %opt) { print STDERR "DEBUG:   '$k' => '$v'\n"; }
  print STDERR "DEBUG: Arguments summary:\n";
  foreach (@ARGV) { print STDERR "DEBUG:   '$_'\n"; }
}

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

# Warn about unknown addresses
if ($opt{warn}) {
  foreach (sort caseicmp keys %address_unknown) {
    print STDERR "Warning: unknown address \"$_\"\n" or write_error();
  }
}

__END__
# --------------------------------------------------------------------
# $Log: lk-changelog.pl,v $
# Revision 0.24  2002/06/03 13:33:00  emma
# * Fix 'grouped', 'terse', 'oneline' modes (change to parse_file()). We
#   now take the first paragraph instead of the first line as log
#   entry. We also guess where the paragraph ends, it ends at a line with
#   trailing dot or colon, or if the next line is empty or starts with a
#   "bullet" (that is -, *, o or #).
# * New option --abbreviate-names.
# * Fix 'full' mode indentation, broken in v0.21 by expanding the tabs.
#   Now, the first tab is unexpanded again.
# * Enhance 'online' mode: if the log is truncated, append an ellipsis ("...").
# * Add more mail addresses.
# * Fix Brian Beattie's name (was "Michael Beattie").
#
# Revision 0.23  2002/06/03 12:36:01  emma
# More e-mail addresses.
#
# Revision 0.22  2002/05/29 20:28:20  emma
# Mail addresses added.
#
# Revision 0.21  2002/05/29 11:45:48  emma
# * Implement --mode=oneline.
# * Expand tabs in input lines (tab stops are spaced 8 columns away from each other).
# * Bugfix --multi mode: all append_item to flush @cur before printing.
# * Restore prolog detection in --multi mode for efficiency.
# * Undo the "unexpand()" that Text::Wrap does, it breaks our line width
#   calculation. In the long run, a replacement for Text::Wrap must be
#   found that does not unexpand().
#
# Revision 0.20  2002/05/29 10:44:35  emma
# New --multi option that states multiple changelogs are in the same file.
#
# Revision 0.19  2002/05/29 10:27:21  emma
# New option: --[no]warn: Warn about unknown addresses. By default
# enabled, use --nowarn to suppress.
#
# Revision 0.18  2002/05/29 10:17:00  emma
# New addresses.
#
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
# Suggested by Greg Kroah-Hartman <greg@kroah.com>.
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
     --[no]multi     states that multiple changelogs are in one file
     --[no]warn      warn about unknown addresses. Default: set!
     --[no]abbreviate-names
                     abbreviate all but the last name

     --mode=MODE     specify the output format (use --man to find out more)
     --width[=WIDTH] specify the line length, if omitted: $COLUMNS or 80.
                     text lines will not exceed this length.

Warning: Neither --compress nor --count are currently functional with
--mode=full.

=head1 DESCRIPTION

Summarizes or reformats BitKeeper ChangeLogs for Linux Kernel 2.X.

=head1 ENVIRONMENT

=over

=item LINUXKERNEL_BK_FMT

Default options. These have the same meaning and syntax as the command
line options and are parsed before them, so you can override defaults
set in this variable on the command line. B<Example:> If you put
--swap here and --noswap on your command line, --noswap takes
precedence.

=back



=head1 EXAMPLES

=over

=item Reformat ChangeLog-2.5.17, displaying all changes grouped by
  their author (that is the default mode, but we specify it anyways),
  with 76 character wide lines:

 lk-changelog.pl --mode=grouped --width=76 ChangeLog-2.5.17

=item Reformat ChangeLog-2.5.18, displaying all changes and their
      author on in "-ac changelog style", with 80 character wide lines:

 lk-changelog.pl --mode=terse --width=80 ChangeLog-2.5.18

=item Reformat 2.4.19-pre ChangeLogs (several in one file) from your mailer:

Use the pipe command to pipe the mail into:

 lk-changelog.pl --multi --mode=terse --width=80

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

=item * --compress does not currently work with --mode=full.

=item * does not detect if the changelog is already summarized (as in Marcelo's 2.4.19-pre9 announcement on the list)

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

=item * Offer sort by last name

=back

=cut
