Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbTFDStR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 14:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTFDStQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 14:49:16 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:56839 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263847AbTFDSsS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 14:48:18 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com, marcelo@conectiva.com.br
Subject: lk-changelog.pl 0.124
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed_Jun__4_19_01_43_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030604190143.3314F89AEA@merlin.emma.line.org>
Date: Wed,  4 Jun 2003 21:01:43 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.124 has been released.

This script is used by Linus and Marcelo to rearrange and reformat BK
ChangeSet logs into a more human-readable format, and the official
repository is bk://gkernel.bkbits.net/BK-kernel-tools/

The changes are listed at the end of the script below.

You can always download this script and GPG signatures from
http://mandree.home.pages.de/linux/kernel/

My thanks go to Vitezslav Samel who has spent a lot of time on digging
out the real names for addresses sending in BK ChangeSets.

Note that your mailer must be MIME-capable to save this mail properly,
because it is in the "quoted-printable" encoding.

= <- if you see just an equality sign, but no "3D", your mailer is fine.
= <- if you see 3D on this line, then upgrade your mailer or pipe this mail
= <- into metamail.

-- 
A sh script on behalf of Matthias Andree
-------------------------------------------------------------------------
Changes since last release:

----------------------------
revision 0.124
date: 2003/06/04 10:31:18;  author: vita;  state: Exp;  lines: +7 -1
added 3 names for new addresses
----------------------------
revision 0.123
date: 2003/06/03 05:49:53;  author: vita;  state: Exp;  lines: +6 -1
added 2 names for new addresses
----------------------------
revision 0.122
date: 2003/06/02 09:11:21;  author: emma;  state: Exp;  lines: +5 -2
Fix umlaut in Moritz Mühlenhoff's name.
----------------------------
revision 0.121
date: 2003/06/02 08:56:16;  author: vita;  state: Exp;  lines: +9 -1
added 5 names for new addresses
----------------------------
revision 0.120
date: 2003/05/29 11:11:22;  author: vita;  state: Exp;  lines: +6 -1
added 2 names for new addresses
=============================================================================
-------------------------------------------------------------------------
#! /usr/bin/perl -wT

# This Perl script is meant to simplify/beautify BK ChangeLogs for the linux
# kernel.
#
# (C) Copyright 2002 by Matthias Andree <matthias.andree@gmx.de>
#			Marcus Alanen <maalanen@abo.fi>
#			Tomas Szepe <szepe@pinerecords.com>
#			Vitezslav Samel <samel@mail.cz>
#
# $Id: lk-changelog.pl,v 0.124 2003/06/04 10:31:18 vita Exp $
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

sub selftest();

# --------------------------------------------------------------------
# customize the following line to change the indentation of the change
# lines, $indent1 is used for the first line of an entry, $indent for
# all subsequent lines. $indent is auto-generated from $indent1.
my $indent1 = "  o ";
my $indent  = " " x length($indent1);
# change this to enable some debugging stuff:
my $debug = 0;
# --------------------------------------------------------------------

# Perl syntax magic here, "=>" is equivalent to ","
my @addrregexps = (
[ 'alan@.*\.swansea\.linux\.org\.uk' => 'Alan Cox', ],
[ 'torvalds@(.*\.)?transmeta\.com' => 'Linus Torvalds', ],
[ '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' => '~~~~~~~~' ]);

sub obfuscate(@) {
  my @a = @_;
  map { tr/@/:/ } @a;
  return wantarray ? @a : $a[0];
};

sub unveil(@) {
  my @a = @_;
  map { tr/:/@/ } @a;
  return wantarray ? @a : $a[0];
};

# the key is the email address in ALL LOWER CAPS!
# the value is the real name of the person
#
# Unless otherwise noted, the addresses below have been obtained using
# lbdb.
my @addresses_handled_in_regexp = (
'alan:hraefn.swansea.linux.org.uk' => 'Alan Cox',
'alan:irongate.swansea.linux.org.uk' => 'Alan Cox',
'torvalds:athlon.transmeta.com' => 'Linus Torvalds',
'torvalds:home.transmeta.com' => 'Linus Torvalds',
'torvalds:kiwi.transmeta.com' => 'Linus Torvalds',
'torvalds:penguin.transmeta.com' => 'Linus Torvalds',
'torvalds:tove.transmeta.com' => 'Linus Torvalds',
'torvalds:transmeta.com' => 'Linus Torvalds',
'###############################' => '###############'
);
# Above is the list of addresses that are now matched by regexps,
# it is not used by _this_ script (ourselves), but Zack Brown has
# scripts that parse this code to get developer addresses, so we keep
# them around. As we don't need it, we just kill it. (We use the same
# syntax as for the regular address hash for ease of use.)
undef @addresses_handled_in_regexp;

