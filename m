Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266005AbUF2UIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbUF2UIJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 16:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266000AbUF2UIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 16:08:09 -0400
Received: from web41504.mail.yahoo.com ([66.218.93.87]:59740 "HELO
	web41504.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266010AbUF2UF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 16:05:26 -0400
Message-ID: <20040629200525.25773.qmail@web41504.mail.yahoo.com>
Date: Tue, 29 Jun 2004 13:05:25 -0700 (PDT)
From: Brian <bmg300@yahoo.com>
Subject: Re: Kernel VM bug?
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040628025832.GM21066@holomorphy.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2102131088-1088539525=:25322"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-2102131088-1088539525=:25322
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

GRASS also has problems on the 2.6.7 kernel.

My system is an Athlon-XP with 512MB RAM running Slackware 10.0.0 (kernel 2.4.26) full
installation in X windows with minimal window manager and minimal other processes.

To reproduce:
Download the NASA blue marble from
(ftp://mitch.gsfc.nasa.gov/pub/stockli/bluemarble/MOD09A1.W.interpol.cyl.retouched.topo.bathymetry.3x21600x21600.gz)
and use netpbm to convert the RAW RGB to a PPM.
'cat bluemarble.gz | gzip -dc | rawtoppm 21600 21600 > bluemarble.W.ppm'

Compile and install grass CVS as of June 28 2004 20:20:00 UTC or use attached bash shell script.

Create a new grass location, let's say with a location name of 'tiger' and a mapset name of
'brian' (use space to delete if compiled without readline support). Make sure the database
directory is set and it already exists. Answer 'yes' until you get asked to select the coordinate
system. Select coordinate system B, longitude latitude. Keep answering until you get asked to
select a geodatic datum, use 'wgs84' as the datum. Type '1' when asked for the datum
transformation parameters. For north edge type 50N, south edge type 23N, west edge 125W, east edge
70W, both east west and north south resolution of 0.00222222.

Create a new location, let's say with a location name of 'blue.w_loc' and the mapset MUST be
'PERMANENT'. The rest is the same until the default region. Set those to north 90N, south 90S,
west 180W, east 0W, and both grid resolutions to 0.00833333.

Restart GRASS and choose the 'blue.w_loc'/'PERMANENT' location/mapset. Import the bluemarble PPM
using r.in.ppm and use the create separate red/green/blue maps command line option "-b"
'r.in.ppm -bv input=<path to blue marble ppm> output=bluemarble.w'.

Restart GRASS and use the the 'tiger'/'brian' location/mapset.
Project the bluemarble maps until the filesystem cache fills up and something bad happens. Might
take a few tries.
'r.proj input=bluemarble.w.r location=blue.w_loc mapset=PERMANENT method=cubic;r.proj
input=bluemarble.w.g location=blue.w_loc mapset=PERMANENT method=cubic;r.proj input=bluemarble.w.b
location=blue.w_loc mapset=PERMANENT method=cubic'

Brian

--- William Lee Irwin III <wli@holomorphy.com> wrote:
> To investigate what may have happened in 2.4, it may be helpful for us
> to be able to run GRASS on a similar data set (IIRC it is open source
> and freely available for download) and to arrange for testing on a
> similar machine, which by and large we can arrange for ourselves given
> a sufficiently detailed description.
> 
> Thanks.
> 
> -- wli


		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail
--0-2102131088-1088539525=:25322
Content-Type: text/x-sh; name="build_grass.sh"
Content-Description: build_grass.sh
Content-Disposition: inline; filename="build_grass.sh"

#!/bin/bash
mkdir $HOME/grassroot|| exit
cd $HOME/grassroot

#Checkout grass
echo "Password is grass"
cvs -d:pserver:grass-guest@intevation.de:/home/grass/grassrepository login
cvs -d:pserver:grass-guest@intevation.de:/home/grass/grassrepository -z3 checkout -D "28 Jun 2004 20:20" grass

#Get grass dependencies
cd $HOME/grassroot
echo "Getting fftw-2.1.5..."
wget http://www.fftw.org/fftw-2.1.5.tar.gz
tar -xzf fftw-2.1.5.tar.gz
echo "Getting proj4..."
wget --passive-ftp ftp://ftp.remotesensing.org/pub/proj/proj-4.4.8.tar.gz
tar -xzf proj-4.4.8.tar.gz
echo "Getting gdal-1.2.1..."
wget --passive-ftp ftp://ftp.remotesensing.org/gdal/gdal-1.2.1.tar.gz
tar -xzf gdal-1.2.1.tar.gz

#Compile dependencies
cd $HOME/grassroot
cd fftw-2.1.5
./configure --prefix=/opt/grass &&
make || exit
echo "Need root password"
su -c "make install"

cd $HOME/grassroot
cd proj-4.4.8
./configure --prefix=/opt/grass &&
make || exit
echo "Need root password"
su -c "make install"

cd $HOME/grassroot
cd gdal-1.2.1
./configure --prefix=/opt/grass &&
make || exit
echo "Need root password"
su -c "make install"

#Compile grass
cd $HOME/grassroot
cd grass
PATH="/opt/grass/bin":$PATH ./configure --prefix=/opt/grass --with-proj-includes=/opt/grass/include/ --with-proj-libs=/opt/grass/lib/ --with-fftw-libs=/opt/grass/lib --with-fftw-includes=/opt/grass/include/ --without-postgres --without-odbc &&
make || exit
echo "Need root password"
su -c "make install"

--0-2102131088-1088539525=:25322--
