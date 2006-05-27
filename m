Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWE0ER6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWE0ER6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 00:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWE0ER6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 00:17:58 -0400
Received: from terminus.zytor.com ([192.83.249.54]:28037 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751376AbWE0ER6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 00:17:58 -0400
Message-ID: <4477D2D9.5050001@zytor.com>
Date: Fri, 26 May 2006 21:17:29 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
References: <4477B905.9090806@garzik.org>
In-Reply-To: <4477B905.9090806@garzik.org>
Content-Type: multipart/mixed;
 boundary="------------070209010509020608080307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070209010509020608080307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> 
> Attached to this email is chomp.pl, a Perl script which removes trailing 
> whitespace from several files.  I've had this for years, as trailing 
> whitespace is one of my pet peeves.
> 
> Now that git-applymbox complains loudly whenever a patch adds trailing 
> whitespace, I figured this script may be useful to others.
> 

This is the script I use for the same purpose.  It's a bit more 
sophisticated, in that it detects and avoids binary files, and doesn't 
throw an error if it encounters a directory (which can happen if you 
give it a wildcard.)

	-hpa

--------------070209010509020608080307
Content-Type: text/plain;
 name="cleanfile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cleanfile"

#!/usr/bin/perl
#
# Clean a text file of stealth whitespace
#

use bytes;

$name = 'cleanfile';

foreach $f ( @ARGV ) {
    print STDERR "$name: $f\n";

    if (! -f $f) {
	print STDERR "$f: not a file\n";
	next;
    }
    
    if (!open(FILE, '+<', $f)) {
	print STDERR "$name: Cannot open file: $f: $!\n";
	next;
    }

    binmode FILE;

    # First, verify that it is not a binary file
    $is_binary = 0;

    while (read(FILE, $data, 65536) > 0) {
	if ($data =~ /\0/) {
	    $is_binary = 1;
	    last;
	}
    }

    if ($is_binary) {
	print STDERR "$name: $f: binary file\n";
	next;
    }

    seek(FILE, 0, 0);

    @blanks = ();
    @lines  = ();

    while ( defined($line = <FILE>) ) {
	$line =~ s/[ \t\r\n]*$/\n/;

	if ( $line eq "\n" ) {
	    push(@blanks, $line);
	} else {
	    push(@lines, @blanks);
	    push(@lines, $line);
	    @blanks = ();
	}
    }

    # Any blanks at the end of the file are discarded

    seek(FILE, 0, 0);
    print FILE @lines;

    if ( !defined($where = tell(FILE)) ||
	 !truncate(FILE, $where) ) {
	die "$name: Failed to truncate modified file: $f: $!\n";
    }
    close(FILE);
}

--------------070209010509020608080307--