my %addresses = (
'aaron.baranoff:tsc.tdk.com' => 'Aaron Baranoff',
'abraham:2d3d.co.za' => 'Abraham van der Merwe',
'abslucio:terra.com.br' => 'Lucio Maciel',
'ac9410:attbi.com' => 'Albert Cranford',
'ac9410:bellsouth.net' => 'Albert Cranford',
'acher:in.tum.de' => 'Georg Acher',
'achirica:ttd.net' => 'Javier Achirica',
'acme:brinquedo.oo.ps' => 'Arnaldo Carvalho de Melo',
'acme:conectiva.com.br' => 'Arnaldo Carvalho de Melo',
'acme:dhcp197.conectiva' => 'Arnaldo Carvalho de Melo',
'acurtis:onz.com' => 'Allen Curtis',
'adam:kroptech.com' => 'Adam Kropelin',
'adam:mailhost.nmt.edu' => 'Adam Radford', # google
'adam:nmt.edu' => 'Adam Radford', # google
'adam:skullslayer.rod.org' => 'Adam Bernau',
'adam:yggdrasil.com' => 'Adam J. Richter',
'adaplas:pol.net' => 'Antonino Daplas',
'aderesch:fs.tum.de' => 'Andreas Deresch',
'adilger:clusterfs.com' => 'Andreas Dilger',
'aebr:win.tue.nl' => 'Andries E. Brouwer',
'agrover:acpi3.(none)' => 'Andy Grover',
'agrover:acpi3.jf.intel.com' => 'Andy Grover', # guessed
'agrover:aracnet.com' => 'Andy Grover',
'agrover:dexter.groveronline.com' => 'Andy Grover',
'agrover:groveronline.com' => 'Andy Grover',
'agruen:suse.de' => 'Andreas Gruenbacher',
'ahaas:airmail.net' => 'Art Haas',
'ahaas:neosoft.com' => 'Art Haas',
'aia21:cam.ac.uk' => 'Anton Altaparmakov',
'aia21:cantab.net' => 'Anton Altaparmakov',
'aia21:cus.cam.ac.uk' => 'Anton Altaparmakov',
'ajoshi:kernel.crashing.org' => 'Ani Joshi',
'ajoshi:shell.unixbox.com' => 'Ani Joshi',
'ak:muc.de' => 'Andi Kleen',
'ak:suse.de' => 'Andi Kleen',
'akpm:digeo.com' => 'Andrew Morton',
'akpm:reardensteel.com' => 'Andrew Morton',
'akpm:zip.com.au' => 'Andrew Morton',
'akropel1:rochester.rr.com' => 'Adam Kropelin', # lbdb
'alan:lxorguk.ukuu.org.uk' => 'Alan Cox',
'alan:redhat.com' => 'Alan Cox',
'alborchers:steinerpoint.com' => 'Al Borchers',
'alex:ssi.bg' => 'Alexander Atanasov',
'alex_williamson:attbi.com' => 'Alex Williamson', # lbdb
'alex_williamson:com.rmk.(none)' => 'Alex Williamson',
'alex_williamson:hp.com' => 'Alex Williamson', # google
'alexander.riesen:synopsys.com' => 'Alexander Riesen',
'alexander.schulz:innominate.com' => 'Alexander Schulz',
'alexander.schulz:com.rmk.(none)' => 'Alexander Schulz',
'alexey:technomagesinc.com' => 'Alex Tomas',
'alfre:ibd.es' => 'Alfredo Sanjuán',
'ambx1:neo.rr.com' => 'Adam Belay',
'amunoz:vmware.com' => 'Alberto Munoz',
'andersen:codepoet.org' => 'Erik Andersen',
'andersg:0x63.nu' => 'Anders Gustafsson',
'andmike:us.ibm.com' => 'Mike Anderson', # lbdb
'andre.breiler:null-mx.org' => 'André Breiler',
'andrea:suse.de' => 'Andrea Arcangeli',
'andrew.wood:ivarch.com' => 'Andrew Wood',
'andries.brouwer:cwi.nl' => 'Andries E. Brouwer',
'andros:citi.umich.edu' => 'Andy Adamson',
'angus.sawyer:dsl.pipex.com' => 'Angus Sawyer',
'ankry:green.mif.pg.gda.pl' => 'Andrzej Krzysztofowicz',
'anton:samba.org' => 'Anton Blanchard',
'anton:superego.(none)' => 'Anton Blanchard',
'anton:superego.ozlabs.ibm.com' => 'Anton Blanchard',
'apolkosnik:directvinternet.com' => 'Adam Polkosnik',
'arashi:yomerashi.yi.org' => 'Matt Reppert',
'aris:cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
'arjan:redhat.com' => 'Arjan van de Ven',
'arjanv:redhat.com' => 'Arjan van de Ven',
'arnaud.quette:mgeups.com' => 'Arnaud Quette',
'arnd:arndb.de' => 'Arnd Bergmann',
'arnd:bergmann-dalldorf.de' => 'Arnd Bergmann',
'arndb:de.ibm.com' => 'Arnd Bergmann',
'arndt:lin02384n012.mc.schoenewald.de' => 'Arndt Schoenewald',
'arun.sharma:intel.com' => 'Arun Sharma',
'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
'asl:launay.org' => 'Arnaud S. Launay',
'atulm:lsil.com' => 'Atul Mukker',
'axboe:burns.home.kernel.dk' => 'Jens Axboe', # guessed
'axboe:hera.kernel.org' => 'Jens Axboe',
'axboe:suse.de' => 'Jens Axboe',
'azarah:gentoo.org' => 'Martin Schlemmer',
'b.zolnierkiewicz:elka.pw.edu.pl' => 'Bartlomiej Zolnierkiewicz',
'baccala:vger.freesoft.org' => 'Brent Baccala',
'baldrick:wanadoo.fr' => 'Duncan Sands',
'ballabio_dario:emc.com' => 'Dario Ballabio',
'barrow_dj:yahoo.com' => 'D. J. Barrow',
'barryn:pobox.com' => 'Barry K. Nathan', # lbdb
'bart.de.schuyer:pandora.be' => 'Bart De Schuymer',
'bart.de.schuymer:pandora.be' => 'Bart De Schuymer',
'bbosch:iphase.com' => 'Bradley A. Bosch',
'bcollins:debian.org' => 'Ben Collins',
'bcrl:bob.home.kvack.org' => 'Benjamin LaHaise',
'bcrl:redhat.com' => 'Benjamin LaHaise',
'bcrl:toomuch.toronto.redhat.com' => 'Benjamin LaHaise', # guessed
'bde:bwlink.com' => 'Bruce D. Elliott',	# it's typo IMHO
'bde:nwlink.com' => 'Bruce D. Elliott',
'bdschuym:pandora.be' => 'Bart De Schuymer',
'beattie:beattie-home.net' => 'Brian Beattie', # from david.nelson
'bellucda:tiscali.it' => 'Daniele Bellucci',
'benh:kernel.crashing.org' => 'Benjamin Herrenschmidt',
'benh:zion.wanadoo.fr' => 'Benjamin Herrenschmidt',
'bergner:brule.rchland.ibm.com' => 'Peter Bergner',
'bergner:cannon.rchland.ibm.com' => 'Peter Bergner',
'bergner:vnet.ibm.com' => 'Peter Bergner',
'bernhard.kaindl:gmx.de' => 'Bernhard Kaindl',
'berny.f:aon.at' => 'Bernhard Fischer',
'bero:arklinux.org' => 'Bernhard Rosenkraenzer',
'bfennema:falcon.csc.calpoly.edu' => 'Ben Fennema',
'bgerst:didntduck.org' => 'Brian Gerst',
'bhards:bigpond.net.au' => 'Brad Hards',
'bhavesh:avaya.com' => 'Bhavesh P. Davda',
'bheilbrun:paypal.com' => 'Brad Heilbrun', # by himself
'bjorn.andersson:erc.ericsson.se' => 'Björn Andersson', # google, guessed ö
'bjorn.wesen:axis.com' => 'Bjorn Wesen',
'bjorn_helgaas:hp.com' => 'Bjorn Helgaas',
'bk:suse.de' => 'Bernhard Kaindl',
'blaschke:blaschke3.austin.ibm.com' => 'Dave Blaschke',
'blueflux:koffein.net' => 'Oskar Andreasson',
'bmatheny:purdue.edu' => 'Blake Matheny', # google
'bombe:informatik.tu-muenchen.de' => 'Andreas Bombe',
'borisitk:fortunet.com' => 'Boris Itkis', # by Kristian Peters
'braam:clusterfs.com' => 'Peter Braam',
'brett:bad-sports.com' => 'Brett Pemberton',
'brihall:pcisys.net' => 'Brian Hall', # google
'brm:murphy.dk' => 'Brian Murphy',
'brownfld:irridia.com' => 'Ken Brownfield',
'bryder:paradise.net.nz' => 'Bill Ryder',
'bunk:fs.tum.de' => 'Adrian Bunk',
'buytenh:gnu.org' => 'Lennert Buytenhek',
'bwa:us.ibm.com' => 'Bruce Allan',
'bwheadley:earthlink.net' => 'Bryan W. Headley',
'bwindle:fint.org' => 'Burton N. Windle',
'bzeeb-lists:lists.zabbadoz.net' => 'Björn A. Zeeb', # lbdb
'bzzz:gerasimov.net' => 'Alex Tomas',
'bzzz:tmi.comex.ru' => 'Alex Tomas',
'c-d.hailfinger.kernel.2002-07:gmx.net' => 'Carl-Daniel Hailfinger',
'c-d.hailfinger.kernel.2002-q4:gmx.net' => 'Carl-Daniel Hailfinger', # himself
'c-d.hailfinger.kernel.2003:gmx.net' => 'Carl-Daniel Hailfinger', # himself
'cananian:lesser-magoo.lcs.mit.edu' => 'C. Scott Ananian',
'cattelan:sgi.com' => 'Russell Cattelan', # google
'ccaputo:alt.net' => 'Chris Caputo',
'ccheney:cheney.cx' => 'Christopher L. Cheney',
'cel:citi.umich.edu' => 'Chuck Lever',
'celso:bulma.net' => 'Celso González', # google
'ch:com.rmk.(none)' => 'Christopher Hoover',
'ch:hpl.hp.com' => 'Christopher Hoover', # by Kristian Peters
'ch:murgatroid.com' => 'Christopher Hoover',
'chan:aleph1.co.uk' => 'Tak-Shing Chan',
'charles.white:hp.com' => 'Charles White',
'chas:cmf.nrl.navy.mil' => 'Chas Williams',
'chas:locutus.cmf.nrl.navy.mil' => 'Chas Williams',
'chessman:tux.org' => 'Samuel S. Chessman',
'chris:qwirx.com' => 'Chris Wilson',
'chris:wirex.com' => 'Chris Wright',
'christer:weinigel.se' => 'Christer Weinigel', # from shortlog
'christopher.leech:intel.com' => 'Christopher Leech',
'christopher:intel.com' => 'Christopher Goldfarb',
'cip307:cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
'ckulesa:as.arizona.edu' => 'Craig Kulesa',
'clemens:ladisch.de' => 'Clemens Ladisch',
'cloos:jhcloos.com' => 'James H. Cloos Jr.',
'cloos:lugabout.jhcloos.org' => 'James H. Cloos Jr.',
'cmayor:ca.rmk.(none)' => 'Cam Mayor',
'cminyard:mvista.com' => 'Corey Minyard',
'cniehaus:handhelds.org' => 'Carsten Niehaus',
'cobra:compuserve.com' => 'Kevin Brosius',
'colin:gibbs.dhs.org' => 'Colin Gibbs',
'colpatch:us.ibm.com' => 'Matthew Dobson',
'corbet:lwn.net' => 'Jonathan Corbet',
'corryk:us.ibm.com' => 'Kevin Corry',
'cort:fsmlabs.com' => 'Cort Dougan',
'coughlan:redhat.com' => 'Tom Coughlan',
'cph:zurich.ai.mit.edu' => 'Chris Hanson',
'cr:sap.com' => 'Christoph Rohland',
'craig:homerjay.homelinux.org' => 'Craig Wilkie',
'cramerj:intel.com' => 'Jeb J. Cramer',
'cruault:724.com' => 'Charles-Edouard Ruault',
'ctindel:cup.hp.com' => 'Chad N. Tindel',
'cubic:miee.ru' => 'Ruslan U. Zakirov',
'cw:f00f.org' => 'Chris Wedgwood',
'cwf:sgi.com' => 'Charles Fumuso',
'cyeoh:samba.org' => 'Christopher Yeoh',
'd.mueller:elsoft.ch' => 'David Müller',
'd3august:dtek.chalmers.se' => 'Björn Augustsson',
'da-x:gmx.net' => 'Dan Aloni',
'daisy:teetime.dynamic.austin.ibm.com' => 'Daisy Chang', # from shortlog
'dale.farnsworth:mvista.com' => 'Dale Farnsworth',
'dale:farnsworth.org' => 'Dale Farnsworth',
'dalecki:evision-ventures.com' => 'Martin Dalecki',
'dalecki:evision.ag' => 'Martin Dalecki',
'dan.zink:hp.com' => 'Dan Zink',
'dan:debian.org' => 'Daniel Jacobowitz',
'dana.lacoste:peregrine.com' => 'Dana Lacoste',
'danc:mvista.com' => 'Dan Cox', # some CREDITS patch found by google
'daniel.ritz:gmx.ch' => 'Daniel Ritz',
'daniel:osdl.org' => 'Daniel McNeil',
'dank:kegel.com' => 'Dan Kegel',
'dave:qix.net' => 'Dave Maietta',
'dave:thedillows.org' => 'David Dillow',
'davej:codemonkey.or' => 'Dave Jones',
'davej:codemonkey.org.u' => 'Dave Jones',
'davej:codemonkey.org.uk' => 'Dave Jones',
'davej:codmonkey.org.uk' => 'Dave Jones',
'davej:suse.de' => 'Dave Jones',
'davej:tetrachloride.(none)' => 'Dave Jones',
'davem:hera.kernel.org' => 'David S. Miller',
'davem:kernel.bkbits.net' => 'David S. Miller',
'davem:nuts.ninka.net' => 'David S. Miller',
'davem:pizda.ninka.net' => 'David S. Miller', # guessed
'davem:redhat.com' => 'David S. Miller',
'david-b:pacbell.com' => 'David Brownell',
'david-b:pacbell.net' => 'David Brownell',
'david-b:packbell.net' => 'David Brownell',
'david.nelson:pobox.com' => 'David Nelson',
'david:gibson.dropbear.id.au' => 'David Gibson',
'david_jeffery:adaptec.com' => 'David Jeffery',
'davidel:xmailserver.org' => 'Davide Libenzi',
'davidm:hpl.hp.com' => 'David Mosberger',
'davidm:napali.hpl.hp.com' => 'David Mosberger',
'davidm:tiger.hpl.hp.com' => 'David Mosberger',
'davidm:wailua.hpl.hp.com' => 'David Mosberger',
'davids:youknow.youwant.to' => 'David Schwartz', # google
'davidvh:cox.net' => 'David van Hoose',
'dbrownell:users.sourceforge.net' => 'David Brownell',
'ddstreet:ieee.org' => 'Dan Streetman',
'ddstreet:us.ibm.com' => 'Dan Streetman',
'dean:arctic.org' => 'Dean Gaudet',
'defouwj:purdue.edu' => 'Jeff DeFouw',
'dent:cosy.sbg.ac.at' => "Thomas 'Dent' Mirlacher",
'derek:ihtfp.com' => 'Derek Atkins',
'devel:brodo.de' => 'Dominik Brodowski',
'devik:cdi.cz' => 'Martin Devera',
'dgibson:samba.org' => 'David Gibson',
'dhinds:sonic.net' => 'David Hinds', # google
'dhollis:davehollis.com' => 'David T. Hollis',
'dhowells:cambridge.redhat.com' => 'David Howells',
'dhowells:redhat.com' => 'David Howells',
'dilinger:mp3revolution.net' => 'Andres Salomon',
'dipankar:in.ibm.com' => 'Dipankar Sarma',
'dirk.behme:com.rmk.(none)' => 'Dirk Behme',
'dirk.behme:de.bosch.com' => 'Dirk Behme',
'dirk.uffmann:nokia.com' => 'Dirk Uffmann',
'dkuhlen:fhm.edu' => 'Dominik Kuhlen',
'dledford:aladin.rdu.redhat.com' => 'Doug Ledford',
'dledford:dledford.theledfords.org' => 'Doug Ledford',
'dledford:flossy.devel.redhat.com' => 'Doug Ledford',
'dledford:redhat.com' => 'Doug Ledford',
'dlstevens:us.ibm.com' => 'David Stevens',
'dmccr:us.ibm.com' => 'Dave McCracken',
'dmo:osdl.org' => 'Dave Olien',
'dok:directfb.org' => 'Denis Oliver Kropp',
'dougg:torque.net' => 'Douglas Gilbert',
'drepper:redhat.com' => 'Ulrich Drepper',
'driver:huey.jpl.nasa.gov' => 'Bryan B. Whitehead', # google
'drow:false.org' => 'Daniel Jacobowitz',
'drow:nevyn.them.org' => 'Daniel Jacobowitz',
'dsaxena:mvista.com' => 'Deepak Saxena',
'dsteklof:us.ibm.com' => 'Daniel E. F. Stekloff',
'duncan.sands:math.u-psud.fr' => 'Duncan Sands',
'dwmw2:dwmw2.baythorne.internal' => 'David Woodhouse',
'dwmw2:infradead.org' => 'David Woodhouse',
'dwmw2:redhat.com' => 'David Woodhouse',
'dz:cs.unitn.it' => 'Massimo Dal Zotto',
'ebiederm:xmission.com' => 'Eric W. Biederman',
'ebrower:resilience.com' => 'Eric Brower',
'ebrower:usa.net' => 'Eric Brower',
'ecd:skynet.be' => 'Eddie C. Dost',
'eddie.williams:steeleye.com' => 'Eddie Williams',
'edv:macrolink.com' => 'Ed Vance',
'edward_peng:dlink.com.tw' => 'Edward Peng',
'efocht:ess.nec.de' => 'Erich Focht',
'ehabkost:conectiva.com.br' => 'Eduardo Pereira Habkost',
'eike-kernel:sf-tec.de' => 'Rolf Eike Beer', # sent by himself
'eike:bilbo.math.uni-mannheim.de' => 'Rolf Eike Beer',
'elenstev:com.rmk.(none)' => 'Steven Cole',
'elenstev:mesatop.com' => 'Steven Cole',
'eli.carter:com.rmk.(none)' => 'Eli Carter',
'eli.kupermann:intel.com' => 'Eli Kupermann',
'engebret:us.ibm.com' => 'Dave Engebretsen',
'eranian:frankl.hpl.hp.com' => 'Stéphane Eranian',
'eranian:hpl.hp.com' => 'Stéphane Eranian',
'eric.piel:bull.net' => 'Eric Piel',
'erik:aarg.net' => 'Erik Arneson',
'erik_habbinga:hp.com' => 'Erik Habbinga',
'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hüffner',
'faikuygur:ttnet.net.tr' => 'Faik Uygur',
'fbl:conectiva.com.br' => 'Flávio Bruno Leitner', # google
'fdavis:si.rr.com' => 'Frank Davis',
'felipewd:terra.com.br' => 'Felipe Damasio', # by self (did not ask to include the W.)
'fenghua.yu:intel.com' => 'Fenghua Yu', # google
'fero:sztalker.hu' => 'Bakonyi Ferenc',
'filip.sneppe:cronos.be' => 'Filip Sneppe',
'fischer:linux-buechse.de' => 'Jürgen E. Fischer',
'flavien:lebarbe.net' => 'Flavien Lebarbé',
'fletch:aracnet.com' => 'Martin J. Bligh',
'flo:rfc822.org' => 'Florian Lohoff',
'florian.thiel:gmx.net' => 'Florian Thiel', # from shortlog
'florin:iucha.net' => 'Florin Iucha',
'fnm:fusion.ukrsat.com' => 'Nick Fedchik',
'focht:ess.nec.de' => 'Erich Focht',
'fokkensr:fokkensr.vertis.nl' => 'Rolf Fokkens',
'franz.sirl-kernel:lauterbach.com' => 'Franz Sirl',
'franz.sirl:lauterbach.com' => 'Franz Sirl',
'frival:zk3.dec.com' => 'Peter Rival',
'fscked:netvisao.pt' => 'Paulo André',
'fubar:us.ibm.com' => 'Jay Vosburgh',
'fw:deneb.enyo.de' => 'Florian Weimer', # lbdb
'fzago:austin.rr.com' => 'Frank Zago', # google
'ganadist:nakyup.mizi.com' => 'Cha Young-Ho',
'gandalf:netfilter.org' => 'Martin Josefsson',
'gandalf:wlug.westbo.se' => 'Martin Josefsson',
'ganesh.venkatesan:intel.com' => 'Ganesh Venkatesan',
'ganesh:tuxtop.vxindia.veritas.com' => 'Ganesh Varadarajan',
'ganesh:veritas.com' => 'Ganesh Varadarajan',
'ganesh:vxindia.veritas.com' => 'Ganesh Varadarajan',
'garloff:suse.de' => 'Kurt Garloff',
'garyhade:us.ibm.com' => 'Gary Hade',
'gbarzini:virata.com' => 'Guido Barzini',
'geert:linux-m68k.org' => 'Geert Uytterhoeven',
'george:mvista.com' => 'George Anzinger',
'georgn:somanetworks.com' => 'Georg Nikodym',
'gerg:moreton.com.au' => 'Greg Ungerer',
'gerg:snapgear.com' => 'Greg Ungerer',
'ghoz:sympatico.ca' => 'Ghozlane Toumi',
'gibbs:overdrive.btc.adaptec.com' => 'Justin T. Gibbs',
'gibbs:scsiguy.com' => 'Justin T. Gibbs',
'gilbertd:treblig.org' => 'Dr. David Alan Gilbert',
'gj:pointblue.com.pl' => 'Grzegorz Jaskiewicz',
'gl:dsa-ac.de' => 'Guennadi Liakhovetski',
'glee:gnupilgrims.org' => 'Geoffrey Lee', # lbdb
'gnb:alphalink.com.au' => 'Greg Banks',
'go:turbolinux.co.jp' => 'Go Taniguchi',
'gone:us.ibm.com' => 'Patricia Gaughen',
'gotom:debian.or.jp' => 'Goto Masanori', # from shortlog
'gphat:cafes.net' => 'Cory Watson',
'greearb:candelatech.com' => 'Ben Greear',
'green:angband.namesys.com' => 'Oleg Drokin',
'green:linuxhacker.ru' => 'Oleg Drokin',
'green:namesys.com' => 'Oleg Drokin',
'greg:kroah.com' => 'Greg Kroah-Hartman',
'greg:soap.kroah.net' => 'Greg Kroah-Hartman',
'gregkh:kernel.bkbits.net' => 'Greg Kroah-Hartman',
'gronkin:nerdvana.com' => 'George Ronkin',
'grundler:cup.hp.com' => 'Grant Grundler',
'grundym:us.ibm.com' => 'Michael Grundy',
'gsromero:alumnos.euitt.upm.es' => 'Guillermo S. Romero',
'gtoumi:laposte.net' => 'Ghozlane Toumi',
'gwehrman:sgi.com' => 'Geoffrey Wehrman',
'hadi:cyberus.ca' => 'Jamal Hadi Salim',
'hannal:us.ibm.com' => 'Hanna V. Linder',
'harald:gnumonks.org' => 'Harald Welte',
'haveblue:us.ibm.com' => 'Dave Hansen',
'hawkes:oss.sgi.com' => 'John Hawkes',
'hch:caldera.de' => 'Christoph Hellwig',
'hch:com.rmk.(none)' => 'Christoph Hellwig',
'hch:de.rmk.(none)' => 'Christoph Hellwig',
'hch:dhcp212.munich.sgi.com' => 'Christoph Hellwig',
'hch:hera.kernel.org' => 'Christoph Hellwig',
'hch:infradead.org' => 'Christoph Hellwig',
'hch:lab343.munich.sgi.com' => 'Christoph Hellwig',
'hch:lst.de' => 'Christoph Hellwig',
'hch:pentafluge.infradead.org' => 'Christoph Hellwig',
'hch:sb.bsdonline.org' => 'Christoph Hellwig', # by Kristian Peters
'hch:sgi.com' => 'Christoph Hellwig',
'heiko.carstens:de.ibm.com' => 'Heiko Carstens',
'helgaas:fc.hp.com' => 'Bjorn Helgaas', # doesn't want ø/å
'henning:meier-geinitz.de' => 'Henning Meier-Geinitz',
'henrique2.gobbi:cyclades.com' => 'Henrique Gobbi',
'henrique:cyclades.com' => 'Henrique Gobbi',
'herbert:gondor.apana.org.au' => 'Herbert Xu',
'hermes:gibson.dropbear.id.au' => 'David Gibson',
'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
'hoho:binbash.net' => 'Colin Slater',
'hpa:transmeta.com' => 'H. Peter Anvin',
'hpa:zytor.com' => 'H. Peter Anvin',
'hugh:veritas.com' => 'Hugh Dickins',
'hunold:convergence.de' => 'Michael Hunold',
'hwahl:hwahl.de' => 'Hartmut Wahl',
'ica2_ts:csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
'info:usblcd.de' => 'Adams IT Services',
'ink:jurassic.park.msu.ru' => 'Ivan Kokshaysky',
'ink:ru.rmk.(none)' => 'Ivan Kokshaysky',
'ink:undisclosed.(none)' => 'Ivan Kokshaysky',
'ionut:badula.org' => 'Ion Badulescu',
'ionut:cs.columbia.edu' => 'Ion Badulescu',
'ioshadij:hotmail.com' => 'Ishan O. Jayawardena',
'irohlfs:irohlfs.de' => 'Ingo Rohlfs',
'ishikawa:linux.or.jp' => 'Mutsumi Ishikawa',
'ivangurdiev:linuxfreemail.com' => 'Ivan Gyurdiev',
'j-nomura:ce.jp.nec.com' => 'Junichi Nomura',
'j.dittmer:portrix.net' => 'Jan Dittmer',
'jack:suse.cz' => 'Jan Kara',
'jack_hammer:adaptec.com' => 'Jack Hammer',
'jackson:realtek.com.tw' => 'Ian Jackson',
'jaharkes:cs.cmu.edu' => 'Jan Harkes',
'jakob.kemi:telia.com' => 'Jakob Kemi',
'jakub:redhat.com' => 'Jakub Jelínek',
'jamagallon:able.es' => 'J. A. Magallon',
'james.bottomley:steeleye.com' => 'James Bottomley',
'james:cobaltmountain.com' => 'James Mayer',
'james:superbug.demon.co.uk' => 'James Courtier-Dutton',
'james_mcmechan:hotmail.com' => 'James McMechan',
'jamey.hicks:hp.com' => 'Jamey Hicks',
'jamey:crl.dec.com' => 'Jamey Hicks',
'jamie:shareable.org' => 'Jamie Lokier',
'jani:astechnix.ro' => 'Jani Monoses',
'jani:iv.ro' => 'Jani Monoses',
'javaman:katamail.com' => 'Paulo Ornati',
'jb:jblache.org' => 'Julien Blache',
'jbarnes:sgi.com' => 'Jesse Barnes',
'jbglaw:lug-owl.de' => 'Jan-Benedict Glaw',
'jblack:linuxguru.net' => 'James Blackwell',
'jbm:joshisanerd.com' => 'Josh Myer',
'jcdutton:users.sourceforge.net' => 'James Courtier-Dutton',
'jdavid:farfalle.com' => 'David Ruggiero',
'jdike:jdike.wstearns.org' => 'Jeff Dike',
'jdike:karaya.com' => 'Jeff Dike',
'jdike:uml.karaya.com' => 'Jeff Dike',
'jdr:farfalle.com' => 'David Ruggiero',
'jdthood:yahoo.co.uk' => 'Thomas Hood',
'jeb.j.cramer:intel.com' => 'Jeb J. Cramer',
'jef:linuxbe.org' => 'Jean-Francois Dive',
'jeff.wiedemeier:hp.com' => 'Jeff Wiedemeier',
'jeffs:accelent.com' => 'Jeff Sutherland', # lbdb
'jejb:malley.(none)' => 'James Bottomley',
'jejb:mulgrave.(none)' => 'James Bottomley', # from shortlog
'jejb:raven.il.steeleye.com' => 'James Bottomley',
'jenna.s.hall:intel.com' => 'Jenna S. Hall', # google
'jes:trained-monkey.org' => 'Jes Sorensen',
'jes:wildopensource.com' => 'Jes Sorensen',
'jgarzik:fokker2.devel.redhat.com' => 'Jeff Garzik',
'jgarzik:hum.(none)' => 'Jeff Garzik',
'jgarzik:mandrakesoft.com' => 'Jeff Garzik',
'jgarzik:pobox.com' => 'Jeff Garzik',
'jgarzik:redhat.com' => 'Jeff Garzik',
'jgarzik:rum.normnet.org' => 'Jeff Garzik',
'jgarzik:tout.normnet.org' => 'Jeff Garzik',
'jgmyers:netscape.com' => 'John Myers',
'jgrimm2:us.ibm.com' => 'Jon Grimm',
'jgrimm:death.austin.ibm.com' => 'Jon Grimm',
'jgrimm:jgrimm.(none)' => 'Jon Grimm',
'jgrimm:jgrimm.austin.ibm.com' => 'Jon Grimm', # google
'jgrimm:touki.austin.ibm.com' => 'Jon Grimm', # google
'jgrimm:touki.qip.austin.ibm.com' => 'Jon Grimm', # google
'jh:sgi.com' => 'John Hesterberg',
'jhammer:us.ibm.com' => 'Jack Hammer',
'jhartmann:addoes.com' => 'Jeff Hartmann',
'jim.houston:attbi.com' => 'Jim Houston',
'jkenisto:us.ibm.com' => 'James Keniston',
'jkt:helius.com' => 'Jack Thomasson',
'jmcmullan:linuxcare.com' => 'Jason McMullan',
'jmm:informatik.uni-bremen.de' => 'Moritz Mühlenhoff',
'jmorris:intercode.com.au' => 'James Morris',
'jmorros:intercode.com.au' => 'James Morris',	# it's typo IMHO
'jo-lkml:suckfuell.net' => 'Jochen Suckfuell',
'jochen:jochen.org' => 'Jochen Hein',
'jochen:scram.de' => 'Jochen Friedrich',
'joe:fib011235813.fsnet.co.uk' => 'Joe Thornber',
'joe:perches.com' => 'Joe Perches',
'joe:wavicle.org' => 'Joe Burks',
'joel.buckley:sun.com' => 'Joel Buckley',
'joergprante:netcologne.de' => 'Jörg Prante',
'johan.adolfsson:axis.com' => 'Johan Adolfsson',
'johann.deneux:it.uu.se' => 'Johann Deneux',
'johann.deneux:laposte.net' => 'Johann Deneux',
'johannes:erdfelt.com' => 'Johannes Erdfelt',
'john:deater.net' => 'John Clemens',
'john:grabjohn.com' => 'John Bradford',
'john:larvalstage.com' => 'John Kim',
'johnf:whitsunday.net.au' => 'John W. Fort',
'johnpol:2ka.mipt.ru' => 'Evgeniy Polyakov',
'johnstul:us.ibm.com' => 'John Stultz',
'josh:joshisanerd.com' => 'Josh Myer',
'jsiemes:web.de' => 'Josef Siemes',
'jsimmons:heisenberg.transvirtual.com' => 'James Simmons',
'jsimmons:infradead.org' => 'James Simmons',
'jsimmons:kozmo.(none)' => 'James Simmons',
'jsimmons:maxwell.earthlink.net' => 'James Simmons',
'jsimmons:transvirtual.com' => 'James Simmons',
'jsm:udlkern.fc.hp.com' => 'John Marvin',
'jsun:mvista.com' => 'Jun Sun',
'jt:bougret.hpl.hp.com' => 'Jean Tourrilhes',
'jt:hpl.hp.com' => 'Jean Tourrilhes',
'jtyner:cs.ucr.edu' => 'John Tyner',
'jun.nakajima:intel.com' => 'Jun Nakajima',
'jung-ik.lee:intel.com' => 'Jung-Ik Lee',
'jwoithe:physics.adelaide.edu.au' => 'Jonathan Woithe',
'k-suganuma:mvj.biglobe.ne.jp' => 'Kimio Suganuma',
'k.kasprzak:box43.pl' => 'Karol Kasprzak', # by Kristian Peters
'kaber:trash.net' => 'Patrick McHardy',
'kadlec:blackhole.kfki.hu' => 'Jozsef Kadlecsik',
'kai-germaschewski:uiowa.edu' => 'Kai Germaschewski',
'kai.makisara:kolumbus.fi' => 'Kai Makisara',
'kai.reichert:udo.edu' => 'Kai Reichert',
'kai:chaos.tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
'kai:tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
'kai:vaio.(none)' => 'Kai Germaschewski',
'kai:zephyr.physics.uiowa.edu' => 'Kai Germaschewski',
'kala:pinerecords.com' => 'Tomas Szepe',
'kanoj:vger.kernel.org' => 'Kanoj Sarcar', # sent by Arnaldo Carvalho de Melo
'kanojsarcar:yahoo.com' => 'Kanoj Sarcar',
'kaos:ocs.com.au' => 'Keith Owens',
'kaos:sgi.com' => 'Keith Owens', # sent by himself
'kare.sars:lmf.ericsson.se' => 'Kåre Särs',
'kasperd:daimi.au.dk' => 'Kasper Dupont',
'kaz:earth.email.ne.jp' => 'Kazuto Miyoshi',
'kazunori:miyazawa.org' => 'Kazunori Miyazawa',
'keithu:parl.clemson.edu' => 'Keith Underwood',
'kenneth.w.chen:intel.com' => 'Kenneth W. Chen',
'kernel:jsl.com' => 'Jeffrey S. Laing',
'kernel:steeleye.com' => 'Paul Clements',
'kettenis:gnu.org' => 'Mark Kettenis',
'key:austin.ibm.com' => 'Kent Yoder',
'khaho:koti.soon.fi' => 'Ari Juhani Hämeenaho',
'khalid:fc.hp.com' => 'Khalid Aziz',
'khalid_aziz:hp.com' => 'Khalid Aziz',
'khc:pm.waw.pl' => 'Krzysztof Halasa',
'kiran:in.ibm.com' => 'Ravikiran G. Thirumalai',
'kisza:sch.bme.hu' => 'Andras Kis-Szabo', # google (netfilter-ext HOWTO)
'kkeil:isdn4linux.de' => 'Karsten Keil',
'kkeil:suse.de' => 'Karsten Keil',
'kmsmith:umich.edu' => 'Kendrick M. Smith',
'knan:mo.himolde.no' => 'Erik Inge Bolsø',
'kochi:hpc.bs1.fc.nec.co.jp' => 'Kochi Takayoshi',
'komujun:nifty.com' => 'Jun Komuro', # google
'kraxel:bytesex.org' => 'Gerd Knorr',
'kraxel:suse.de' => 'Gerd Knorr',
'krkumar:us.ibm.com' => 'Krishna Kumar',
'kronos:kronoz.cjb.net' => 'Luca Tettamanti',
'kuba:mareimbrium.org' => 'Kuba Ober',
'kuebelr:email.uc.edu' => 'Robert Kuebel',
'kumarkr:us.ibm.com' => 'Krishna Kumar',
'kunihiro:ipinfusion.com' => 'Kunihiro Ishiguro',
'kuznet:mops.inr.ac.ru' => 'Alexey Kuznetsov',
'kuznet:ms2.inr.ac.ru' => 'Alexey Kuznetsov',
'l.s.r:web.de' => 'René Scharfe',
'ladis:psi.cz' => 'Ladislav Michl',
'laforge:gnumonks.org' => 'Harald Welte',
'laforge:netfilter.org' => 'Harald Welte',
'latten:austin.ibm.com' => 'Joy Latten',
'laurent:latil.nom.fr' => 'Laurent Latil',
'lawrence:the-penguin.otak.com' => 'Lawrence Walton',
'ldb:ldb.ods.org' => 'Luca Barbieri',
'ldm:flatcap.org' => 'Richard Russon',
'lee:compucrew.com' => 'Lee Nash', # lbdb
'legoll:free.fr' => 'Vincent Legoll', # correction sent by himself
'leigh:solinno.co.uk' => 'Leigh Brown', # lbdb
'lethal:linux-sh.org' => 'Paul Mundt',
'levon:movementarian.org' => 'John Levon',
'lfo:polyad.org' => 'Luis F. Ortiz',
'linux:brodo.de' => 'Dominik Brodowski',
'linux:de.rmk.(none)' => 'Dominik Brodowski',
'linux:hazard.jcu.cz' => 'Jan Marek',
'linux-usb:gemeinhardt.info' => 'Lars Gemeinhardt',
'lionel.bouton:inet6.fr' => 'Lionel Bouton',
'lists:mdiehl.de' => 'Martin Diehl',
'liyang:nerv.cx' => 'Liyang Hu',
'lkml:shemesh.biz' => 'Shachar Shemesh',
'lkml001:vrfy.org' => 'Kay Sievers',
'lm:bitmover.com' => 'Larry McVoy',
'lm:work.bitmover.com' => 'Larry McVoy',
'lopezp:grupocp.es' => 'Jose A. Lopez',
'lord:sgi.com' => 'Stephen Lord',
'louis.zhuang:linux.co.intel.com' => 'Louis Zhuang',
'louisk:cse.unsw.edu.au' => 'Louis Yu-Kiu Kwan',
'lowekamp:cs.wm.edu' => 'Bruce B. Lowekamp', # lbdb
'luben:splentec.com' => 'Luben Tuikov',
'luc.vanoostenryck:easynet.be' => 'Luc Van Oostenryck', # lbdb
'lucasvr:terra.com.br' => 'Lucas Correia Villa Real', # google
'lunz:falooley.org' => 'Jason Lunz',
'm.c.p:wolk-project.de' => 'Marc-Christian Petersen',
'maalanen:ra.abo.fi' => 'Marcus Alanen',
'mac:melware.de' => 'Armin Schindler',
'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
'makisara:abies.metla.fi' => 'Kai Makisara',
'manand:us.ibm.com' => 'Mala Anand',
'maneesh:in.ibm.com' => 'Maneesh Soni',
'manfred:colorfullife.com' => 'Manfred Spraul',
'manik:cisco.com' => 'Manik Raina',
'manish:zambeel.com' => 'Manish Lachwani',
'mannthey:us.ibm.com' => 'Keith Mannthey',
'marc:mbsi.ca' => 'Marc Boucher',
'marcel:holtmann.org' => 'Marcel Holtmann', # sent by himself
'marcelo:conectiva.com.br' => 'Marcelo Tosatti',
'marcelo:freak.distro.conectiva' => 'Marcelo Tosatti', # guessed
'marcelo:plucky.distro.conectiva' => 'Marcelo Tosatti',
'marcus:ingate.com' => 'Marcus Sundberg',
'marekm:amelek.gda.pl' => 'Marek Michalkiewicz',
'marijnk:gmx.co.uk' => 'Marijn Kruisselbrink',
'marius:citi.umich.edu' => 'Marius Aamodt Eriksen',
'mark:alpha.dyndns.org' => 'Mark W. McClelland',
'mark:hal9000.dyndns.org' => 'Mark W. McClelland',
'markh:osdl.org' => 'Mark Haverkamp',
'martin.bligh:us.ibm.com' => 'Martin J. Bligh',
'martin.schwidefsky:debitel.net' => 'Martin Schwidefsky',
'martin:bruli.net' => 'Martin Brulisauer',
'martin:mdiehl.de' => 'Martin Diehl',
'martin:meltin.net' => 'Martin Schwenke',
'mashirle:us.ibm.com' => 'Shirley Ma',
'mason:suse.com' => 'Chris Mason',
'matt_domsch:dell.com' => 'Matt Domsch', # sent by himself
'matthew:wil.cx' => 'Matthew Wilcox',
'matthias.andree:gmx.de' => 'Matthias Andree', # added by himself
'mauelshagen:sistina.com' => 'Heinz J. Mauelshagen',
'maxk:qualcomm.com' => 'Maksim Krasnyanskiy',
'maxk:viper.(none)' => 'Maksim Krasnyanskiy', # from shortlog
'maxk:viper.qualcomm.com' => 'Maksim Krasnyanskiy',
'mb:ozaba.mine.nu' => 'Magnus Boden',
'mbligh:aracnet.com' => 'Martin J. Bligh',
'mcp:linux-systeme.de' => 'Marc-Christian Petersen',
'mdharm-scsi:one-eyed-alien.net' => 'Matthew Dharm',
'mdharm-usb:one-eyed-alien.net' => 'Matthew Dharm',
'mdharm:one-eyed-alien.net' => 'Matthew Dharm',
'mdiehl:mdiehl.de' => 'Martin Diehl',
'mec:shout.net' => 'Michael Elizabeth Chastain',
'meissner:suse.de' => 'Marcus Meissner',
'mgreer:mvista.com' => 'Mark A. Greer', # lbdb
'mhoffman:lightlink.com' => 'Mark M. Hoffman',
'mhopf:innominate.com' => 'Mark-André Hopf',
'michaelw:foldr.org' => 'Michael Weber', # google
'michal:harddata.com' => 'Michal Jaegermann',
'mikael.starvik:axis.com' => 'Mikael Starvik',
'mikal:stillhq.com' => 'Michael Still',
'mike:aiinc.ca' => 'Michael Hayes',
'mikenc:us.ibm.com' => 'Mike Christie',
'mikep:linuxtr.net' => 'Mike Phillips',
'mikpe:csd.uu.se' => 'Mikael Pettersson',
'mikpe:user.it.uu.se' => 'Mikael Pettersson',
'mikulas:artax.karlin.mff.cuni.cz' => 'Mikulas Patocka',
'miles:lsi.nec.co.jp' => 'Miles Bader',
'miles:megapathdsl.net' => 'Miles Lane',
'milli:acmeps.com' => 'Michael Milligan',
'miltonm:bga.com' => 'Milton Miller', # by Kristian Peters
'mingo:earth2.(none)' => 'Ingo Molnar',
'mingo:elte.hu' => 'Ingo Molnar',
'mingo:redhat.com' => 'Ingo Molnar',
'minyard:acm.org' => 'Corey Minyard',
'mitch:sfgoth.com' => 'Mitchell Blank Jr.',
'miyazawa:linux-ipv6.org' => 'Kazunori Miyazawa',
'mj:ucw.cz' => 'Martin Mares',
'mk:linux-ipv6.org' => 'Mitsuru Kanda',
'mkp:mkp.net' => 'Martin K. Petersen', # lbdb
'mlang:delysid.org' => 'Mario Lang', # google
'mlindner:syskonnect.de' => 'Mirko Lindner',
'mlocke:mvista.com' => 'Montavista Software, Inc.',
'mmcclell:bigfoot.com' => 'Mark McClelland',
'mochel:geena.pdx.osdl.net' => 'Patrick Mochel',
'mochel:osdl.org' => 'Patrick Mochel',
'mochel:segfault.osdl.org' => 'Patrick Mochel',
'mochel:segfault.osdlab.org' => 'Patrick Mochel',
'mort:wildopensource.com' => 'Martin Hicks',
'mostrows:speakeasy.net' => 'Michal Ostrowski',
'mostrows:watson.ibm.com' => 'Michal Ostrowski',
'mporter:cox.net' => 'Matt Porter',
'mrr:nexthop.com' => 'Mathew Richardson',
'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
'msw:redhat.com' => 'Matt Wilson',
'mufasa:sis.com.tw' => 'Mufasa Yang', # sent by himself
'muizelaar:rogers.com' => 'Jeff Muizelaar',
'mulix:actcom.co.il' => 'Muli Ben-Yehuda', # sent by himself
'mulix:mulix.org' => 'Muli Ben-Yehuda',
'mw:microdata-pos.de' => 'Michael Westermann',
'mzyngier:freesurf.fr' => 'Marc Zyngier',
'n0ano:n0ano.com' => 'Don Dugger',
'nahshon:actcom.co.il' => 'Itai Nahshon',
'nathans:sgi.com' => 'Nathan Scott',
'neilb:cse.unsw.edu.au' => 'Neil Brown',
'neilt:slimy.greenend.org.uk' => 'Neil Turton',
'nemosoft:smcc.demon.nl' => 'Nemosoft Unv.',
'netfilter:interlinx.bc.ca' => 'Brian J. Murrell',
'nick.holloway:pyrites.org.uk' => 'Nick Holloway',
'nico:cam.org' => 'Nicolas Pitre',
'nico:org.rmk.(none)' => 'Nicolas Pitre',
'nicolas.aspert:epfl.ch' => 'Nicolas Aspert',
'nicolas:dupeux.net' => 'Nicolas Dupeux',
'nicolas.mailhot:laposte.net' => 'Nicolas Mailhot',
'niv:us.ibm.com' => 'Nivedita Singhvi',
'nivedita:w-nivedita.beaverton.ibm.com' => 'Nivedita Singhvi',
'nkbj:image.dk' => 'Niels Kristian Bech Jensen',
'nlaredo:transmeta.com' => 'Nathan Laredo',
'nmiell:attbi.com' => 'Nicholas Miell',
'nobita:t-online.de' => 'Andreas Busch',
'nstraz:sgi.com' => 'Nathan Straz',
'okir:suse.de' => 'Olaf Kirch', # lbdb
'okurth:gmx.net' => 'Oliver Kurth',
'olaf.dietsche#list.linux-kernel:t-online.de' => 'Olaf Dietsche',
'olaf.dietsche' => 'Olaf Dietsche',
'oleg:tv-sign.ru' => 'Oleg Nesterov',
'olh:suse.de' => 'Olaf Hering',
'oliendm:us.ibm.com' => 'Dave Olien',
'oliver.neukum:lrz.uni-muenchen.de' => 'Oliver Neukum',
'oliver.spang:siemens.com' => 'Oliver Spang',
'oliver:neukum.name' => 'Oliver Neukum',
'oliver:neukum.org' => 'Oliver Neukum',
'oliver:oenone.homelinux.org' => 'Oliver Neukum',
'oliver:vermuden.neukum.org' => 'Oliver Neukum',
'olof:austin.ibm.com' => 'Olof Johansson',
'orjan.friberg:axis.com' => 'Orjan Friberg',
'os:emlix.com' => 'Oskar Schirmer', # sent by himself
'osst:riede.org' => 'Willem Riede',
'otaylor:redhat.com' => 'Owen Taylor',
'overby:sgi.com' => 'Glen Overby',
'p.guehring:futureware.at' => 'Philipp Gühring',
'p2:ace.ulyssis.sutdent.kuleuven.ac.be' => 'Peter De Shrijver',
'p_gortmaker:yahoo.com' => 'Paul Gortmaker',
'pablo:menichini.com.ar' => 'Pablo Menichini',
'pam.delaney:lsil.com' => 'Pamela Delaney',
'paschal:rcsis.com' => 'David Paschal',
'pasky:ucw.cz' => 'Petr Baudis',
'patmans:us.ibm.com' => 'Patrick Mansfield',
'paubert:iram.es' => 'Gabriel Paubert',
'paul.mundt:timesys.com' => 'Paul Mundt', # google
'paulkf:microgate.com' => 'Paul Fulghum',
'paulm:routefree.com' => 'Paul Mielke',
'paulus:au1.ibm.com' => 'Paul Mackerras',
'paulus:cargo.(none)' => 'Paul Mackerras',
'paulus:nanango.paulus.ozlabs.org' => 'Paul Mackerras',
'paulus:quango.ozlabs.ibm.com' => 'Paul Mackerras',
'paulus:samba.org' => 'Paul Mackerras',
'paulus:tango.paulus.ozlabs.org' => 'Paul Mackerras',
'pavel:janik.cz' => 'Pavel Janík',
'pavel:suse.cz' => 'Pavel Machek',
'pavel:ucw.cz' => 'Pavel Machek',
'pazke:orbita1.ru' => 'Andrey Panin',
'pbadari:us.ibm.com' => 'Badari Pulavarty',
'pdelaney:lsil.com' => 'Pam Delaney',
'pe1rxq:amsat.org' => 'Jeroen Vreeken',
'pekon:informatics.muni.cz' => 'Petr Konecny',
'per.winkvist:telia.com' => 'Per Winkvist',
'perex:perex.cz' => 'Jaroslav Kysela',
'perex:pnote.perex-int.cz' => 'Jaroslav Kysela',
'perex:suse.cz' => 'Jaroslav Kysela',
'peter:bergner.org' => 'Peter Bergner',
'peter:cadcamlab.org' => 'Peter Samuelson',
'peter:chubb.wattle.id.au' => 'Peter Chubb',
'peterc:gelato.unsw.edu.au' => 'Peter Chubb',
'petero2:telia.com' => 'Peter Osterlund',
'petkan:mastika.' => 'Petko Manolov',
'petkan:mastika.dce.bg' => 'Petko Manolov',
'petkan:mastika.lnxw.com' => 'Petko Manolov',
'petkan:rakia.dce.bg' => 'Petko Manolov',
'petkan:rakia.hell.org' => 'Petko Manolov',
'petkan:tequila.dce.bg' => 'Petko Manolov',
'petkan:users.sourceforge.net' => 'Petko Manolov',
'petr:vandrovec.name' => 'Petr Vandrovec',
'petri.koistinen:iki.fi' => 'Petri Koistinen',
'petrides:redhat.com' => 'Ernie Petrides',
'philipp:void.at' => 'Philipp Friedrich',
'phillim2:comcast.net' => 'Mike Phillips',
'pkot:linuxnews.pl' => 'Pawel Kot',
'pkot:ziew.org' => 'Pawel Kot',
'plars:austin.ibm.com' => 'Paul Larson',
'plars:linuxtestproject.org' => 'Paul Larson',
'plcl:telefonica.net' => 'Pedro Lopez-Cabanillas',
'pmanolov:lnxw.com' => 'Petko Manolov',
'pmenage:ensim.com' => 'Paul Menage',
'porter:cox.net' => 'Matt Porter',
'ppc64:brule.rchland.ibm.com' => 'Peter Bergner',
'prom:berlin.ccc.de' => 'Ingo Albrecht',
'proski:gnu.org' => 'Pavel Roskin',
'proski:org.rmk.(none)' => 'Pavel Roskin',
'pwaechtler:mac.com' => 'Peter Wächtler',
'quinlan:transmeta.com' => 'Daniel Quinlan',
'quintela:mandrakesoft.com' => 'Juan Quintela',
'r.a.mercer:blueyonder.co.uk' => 'Adam Mercer',
'r.e.wolff:bitwizard.nl' => 'Rogier Wolff', # lbdbq
'ralf:dea.linux-mips.net' => 'Ralf Bächle',
'ralf:linux-mips.org' => 'Ralf Bächle',
'ralphs:org.rmk.(none)' => 'Ralph Siemsen',
'ramune:net-ronin.org' => 'Daniel A. Nobuto',
'randolph:tausq.org' => 'Randolph Chung',
'randy.dunlap:verizon.net' => 'Randy Dunlap',
'raul:pleyades.net' => 'Raul Nunez de Arenas Coronado',
'ray-lk:madrabbit.org' => 'Ray Lee',
'rbh00:utsglobal.com' => 'Richard Hitt', # asked him, he prefers Richard
'rbt:mtlb.co.uk' => 'Robert Cardell',
'rct:gherkin.frus.com' => 'Bob Tracy',
'rddunlap:osdl.org' => 'Randy Dunlap',
'reality:delusion.de' => 'Udo A. Steinberg',
'reeja.john:amd.com' => 'Reeja John',
'reiser:namesys.com' => 'Hans Reiser',
'rem:osdl.org' => 'Bob Miller',
'rgcrettol@datacomm.ch' => 'Roger Crettol',
'rgooch:atnf.csiro.au' => 'Richard Gooch',
'rgooch:ras.ucalgary.ca' => 'Richard Gooch',
'rgs:linalco.com' => 'Roberto Gordo Saez',
'rhirst:linuxcare.com' => 'Richard Hirst',
'rhw:infradead.org' => 'Riley Williams',
'richard.brunner:amd.com' => 'Richard Brunner',
'riel:conectiva.com.br' => 'Rik van Riel',
'riel:imladris.surriel.com' => 'Rik van Riel',
'riel:redhat.com' => 'Rik van Riel',
'riel:surriel.com' => 'Rik van Riel',
'rjweryk:uwo.ca' => 'Rob Weryk',
'rl:hellgate.ch' => 'Roger Luethi',
'rlievin:free.fr' => 'Romain Lievin',
'rmk:arm.linux.org.uk' => 'Russell King',
'rmk:flint.arm.linux.org.uk' => 'Russell King',
'rml:tech9.net' => 'Robert Love',
'rob:osinvestor.com' => 'Rob Radez',
'robert.olsson:data.slu.se' => 'Robert Olsson',
'roehrich:sgi.com' => 'Dean Roehrich',
'rohit.seth:intel.com' => 'Seth Rohit',
'rol:as2917.net' => 'Paul Rolland',
'roland:frob.com' => 'Roland McGrath',
'roland:redhat.com' => 'Roland McGrath',
'roland:topspin.com' => 'Roland Dreier',
'romain.lievin:esisar.inpg.fr' => 'Romain Lievin',
'romain.lievin:wanadoo.fr' => 'Romain Lievin',
'romieu:cogenit.fr' => 'François Romieu',
'romieu:fr.zoreil.com' => 'François Romieu',
'root:viper.(none)' => 'Maxim Krasnyansky',
'rread:clusterfs.com' => 'Robert Read',
'rscott:attbi.com' => 'Rob Scott',
'rth:are.twiddle.net' => 'Richard Henderson',
'rth:dorothy.sfbay.redhat.com' => 'Richard Henderson',
'rth:dot.sfbay.redhat.com' => 'Richard Henderson',
'rth:eeyore.twiddle.net' => 'Richard Henderson',
'rth:fidel.sfbay.redhat.com' => 'Richard Henderson',
'rth:kanga.twiddle.net' => 'Richard Henderson',
'rth:splat.sfbay.redhat.com' => 'Richard Henderson',
'rth:tigger.twiddle.net' => 'Richard Henderson',
'rth:twiddle.net' => 'Richard Henderson',
'rth:vsop.sfbay.redhat.com' => 'Richard Henderson',
'rui.sousa:laposte.net' => 'Rui Sousa',
'rusty:linux.co.intel.com' => 'Rusty Lynch',
'rusty:rustcorp.com.au' => 'Rusty Russell',
'rvinson:mvista.com' => 'Randy Vinson',
'rwhron:earthlink.net' => 'Randy Hron',
'rz:linux-m68k.org' => 'Richard Zidlicky',
's.doyon:videotron.ca' => 'Stéphane Doyon',
'sabala:students.uiuc.edu' => 'Michal Sabala', # google
'sailer:scs.ch' => 'Thomas Sailer',
'sam:mars.ravnborg.org' => 'Sam Ravnborg',
'sam:ravnborg.org' => 'Sam Ravnborg',
'samel:mail.cz' => 'Vitezslav Samel',
'samuel.thibault:ens-lyon.fr' => 'Samuel Thibault',
'sandeen:sgi.com' => 'Eric Sandeen',
'santiago:newphoenix.net' => 'Santiago A. Nullo', # sent by self
'sarolaht:cs.helsinki.fi' => 'Pasi Sarolahti',
'sawa:yamamoto.gr.jp' => 'sawa',
'scameron:quandary.cca.cpqcorp.net' => 'Steve Cameron',
'schlicht:uni-mannheim.de' => 'Thomas Schlichter',
'schlicht:uni-mannheimn.de' => 'Thomas Schlichter',	# it's typo IMHO
'shmulik.hen:intel.com' => 'Shmulik Hen',
'schoenfr:gaaertner.de' => 'Erik Schoenfelder',
'schwab:suse.de' => 'Andreas Schwab',
'schwidefsky:de.ibm.com' => 'Martin Schwidefsky',
'scott.feldman:intel.com' => 'Scott Feldman',
'scott_anderson:mvista.com' => 'Scott Anderson',
'scottm:somanetworks.com' => 'Scott Murray',
'sct:redhat.com' => 'Stephen C. Tweedie',
'sds:epoch.ncsc.mil' => 'Stephen D. Smalley',
'sds:tislabs.com' => 'Stephen D. Smalley',
'sebastian.droege:gmx.de' => 'Sebastian Dröge',
'sfbest:us.ibm.com' => 'Steve Best',
'sfr:canb.auug.org.au' => 'Stephen Rothwell',
'shaggy:austin.ibm.com' => 'Dave Kleikamp',
'shaggy:kleikamp.austin.ibm.com' => 'Dave Kleikamp',
'shaggy:shaggy.austin.ibm.com' => 'Dave Kleikamp', # lbdb
'shemminger:osdl.org' => 'Stephen Hemminger',
'shields:msrl.com' => 'Michael Shields',
'shingchuang:via.com.tw' => 'Shing Chuang',
'silicon:falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
'simonb:lipsyncpost.co.uk' => 'Simon Burley',
'skip.ford:verizon.net' => 'Skip Ford',
'skyrelighten:yahoo.co.kr' => 'Donggyoo Lee',
'sl:lineo.com' => 'Stuart Lynne',
'smb:smbnet.de' => 'Stefan M. Brandl',
'smurf:osdl.org' => 'Nathan Dabney',
'snailtalk:linux-mandrake.com' => 'Geoffrey Lee', # by himself
'solar:openwall.com' => 'Solar Designer',
'soruk:eridani.co.uk' => 'Michael McConnell',
'sparker:sun.com' => 'Steven Parker', # by Duncan Laurie
'sprite:sprite.fr.eu.org' => 'Jeremie Koenig',
'spse:secret.org.uk' => 'Simon Evans', # by Kristian Peters
'spyro:com.rmk.(none)' => 'Ian Molton',
'src:flint.arm.linux.org.uk' => 'Russell King',
'sri:us.ibm.com' => 'Sridhar Samudrala',
'sridhar:dyn9-47-18-140.beaverton.ibm.com' => 'Sridhar Samudrala',
'sridhar:dyn9-47-18-86.beaverton.ibm.com' => 'Sridhar Samudrala',
'sridhar:x1-6-00-10-a4-8b-06-f6.attbi.com' => 'Sridhar Samudrala',
'srompf:isg.de' => 'Stefan Rompf',
'stanley.wang:linux.co.intel.com' => 'Stanley Wang',
'stefan.eletzhofer:eletztrick.de' => 'Stefan Eletzhofer',
'steiner:sgi.com' => 'Jack Steiner',
'stekloff:w-stekloff.beaverton.ibm.com' => 'Daniel Stekloff',
'stelian.pop:fr.alcove.com' => 'Stelian Pop',
'stelian:popies.net' => 'Stelian Pop',
'stern:rowland.harvard.edu' => 'Alan Stern',
'stern:rowland.org' => 'Alan Stern', # lbdb
'steve.cameron:hp.com' => 'Stephen Cameron',
'steve:chygwyn.com' => 'Steven Whitehouse',
'steve:gw.chygwyn.com' => 'Steven Whitehouse',
'steve:kbuxd.necst.nec.co.jp' => 'Steve Baur',
'stevef:smfhome1.austin.rr.com' => 'Steve French',
'stevef:steveft21.austin.ibm.com' => 'Steve French',
'stevef:steveft21.ltcsamba' => 'Steve French',
'stewart:inverse.wetlogic.net' => 'Paul Stewart',
'stewart:wetlogic.net' => 'Paul Stewart',
'stuartm:connecttech.com' => 'Stuart MacDonald',
'sullivan:austin.ibm.com' => 'Mike Sullivan',
'suncobalt.adm:hostme.bitkeeper.com' => 'Tim Hockin', # by Duncan Laurie
'sunil.saxena:intel.com' => 'Sunil Saxena',
'suresh.b.siddha:intel.com' => 'Suresh B. Siddha',
'sv:sw.com.sg' => 'Vladimir Simonov',
'swanson:uklinux.net' => 'Alan Swanson',
'swiergot:intersec.pl' => 'Jaroslaw Swierczynski',
'szepe:pinerecords.com' => 'Tomas Szepe',
't-kouchi:mvf.biglobe.ne.jp' => 'Takayoshi Kouchi',
'tai:imasy.or.jp' => 'Taisuke Yamada',
'taka:valinux.co.jp' => 'Hirokazu Takahashi',
'tao:acc.umu.se' => 'David Weinehall', # by himself
'tao:kernel.org' => 'David Weinehall', # by himself
'tapio:iptime.fi' => 'Tapio Laxström',
'tausq:debian.org' => 'Randolph Chung',
'tcallawa:redhat.com' => "Tom 'spot' Callaway",
'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
'th122948:scl1.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
'th122948:scl3.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
'thiel:ksan.de' => 'Florian Thiel', # lbdb
'thockin:freakshow.cobalt.com' => 'Tim Hockin',
'thockin:sun.com' => 'Tim Hockin',
'thomas:bender.thinknerd.de' => 'Thomas Walpuski',
'thunder:ngforever.de' => 'Thunder From The Hill',
'tigran:aivazian.name' => 'Tigran Aivazian',
'tim:physik3.uni-rostock.de' => 'Tim Schmielau',
'timw:splhi.com' => 'Tim Wright',
'tinglett:vnet.ibm.com' => 'Todd Inglett',
'tiwai:suse.de' => 'Takashi Iwai',
'tmcreynolds:nvidia.com' => 'Tom McReynolds',
'tmolina:cox.net' => 'Thomas Molina',
'tomita:cinet.co.jp' => 'Osamu Tomita',
'toml:us.ibm.com' => 'Tom Lendacky',
'tomlins:cam.org' => 'Ed Tomlinson',
'tony.luck:intel.com' => 'Tony Luck',
'tony:cantech.net.au' => 'Anthony J. Breeds-Taurima',
'torben.mathiasen:hp.com' => 'Torben Mathiasen',
'torvalds:linux.local' => 'Linus Torvalds',
'trevor.pering:intel.com' => 'Trevor Pering',
'trini:bill-the-cat.bloom.county' => 'Tom Rini',
'trini:kernel.crashing.org' => 'Tom Rini',
'trini:opus.bloom.county' => 'Tom Rini',
'trond.myklebust:fys.uio.no' => 'Trond Myklebust',
'tvignaud:mandrakesoft.com' => 'Thierry Vignaud',
'tvrtko:net4u.hr' => 'Tvrtko A. Ursulin',
'twaugh:redhat.com' => 'Tim Waugh',
'tytso:mit.edu' => "Theodore Y. T'so", # web.mit.edu/tytso/www/home.html
'tytso:snap.thunk.org' => "Theodore Y. T'so",
'tytso:think.thunk.org' => "Theodore Y. T'so", # guessed
'urban:teststation.com' => 'Urban Widmark',
'uzi:uzix.org' => 'Joshua Uziel',
'valdis.kletnieks:vt.edu' => 'Valdis Kletnieks',
'valko:linux.karinthy.hu' => 'Laszlo Valko',
'vandrove:vc.cvut.cz' => 'Petr Vandrovec',
'vanl:megsinet.net' => 'Martin H. VanLeeuwen',
'varenet:parisc-linux.org' => 'Thibaut Varene',
'vberon:mecano.gme.usherb.ca' => 'Vincent Béron',
'venkatesh.pallipadi:intel.com' => 'Venkatesh Pallipadi',
'vinay-rc:naturesoft.net' => 'Vinay K. Nallamothu',
'viro:math.psu.edu' => 'Alexander Viro',
'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
'viro:www.linux.org.uk' => 'Alexander Viro',
'vojta:math.berkeley.edu' => 'Paul Vojta',
'vojtech:suse.cz' => 'Vojtech Pavlik',
'vojtech:twilight.ucw.cz' => 'Vojtech Pavlik',
'vojtech:ucw.cz' => 'Vojtech Pavlik', # added by himself
'vs:tribesman.namesys.com' => 'Vladimir Saveliev',
'wa:almesberger.net' => 'Werner Almesberger',
'wahrenbruch:kobil.de' => 'Thomas Wahrenbruch',
'walter.harms:informatik.uni-oldenburg.de' => 'Walter Harms',
'warlord:mit.edu' => 'Derek Atkins',
'warp:mercury.d2dc.net' => 'Zephaniah E. Hull',
'wayne:stallion.oz.au' => 'Wayne Piekarski',
'wd:denx.de' => 'Wolfgang Denk',
'weigand:immd1.informatik.uni-erlangen.de' => 'Ulrich Weigand',
'wes:infosink.com' => 'Wes Schreiner',
'wesolows:foobazco.org' => 'Keith M. Wesolowski',
'wg:malloc.de' => 'Wolfram Gloger', # lbdb
'whitney:math.berkeley.edu' => 'Wayne Whitney',
'whydoubt:yahoo.com' => 'Jeff Smith',
'will:sowerbutts.com' => 'William R. Sowerbutts',
'willschm:us.ibm.com' => 'Will Schmidt',
'willy:debian.org' => 'Matthew Wilcox',
'willy:fc.hp.com' => 'Matthew Wilcox',
'willy:w.ods.org' => 'Willy Tarreau',
'wilsonc:abocom.com.tw' => 'Wilson Chen', # google
'wim:iguana.be' => 'Wim Van Sebroeck',
'wli:holomorphy.com' => 'William Lee Irwin III',
'wolfgang.fritz:gmx.net' => 'Wolfgang Fritz', # by Kristian Peters
'wolfgang:iksw-muees.de' => 'Wolfgang Muees',
'wolfgang:top.mynetix.de' => 'Wolfgang Mauerer',
'wriede:riede.org' => 'Willem Riede',
'wrlk:riede.org' => 'Willem Riede',
'wstinson:infonie.fr' => 'William Stinson',
'wstinson:wanadoo.fr' => 'William Stinson',
'xavier.bru:bull.net' => 'Xavier Bru',
'xkaspa06:stud.fee.vutbr.cz' => 'Tomas Kasparek',
'ya:slamail.org' => 'Yaacov Akiba Slama',
'yokota:netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
'yoshfuji:linux-ipv6.org' => 'Hideaki Yoshifuji', # lbdb
'yoshfuji:nuts.ninka.net' => 'Hideaki Yoshifuji',
'yuri:acronis.com' => 'Yuri Per', # lbdb
'zaitcev:redhat.com' => 'Pete Zaitcev',
'zinx:epicsol.org' => 'Zinx Verituse',
'zippel:linux-m68k.org' => 'Roman Zippel',
'zubarev:us.ibm.com' => 'Irene Zubarev', # google
'zw:superlucidity.net' => 'Zach Welch',
'zwane:commfireservices.com' => 'Zwane Mwaikambo',
'zwane:holomorphy.com' => 'Zwane Mwaikambo',
'zwane:linux.realnet.co.sz' => 'Zwane Mwaikambo',
'zwane:linuxpower.ca' => 'Zwane Mwaikambo',
'zwane:mwaikambo.name' => 'Zwane Mwaikambo',
'~~~~~~thisentrylastforconvenience~~~~~' => 'Cesar Brutus Anonymous'
);

