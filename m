Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262712AbSLGPLJ>; Sat, 7 Dec 2002 10:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbSLGPLI>; Sat, 7 Dec 2002 10:11:08 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:1800 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S262712AbSLGPKs> convert rfc822-to-8bit; Sat, 7 Dec 2002 10:10:48 -0500
MIME-Version: 1.0
To: torvalds@transmeta.com, marcelo@conectiva.com.br
Subject: lk-changelog.pl 0.58
Cc: linux-kernel@vger.kernel.org
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sat_Dec__7_15_18_22_UTC_2002_0@merlin.emma.line.org>
Content-type: text/plain
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20021207151822.4FC536EF04@merlin.emma.line.org>
Date: Sat,  7 Dec 2002 16:18:22 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.58 has been released.
The changes are listed at the end of the script below.

You can always download this script and GPG signatures from
http://mandree.home.pages.de/linux/kernel/

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
revision 0.58
date: 2002/12/07 15:14:57;  author: emma;  state: Exp;  lines: +26 -1
More addresses figured by Vitetzslav Samel.
----------------------------
revision 0.57
date: 2002/12/07 15:08:34;  author: emma;  state: Exp;  lines: +7 -1
3 more addresses.
----------------------------
revision 0.56
date: 2002/11/28 02:32:11;  author: emma;  state: Exp;  lines: +6 -1
List David Weinehall.
----------------------------
revision 0.55
date: 2002/11/27 04:44:54;  author: emma;  state: Exp;  lines: +5 -1
Add kaos@sgi.com for Keith Owens as per his own request.
----------------------------
revision 0.54
date: 2002/11/26 23:27:11;  author: emma;  state: Exp;  lines: +18 -2
Merge changes from Linus' version.
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
# $Id: lk-changelog.pl,v 0.58 2002/12/07 15:14:57 emma Exp $
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
# lbdb.
my %addresses = (
'abraham@2d3d.co.za' => 'Abraham van der Merwe',
'ac9410@attbi.com' => 'Albert Cranford',
'acher@in.tum.de' => 'Georg Acher',
'achirica@ttd.net' => 'Javier Achirica',
'acme@brinquedo.oo.ps' => 'Arnaldo Carvalho de Melo',
'acme@conectiva.com.br' => 'Arnaldo Carvalho de Melo',
'acme@dhcp197.conectiva' => 'Arnaldo Carvalho de Melo',
'adam@mailhost.nmt.edu' => 'Adam Radford', # google
'adam@nmt.edu' => 'Adam Radford', # google
'adam@yggdrasil.com' => 'Adam J. Richter',
'adilger@clusterfs.com' => 'Andreas Dilger',
'aebr@win.tue.nl' => 'Andries E. Brouwer',
'agrover@acpi3.(none)' => 'Andy Grover',
'agrover@acpi3.jf.intel.com' => 'Andy Grover', # guessed
'agrover@dexter.groveronline.com' => 'Andy Grover',
'agrover@groveronline.com' => 'Andy Grover',
'ahaas@airmail.net' => 'Art Haas',
'ahaas@neosoft.com' => 'Art Haas',
'aia21@cam.ac.uk' => 'Anton Altaparmakov',
'aia21@cantab.net' => 'Anton Altaparmakov',
'aia21@cus.cam.ac.uk' => 'Anton Altaparmakov',
'ajoshi@shell.unixbox.com' => 'Ani Joshi',
'ak@muc.de' => 'Andi Kleen',
'ak@suse.de' => 'Andi Kleen',
'akpm@digeo.com' => 'Andrew Morton',
'akpm@zip.com.au' => 'Andrew Morton',
'akropel1@rochester.rr.com' => 'Adam Kropelin', # lbdb
'alan@irongate.swansea.linux.org.uk' => 'Alan Cox',
'alan@lxorguk.ukuu.org.uk' => 'Alan Cox',
'alan@redhat.com' => 'Alan Cox',
'alex_williamson@attbi.com' => 'Alex Williamson', # lbdb
'alex_williamson@hp.com' => 'Alex Williamson', # google
'alexander.riesen@synopsys.com' => 'Alexander Riesen',
'alfre@ibd.es' => 'Alfredo Sanju�n',
'ambx1@neo.rr.com' => 'Adam Belay',
'amunoz@vmware.com' => 'Alberto Munoz',
'andersen@codepoet.org' => 'Erik Andersen',
'andersg@0x63.nu' => 'Anders Gustafsson',
'andmike@us.ibm.com' => 'Mike Anderson', # lbdb
'andrea@suse.de' => 'Andrea Arcangeli',
'andries.brouwer@cwi.nl' => 'Andries E. Brouwer',
'andros@citi.umich.edu' => 'Andy Adamson',
'angus.sawyer@dsl.pipex.com' => 'Angus Sawyer',
'ankry@green.mif.pg.gda.pl' => 'Andrzej Krzysztofowicz',
'anton@samba.org' => 'Anton Blanchard',
'aris@cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
'arjan@redhat.com' => 'Arjan van de Ven',
'arjanv@redhat.com' => 'Arjan van de Ven',
'arndb@de.ibm.com' => 'Arnd Bergmann',
'asit.k.mallick@intel.com' => 'Asit K. Mallick', # by Kristian Peters
'axboe@burns.home.kernel.dk' => 'Jens Axboe', # guessed
'axboe@hera.kernel.org' => 'Jens Axboe',
'axboe@suse.de' => 'Jens Axboe',
'baccala@vger.freesoft.org' => 'Brent Baccala',
'barrow_dj@yahoo.com' => 'D. J. Barrow',
'barryn@pobox.com' => 'Barry K. Nathan', # lbdb
'bart.de.schuymer@pandora.be' => 'Bart De Schuymer',
'bcollins@debian.org' => 'Ben Collins',
'bcrl@bob.home.kvack.org' => 'Benjamin LaHaise',
'bcrl@redhat.com' => 'Benjamin LaHaise',
'bcrl@toomuch.toronto.redhat.com' => 'Benjamin LaHaise', # guessed
'bdschuym@pandora.be' => 'Bart De Schuymer',
'beattie@beattie-home.net' => 'Brian Beattie', # from david.nelson
'benh@kernel.crashing.org' => 'Benjamin Herrenschmidt',
'bfennema@falcon.csc.calpoly.edu' => 'Ben Fennema',
'bgerst@didntduck.org' => 'Brian Gerst',
'bhards@bigpond.net.au' => 'Brad Hards',
'bhavesh@avaya.com' => 'Bhavesh P. Davda',
'bheilbrun@paypal.com' => 'Brad Heilbrun', # by himself
'bjorn.andersson@erc.ericsson.se' => 'Bj�rn Andersson', # google, guessed �
'bjorn.wesen@axis.com' => 'Bjorn Wesen',
'bjorn_helgaas@hp.com' => 'Bjorn Helgaas',
'bmatheny@purdue.edu' => 'Blake Matheny', # google
'borisitk@fortunet.com' => 'Boris Itkis', # by Kristian Peters
'brett@bad-sports.com' => 'Brett Pemberton',
'brihall@pcisys.net' => 'Brian Hall', # google
'brownfld@irridia.com' => 'Ken Brownfield',
'bunk@fs.tum.de' => 'Adrian Bunk',
'buytenh@gnu.org' => 'Lennert Buytenhek',
'bzeeb-lists@lists.zabbadoz.net' => 'Bj�rn A. Zeeb', # lbdb
'c-d.hailfinger.kernel.2002-07@gmx.net' => 'Carl-Daniel Hailfinger',
'c-d.hailfinger.kernel.2002-q4@gmx.net' => 'Carl-Daniel Hailfinger', # himself
'cattelan@sgi.com' => 'Russell Cattelan', # google
'ccaputo@alt.net' => 'Chris Caputo',
'cel@citi.umich.edu' => 'Chuck Lever',
'celso@bulma.net' => 'Celso Gonz�lez', # google
'ch@hpl.hp.com' => 'Christopher Hoover', # by Kristian Peters
'charles.white@hp.com' => 'Charles White',
'chessman@tux.org' => 'Samuel S. Chessman',
'chris@wirex.com' => 'Chris Wright',
'christer@weinigel.se' => 'Christer Weinigel', # from shortlog
'christopher.leech@intel.com' => 'Christopher Leech',
'cip307@cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
'ckulesa@as.arizona.edu' => 'Craig Kulesa',
'colin@gibbs.dhs.org' => 'Colin Gibbs',
'colpatch@us.ibm.com' => 'Matthew Dobson',
'cort@fsmlabs.com' => 'Cort Dougan',
'cph@zurich.ai.mit.edu' => 'Chris Hanson',
'cr@sap.com' => 'Christoph Rohland',
'cruault@724.com' => 'Charles-Edouard Ruault',
'ctindel@cup.hp.com' => 'Chad N. Tindel',
'cyeoh@samba.org' => 'Christopher Yeoh',
'da-x@gmx.net' => 'Dan Aloni',
'daisy@teetime.dynamic.austin.ibm.com' => 'Daisy Chang', # from shortlog
'dalecki@evision-ventures.com' => 'Martin Dalecki',
'dalecki@evision.ag' => 'Martin Dalecki',
'dan.zink@hp.com' => 'Dan Zink',
'dan@debian.org' => 'Daniel Jacobowitz',
'danc@mvista.com' => 'Dan Cox', # some CREDITS patch found by google
'davej@codemonkey.org.uk' => 'Dave Jones',
'davej@suse.de' => 'Dave Jones',
'davem@hera.kernel.org' => 'David S. Miller',
'davem@nuts.ninka.net' => 'David S. Miller',
'davem@pizda.ninka.net' => 'David S. Miller', # guessed
'davem@redhat.com' => 'David S. Miller',
'david-b@pacbell.net' => 'David Brownell',
'david.nelson@pobox.com' => 'David Nelson',
'david@gibson.dropbear.id.au' => 'David Gibson',
'david_jeffery@adaptec.com' => 'David Jeffery',
'davidel@xmailserver.org' => 'Davide Libenzi',
'davidm@hpl.hp.com' => 'David Mosberger',
'davidm@napali.hpl.hp.com' => 'David Mosberger',
'davidm@tiger.hpl.hp.com' => 'David Mosberger',
'davidm@wailua.hpl.hp.com' => 'David Mosberger',
'davids@youknow.youwant.to' => 'David Schwartz', # google
'dbrownell@users.sourceforge.net' => 'David Brownell',
'ddstreet@ieee.org' => 'Dan Streetman',
'ddstreet@us.ibm.com' => 'Dan Streetman',
'defouwj@purdue.edu' => 'Jeff DeFouw',
'dent@cosy.sbg.ac.at' => "Thomas 'Dent' Mirlacher",
'devel@brodo.de' => 'Dominik Brodowski',
'devik@cdi.cz' => 'Martin Devera',
'dgibson@samba.org' => 'David Gibson',
'dhinds@sonic.net' => 'David Hinds', # google
'dhollis@davehollis.com' => 'Dave Hollis',
'dhowells@cambridge.redhat.com' => 'David Howells',
'dhowells@redhat.com' => 'David Howells',
'dipankar@in.ibm.com' => 'Dipankar Sarma',
'dirk.uffmann@nokia.com' => 'Dirk Uffmann',
'dledford@aladin.rdu.redhat.com' => 'Doug Ledford',
'dledford@dledford.theledfords.org' => 'Doug Ledford',
'dledford@flossy.devel.redhat.com' => 'Doug Ledford',
'dledford@redhat.com' => 'Doug Ledford',
'dmccr@us.ibm.com' => 'Dave McCracken',
'dok@directfb.org' => 'Denis Oliver Kropp',
'dougg@torque.net' => 'Douglas Gilbert',
'driver@huey.jpl.nasa.gov' => 'Bryan B. Whitehead', # google
'drow@false.org' => 'Daniel Jacobowitz',
'drow@nevyn.them.org' => 'Daniel Jacobowitz',
'dsaxena@mvista.com' => 'Deepak Saxena',
'dwmw2@infradead.org' => 'David Woodhouse',
'dwmw2@redhat.com' => 'David Woodhouse',
'dz@cs.unitn.it' => 'Massimo Dal Zotto',
'ebiederm@xmission.com' => 'Eric Biederman',
'ebrower@resilience.com' => 'Eric Brower',
'ebrower@usa.net' => 'Eric Brower',
'ecd@skynet.be' => 'Eddie C. Dost',
'edv@macrolink.com' => 'Ed Vance',
'edward_peng@dlink.com.tw' => 'Edward Peng',
'efocht@ess.nec.de' => 'Erich Focht',
'eike@bilbo.math.uni-mannheim.de' => 'Rolf Eike Beer',
'elenstev@mesatop.com' => 'Steven Cole',
'engebret@us.ibm.com' => 'Dave Engebretsen',
'eranian@hpl.hp.com' => 'St�phane Eranian',
'erik_habbinga@hp.com' => 'Erik Habbinga',
'eyal@eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
'fbl@conectiva.com.br' => 'Fl�vio Bruno Leitner', # google
'fdavis@si.rr.com' => 'Frank Davis',
'felipewd@terra.com.br' => 'Felipe Damasio', # by self (did not ask to include the W.)
'fenghua.yu@intel.com' => 'Fenghua Yu', # google
'fero@sztalker.hu' => 'Bakonyi Ferenc',
'fischer@linux-buechse.de' => 'J�rgen E. Fischer',
'fletch@aracnet.com' => 'Martin J. Bligh',
'flo@rfc822.org' => 'Florian Lohoff',
'florian.thiel@gmx.net' => 'Florian Thiel', # from shortlog
'focht@ess.nec.de' => 'Erich Focht',
'fokkensr@fokkensr.vertis.nl' => 'Rolf Fokkens',
'franz.sirl-kernel@lauterbach.com' => 'Franz Sirl',
'franz.sirl@lauterbach.com' => 'Franz Sirl',
'fubar@us.ibm.com' => 'Jay Vosburgh',
'fw@deneb.enyo.de' => 'Florian Weimer', # lbdb
'fzago@austin.rr.com' => 'Frank Zago', # google
'ganesh@tuxtop.vxindia.veritas.com' => 'Ganesh Varadarajan',
'ganesh@veritas.com' => 'Ganesh Varadarajan',
'ganesh@vxindia.veritas.com' => 'Ganesh Varadarajan',
'garloff@suse.de' => 'Kurt Garloff',
'geert@linux-m68k.org' => 'Geert Uytterhoeven',
'george@mvista.com' => 'George Anzinger',
'gerg@snapgear.com' => 'Greg Ungerer',
'ghoz@sympatico.ca' => 'Ghozlane Toumi',
'gibbs@overdrive.btc.adaptec.com' => 'Justin T. Gibbs',
'gibbs@scsiguy.com' => 'Justin T. Gibbs',
'gilbertd@treblig.org' => 'Dr. David Alan Gilbert',
'gl@dsa-ac.de' => 'Guennadi Liakhovetski',
'glee@gnupilgrims.org' => 'Geoffrey Lee', # lbdb
'gnb@alphalink.com.au' => 'Greg Banks',
'go@turbolinux.co.jp' => 'Go Taniguchi',
'gone@us.ibm.com' => 'Patricia Guaghen',
'gotom@debian.or.jp' => 'Goto Masanori', # from shortlog
'gphat@cafes.net' => 'Cory Watson',
'greearb@candelatech.com' => 'Ben Greear',
'green@angband.namesys.com' => 'Oleg Drokin',
'green@namesys.com' => 'Oleg Drokin',
'greg@kroah.com' => 'Greg Kroah-Hartman',
'grundler@cup.hp.com' => 'Grant Grundler',
'gsromero@alumnos.euitt.upm.es' => 'Guillermo S. Romero',
'gtoumi@laposte.net' => 'Ghozlane Toumi',
'hadi@cyberus.ca' => 'Jamal Hadi Salim',
'hannal@us.ibm.com' => 'Hanna Linder',
'haveblue@us.ibm.com' => 'Dave Hansen',
'hch@caldera.de' => 'Christoph Hellwig',
'hch@dhcp212.munich.sgi.com' => 'Christoph Hellwig',
'hch@hera.kernel.org' => 'Christoph Hellwig',
'hch@infradead.org' => 'Christoph Hellwig',
'hch@lab343.munich.sgi.com' => 'Christoph Hellwig',
'hch@lst.de' => 'Christoph Hellwig',
'hch@pentafluge.infradead.org' => 'Christoph Hellwig',
'hch@sb.bsdonline.org' => 'Christoph Hellwig', # by Kristian Peters
'hch@sgi.com' => 'Christoph Hellwig',
'helgaas@fc.hp.com' => 'Bj�rn Helg�s', # lbdb + guessed national characters
'henrique@cyclades.com' => 'Henrique Gobbi',
'hermes@gibson.dropbear.id.au' => 'David Gibson',
'hirofumi@mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
'hoho@binbash.net' => 'Colin Slater',
'hpa@zytor.com' => 'H. Peter Anvin',
'hugh@veritas.com' => 'Hugh Dickins',
'ica2_ts@csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
'info@usblcd.de' =>  'Adams IT Services',
'ink@jurassic.park.msu.ru' => 'Ivan Kokshaysky',
'ink@jurassic.park.msu.ru[rth]' => 'Ivan Kokshaysky',
'ionut@cs.columbia.edu' => 'Ion Badulescu',
'ioshadij@hotmail.com' => 'Ishan O. Jayawardena',
'irohlfs@irohlfs.de' => 'Ingo Rohlfs',
'ivangurdiev@linuxfreemail.com' => 'Ivan Gyurdiev',
'jack@suse.cz' => 'Jan Kara',
'jack_hammer@adaptec.com' => 'Jack Hammer',
'jaharkes@cs.cmu.edu' => 'Jan Harkes',
'jakob.kemi@telia.com' => 'Jakob Kemi',
'jamagallon@able.es' => 'J. A. Magallon',
'james.bottomley@steeleye.com' => 'James Bottomley',
'james@cobaltmountain.com' => 'James Mayer',
'james_mcmechan@hotmail.com' => 'James McMechan',
'jamey.hicks@hp.com' => 'Jamey Hicks',
'jamey@crl.dec.com' => 'Jamey Hicks',
'jani@astechnix.ro' => 'Jani Monoses',
'jani@iv.ro' => 'Jani Monoses',
'jb@jblache.org' => 'Julien Blache',
'jbglaw@lug-owl.de' => 'Jan-Benedict Glaw',
'jblack@linuxguru.net' => 'James Blackwell',
'jdavid@farfalle.com' => 'David Ruggiero',
'jdike@jdike.wstearns.org' => 'Jeff Dike',
'jdike@karaya.com' => 'Jeff Dike',
'jdike@uml.karaya.com' => 'Jeff Dike',
'jdr@farfalle.com' => 'David Ruggiero',
'jdthood@yahoo.co.uk' => 'Thomas Hood',
'jeb.j.cramer@intel.com' => 'Jeb J. Cramer',
'jeffs@accelent.com' => 'Jeff Sutherland', # lbdb
'jejb@mulgrave.(none)' => 'James Bottomley', # from shortlog
'jenna.s.hall@intel.com' => 'Jenna S. Hall', # google
'jes@trained-monkey.org' => 'Jes Sorensen',
'jes@wildopensource.com' => 'Jes Sorensen',
'jgarzik@fokker2.devel.redhat.com' => 'Jeff Garzik',
'jgarzik@mandrakesoft.com' => 'Jeff Garzik',
'jgarzik@redhat.com' => 'Jeff Garzik',
'jgarzik@rum.normnet.org' => 'Jeff Garzik',
'jgarzik@tout.normnet.org' => 'Jeff Garzik',
'jgrimm@jgrimm.austin.ibm.com' => 'Jon Grimm', # google
'jgrimm@touki.austin.ibm.com' => 'Jon Grimm', # google
'jgrimm@touki.qip.austin.ibm.com' => 'Jon Grimm', # google
'jgrimm2@us.ibm.com' => 'Jon Grimm',
'jhammer@us.ibm.com' => 'Jack Hammer',
'jmorris@intercode.com.au' => 'James Morris',
'jo-lkml@suckfuell.net' => 'Jochen Suckfuell',
'joe@wavicle.org' => 'Joe Burks',
'johann.deneux@it.uu.se' => 'Johann Deneux',
'johannes@erdfelt.com' => 'Johannes Erdfelt',
'john@deater.net' => 'John Clemens',
'john@larvalstage.com' => 'John Kim',
'johnpol@2ka.mipt.ru' => 'Evgeniy Polyakov',
'johnstul@us.ibm.com' => 'John Stultz',
'jsiemes@web.de' => 'Josef Siemes',
'jsimmons@heisenberg.transvirtual.com' => 'James Simmons',
'jsimmons@maxwell.earthlink.net' => 'James Simmons',
'jsimmons@transvirtual.com' => 'James Simmons',
'jt@bougret.hpl.hp.com' => 'Jean Tourrilhes',
'jt@hpl.hp.com' => 'Jean Tourrilhes',
'jtyner@cs.ucr.edu' => 'John Tyner',
'jun.nakajima@intel.com' => 'Jun Nakajima',
'jung-ik.lee@intel.com' => 'J.I. Lee',
'jwoithe@physics.adelaide.edu.au' => 'Jonathan Woithe',
'k-suganuma@mvj.biglobe.ne.jp' => 'Kimio Suganuma',
'k.kasprzak@box43.pl' => 'Karol Kasprzak', # by Kristian Peters
'kaber@trash.net' => 'Patrick McHardy',
'kai-germaschewski@uiowa.edu' => 'Kai Germaschewski',
'kai.makisara@kolumbus.fi' => 'Kai Makisara',
'kai.reichert@udo.edu' => 'Kai Reichert',
'kai@chaos.tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
'kai@tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
'kanoj@vger.kernel.org' => 'Kanoj Sarcar', # sent by Arnaldo Carvalho de Melo
'kanojsarcar@yahoo.com' => 'Kanoj Sarcar',
'kaos@ocs.com.au' => 'Keith Owens',
'kaos@sgi.com' => 'Keith Owens', # sent by himself
'kasperd@daimi.au.dk' => 'Kasper Dupont',
'keithu@parl.clemson.edu' => 'Keith Underwood',
'kenneth.w.chen@intel.com' => 'Kenneth W. Chen',
'key@austin.ibm.com' => 'Kent Yoder',
'khalid@fc.hp.com' => 'Khalid Aziz',
'khalid_aziz@hp.com' => 'Khalid Aziz',
'khc@pm.waw.pl' => 'Krzysztof Halasa',
'kiran@in.ibm.com' => 'Ravikiran G. Thirumalai',
'kisza@sch.bme.hu' => 'Andras Kis-Szabo', # google (netfilter-ext HOWTO)
'kkeil@suse.de' => 'Karsten Keil',
'kmsmith@umich.edu' => 'Kendrick M. Smith',
'knan@mo.himolde.no' => 'Erik Inge Bols�',
'komujun@nifty.com' => 'Jun Komuro', # google
'kraxel@bytesex.org' => 'Gerd Knorr',
'kraxel@suse.de' => 'Gerd Knorr',
'kuebelr@email.uc.edu' => 'Robert Kuebel',
'kuznet@mops.inr.ac.ru' => 'Alexey Kuznetsov',
'kuznet@ms2.inr.ac.ru' => 'Alexey Kuznetsov',
'ladis@psi.cz' => 'Ladislav Michl',
'laforge@gnumonks.org' => 'Harald Welte',
'laurent@latil.nom.fr' => 'Laurent Latil',
'lawrence@the-penguin.otak.com' => 'Lawrence Walton',
'ldb@ldb.ods.org' => 'Luca Barbieri',
'ldm@flatcap.org' => 'Richard Russon',
'lee@compucrew.com' => 'Lee Nash', # lbdb
'leigh@solinno.co.uk' => 'Leigh Brown', # lbdb
'levon@movementarian.org' => 'John Levon',
'linux@brodo.de' => 'Dominik Brodowski',
'lionel.bouton@inet6.fr' => 'Lionel Bouton',
'lists@mdiehl.de' => 'Martin Diehl',
'liyang@nerv.cx' => 'Liyang Hu',
'lm@bitmover.com' => 'Larry McVoy',
'lord@sgi.com' => 'Stephen Lord',
'lowekamp@cs.wm.edu' => 'Bruce B. Lowekamp', # lbdb
'luc.vanoostenryck@easynet.be' => 'Luc Van Oostenryck', # lbdb
'lucasvr@terra.com.br' => 'Lucas Correia Villa Real', # google
'maalanen@ra.abo.fi' => 'Marcus Alanen',
'mac@melware.de' => 'Armin Schindler',
'macro@ds2.pg.gda.pl' => 'Maciej W. Rozycki',
'manfred@colorfullife.com' => 'Manfred Spraul',
'manik@cisco.com' => 'Manik Raina',
'mannthey@us.ibm.com' => 'Keith Mannthey',
'marc@mbsi.ca' => 'Marc Boucher',
'marcel@holtmann.org' => 'Marcel Holtmann', # sent by himself
'marcelo@conectiva.com.br' => 'Marcelo Tosatti',
'marcelo@freak.distro.conectiva' => 'Marcelo Tosatti', # guessed
'marcelo@plucky.distro.conectiva' => 'Marcelo Tosatti',
'mark@alpha.dyndns.org' => 'Mark W. McClelland',
'mark@hal9000.dyndns.org' => 'Mark W. McClelland',
'markh@osdl.org' => 'Mark Haverkamp',
'martin.bligh@us.ibm.com' => 'Martin J. Bligh',
'martin@bruli.net' => 'Martin Brulisauer',
'martin@meltin.net' => 'Martin Schwenke',
'mason@suse.com' => 'Chris Mason',
'matt_domsch@dell.com' => 'Matt Domsch', # sent by himself
'matthew@wil.cx' => 'Matthew Wilcox',
'mauelshagen@sistina.com' => 'Heinz J. Mauelshagen',
'maxk@qualcomm.com' => 'Maksim Krasnyanskiy',
'maxk@viper.(none)' => 'Maksim Krasnyanskiy', # from shortlog
'maxk@viper.qualcomm.com' => 'Maksim Krasnyanskiy',
'mbligh@aracnet.com' => 'Martin J. Bligh',
'mcp@linux-systeme.de' => 'Marc-Christian Petersen',
'mdharm-scsi@one-eyed-alien.net' => 'Matthew Dharm',
'mdharm-usb@one-eyed-alien.net' => 'Matthew Dharm',
'mdharm@one-eyed-alien.net' => 'Matthew Dharm',
'mec@shout.net' => 'Michael Elizabeth Chastain',
'mgreer@mvista.com' => 'Mark A. Greer', # lbdb
'michaelw@foldr.org' => 'Michael Weber', # google
'michal@harddata.com' => 'Michal Jaegermann',
'mikep@linuxtr.net' => 'Mike Phillips',
'mikpe@csd.uu.se' => 'Mikael Pettersson',
'mikulas@artax.karlin.mff.cuni.cz' => 'Mikulas Patocka',
'miles@lsi.nec.co.jp' => 'Miles Bader',
'miles@megapathdsl.net' => 'Miles Lane',
'miltonm@bga.com' => 'Milton Miller', # by Kristian Peters
'mingo@elte.hu' => 'Ingo Molnar',
'mingo@redhat.com' => 'Ingo Molnar',
'mj@ucw.cz' => 'Martin Mares',
'mkp@mkp.net' => 'Martin K. Petersen', # lbdb
'mlang@delysid.org' => 'Mario Lang', # google
'mlindner@syskonnect.de' => 'Mirko Lindner',
'mmcclell@bigfoot.com' => 'Mark McClelland',
'mochel@geena.pdx.osdl.net' => 'Patrick Mochel',
'mochel@osdl.org' => 'Patrick Mochel',
'mochel@segfault.osdl.org' => 'Patrick Mochel',
'mostrows@speakeasy.net' => 'Michal Ostrowski',
'msw@redhat.com' => 'Matt Wilson',
'mufasa@sis.com.tw' => 'Mufasa Yang', # sent by himself
'mulix@actcom.co.il' => 'Muli Ben-Yehuda', # sent by himself
'mw@microdata-pos.de' => 'Michael Westermann',
'mzyngier@freesurf.fr' => 'Marc Zyngier',
'n0ano@n0ano.com' => 'Don Dugger',
'nahshon@actcom.co.il' => 'Itai Nahshon',
'nathans@sgi.com' => 'Nathan Scott',
'neilb@cse.unsw.edu.au' => 'Neil Brown',
'nemosoft@smcc.demon.nl' => 'Nemosoft Unv.',
'nico@cam.org' => 'Nicolas Pitre',
'nicolas.aspert@epfl.ch' => 'Nicolas Aspert',
'nicolas.mailhot@laposte.net' => 'Nicolas Mailhot',
'nkbj@image.dk' => 'Niels Kristian Bech Jensen',
'nmiell@attbi.com' => 'Nicholas Miell',
'okir@suse.de' => 'Olaf Kirch', # lbdb
'olaf.dietsche#list.linux-kernel@t-online.de' => 'Olaf Dietsche',
'olaf.dietsche' => 'Olaf Dietsche',
'oleg@tv-sign.ru' => 'Oleg Nesterov',
'olh@suse.de' => 'Olaf Hering',
'oliendm@us.ibm.com' => 'Dave Olien',
'oliver.neukum@lrz.uni-muenchen.de' => 'Oliver Neukum',
'oliver@neukum.name' => 'Oliver Neukum',
'oliver@neukum.org' => 'Oliver Neukum',
'orjan.friberg@axis.com' => 'Orjan Friberg',
'os@emlix.com' => 'Oskar Schirmer', # sent by himself
'otaylor@redhat.com' => 'Owen Taylor',
'p2@ace.ulyssis.sutdent.kuleuven.ac.be' => 'Peter De Shrijver',
'p_gortmaker@yahoo.com' => 'Paul Gortmaker',
'pasky@ucw.cz' => 'Petr Baudis',
'patmans@us.ibm.com' => 'Patrick Mansfield',
'paul.mundt@timesys.com' => 'Paul Mundt', # google
'paulkf@microgate.com' => 'Paul Fulghum',
'paulus@au1.ibm.com' => 'Paul Mackerras',
'paulus@nanango.paulus.ozlabs.org' => 'Paul Mackerras',
'paulus@quango.ozlabs.ibm.com' => 'Paul Mackerras',
'paulus@samba.org' => 'Paul Mackerras',
'pavel@janik.cz' => 'Pavel Jan�k',
'pavel@suse.cz' => 'Pavel Machek',
'pavel@ucw.cz' => 'Pavel Machek',
'pazke@orbita1.ru' => 'Andrey Panin',
'pbadari@us.ibm.com' => 'Badari Pulavarty',
'pdelaney@lsil.com' => 'Pam Delaney',
'pe1rxq@amsat.org' => 'Jeroen Vreeken',
'pekon@informatics.muni.cz' => 'Petr Konecny',
'perex@perex.cz' => 'Jaroslav Kysela',
'perex@pnote.perex-int.cz' => 'Jaroslav Kysela',
'perex@suse.cz' => 'Jaroslav Kysela',
'peter@cadcamlab.org' => 'Peter Samuelson',
'peter@chubb.wattle.id.au' => 'Peter Chubb',
'peterc@gelato.unsw.edu.au' => 'Peter Chubb',
'petero2@telia.com' => 'Peter Osterlund',
'petkan@tequila.dce.bg' => 'Petko Manolov',
'petkan@users.sourceforge.net' => 'Petko Manolov',
'petr@vandrovec.name' => 'Petr Vandrovec',
'petri.koistinen@iki.fi' => 'Petri Koistinen',
'pkot@linuxnews.pl' => 'Pawel Kot',
'plars@austin.ibm.com' => 'Paul Larson',
'pmenage@ensim.com' => 'Paul Menage',
'porter@cox.net' => 'Matt Porter',
'prom@berlin.ccc.de' => 'Ingo Albrecht',
'proski@gnu.org' => 'Pavel Roskin',
'pwaechtler@mac.com' => 'Peter W�chtler',
'quinlan@transmeta.com' => 'Daniel Quinlan',
'quintela@mandrakesoft.com' => 'Juan Quintela',
'r.e.wolff@bitwizard.nl' => 'Rogier Wolff', # lbdbq
'ralf@dea.linux-mips.net' => 'Ralf B�chle',
'ralf@linux-mips.org' => 'Ralf B�chle',
'randy.dunlap@verizon.net' => 'Randy Dunlap',
'ray-lk@madrabbit.org' => 'Ray Lee',
'rbh00@utsglobal.com' => 'Richard Hitt', # asked him, he prefers Richard
'rbt@mtlb.co.uk' => 'Robert Cardell',
'rct@gherkin.frus.com' => 'Bob Tracy',
'rddunlap@osdl.org' => 'Randy Dunlap',
'reality@delusion.de' => 'Udo A. Steinberg',
'reiser@namesys.com' => 'Hans Reiser',
'rem@osdl.org' => 'Bob Miller',
'rgooch@atnf.csiro.au' => 'Richard Gooch',
'rgooch@ras.ucalgary.ca' => 'Richard Gooch',
'rgs@linalco.com' => 'Roberto Gordo Saez',
'rhirst@linuxcare.com' => 'Richard Hirst',
'rhw@infradead.org' => 'Riley Williams',
'richard.brunner@amd.com' => 'Richard Brunner',
'riel@conectiva.com.br' => 'Rik van Riel',
'rl@hellgate.ch' => 'Roger Luethi',
'rlievin@free.fr' => 'Romain Lievin',
'rmk@arm.linux.org.uk' => 'Russell King',
'rmk@flint.arm.linux.org.uk' => 'Russell King',
'rml@tech9.net' => 'Robert Love',
'rob@osinvestor.com' => 'Rob Radez',
'robert.olsson@data.slu.se' => 'Robert Olsson',
'rohit.seth@intel.com' => 'Rohit Seth',
'roland@topspin.com' => 'Roland Dreier',
'romieu@cogenit.fr' => 'Fran�ois Romieu',
'root@viper.(none)' => 'Maxim Krasnyansky',
'rscott@attbi.com' => 'Rob Scott',
'rth@are.twiddle.net' => 'Richard Henderson',
'rth@dorothy.sfbay.redhat.com' => 'Richard Henderson',
'rth@dot.sfbay.redhat.com' => 'Richard Henderson',
'rth@splat.sfbay.redhat.com' => 'Richard Henderson',
'rth@twiddle.net' => 'Richard Henderson',
'rth@vsop.sfbay.redhat.com' => 'Richard Henderson',
'rui.sousa@laposte.net' => 'Rui Sousa',
'rusty@rustcorp.com.au' => 'Rusty Russell',
'rwhron@earthlink.net' => 'Randy Hron',
'rz@linux-m68k.org' => 'Richard Zidlicky',
'sabala@students.uiuc.edu' => 'Michal Sabala', # google
'sailer@scs.ch' => 'Thomas Sailer',
'sam@mars.ravnborg.org' => 'Sam Ravnborg',
'sam@ravnborg.org' => 'Sam Ravnborg',
'samel@mail.cz' => 'Vitezslav Samel',
'samuel.thibault@ens-lyon.fr' => 'Samuel Thibault',
'sandeen@sgi.com' => 'Eric Sandeen',
'santiago@newphoenix.net' => 'Santiago A. Nullo', # sent by self
'sarolaht@cs.helsinki.fi' => 'Pasi Sarolahti',
'sawa@yamamoto.gr.jp' => 'sawa',
'schoenfr@gaaertner.de' => 'Erik Schoenfelder',
'schwab@suse.de' => 'Andreas Schwab',
'schwidefsky@de.ibm.com' => 'Martin Schwidefsky',
'scott.feldman@intel.com' => 'Scott Feldman',
'scott_anderson@mvista.com' => 'Scott Anderson',
'scottm@somanetworks.com' => 'Scott Murray',
'sct@redhat.com' => 'Stephen C. Tweedie',
'sds@tislabs.com' => 'Stephen Smalley',
'sebastian.droege@gmx.de' => 'Sebastian Dr�ge',
'sfr@canb.auug.org.au' => 'Stephen Rothwell',
'shaggy@austin.ibm.com' => 'Dave Kleikamp',
'shaggy@kleikamp.austin.ibm.com' => 'Dave Kleikamp',
'shaggy@shaggy.austin.ibm.com' => 'Dave Kleikamp', # lbdb
'shingchuang@via.com.tw' => 'Shing Chuang',
'silicon@falcon.sch.bme.hu' => 'Szil�rd P�sztor', # google
'simonb@lipsyncpost.co.uk' => 'Simon Burley',
'skip.ford@verizon.net' => 'Skip Ford',
'sl@lineo.com' => 'Stuart Lynne',
'smurf@osdl.org' => 'Nathan Dabney',
'snailtalk@linux-mandrake.com' => 'Geoffrey Lee', # by himself
'solar@openwall.com' => 'Solar Designer',
'sparker@sun.com' => 'Steven Parker', # by Duncan Laurie
'spse@secret.org.uk' => 'Simon Evans', # by Kristian Peters
'sridhar@dyn9-47-18-140.beaverton.ibm.com' => 'Sridhar Samudrala',
'srompf@isg.de' => 'Stefan Rompf',
'steiner@sgi.com' => 'Jack Steiner',
'stelian.pop@fr.alcove.com' => 'Stelian Pop',
'stelian@popies.net' => 'Stelian Pop',
'stern@rowland.harvard.edu' => 'Alan Stern',
'stern@rowland.org' => 'Alan Stern', # lbdb
'steve.cameron@hp.com' => 'Stephen Cameron',
'steve@chygwyn.com' => 'Steven Whitehouse',
'steve@gw.chygwyn.com' => 'Steven Whitehouse',
'stevef@smfhome1.austin.rr.com' => 'Steve French',
'stevef@steveft21.ltcsamba' => 'Steve French',
'stuartm@connecttech.com' => 'Stuart MacDonald',
'sullivan@austin.ibm.com' => 'Mike Sullivan',
'suncobalt.adm@hostme.bitkeeper.com' => 'Tim Hockin', # by Duncan Laurie
'sunil.saxena@intel.com' => 'Sunil Saxena',
'swanson@uklinux.net' => 'Alan Swanson',
'szepe@pinerecords.com' => 'Tomas Szepe',
't-kouchi@mvf.biglobe.ne.jp' => 'Takayoshi Kouchi',
'tai@imasy.or.jp' => 'Taisuke Yamada',
'tao@acc.umu.se' => 'David Weinehall', # by himself
'tao@kernel.org' => 'David Weinehall', # by himself
'taka@valinux.co.jp' => 'Hirokazu Takahashi',
'tcallawa@redhat.com' => 'Tom Callaway',
'tetapi@utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
'th122948@scl1.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
'th122948@scl3.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
'thiel@ksan.de' => 'Florian Thiel', # lbdb
'thockin@freakshow.cobalt.com' => 'Tim Hockin',
'thockin@sun.com' => 'Tim Hockin',
'tigran@aivazian.name' => 'Tigran Aivazian',
'tim@physik3.uni-rostock.de' => 'Tim Schmielau',
'tmolina@cox.net' => 'Thomas Molina',
'tomita@cinet.co.jp' => 'Osamu Tomita',
'tomlins@cam.org' => 'Ed Tomlinson',
'tony.luck@intel.com' => 'Tony Luck',
'tony@cantech.net.au' => 'Anthony J. Breeds-Taurima',
'torvalds@athlon.transmeta.com' => 'Linus Torvalds',
'torvalds@home.transmeta.com' => 'Linus Torvalds',
'torvalds@kiwi.transmeta.com' => 'Linus Torvalds',
'torvalds@penguin.transmeta.com' => 'Linus Torvalds',
'torvalds@tove.transmeta.com' => 'Linus Torvalds',
'torvalds@transmeta.com' => 'Linus Torvalds',
'trini@bill-the-cat.bloom.county' => 'Tom Rini',
'trini@kernel.crashing.org' => 'Tom Rini',
'trond.myklebust@fys.uio.no' => 'Trond Myklebust',
'tvignaud@mandrakesoft.com' => 'Thierry Vignaud',
'twaugh@redhat.com' => 'Tim Waugh',
'tytso@mit.edu' => "Theodore Ts'o", # web.mit.edu/tytso/www/home.html
'tytso@snap.thunk.org' => "Theodore Ts'o",
'tytso@think.thunk.org' => "Theodore Ts'o", # guessed
'urban@teststation.com' => 'Urban Widmark',
'uzi@uzix.org' => 'Joshua Uziel',
'vandrove@vc.cvut.cz' => 'Petr Vandrovec',
'varenet@parisc-linux.org' => 'Thibaut Varene',
'venkatesh.pallipadi@intel.com' => 'Venkatesh Pallipadi',
'viro@math.psu.edu' => 'Alexander Viro',
'vojta@math.berkeley.edu' => 'Paul Vojta',
'vojtech@suse.cz' => 'Vojtech Pavlik',
'vojtech@twilight.ucw.cz' => 'Vojtech Pavlik',
'vojtech@ucw.cz' => 'Vojtech Pavlik', # added by himself
'wa@almesberger.net' => 'Werner Almesberger',
'wes@infosink.com' => 'Wes Schreiner',
'wg@malloc.de' => 'Wolfram Gloger', # lbdb
'willy@debian.org' => 'Matthew Wilcox',
'willy@w.ods.org' => 'Willy Tarreau',
'wilsonc@abocom.com.tw' => 'Wilson Chen', # google
'wim@iguana.be' => 'Wim Van Sebroeck',
'wli@holomorphy.com' => 'William Lee Irwin III',
'wolfgang.fritz@gmx.net' => 'Wolfgang Fritz', # by Kristian Peters
'wolfgang@iksw-muees.de' => 'Wolfgang Muees',
'wstinson@infonie.fr' => 'William Stinson',
'xkaspa06@stud.fee.vutbr.cz' => 'Tomas Kasparek',
'yokota@netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
'yoshfuji@linux-ipv6.org' => 'Hideaki Yoshifuji', # lbdb
'yuri@acronis.com' => 'Yuri Per', # lbdb
'zaitcev@redhat.com' => 'Pete Zaitcev',
'zippel@linux-m68k.org' => 'Roman Zippel',
'zubarev@us.ibm.com' => 'Irene Zubarev', # google
'zwane@commfireservices.com' => 'Zwane Mwaikambo',
'zwane@holomorphy.com' => 'Zwane Mwaikambo',
'zwane@linuxpower.ca' => 'Zwane Mwaikambo',
'zwane@mwaikambo.name' => 'Zwane Mwaikambo',
'~~~~~~thisentrylastforconvenience~~~~~' => 'Cesar Brutus Anonymous'
);

