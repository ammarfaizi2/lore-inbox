Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSGMUpp>; Sat, 13 Jul 2002 16:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSGMUpm>; Sat, 13 Jul 2002 16:45:42 -0400
Received: from 64-60-75-69.cust.telepacific.net ([64.60.75.69]:57863 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S315437AbSGMUpk>; Sat, 13 Jul 2002 16:45:40 -0400
Message-ID: <3D309C22.902@ixiacom.com>
Date: Sat, 13 Jul 2002 14:31:14 -0700
From: Dan Kegel <dkegel@ixiacom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: compile the kernel with -Werror
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Sat, 2002-07-13 at 14:41, Roy Sigurd Karlsbakk wrote: 
>> Why not add a menu item under kernel hacking?
> 
> CONFIG_TEACH_USER_TO_USE_GREP 

It's a bit challenging to grep for errors in gcc's output, as
gcc produces multiline errors and warnings.
Here's a perl script I whipped up yesterday to filter out
all but the errors and warnings from a make + gcc run
for some other project; it'd probably do nicely on kernel
builds.  I use it like this:

     make > log 2>&1
     errfilter.pl log | more

It has the dubious feature that it properly filters out the
warnings gcc produces on .h files that don't end in newlines
(guess what IDE people use here?)
- Dan

--- errfilter.pl ---



#!/usr/bin/perl
# Filter out all but essential lines of the output of a make + gcc run.
# Dan Kegel dkegel@ixiacom.com 12 July 2002

# Join logical lines which have been split into multiple physical lines
while (<>) {
     chop;
     if (/^\S/) {
         &save($linebuf);
         $linebuf = "";
     }
     $linebuf .= $_;
}
# Force blank lines at end
&save($linebuf);
&save("");

# Handle next logical line.  Handle lines of context, like 'Entering directory', properly.
sub save
{
     my($buf) = $_[0];

     # Remove excess space used at beginning of all but first physical
     # of a long logical line.
     $buf =~ s/  */ /g;

     if ($buf =~ /In file included from/) {
         # Handle include context.
         $prefix = $buf."\n";
     } elsif ($buf =~ /Entering directory/) {
         # Handle directory context.
         unshift(@dir, $buf."\n");
         $curdir = $dir[0];
     } elsif ($buf =~ /Leaving directory/) {
         # Handle directory context.
         shift(@dir);
         $curdir = $dir[0];
     } else {
         # Handle possible error lines.
         if (&filter($buf)) {
             # It's an error.  Print it out with its context.
             print $curdir.$prefix.$buf;
             print "\n";
             # Dir context only gets printed out once per directory change.
             $curdir = "";
         }
         # Include context only gets printed out for immediately following line.
         $prefix = "";
     }
}

# Return true if given logical line contains a gcc error or warning and has not been seen before
sub filter
{
     my($line) = $_[0];

     if ($line =~ /:.*:/) {
         if ($line !~ /treated|sed.*\.d|no newline at end|warning: overriding commands|warning: ignoring old commands|File format not recognized/) {
             # uniq
             if ($out{$line} == 0) {
                 $out{$line}++;
                 return 1;
             }
         }
     }
     return 0;
}



