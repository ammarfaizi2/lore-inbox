Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbTJFS6V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTJFS6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:58:20 -0400
Received: from host16.fastclick.com ([205.180.85.17]:53463 "EHLO
	mail.fastclick.net") by vger.kernel.org with ESMTP id S262105AbTJFS6P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:58:15 -0400
Message-ID: <3F81BB34.3080008@fastclick.com>
Date: Mon, 06 Oct 2003 11:57:56 -0700
From: Brett <brettspamacct@fastclick.com>
Reply-To: brettspamacct@fastclick.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Kevin Kahley <kkahley@cs.uic.edu>
Subject: My stab at finding memory used by processes
Content-Type: multipart/mixed;
 boundary="------------010100070808000004070500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010100070808000004070500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This perl script just goes through /proc/maps, finding inodes numbered 
with 0 and adds those sizes.  Seems to over-report things with our 
servers, probably because it counts all pages even if they're copy on 
write, don't know how to get around that.

Any comments are welcome.

--------------010100070808000004070500
Content-Type: text/plain;
 name="getprocmem.pl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="getprocmem.pl"

#!/usr/bin/perl -w
use strict;
use File::Glob ':glob';

my $procregex = qr /^(\S+)-(\S+) \S+ \S+ \S+ (\S+)/;

sub process_mapsfile {
    my ($path) = @_;

    open(MAPSFD, $path);

    my $totalsize = 0;
    while(<MAPSFD>)
    {
	if (!/$procregex/)
	{
	    #print "Couldn't match\n$_\n";
	    next;
	}
	else
	{
	    #print "Matched\n$_\n";
	}

	#print "line = $_";
	my $start = int(hex($1));
	my $end = int(hex($2));
	my $inode = int($3);
	#print "inode = $inode, end = $end, start = $start\n";
	if($inode == 0)
	{
	    my $size = $end - $start;
	    $totalsize += $size;
	}
    }

    close(MAPSFD);
    return $totalsize;
}


my $totalsize = 0;
my @files = </proc/*>;
foreach my $file (@files)
{
    # if we have a pid file, parse maps file
    if($file =~ /\/proc\/\d+/)
    {
	$totalsize += process_mapsfile($file . "/maps");
    }
}

print "size = $totalsize\n";

--------------010100070808000004070500--