sub doprint(\%@ ); # forward declaration

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
  return unless @cur;
  return unless &$indexby;
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
      # defined $address trick lets this only trigger to switch back
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

# === MAIN PROGRAM ===============================================
# Command line arguments
# What options do we support?
my @opts = ("help|?|h", "man", "mode=s", "compress!", "count!", "width:i",
	    "swap!", "merge!", "warn!", "multi!", "abbreviate-names!",
	    "by-surname!");
#	    "bitkeeper|bk!");

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
  if (not $opt{bitkeeper} and (@ARGV == 0) and (-t STDIN));
pod2usage(-verbose => 0,
	  -message => "$0: Must have one or two arguments in --bitkeeper mode.")
  if ($opt{bitkeeper} && (@ARGV < 1 || @ARGV > 2));
pod2usage(-verbose => 0,
	  -message => "$0: You cannot use --merge and --multi at the same time.")
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
# Revision 0.58  2002/12/07 15:14:57  emma
# More addresses figured by Vitetzslav Samel.
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

=head1 AUTHOR

=over

=item * Matthias Andree <matthias.andree@gmx.de>

Main developer

=item * Marcus Alanen <maalanen@abo.fi>

=item * Tomas Szepe <szepe@pinerecords.com>

=item * Further help from:

Albert D. Cahalan <acahalan@cs.uml.edu>, Robinson Maureira Castillo
<rmaureira@alumno.inacap.cl>, Greg Kroah-Hartman <greg@kroah.com>.

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

=item * See if the map can be made to use or accompanied by regexp.

=back

=cut