sub doprint(\%@ ); # forward declaration

my $myname;
my %address_unknown;

# get name associated with an "email address" formatted
# BK_USER,BK_HOST tuple
sub rmap_address($) {
    my $in = shift;
    my $key = lc $in;
    # try hash lookup first, return result if any
    if (defined $addresses{obfuscate $key}) {
	return $addresses{obfuscate $key};
    }
    # try matching against all regexps in listed order
    # return result if any
    foreach my $ar (@addrregexps) {
	if ($in =~ m/$ar->[0]/) {
	    return $ar->[1];
	}
    }
    # when the address is unknown, return the unchanged input
    # and mark the address as unknown (so it can be printed in --warn
    # mode).
    $address_unknown{$key} = 1;
    return $in;
}

# case insensitive string comparison
# FIXME: use locale?
sub caseicmp { uc($a) cmp uc($b) };

# case insensitive string comparison by surname
# Strings are of the form
# "Firstname Surname <mailaddress>"
# or
# "<mailaddress>"
sub caseicmpbysurname {
  my $alast = "";
  my $blast = "";
  if ($a =~ m/(\S+)\s*(\s\<|$)/) { $alast = $1; }
  if ($b =~ m/(\S+)\s*(\s\<|$)/) { $blast = $1; }
  return uc($alast . $a) cmp uc($blast . $b);
}

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

