Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVELStj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVELStj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 14:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVELStj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 14:49:39 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:48524 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261252AbVELStU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 14:49:20 -0400
Subject: Re: Automatic .config generation
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Cc: linux-kernel@vger.kernel.org, Scott Robert Ladd <lkml@coyotegulch.com>,
       jmerkey <jmerkey@utah-nac.org>
In-Reply-To: <42839EAC.3070802@tiscali.de>
References: <42839AF7.4030708@coyotegulch.com>
	 <42838D4C.3040207@utah-nac.org>  <42839EAC.3070802@tiscali.de>
Content-Type: multipart/mixed; boundary="=-0tx1Ssdvi/TuHQ3r86ZG"
Organization: Kihon Technologies
Date: Thu, 12 May 2005 14:49:06 -0400
Message-Id: <1115923746.7125.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0tx1Ssdvi/TuHQ3r86ZG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-05-12 at 20:21 +0200, Matthias-Christian Ott wrote:
> jmerkey wrote:
> > Scott Robert Ladd wrote:
> > 
> > Now that's a great idea ..... :-)
> > Jeff
> > 
> >> Is there a utility that creates a .config based on analysis of the
> >> target system?
> >> -

This probably isn't what you are looking for, but I posted this a while
back, and have found this useful for myself.  

I wrote a simple perl script (attached) to turn off all the modules that
are not being used on the current system. Obviously if you have a USB
device that's not attached, it would get turned off too. But this was
nice to see what modules I actually needed to get a system running.

You first compile the kernel with the default distribution .config.
Then run this script in the directory of the kernel that's running, and
has that .config available. The output of a .config with all non
necessary modules turned off is sent to standard output.

-- Steve


--=-0tx1Ssdvi/TuHQ3r86ZG
Content-Disposition: attachment; filename=streamline_config.pl
Content-Type: application/x-perl; name=streamline_config.pl
Content-Transfer-Encoding: 7bit

#!/usr/bin/perl -w
#
# Copywrite 2005 - Steven Rostedt
#
# This code has no restrictions and NO WARRANTY. 
#  Use it at your own risk, do what you want with it,
#  Just don't blame me.
#
#  It's simple enough to figure out how this works.
#  If not, then you can ask me at stripconfig@goodmis.org
#  
# What it does?
#
#   If you have installed a Linux kernel from a distribution
#   that turns on way too many modules than you need, and 
#   you only want the modules you use, than this program
#   is perfect for you.
#
#   It gives you the ability to turn off all the modules that are
#   not loaded on your system. 
#
# Howto:
#
#  1. Boot up the kernel that you want to stream line the config on.
#  2. Change directory to the directory holding the source of the 
#       kernel that you just booted.
#  3. Copy the configuraton file to this directory as .config
#  4. Have all your devices that you need modules for connected and
#      operational (make sure that their corresponding modules are loaded)
#  5. Run this script redirecting the output to some other file
#       like config_strip.
#  6. Back up your old config (if you want too).
#  7. copy the config_strip file to .config
#  8. Run "make oldconfig"
#  
#  Now your kernel is ready to be built with only the modules that
#  are loaded.
#
# Here's what I did with my Debian distribution.
#
#    cd /usr/src/linux-2.6.10
#    cp /boot/config-2.6.10-1-686-smp .config
#    ~/bin/streamline_config > config_strip
#    mv .config config_sav
#    mv config_strip .config
#    make oldconfig
# 
my $config = ".config";
my $linuxpath = ".";

open(CIN,$config) || die "Can't open current config file: $config";
my @makefiles = `find $linuxpath -name Makefile`;

my %objects;
my $var;
my $cont = 0;

foreach my $makefile (@makefiles) {
	chomp $makefile;
	
	open(MIN,$makefile) || die "Can't open $makefile";
	while (<MIN>) {
		my $catch = 0;
		
		if ($cont && /(\S.*)$/) {
			$objs = $1;
			$catch = 1;
		}
		$cont = 0;
		
		if (/obj-\$\((CONFIG_[^)]*)\)\s*[+:]?=\s*(.*)/) {
			$var = $1;
			$objs = $2;
			$catch = 1;
		}
		if ($catch) {
			if ($objs =~ m,(.*)/$,) {
				$objs = $1;
				$cont = 1;
			}
			
			foreach my $obj (split /\s+/,$objs) {
				$obj =~ s/-/_/g;
				if ($obj =~ /(.*)\.o$/) {
					$objects{$1} = $var;
				}
			}
		}
	}
	close(MIN);
}

my %modules;

open(LIN,"/sbin/lsmod|") || die "Cant lsmod";
while (<LIN>) {
	next if (/^Module/);  # Skip the first line.
	if (/^(\S+)/) {
		$modules{$1} = 1;
	}
}
close (LIN);

my %configs;
foreach my $module (keys(%modules)) {
	if (defined($objects{$module})) {
		$configs{$objects{$module}} = $module;
	} else {
		print STDERR "$module config not found!!\n";
	}
}

while(<CIN>) {
	if (/^(CONFIG.*)=m/) {
		if (defined($configs{$1})) {
			print;
		} else {
			print "# $1 is not set\n";
		}
	} else {
		print;
	}
}
close(CIN);

--=-0tx1Ssdvi/TuHQ3r86ZG--

