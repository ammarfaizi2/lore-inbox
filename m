Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266021AbUAFAjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265990AbUAFAhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:37:02 -0500
Received: from mail.kroah.org ([65.200.24.183]:32435 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266021AbUAFAge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:36:34 -0500
Date: Mon, 5 Jan 2004 16:36:14 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>,
       linux-hotplug-devel@lists.sourceforge.net
Cc: Andries Brouwer <aebr@win.tue.nl>, Daniel Jacobowitz <dan@debian.org>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
Subject: Silly udev script [was Re: udev and devfs - The final word]
Message-ID: <20040106003614.GA1043@kroah.com>
References: <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105132756.A975@pclin040.win.tue.nl> <Pine.LNX.4.58.0401050749490.21265@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401050749490.21265@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 08:13:26AM -0800, Linus Torvalds wrote:
> 
> For example, if you wanted to, you could make udev do a cddb lookup on the
> CD-ROM, and use that as the pathname, so that when you insert your
> favorite audio disk, it will always show up in the same place, regardless 
> of whether you put it in the DVD slot or the CD-RW drive. 
> 
> [ Yeah, that sounds like a singularly silly thing to do, but it's a good 
>   example of something where there is no actual serial number, but you can 
>   "identify" it automatically through its contents, and name it stably 
>   according to that. ]

That was such a silly thing to do, here's a script that does it, along
with the udev rule to add to udev.rules for it.  It names your cdrom
Artist_Title, and creates a symlink called cdrom that points to it, just
to be a tiny bit sane :)

I had been saying for a long time that you could have udev make a query
across the network to get a device name, this provides the perfect
example of just that...

thanks,

greg k-h


#!/usr/bin/perl

# a horribly funny script that shows how flexible udev can really be
# This is to be executed by udev with the following rules:
# CALLOUT, BUS="ide", PROGRAM="name_cdrom.pl %M %m", ID="good*", NAME="%1c", SYMLINK="cdrom" 
# CALLOUT, BUS="scsi", PROGRAM="name_cdrom.pl %M %m", ID="good*", NAME="%1c", SYMLINK="cdrom" 
#
# The scsi rule catches USB cdroms and ide-scsi devices.
#

use CDDB_get qw( get_cddb );

my %config;

$dev_node = "/tmp/cd_foo";

# following variables just need to be declared if different from defaults
$config{CDDB_HOST}="freedb.freedb.org";        # set cddb host
$config{CDDB_PORT}=8880;                       # set cddb port
$config{CDDB_MODE}="cddb";			# set cddb mode: cddb or http
$config{CD_DEVICE}="$dev_node";			# set cd device

# No user interaction, this is a automated script!
$config{input}=0;

$major = $ARGV[0];
$minor = $ARGV[1];

# create our temp device node to read the cd info from
if (system("mknod $dev_node b $major $minor")) {
       die "bad mknod failed";
       }

# get it on
my %cd=get_cddb(\%config);

# remove the dev node we just created
unlink($dev_node);

# print out our cd name if we have found it
unless(defined $cd{title}) {
	print"bad unknown cdrom\n";
} else {
	print "good $cd{artist}_$cd{title}\n";
}