# The sort function we will use
my $namesortfunc;

# Global store #############
# We store our options here.
my %opt;

# As we are parsing, the log is accumulated in the @cur array.  When
# we are done with one item (end of input or new mail address found),
# stuff a copy of this @cur array into the %log hash.
sub append_item(\%@)
# arguments: reference to hash
#            array to push
{
  my $log = shift;
  my @cur = @_;
  my $re = qr'((http|bk|ssh)://.*|[-a-zA-Z0-9.@()]+:\S+)';
  return unless @cur;
  return unless &$indexby;
  return if $opt{ignoremerge} and $cur[0] =~ m/Merge $re into $re/;
  return if $opt{ignoremerge} and $cur[0] =~ m/^Merge$/;
  $log->{&$indexby} = () unless defined $log->{&$indexby};

  # strip trailing blank lines
  my $t;
  while (($t = pop(@cur)) eq '') { };
  push @cur, $t;

  # store the array
  push @{$log->{&$indexby}}, [@cur];
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
sub print_grouped(\%) {
  my $log = shift;
  for (sort $namesortfunc keys %$log) {
    my @lines = compress(map { $_->[0] . "\n"; } @{$log->{$_}});
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
sub print_full(\%) {
  my $log = shift;
  for (sort $namesortfunc keys %$log) {
    printtag($_) or write_error();
    foreach (compress(@{$log->{$_}})) {
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
sub print_terse(\%) {
  my $log = shift;
  for (sort $namesortfunc keys %$log) {
    my $a = $_;
    if ($opt{width}) {
      if ($opt{swap}) {
	foreach (compress(map { $_->[0]; } @{$log->{$_}})) {
	  my @lines = expand(wrap($indent1, $indent, ("$a: $_")));
	  print join("\n", @lines), "\n"  or write_error();
	}
      } else {
	# width, but not swap set
	foreach (compress(map { $_->[0]; } @{$log->{$_}})) {
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
		   compress(map { $_->[0]; } @{$log->{$_}})), "\n"
		     or write_error();
      } else {
	print join("\n", map { "$indent1$_ ($a)" } 
		   compress(map { $_->[0]; } @{$log->{$_}})), "\n"
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
sub print_oneline(\%) {
  my $log = shift;
  for (sort $namesortfunc keys %$log) {
    my $a = $_;
    if ($opt{width}) {
      if ($opt{swap}) {
	foreach (compress(map { $_->[0]; } @{$log->{$_}})) {
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
	foreach (compress(map { $_->[0]; } @{$log->{$_}})) {
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
      print_terse(%$log);
    }
  }
}

# Abbreviate all components of the name except the last.  If capital
# Roman numerals form the last component, leave that and the previous
# component alone.
sub abbreviate_name($ ) {
  my @a = split /\s+/, $_[0];

  # treat Roman numerals as last part of name
  my $off = 0;
  $off = 1 if ($a[$#a] =~ /^[IVXLCMD]+$/);

  for (my $i = 0; $i < $#a - $off; $i++) {
    $a[$i] =~ s/^(.).*/$1./;
  }
  return join(" ", @a);
}

# Read a file and parse it into the %log hash.
sub parse_file(\%$$ ) {
# arguments: %log hash
#            file name
#            file handle (IO::Handle or IO::File)
  croak unless wantarray;
  my $log = shift;
  my $fn = shift;
  my $fh = shift;
  my @prolog;
  local $_;

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
    s/^  (\S)/\t$1/;
    # expand all tabs but the first
    $_ = expand($_);
    s/^        /\t/;

    if (defined $address and $opt{multi}
	and m{^[^<[:space:]]} and not m{^ChangeSet@}) {
      # if we are in multi mode, if we encounter a non-address
      # left-justified line, flush all data and print the header. The
      # 'defined $address' trick lets this only trigger to switch back
      # from "log entry" to "prolog" mode
      append_item(%$log, @cur); @cur = ();
      doprint(%$log, @prolog);
      print "\n" or write_error(); # print blank line between changelogs
      @prolog = ($_);
      undef %$log;
      undef $address;
    } elsif (m{^<([^>]+)>} or m{^ChangeSet@[0-9.]+,\s*[-0-9:+ ]+,\s*(.*)}) {
      # go figure if a line starts with an address, if so, take it
      # resolve the address to a name if possible
      append_item(%$log, @cur); @cur = ();
      $address = lc($1);
      $address =~ s/\[[^]]+\]$//;
      $name = rmap_address($address);
      my $havename = $name ne $address;
      if ($opt{'obfuscate'}) {
	$address = obfuscate $address;
      }
      if ($havename) {
	if ($opt{'abbreviate-names'}) {
	  $name = abbreviate_name($name);
	}
	if ($opt{'omitaddresses'}) {
	  $author = $name;
	} else {
	  $author = $name . ' <' . $address . '>';
	}
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
  append_item(%$log, @cur);

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

sub selftest() {
    my $rc = 0;
    foreach my $address (unveil keys %addresses) {
	foreach my $ar (@addrregexps) {
	    if ($address =~ m/$ar->[0]/) {
		print STDERR "Warning: address '$address'\n";
		print STDERR "  shadows regexp '$ar->[0]'\n";
		$rc = 1;
	    }
	}
    }
    return $rc;
}

# === MAIN PROGRAM ===============================================
# Command line arguments
# What options do we support?
my @opts = ("help|?|h", "man", "mode=s", "compress!", "count!", "width:i",
	    "swap!", "merge!", "warn!", "multi!", "abbreviate-names!",
	    "by-surname!", "selftest", "ignoremerge!", "omitaddresses!",
	    "obfuscate!");
#	    "bitkeeper|bk!");

# How do we parse them?
if ($Getopt::Long::VERSION gt '2.24') {
  Getopt::Long::Configure("gnu_getopt");
}

# set default options
$opt{mode} = 'grouped';
$opt{warn} = 1;
$opt{omitaddresses} = 1;
$opt{obfuscate} = 1;

# set up proper environment
$ENV{PATH} = '/bin:/usr/bin:/usr/local/bin';
$0 =~ tr|-a-zA-Z0-9_./||cd;
# untaint $0
$0 =~ m/(.*)/;
$0 = $1;
# get a path-stripped version of $0 in $myname
$0 =~ m/^(.*\/)?([^\/]+)$/;
$myname = $2;
$myname =~ tr/a-zA-Z0-9_.-//cd;

# Parse from environment, temporarily storing the original @ARGV.
if (defined $ENV{LINUXKERNEL_BK_FMT}) {
  my @savedargs = @ARGV;
  @ARGV = parse_line('\s+', 0, $ENV{LINUXKERNEL_BK_FMT});
  GetOptions(\%opt, @opts)
    or pod2usage(-verbose => 0,
		 -message => $myname . ': error in $LINUXKERNEL_BK_FMT');
  push @ARGV, @savedargs;
}

# Parse command line. Handle help, check for errors.
GetOptions(\%opt, @opts) or pod2usage(-verbose => 0);
pod2usage(-verbose => 1) if $opt{help};
pod2usage(-verbose => 2) if $opt{man};
pod2usage(-verbose => 0,
	  -message => ("$myname: Unknown mode specified.\nValid modes are:\n    "
		       . join(" ", sort keys %table) . "\n"))
  unless defined $table{$opt{mode}};
pod2usage(-verbose => 0,
	  -message => "$myname: No files given, refusing to read from a TTY.")
  if (not $opt{selftest} and not $opt{bitkeeper}
	  and (@ARGV == 0) and (-t STDIN));
pod2usage(-verbose => 0,
	  -message => "$myname: Must have one or two arguments in --bitkeeper mode.")
  if ($opt{bitkeeper} && (@ARGV < 1 || @ARGV > 2));
pod2usage(-verbose => 0,
	  -message => "$myname: You cannot use --merge and --multi at the same time.")
  if ($opt{merge} and $opt{multi});

# Shortcut for programmer convenience :-)
$indexby = $table{$opt{mode}}->{'index'};

# --count implies --compress
if ($opt{count}) { $opt{compress} = 1; }

# Set the sort function
$namesortfunc = \&caseicmp;
if ($opt{'by-surname'}) { $namesortfunc = \&caseicmpbysurname; }

# if --width is without argument or the argument is zero,
# try to figure $COLUMNS or fall back to 80.
if (exists $opt{width} and not $opt{width}) {
  $opt{width} = $ENV{COLUMNS} ? $ENV{COLUMNS} : 80;
}

# Print the passed-in array linewise, checking for write errors
# Then call the configured function to print %log formatted
sub doprint(\%@ ) {
  my $log = shift;
  print join("\n", @_), "\n" or write_error();
  $table{$opt{mode}}->{print}->($log);
}

# --------------------------------------------------------------------
# Global initializations
$Text::Tabs::tabstop = 8;
$Text::Wrap::huge = 'wrap';
if ($opt{width}) {
  $Text::Wrap::columns = $opt{width};
}

if ($debug) {
  print STDERR "DEBUG: Options summary:\n";
  while (my ($k, $v) = each %opt) { print STDERR "DEBUG:   '$k' => '$v'\n"; }
  print STDERR "DEBUG: Arguments summary:\n";
  foreach (@ARGV) { print STDERR "DEBUG:   '$_'\n"; }
}

if ($opt{selftest}) {
    my $rc = selftest();
    printf "selftest %s.\n", $rc ? "failed" : "passed";
    exit $rc;
}

# Main program
my @prolog;
my %log;

if($opt{bitkeeper}) {
  # in Bitkeeper mode, try to figure the change set, and connect the
  # bk program to our stdin.
  die "not yet implemented";
} elsif (@ARGV) {
  # file names
  foreach my $fn (@ARGV) {
    my $fh = new IO::File;
    $fh->open($fn, "r")
      or die "cannot open \"$fn\": $!\nAborting";
    push @prolog, parse_file(%log, $fn, $fh);
    if (not $opt{merge}) {
      doprint(%log, @prolog);
      undef %log;
    }
    undef @prolog;
  }

  if ($opt{merge}) {
    doprint(%log, ());
  }
} else {
  # stdin
  my @prolog;
  my $fh = new IO::Handle;
  $fh->fdopen(fileno(STDIN), "r")
    or die "cannot open stdin: $!\nAborting";
  @prolog = parse_file(%log, "stdin", $fh);
  doprint(%log, @prolog);
}

# Flush STDOUT to prevent clobbering STDOUT with 2>&1-style redirections.
$| = 1;

# Warn about unknown addresses
if ($opt{warn}) {
  foreach (sort caseicmp keys %address_unknown) {
    print STDERR "Warning: unknown address \"$_\"\n" or write_error();
  }
}

__END__
# --------------------------------------------------------------------
# $Log: lk-changelog.pl,v $
# Revision 0.124  2003/06/04 10:31:18  vita
# added 3 names for new addresses
#
# Revision 0.123  2003/06/03 05:49:53  vita
# added 2 names for new addresses
#
# Revision 0.122  2003/06/02 09:11:21  emma
# Fix umlaut in Moritz Mühlenhoff's name.
#
# Revision 0.121  2003/06/02 08:56:16  vita
# added 5 names for new addresses
#
# Revision 0.120  2003/05/29 11:11:22  vita
# added 2 names for new addresses
#
# Revision 0.119  2003/05/26 13:45:55  vita
# added 2 names for new addresses
#
# Revision 0.118  2003/05/23 11:07:37  vita
# added 5 names for new addresses
#
# Revision 0.117  2003/05/23 09:31:17  emma
# Add Bernhard Kaindl's address.
#
# Revision 0.116  2003/05/15 08:52:06  vita
# added 4 names for new addresses
#
# Revision 0.115  2003/05/12 10:16:48  vita
# added 3 names for new addresses
#
# Revision 0.114  2003/05/08 10:35:41  vita
# added 5 names for new addresses
#
# Revision 0.113  2003/05/07 09:30:03  vita
# added 3 names for new addresses
#
# Revision 0.112  2003/05/06 15:46:15  vita
# added 3 names for new addresses
#
# Revision 0.111  2003/05/05 08:55:16  vita
# added 3 names for new addresses
#
# Revision 0.110  2003/05/02 14:53:22  vita
# added 6 names for new addresses
#
# Revision 0.109  2003/04/29 10:20:09  vita
# added 8 names for new addresses
#
# Revision 0.108  2003/04/28 23:26:08  emma
# Add explanation why we define an array just to undefine it right away.
#
# Revision 0.107  2003/04/28 23:18:37  emma
# Report status of selftest.
#
# Revision 0.106  2003/04/28 23:00:49  emma
# Correct Vincent Legoll's name (was confused with somebody else).
#
# Revision 0.105  2003/04/28 12:20:56  vita
# added 5 names for new addresses
#
# Revision 0.104  2003/04/27 13:18:46  emma
# Add two more addresses.
#
# Revision 0.103  2003/04/24 09:20:31  vita
# added 2 names for new addresses
#
# Revision 0.102  2003/04/23 12:39:05  vita
# added 9 names for new addresses
#
# Revision 0.101  2003/04/18 11:43:22  vita
# added 8 names for new addresses
#
# Revision 0.100  2003/04/17 10:25:19  vita
# added 3 names for new addresses
#
# Revision 0.99  2003/04/16 08:17:49  vita
# added 9 names for new addresses
#
# Revision 0.98  2003/04/14 15:47:56  emma
# Doing Zack Brown a favor and archiving addresses that are now handled by regexps
# in a separate list.
#
# Revision 0.97  2003/04/13 11:33:27  emma
# Correct Patricia Gaughen's name (was Gua...). Found by Geoffrey Lee.
#
# Revision 0.96  2003/04/13 10:46:57  emma
# 100 (one hundred) new addresses and 17 corrections by Zack Brown.
#
# Revision 0.95  2003/04/10 13:06:17  vita
# added 6 names for new addresses
#
# Revision 0.94  2003/04/10 09:59:04  emma
# Add Carl-Daniel's new 2003 address.
#
# Revision 0.93  2003/04/03 10:48:46  vita
# added 9 names for new addresses
#
# Revision 0.92  2003/04/03 10:33:20  vita
# move multiple linus' entries into regexp one
#
# Revision 0.91  2003/04/03 10:31:42  vita
# change ignoremerge regexp to cover hostnames with ();
# hide lonely standing "Merge" with --ignoremerge
#
# Revision 0.90  2003/03/31 11:24:32  emma
# Obfuscate addresses, in script as well as in output. Output address
# obfuscation can be switched off with --noobfuscate.
# Suggested by Solar Designer.
#
# Omit addresses when a name is known. (Switch this off with
# --noomitaddresses). This fixes the "distinct changelog per address
# rather than per person" problem Sam Ravnborg reported.
#
# Revision 0.89  2003/03/28 10:55:39  emma
# * Add one address.
# * Strip $0 down to POSIX portable file name character set and untaint it
#   to suppress warnings with Perl 5.8.0 and --man.
# * Reset $ENV{PATH} to /bin:/usr/bin:/usr/local/bin for the same reason.
# * In usage information, path-strip $0 in addition to that (and store in
#   $myname).
# * Add --ignoremerge switch to suppress the "Merge ... into ..." log
#   entries.
#
# Revision 0.88  2003/03/26 21:12:23  emma
# Add selftest mode check:
# * check all addresses against all regexps to find addresses shadowing
#   regular expressions.
#
# Revision 0.87  2003/03/26 21:02:53  emma
# Fix broken regexp for Alan's swansea.linux.org.uk addresses. Add some comments.
#
# Revision 0.86  2003/03/26 20:57:49  emma
# Support regexp queries (but try hash lookups first for efficiency).
# Requested by Linus Torvalds.
#
# Revision 0.85  2003/03/26 08:22:11  vita
# Added 6 names for new addresses.
#
# Revision 0.84  2003/03/24 08:45:20  vita
# Added 12 names for new addresses from current 2.5 BK tree.
#
# Revision 0.83  2003/03/19 08:19:48  vita
# Added 4 new names for addresses from current linux-2.5 BK tree.
#
# Revision 0.82  2003/03/17 08:26:30  vita
# Added 2 new names.
#
# Revision 0.81  2003/03/10 15:38:27  vita
# Added 4 new names for addresses from current linux-2.5 BK tree.
#
# Revision 0.80  2003/03/07 13:31:57  vita
# Added 7 new names for addresses from current linux-2.5 BK tree.
#
# Revision 0.79  2003/03/04 16:59:15  vita
# Added 5 new names for addresses from both current BK trees.
#
# Revision 0.78  2003/02/27 12:01:54  emma
# Credit Vita in AUTHOR section of POD.
#
# Revision 0.77  2003/02/27 10:52:59  vita
# Added 7 new names for addresses from both current BK trees.
#
# Revision 0.76  2003/02/24 20:04:23  vita
# Added 7 new names for addresses from current linux-2.5 BK tree.
#
# Revision 0.75  2003/02/21 12:41:18  vita
# Added 5 new names for addresses from current linux-2.4 BK tree.
#
# Revision 0.74  2003/02/19 11:15:14  vita
# Added 7 new addresses found by Google.
#
# Revision 0.73  2003/02/14 10:45:45  vita
# Added 5 new addresses found by Google.
#
# Revision 0.72  2003/02/06 16:10:23  vita
# Added 6 new addresses found by Google.
#
# Revision 0.71  2003/02/05 11:22:06  emma
# New addresses Vita pulled out.
#
# Revision 0.70  2003/02/03 14:58:04  emma
# Vita dug out more addresses.
#
# Revision 0.69  2003/01/28 23:30:02  emma
# Another four addresses by Vita.
#
# Revision 0.68  2003/01/20 10:22:08  emma
# Add new address for Rolf Eike Beer.
#
# Revision 0.67  2003/01/19 14:32:55  emma
# Further addresses figured out by Vita.
#
# Revision 0.66  2003/01/18 12:44:33  emma
# New addresses found out by Vita.
#
# Revision 0.65  2003/01/13 14:12:09  emma
# New addresses dug out by Vita.
#
# Revision 0.64  2003/01/08 14:48:50  emma
# New addresses by Vita.
#
# Revision 0.63  2003/01/08 14:47:37  emma
# New addresses by Vita.
#
# Revision 0.62  2002/12/27 16:59:28  emma
# Another ten addresses sent by Vitezslav Samel.
#
# Revision 0.61  2002/12/14 14:28:49  emma
# Bjorn Helgaas only uses the transscribed version of his name himself.
#
# Revision 0.60  2002/12/13 14:51:35  emma
# Next dozen of addresses digged out by Vita.
#
# Revision 0.59  2002/12/11 12:11:51  emma
# Workaround: strip trailing [tag] from mail addresses, reported by Marcel
#     Holtmann.
# Add some new addresses.
#
# Revision 0.58  2002/12/07 15:14:57  emma
# More addresses figured by Vitezslav Samel.
#
# Revision 0.57  2002/12/07 15:08:34  emma
# 3 more addresses.
#
# Revision 0.56  2002/11/28 02:32:11  emma
# List David Weinehall.
#
# Revision 0.55  2002/11/27 04:44:54  emma
# Add kaos@sgi.com for Keith Owens as per his own request.
#
# Revision 0.54  2002/11/26 23:27:11  emma
# Merge changes from Linus' version.
#
# Revision 0.53  2002/11/25 17:12:08  emma
# Add Lee Nash's address
#
# Revision 0.52  2002/11/14 14:50:21  emma
# Bugfix --by-surname for some modes. Add two addresses. Fix Carl-Daniel Hailfinger's address to lower case.
#
# Revision 0.51  2002/11/14 14:31:10  emma
# Add Carl-Daniel Hailfinger's new address. Add TODO item to see if regexp/wildcard match in address list is possible.
#
# Revision 0.50  2002/11/09 14:24:21  emma
# Add comment to Richard Hitt's address.
#
# Revision 0.49  2002/11/04 17:13:21  emma
# Add 4 addresses sent by Duncan Laurie.
#
# Revision 0.48  2002/11/04 12:37:38  emma
# Another four dozen addresses, courtesy of Vitezslav Samel.
#
# Revision 0.47  2002/11/04 12:19:17  emma
# Vitezslav Samel: Merge bugfix to treat addresses with upper-case characters in ChangeSet.
#
# Revision 0.46  2002/11/04 11:37:33  emma
# 7 new addresses.
#
# Revision 0.45  2002/11/04 11:26:41  emma
# 18 new addresses.
#
# Revision 0.44  2002/10/04 03:37:51  emma
# Track BK-kernel-tools changes to Jes Sorensen's name.
#
# Revision 0.43  2002/10/04 03:33:47  emma
# 4 new addresses.
#
# Revision 0.42  2002/10/01 20:20:33  emma
# Another 25 addresses for ChangeLog 2.5.3?, from google and lbdb.
#
# Revision 0.41  2002/10/01 19:45:20  emma
# Some detective work on google found another 19 addresses.
#
# Revision 0.40  2002/09/30 01:44:51  emma
# Drop bogus geert@linux-m68k.org.com address.
#
# Revision 0.39  2002/09/26 23:07:13  emma
# 46 new addresses from lbdb
#
# Revision 0.38  2002/09/26 22:37:29  emma
# 23 new addresses
#
# Revision 0.37  2002/09/26 22:27:37  emma
# Fix --multi mode.
#
# Revision 0.36  2002/08/29 09:13:40  emma
# Correct Vojtech Pavlik's addresses after mail from him.
#
# Revision 0.35  2002/08/21 13:49:46  emma
# Many new addresses and one correction by Vitezslav 'Vita' Samel <samel@mail.cz>
#
# Revision 0.34  2002/08/21 13:45:53  emma
# 2 new names
#
# Revision 0.33  2002/08/20 01:29:34  emma
# The usual set of new addresses.
#
# Revision 0.32  2002/08/20 01:14:40  emma
# Add Marcel Holtmann, who sent a patch.
#
# Revision 0.31  2002/08/12 22:34:41  emma
# Patch by Marcus Alanen <maalanen@ra.abo.fi>:
# Hi, patch to sort by developer surname, and a couple of more
# developers. Use if you want to.
#
# Revision 0.30  2002/07/20 17:18:28  emma
# Add one new address
#
# Revision 0.29  2002/07/17 23:10:13  emma
# 23 new addresses.
#
# Revision 0.28  2002/06/25 09:46:57  emma
# New mail addresses.
#
# Revision 0.27  2002/06/14 17:05:23  emma
# three new addresses
#
# Revision 0.26  2002/06/06 10:26:51  emma
# Get rid of global %log, pass it to sub functions by reference.
# Move IO::Handle/IO::File treatment back into main program.
# Prepare for integrating Bitkeeper.
#
# Revision 0.25  2002/06/04 00:01:23  emma
# Recognize "bk changes" output format (that is: "ChangeSet@1.234.5.6,
# date, programmer" tag line and body indented by two spaces). Reported
# by Marcelo Tosatti <marcelo@conectiva.com.br>. Former versions would
# only recognize the BK-kernel-tools/changelog format (see
# http://gkernel.bkbits.net:8080/BK-kernel-tools/anno/changelog@1.5?nav=index.html|src/).
#
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
     --[no]by-surname
                     sort entries by surname
     --[no]omitaddresses
                     omit "email address" when a name is known
     --[no]obfuscate
                     obfuscate "email address" in output
     --[no]ignoremerge
                     suppress "Merge bk://..." changelogs.

     --mode=MODE     specify the output format (use --man to find out more)
     --width[=WIDTH] specify the line length, if omitted: $COLUMNS or 80.
                     text lines will not exceed this length.

     --selftest      perform some self tests (for developers of this script)

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

=head1 AUTHOR

=over

=item * Matthias Andree <matthias.andree@gmx.de>

Main developer

=item * Marcus Alanen <maalanen@abo.fi>

=item * Tomas Szepe <szepe@pinerecords.com>

=item * Vitezslav Samel <samel@mail.cz>

Has dug out several dozens of addresses.

=item * Further help from:

Albert D. Cahalan <acahalan@cs.uml.edu>, Robinson Maureira Castillo
<rmaureira@alumno.inacap.cl>, Greg Kroah-Hartman <greg@kroah.com>, Zack
Brown <zbrown@tumblerings.org>.

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

=item * Integrate Bitkeeper

=back

=cut

