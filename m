Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbTFRP7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 11:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265330AbTFRP7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 11:59:00 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:28422 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S265326AbTFRP65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 11:58:57 -0400
Date: Wed, 18 Jun 2003 17:12:54 +0100
From: John Levon <levon@movementarian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Michael Hunold <hunold@convergence.de>, linux-kernel@vger.kernel.org,
       Holger Waechtler <holger@convergence.de>,
       Johannes Stezenbach via CVS <js@convergence.de>
Subject: Re: DVB updates, 3rd try
Message-ID: <20030618161253.GA53261@compsoc.man.ac.uk>
References: <3EF051AF.1060006@convergence.de> <Pine.LNX.4.44.0306180849150.9782-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306180849150.9782-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19SfYM-0004Cg-B0*nFv2BwEXsek*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 08:58:43AM -0700, Linus Torvalds wrote:

> 	[DVB PATCH 1/9] Replace frobutomic counter with sequence numbers

People might find the below script (hacked from gregkh's version) useful
for doing this. Should be fairly obvious.

regards,
john

#!/usr/bin/perl -w

# horrible hack of a script to send off a large number of email messages, one after
# each other, all chained together.  This is useful for large numbers of patches.
#
# Use at your own risk!!!!
#
# greg kroah-hartman Jan 8, 2002
# <greg@kroah.com>
#
# Released under the artistic license.
#

#
# modify these options each time you run the script
#
#$to = 'torvalds@transmeta.com, linux-kernel@vger.kernel.org';
$to = 'levon@movementarian.org';

# If you want to chain the first post, fill this in
$initial_reply_to = '';

# a list of patches to send out
@files = (
["shutdown.diff", "OProfile: small NMI shutdown fix"],
["ioapic.diff", "OProfile: IO-APIC based NMI delivery"],
["exec.diff", "OProfile: thread switching performance fix"],
);

# Put your name and address here
$from = "John Levon <levon\@movementarian.org>";

# Don't need to change anything below here...

use Mail::Sendmail;


# we make a "fake" message id by taking the current number
# of seconds since the beginning of Unix time and tacking on
# a random number to the end, in case we are called quicker than
# 1 second since the last time we were called.
sub make_message_id
{
	my $date = `date "+\%s"`;
	chomp($date);
	my $pseudo_rand = int (rand(4200));
	$message_id = "<$date$pseudo_rand\@movementarian.org>";
	print "new message id = $message_id\n";
}





sub send_message
{
	%mail = (	To	=>	$to,
			From	=>	$from,
			Subject	=>	$subject,
			Message	=>	$message,
			'In-Reply-To'	=>	$reply_to,
			'Message-ID'	=>	$message_id,
			'X-Mailer'	=> "gregkh_patchbomb_levon_offspring",
		);

	$mail{smtp} = 'localhost';

	sendmail(%mail) or die $Mail::Sendmail::error;

	print "OK. Log says:\n", $Mail::Sendmail::log;
	print "\n\n"
}


$reply_to = $initial_reply_to;
make_message_id();
$nrfiles = @files;
$current = 1;

foreach $t (@files) {
	($F, $subj) = @$t;
	open F or die "can't open file $t";
	undef $/;
	$message = <F>;	# slurp the whole file in
	close F;
	$/ = "\n";
	$subject = "[PATCH $current/$nrfiles] $subj";
	send_message();

	# set up for the next message
	$reply_to = $message_id;
	make_message_id();
	$current++;
}


