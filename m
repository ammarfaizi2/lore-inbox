Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTEZThO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 15:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTEZThO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 15:37:14 -0400
Received: from web41501.mail.yahoo.com ([66.218.93.84]:9052 "HELO
	web41501.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262169AbTEZThK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 15:37:10 -0400
Message-ID: <20030526195022.56736.qmail@web41501.mail.yahoo.com>
Date: Mon, 26 May 2003 12:50:22 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: 'fscope': a new debugging tool
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#!/usr/local/bin/perl -s
# (c) 2003 Carl Spalletta under GPL-v2 cspalletta@yahoo.com

# PURPOSE:
# Traces chains of function calls as far back as possible - i.e.,
# to a callback, syscall or interrupt handler. Also, with the
# '-cycles' option set, warns of possible cycles in kernel code.

# USAGE:
# For example we want to find all the ways there are to reach function
# do_mmap_pgoff() within the kernel.  Whereas 'cscope' would only give
# us it's immediate callers, we recreate the whole reverse call tree with
# the command 'fscope -func=do_mmap_pgoff'. It produces about 20 lines of
# output, each line a unique path to do_mmap_pgoff. The command
# 'fscope -func=add_to_swap_cache' produces over 5000 paths. Arranged
# into tabular form with 'column -t' they form some revealing patterns.

# INSTALLATION
# First, install 'cscope' (available from sourceforge or as an rpm).
# Then before running 'fscope' for the first time, give the command
# "cscope -Rkq" in your source directory to setup the indices.
#
# Then you may use this program at will, after verifying 2 things:
#
#    1) That variable $cmd points to some shell script (here called
#      'fscope.cmd'), which is set executable, and whose contents are:
#
#          "cscope -d -L -3$1 | perl -lane 'print $F[1]' | sort -u"
#
#    2) That the hashbang line of _this_ file refers to your local perl.

# OPTIONAL, BUT RECOMMENDED:
#  For cleaner output _before_ running 'cscope -Rkq' - which only need
# be done once for any source tree - you may clone your source dir with
#
#   cpio -pdumv --link
#
# Then prune away the foreign architecture directories & header files,
# as well as any drivers, filesystems, etc, not part of your setup.

# LIMITATIONS:
# Obviously this is not perfect - it may give false positives. Consider
# a call chain '..A..B..C..' where 'B' indirectly calls function 'C' to
# access a resource protected by some non-blocking synchronization
# primitive which happens, for this chain, to always be held by 'A'.
# Thus, function 'C' will never enter it's critical section from this
# particular call chain (nor will it deadlock), and any functions con-
# tained in it's critical section can never be reached from this chain.
# 
# Nonetheless 'fscope' considers that it _is_ possible, since it assumes
# that any call within a function is ultimately reachable from any chain
# the function belongs to.
#
# In other words it's analysis is structural, not logical.

# NB: the interesting part of the code is in the loop after label 'NB:'


BEGIN
{
sub leveln;
$usage="usage: $0 -func=<funcname> [-cycles] [-debug]";
if(!(defined $func))
  {
  print "$usage\n";
  exit;
  }
}

#cycles lead to infinite expansion
sub cycle
{
  my $arrayref  = shift(@_);
  my $candidate = shift(@_);
  my $arrayelem;

  #this argument was supposed to have been
  #cleaned up _before_ the call. However..
  $candidate =~ s/^\W*(\w+)\W*$/\1/;

  foreach $arrayelem (@$arrayref)
  {
    $arrayelem =~ s/^\W*(\w+)\W*$/\1/;
    if($arrayelem eq $candidate)
    {
      if($cycles)
      {
CYCLE0:
        print "cycle detected: ";
	print join ':',@$arrayref;
	print ":$arrayelem\n";
      }
      return 1;
    }
  }
  return 0;
} #end sub cycle

#recurse until we can go no further
sub leveln
{
  my $i,$xfunc,$cmd;
  local @cmd0;

  $xfunc=pop @_;
  push @_,$xfunc;

  #eliminate the line noise :(
  $xfunc =~ s/^\W*(\w+)\W*$/\1/;

  #insert your command here, but preserve
  #the embedded space after the path name
  $cmd = "/usr/local/bin/fscope.cmd " . $xfunc;
  @cmd0= qx/$cmd/;

  if($debug)
  {
DEBUG1:
    print "\n";
    print 'leveln[';
    print join ';',@_;
    print ']';
    print "\n:";
    print join ':',@cmd0;
  }

  #at this point @cmd0 includes all callers of $xfunc.
  if(@cmd0)
  {
    my @args=@_;
NB:
    #this loop contains the really interesting bits..
    foreach $i (@cmd0)
    {
      $i =~ s/^\W*(\w+)\W*$/\1/;
      next if $i eq $xfunc;

      #invalid value - a cycle
      if(cycle(\@args,$i))
      {
        return;
      }
      #numeric value - not called directly by anything
      #thus end of call chain
      elsif($i=~m/^\d+$/)
      {
        return;
      }
      ##elsif($i=~m/^sys_\w+$/) { return; } #exclude linux syscalls
      #default action
      #  go one level deeper
      else
      {
        push @args,$i;
        leveln @args;
        pop @args;
      }
    } #end foreach $i
  return;
  } #end if @cmd0
  else
  {
    if($debug)
    {
DEBUG2:
      print "\@_ at terminal node <<@_>>\n";
      return;
    } #end if debug
    else
    {
      #Hoorah!
      #This is where we output the call chain
      print "@_\n";
      return;
    } #end if not debug
  } #end not @cmd0
} #end sub leveln

leveln $func;


