Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVCMLab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVCMLab (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 06:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVCMLaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 06:30:30 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:44408 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261154AbVCMLaK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 06:30:10 -0500
Date: Sun, 13 Mar 2005 12:31:33 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Martin Waitz <tali@admingilde.org>
Subject: Re: script to send changesets per mail
Message-ID: <20050313113133.GA8083@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
References: <20050303105950.GH8617@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303105950.GH8617@admingilde.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 11:59:50AM +0100, Martin Waitz wrote:
> hoi :)
> 
> I just tested my little script that can send changesets per mail.
> okok, it still had a bug when I first tested it but that should be
> fixed now.

Greg has a similar script - could you take a look and tell
which is the better (and why). We only want one in the kernel.

It is attached.

	Sam
	
send_lots_of_emails.pl:

#!/usr/bin/perl -w

# horrible hack of a script to send off a large number of email messages, one after
# each other, all chained together.  This is useful for large numbers of patches.
#
# Use at your own risk!!!!
#
# greg kroah-hartman Jan 8, 2002
# <greg@kroah.com>a
# 
# updated to give a valid subject and CC the owner of the patch - Jan 2005
# 

# change this to your email address.
$from = "SOMEONE <someone\@somewhere.com>";

# modify these options each time you run the script
$to = 'linux-kernel@vger.kernel.org';
$initial_reply_to = '<20050203173208.GA23964@foobar.com>';
$initial_subject = "[PATCH] XXX fixes for 2.6.11-rc3";
@files = (
"rev-1.2041.patch",
"rev-1.2042.patch",
"rev-1.2043.patch",
"rev-1.2044.patch",
"rev-1.2045.patch",
"rev-1.2046.patch",
);

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
	$message_id = "<$date$pseudo_rand\@kroah.com>";
	print "new message id = $message_id\n";
}



$cc = "";

sub send_message
{
	%mail = (	To	=>	$to,
			From	=>	$from,
			CC	=>	$cc,
			Subject	=>	$subject,
			Message	=>	$message,
			'Reply-to'	=>	"Greg K-H <greg\@kroah.com>",
			'In-Reply-To'	=>	$reply_to,
			'Message-ID'	=>	$message_id,
			'X-Mailer'	=>	"gregkh_patchbomb",
		);

	$mail{smtp} = 'localhost';

	sendmail(%mail) or die $Mail::Sendmail::error;

	print "OK. Log says:\n", $Mail::Sendmail::log;
	print "\n\n"
}


$reply_to = $initial_reply_to;
make_message_id();
$subject = $initial_subject;

foreach $t (@files) {
	$F = $t;
	open F or die "can't open file $t";

	# first line is the CC: list
	$cc = <F>;
	print "cc: $cc";
	
	# second line is the Subject:
	$subject = <F>;
	print "subject: $subject";

	undef $/;
	$message = <F>;	# slurp the whole file in
	close F;
	$/ = "\n";
	send_message();

	# set up for the next message
	$reply_to = $message_id;
	make_message_id();
#	$subject = "Re: ".$initial_subject;
}

