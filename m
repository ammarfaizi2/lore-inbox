Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTJ3MXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 07:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbTJ3MXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 07:23:16 -0500
Received: from mail.convergence.de ([212.84.236.4]:5043 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262410AbTJ3MXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 07:23:06 -0500
Message-ID: <3FA1029B.9030106@convergence.de>
Date: Thu, 30 Oct 2003 13:22:51 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Need script for submitting multi-part patches
References: <3289.1067514507@ocs3.intra.ocs.com.au>
In-Reply-To: <3289.1067514507@ocs3.intra.ocs.com.au>
Content-Type: multipart/mixed;
 boundary="------------090800070006020907020700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090800070006020907020700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Keith,

> Several weeks ago, somebody mailed a script for submitting multi-part
> patches (e.g. [patch 3/12]) and automatically threading them.  Searc
> via google and browsing the kernel archives has failed to find it, does
> anybody have a URL?

IIRC it was posted on lkml a few months ago as a response to one of my 
DVB patches.

I picked it up and modified it to fit my needs. I attached it to this 
mail. Have fun!

CU
Michael.

--------------090800070006020907020700
Content-Type: text/plain;
 name="linus_send"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linus_send"

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
#$to = 'torvalds@osdl.org';
$to = 'torvalds@osdl.org, linux-kernel@vger.kernel.org';
#$to = 'linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org';

# If you want to chain the first post, fill this in
$initial_reply_to = '';

# a list of patches to send out, last parameter specifies if message should
# *not* be send, ie. in case of a binary firmware blob, so you can send it out
# manually
@files = (
["00-DVB-LinuxTV.org-CVS-update","LinuxTV.org DVB+V4L fixes" ,"0"],
["01-DVB-important-DVB-fixes.diff","Fix bugs in various DVB drivers","0"],
["02-V4L-saa7146-analog-tv-fix.diff","Fix bug in saa7146 analog tv i2c-handling","0"],
["03-V4L-i2c-helper-fix.diff","Fix bugs in analog tv i2c-helper chipset drivers","0"],
);

#["","","0"],
  
#  Put your name and address here
$from = "Michael Hunold <hunold\@linuxtv.org>";

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
	$message_id = "<$date$pseudo_rand\@convergence.de>";
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

	$mail{smtp} = 'mail';

	sendmail(%mail) or die $Mail::Sendmail::error;

	print "OK. Log says:\n", $Mail::Sendmail::log;
	print "\n\n"
}

$reply_to = $initial_reply_to;
make_message_id();

# Linus wants a [0/xx] mail with a summary description...
$nrfiles = @files-1;
$current = 0;

foreach $t (@files) {
	($F, $subj, $skip) = @$t;

	if ( $skip eq "0" ) {
		open F or die "can't open file $F";
		undef $/;
		$message = <F>;	# slurp the whole file in
		close F;
		$/ = "\n";
		$subject = "[PATCH $current/$nrfiles] $subj";
		send_message();
		$reply_to = $message_id;
		make_message_id();
	}
	
	# set up for the next message
	$current++;
}




--------------090800070006020907020700--

