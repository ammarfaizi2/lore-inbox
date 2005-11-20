Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVKTDZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVKTDZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 22:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbVKTDZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 22:25:57 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:24773
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750787AbVKTDZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 22:25:56 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: linux-kernel@vger.kernel.org
Subject: Re: Quick and dirty miniconfig howto, with feature suggestions.
Date: Sat, 19 Nov 2005 21:25:37 -0600
User-Agent: KMail/1.8
Cc: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>
References: <200511170629.42389.rob@landley.net>
In-Reply-To: <200511170629.42389.rob@landley.net>
MIME-Version: 1.0
Message-Id: <200511192125.37630.rob@landley.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xy+fDVcg8zOzL+5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_xy+fDVcg8zOzL+5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 17 November 2005 06:29, Rob Landley wrote:
> --- What is a miniconfig?
>
> A new feature of 2.6.15 lets you use miniature configuration files, listing
> just the symbols you want to enable and letting the configurator enable any
> dependencies to give you a valid configuration.
>
> To make it work, create a mini.config file and run allnoconfig (to create
> a .config file with all unspecified symbols switched off) with the extra
> argument "KCONFIG_ALLCONFIG=mini.config".

And here's a shell script that will automatically create a mini.conf from a 
standard .config file.

It does this via the simple expedient of trying to remove each line and seeing 
which ones make any difference to the generated .config.  (This means it runs 
make allnoconfig about 1300 times.  This is very very slow, so it displays a 
progress indicator.)

To use the script, go into the kernel source directory, create your .config 
file (via menuconfig or however), rename that .config file to something else 
(like "myconfig"), then run the script like so:

./miniconfig.sh myconfig

(Note you still have to be in the directory where the script can run "make 
allnoconfig".)  When it finishes, you should have a mini.conf containing the 
minimal set  of lines necessary to specify that configuration via
"make KCONFIG_ALLCONFIG=mini.config allnoconfig".

I'm sure there's a better way to do this, but this works now.

Rob

--Boundary-00=_xy+fDVcg8zOzL+5
Content-Type: application/x-shellscript;
  name="miniconf.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="miniconf.sh"

#!/bin/sh

# miniconf.sh copyright 2005 by Rob Landley <rob@landley.net>
# Licensed under the GNU General Public License version 2.

if [ $# -ne 1 ] || [ ! -f "$1" ]
then
  echo "Usage: miniconf.sh configfile" 
fi

if [ "$1" == ".config" ]
then
  echo "It overwrites .config, rename it and try again."
  exit 1
fi

cp $1 mini.conf
echo "Calculating mini.conf..."

LENGTH=`cat $1 | wc -l`

# Loop through all lines in the file 
I=1
while true
do
  if [ $I -gt $LENGTH ]
  then
    exit
  fi
  sed -n "${I}!p" mini.conf > .config.test
  # Do a config with this file
  make allnoconfig KCONFIG_ALLCONFIG=.config.test > /dev/null

  # Compare, skipping first 5 lines which contain changeable date.
  D=`diff .config $1 | wc -l`
  if [ $D -eq 4 ]
  then
    mv .config.test mini.conf
    LENGTH=$[$LENGTH-1]
  else
    I=$[$I + 1]
  fi
  echo -n -e $I/$LENGTH lines `cat mini.conf | wc -c` bytes "\r"
done
echo

--Boundary-00=_xy+fDVcg8zOzL+5--
